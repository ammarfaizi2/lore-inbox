Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751231AbVKAVLa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751231AbVKAVLa (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Nov 2005 16:11:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751220AbVKAVLa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Nov 2005 16:11:30 -0500
Received: from waste.org ([216.27.176.166]:8154 "EHLO waste.org")
	by vger.kernel.org with ESMTP id S1751231AbVKAVL3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Nov 2005 16:11:29 -0500
Date: Tue, 1 Nov 2005 13:06:18 -0800
From: Matt Mackall <mpm@selenic.com>
To: Rob Landley <rob@landley.net>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] slob: introduce the SLOB allocator
Message-ID: <20051101210617.GS4367@waste.org>
References: <3.494767362@selenic.com> <200511011451.55362.rob@landley.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200511011451.55362.rob@landley.net>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 01, 2005 at 02:51:54PM -0600, Rob Landley wrote:
> On Tuesday 01 November 2005 12:33, Matt Mackall wrote:
> > SLOB is a traditional K&R/UNIX allocator with a SLAB emulation layer,
> > similar to the original Linux kmalloc allocator that SLAB replaced.
> > It's signicantly smaller code and is more memory efficient. But like
> > all similar allocators, it scales poorly and suffers from
> > fragmentation more than SLAB, so it's only appropriate for small
> > systems.
> 
> Just to clarify: define "small".  My current laptop has half a gigabyte of 
> ram.  (Yeah, I broke down and bought a real machine, and even kept a World of 
> Warcraft partition this time...)
> 
> Does small mean "this is better for laptops with < 4gig"?  In which case, 
> possibly this should be tied to CONFIG_HIGHMEM or some such?

This is targeted at the bottom of the range that Linux supports, ie
less than 32MB. I originally tested it with _2MB_.

This allocator's performance is linear in the number of
smaller-than-a-page memory fragments (page-sized fragments get
coalesced and handed back to the buddy allocator). When you've only
got 4MB, scanning through all those fragments doesn't take long. When
you've got 400MB, and a lot of fragmentation, it can be very slow
indeed. SLAB, on the other hand, is nearly O(1).

-- 
Mathematics is the supreme nostalgia of our time.
