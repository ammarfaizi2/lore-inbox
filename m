Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751366AbWHVIiy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751366AbWHVIiy (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Aug 2006 04:38:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751367AbWHVIiy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Aug 2006 04:38:54 -0400
Received: from calculon.skynet.ie ([193.1.99.88]:44450 "EHLO
	calculon.skynet.ie") by vger.kernel.org with ESMTP id S1751366AbWHVIix
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Aug 2006 04:38:53 -0400
Date: Tue, 22 Aug 2006 09:38:50 +0100 (IST)
From: Mel Gorman <mel@csn.ul.ie>
X-X-Sender: mel@skynet.skynet.ie
To: Keith Mannthey <kmannth@gmail.com>
Cc: akpm@osdl.org, tony.luck@intel.com,
       Linux Memory Management List <linux-mm@kvack.org>, ak@suse.de,
       bob.picco@hp.com,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       linuxppc-dev@ozlabs.org
Subject: Re: [PATCH 0/6] Sizing zones and holes in an architecture independent
 manner V9
In-Reply-To: <a762e240608211152x5d4f11f0wd26f7e3d75d38e0a@mail.gmail.com>
Message-ID: <Pine.LNX.4.64.0608220923280.11152@skynet.skynet.ie>
References: <20060821134518.22179.46355.sendpatchset@skynet.skynet.ie>
 <a762e240608211152x5d4f11f0wd26f7e3d75d38e0a@mail.gmail.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 21 Aug 2006, Keith Mannthey wrote:

> On 8/21/06, Mel Gorman <mel@csn.ul.ie> wrote:
>> This is V9 of the patchset to size zones and memory holes in an
>> architecture-independent manner. It booted successfully on 5 different
>> machines (arches were x86, x86_64, ppc64 and ia64) in a number of different
>> configurations and successfully built a kernel. If it fails on any machine,
>> booting with loglevel=8 and the console log should tell me what went wrong.
>> 
>
> I am wondering why this new api didn't cleanup the pfn_to_nid code
> path as well. Arches are left to still keep another set of
> nid-start-end info around. We are sending info like
>

pfn_to_nid() is used at runtime and the early_node_map[] is deleted by 
then. As this step, I only want to get the initialisation correct. What 
can be replaced is the architecture-specific early_pfn_to_nid() function 
which I did for power and x86.

> add_active_range(unsigned int nid, unsigned long start_pfn, unsigned
> long end_pfn)
>
> With this info making a common pnf_to_nid seems to be of intrest so we
> don't have to keep redundant information in both generic and arch
> specific data structures.
>

To implement a common one of interest, the array would have to be 
converted to a linked list at the end of boot so it could be modified by 
memory hot-add, then pfn_to_nid() would walk the linked list rather than 
the existing array. pfn_valid() would probably be replaced as well. 
However, this is going to be slower (if more accurate in some cases) than 
the existing pfn_valid() and so I would treat it as a separate issue.

> Are you intending the hot-add memory code path to call add_active_range or 
> ???
>

Not at this time. I want to make sure the memory initialisation is right 
before dealing with additional complications.

> Thanks,
> Keith
>

-- 
Mel Gorman
Part-time Phd Student                          Linux Technology Center
University of Limerick                         IBM Dublin Software Lab
