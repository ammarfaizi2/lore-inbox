Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262149AbVEEQUX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262149AbVEEQUX (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 May 2005 12:20:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262146AbVEEQUV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 May 2005 12:20:21 -0400
Received: from hellhawk.shadowen.org ([80.68.90.175]:47120 "EHLO
	hellhawk.shadowen.org") by vger.kernel.org with ESMTP
	id S262148AbVEEQUD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 May 2005 12:20:03 -0400
Message-ID: <427A4787.4030802@shadowen.org>
Date: Thu, 05 May 2005 17:19:19 +0100
From: Andy Whitcroft <apw@shadowen.org>
User-Agent: Debian Thunderbird 1.0.2 (X11/20050331)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: jschopp@austin.ibm.com
CC: linuxppc64-dev@ozlabs.org, paulus@samba.org, anton@samba.org,
       linux-mm@kvack.org, haveblue@us.ibm.com, linux-kernel@vger.kernel.org
Subject: Re: [1/3] add early_pfn_to_nid for ppc64
References: <E1DTQUL-0002WE-D6@pinky.shadowen.org> <427A3F6A.6060405@austin.ibm.com>
In-Reply-To: <427A3F6A.6060405@austin.ibm.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Joel Schopp wrote:
>> +#ifdef CONFIG_HAVE_ARCH_EARLY_PFN_TO_NID
>> +#define early_pfn_to_nid(pfn)  pa_to_nid(((unsigned long)pfn) <<
>> PAGE_SHIFT)
>> +#endif
> 
> 
> Is there a reason we didn't just use pfn_to_nid() directly here instead
> of pa_to_nid()?  I'm just thinking of having DISCONTIG/NUMA off and
> pfn_to_nid() being #defined to zero for those cases.

The problem is that pfn_to_nid is defined by the memory model.  In the
SPARSEMEM case it isn't always usable until after the we have
initialised and allocated the sparse mem_maps.  It is allocations during
this phase that need this early_pfn_to_nid() form, to guide its
allocations of the mem_map to obtain locality with the physical memory
blocks.

This is clearer in the i386 port where the early_pfn_to_nid()
implementation uses low level table to determine the location.  As has
been mentioned in another thread, we are using what is effectivly a
DISCONTIGMEM data structure here.  I have some work in progress to split
that last part and move to a true early implementation on ppc64 too.

-apw
