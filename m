Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932301AbWA0ApF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932301AbWA0ApF (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Jan 2006 19:45:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932365AbWA0ApE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Jan 2006 19:45:04 -0500
Received: from e36.co.us.ibm.com ([32.97.110.154]:29852 "EHLO
	e36.co.us.ibm.com") by vger.kernel.org with ESMTP id S932301AbWA0ApC
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Jan 2006 19:45:02 -0500
Message-ID: <43D96D08.6050200@us.ibm.com>
Date: Thu, 26 Jan 2006 16:44:56 -0800
From: Matthew Dobson <colpatch@us.ibm.com>
User-Agent: Mozilla Thunderbird 1.0.7 (X11/20051011)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Christoph Lameter <clameter@engr.sgi.com>
CC: linux-kernel@vger.kernel.org, sri@us.ibm.com, andrea@suse.de,
       pavel@suse.cz, linux-mm@kvack.org
Subject: Re: [patch 3/9] mempool - Make mempools NUMA aware
References: <20060125161321.647368000@localhost.localdomain> <1138233093.27293.1.camel@localhost.localdomain> <Pine.LNX.4.62.0601260953200.15128@schroedinger.engr.sgi.com> <43D953C4.5020205@us.ibm.com> <Pine.LNX.4.62.0601261511520.18716@schroedinger.engr.sgi.com> <43D95A2E.4020002@us.ibm.com> <Pine.LNX.4.62.0601261525570.18810@schroedinger.engr.sgi.com> <43D96633.4080900@us.ibm.com> <Pine.LNX.4.62.0601261619030.19029@schroedinger.engr.sgi.com> <43D96A93.9000600@us.ibm.com> <Pine.LNX.4.62.0601261638210.19078@schroedinger.engr.sgi.com>
In-Reply-To: <Pine.LNX.4.62.0601261638210.19078@schroedinger.engr.sgi.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christoph Lameter wrote:
> On Thu, 26 Jan 2006, Matthew Dobson wrote:
> 
> 
>>That seems a bit beyond the scope of what I'd hoped for this patch series,
>>but if an approach like this is believed to be generally useful, it's
>>something I'm more than willing to work on...
> 
> 
> We need this for other issues as well. f.e. to establish memory allocation 
> policies for the page cache, tmpfs and various other needs. Look at 
> mempolicy.h which defines a subset of what we need. Currently there is no 
> way to specify a policy when invoking the page allocator or slab 
> allocator. The policy is implicily fetched from the current task structure 
> which is not optimal.

I agree that the current, task-based policies are subobtimal.  Having to
allocate and fill in even a small structure for each allocation is going to
be a tough sell, though.  I suppose most allocations could get by with a
small handfull of static generic "policy structures"...  This seems like it
will turn into a signifcant rework of all the kernel's allocation routines,
no small task.  Certainly not something that I'd even start without
response from some other major players in the VM area...  Anyone?


-Matt
