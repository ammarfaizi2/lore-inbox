Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262511AbUKLOU6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262511AbUKLOU6 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Nov 2004 09:20:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261579AbUKLOU6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Nov 2004 09:20:58 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:55775 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S262511AbUKLOUu
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Nov 2004 09:20:50 -0500
Date: Fri, 12 Nov 2004 08:41:58 -0200
From: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
To: Nick Piggin <nickpiggin@yahoo.com.au>
Cc: Justin Piszcz <jpiszcz@lucidpixels.com>, linux-kernel@vger.kernel.org,
       akpm@osdl.org, andrea@novell.com
Subject: Re: Non-e1000, 2.6.9 page allocation failures with OSS/audio.
Message-ID: <20041112104158.GJ22133@logos.cnet>
References: <Pine.LNX.4.61.0411120658490.19273@p500> <4194A9F9.7060901@yahoo.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4194A9F9.7060901@yahoo.com.au>
User-Agent: Mutt/1.5.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 12, 2004 at 11:18:01PM +1100, Nick Piggin wrote:
> Justin Piszcz wrote:
> >The other page allocation failures were due to the e1000+TSO 
> >segmentation offload issue.
> >
> >I use OSS sound drivers with 2.6.9.
> >
> >Here are the options I use and have been using for quite some time 
> >without error:
> >
> >1] <*> Open Sound System (DEPRECATED)
> >2] <*>   OSS sound modules
> >3] [*]     Verbose initialisation
> >4] [*]     Persistent DMA buffers
> >5] <*>     Crystal CS4232 based (PnP) cards
> >
> >My LILO append line as is follows:
> >append="cs4232=0x530,5,1,0,388,5 mce video=atyfb:1600x1200-16@60"
> >
> >What happened to the page allocation / memory subsystem in 2.6.9?
> >I do not recall getting these with 2.6.4, 2.6.5, 2.6.6, 2.6.7, 2.6.8 or 
> >2.6.8.1.
> >
> 
> These failures are actually harmless and not entirely unexpected.
> That path should tell the allocator not to produce warnings on
> failure.
> 
> The issue is being actively worked on in the -mm kernels, and the
> important stuff should get into 2.6.10.
> 
> However, earlier kernels had a bug that prevented a large amount
> of ZONE_DMA memory from being allocated by GFP_KERNEL allocations
> which is probably why this particular path hasn't been a problem
> before. This actually won't be completely reverted in 2.6.10, however
> the correct way to get this behaviour is with "lower zone protection"
> which Andrea had been working on... so things may happen soon.

Well, the zone->protection code is in the tree but disable by default 
(Andrea's lowmem_reserve effectively enables/adjusts it, apart from changing
"protection" to "lowmem_reserve", etc).

The zone protection setup code doesnt configure any protection
for DMA zone with reference to GFP_KERNEL allocations. 
It only sets up protection with reference to HIGH zone, I think.

There must be some reasoning to explain why its disable now?

Who wrote the zone->protection code, Andrew? 
