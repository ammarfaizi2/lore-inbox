Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932125AbWHSQqp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932125AbWHSQqp (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 19 Aug 2006 12:46:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932411AbWHSQqp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 19 Aug 2006 12:46:45 -0400
Received: from omx1-ext.sgi.com ([192.48.179.11]:53984 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S932125AbWHSQqo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 19 Aug 2006 12:46:44 -0400
Date: Sat, 19 Aug 2006 09:46:18 -0700 (PDT)
From: Christoph Lameter <clameter@sgi.com>
To: Manfred Spraul <manfred@colorfullife.com>
cc: Andi Kleen <ak@muc.de>, mpm@selenic.com,
       Marcelo Tosatti <marcelo@kvack.org>, linux-kernel@vger.kernel.org,
       Nick Piggin <nickpiggin@yahoo.com.au>, Andi Kleen <ak@suse.de>,
       Dave Chinner <dgc@sgi.com>
Subject: Re: [MODSLAB 3/7] A Kmalloc subsystem
In-Reply-To: <44E6B8EA.2010100@colorfullife.com>
Message-ID: <Pine.LNX.4.64.0608190941490.4872@schroedinger.engr.sgi.com>
References: <20060816022238.13379.24081.sendpatchset@schroedinger.engr.sgi.com>
 <20060816022253.13379.76984.sendpatchset@schroedinger.engr.sgi.com>
 <20060816094358.e7006276.ak@muc.de> <Pine.LNX.4.64.0608161718160.19789@schroedinger.engr.sgi.com>
 <44E3FC4F.2090506@colorfullife.com> <Pine.LNX.4.64.0608170922030.24204@schroedinger.engr.sgi.com>
 <44E6B8EA.2010100@colorfullife.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 19 Aug 2006, Manfred Spraul wrote:

> What about:
> 
> if (unlikely(addr & (~(PAGE_SIZE-1))))
>    slabp=virt_to_page(addr)->pagefield;
> else
>    slabp=addr & (~(PAGE_SIZE-1));

Well this would not be working with the simple slab design that puts the 
first element at the page border to simplify alignment.

And as we have just seen virt to page is mostly an address 
calculation in many configurations. I doubt that there would be a great 
advantage. Todays processors biggest cause for latencies are 
cacheline misses.. Some arithmetic with addresses does not seem to 
be that important. Misaligning data in order to not put objects on such
boundaries could be an issue.

 > Modify the kmalloc caches slightly and use non-power-of-2 cache sizes. Move
> the kmalloc(PAGE_SIZE) users to gfp.

Power of 2 cache sizes make the object align neatly to cacheline 
boundaries and make them fit tightly into a page.

