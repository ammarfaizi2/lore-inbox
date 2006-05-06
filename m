Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751083AbWEFSgL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751083AbWEFSgL (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 6 May 2006 14:36:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751084AbWEFSgL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 6 May 2006 14:36:11 -0400
Received: from waste.org ([64.81.244.121]:14284 "EHLO waste.org")
	by vger.kernel.org with ESMTP id S1751083AbWEFSgK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 6 May 2006 14:36:10 -0400
Date: Sat, 6 May 2006 13:31:12 -0500
From: Matt Mackall <mpm@selenic.com>
To: David Brownell <david-b@pacbell.net>
Cc: Denis Vlasenko <vda@ilport.com.ua>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH 8/14] random: Remove SA_SAMPLE_RANDOM from USB gadget drivers
Message-ID: <20060506183112.GA15445@waste.org>
References: <9.420169009@selenic.com> <200605061407.02737.vda@ilport.com.ua> <200605061116.18274.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200605061116.18274.david-b@pacbell.net>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 06, 2006 at 11:16:16AM -0700, David Brownell wrote:
> On Saturday 06 May 2006 4:07 am, Denis Vlasenko wrote:
> > On Friday 05 May 2006 19:42, Matt Mackall wrote:
> > > Remove SA_SAMPLE_RANDOM from USB gadget drivers
> 
> It's conventional to post USB patches to linux-usb-devel, or at least
> to CC that list.
> 
> 
> > > There's no a priori reason to think that USB device interrupts will
> > > contain "entropy" as defined/required by /dev/random. In fact, most
> > > operations will be streaming and bandwidth- or CPU-limited.
> > > /dev/random needs unpredictable inputs such as human interaction or
> > > chaotic physical processes like turbulence manifested in disk seek
> > > times.
> 
> And that'd be why you removed that SAMPLE_RANDOM from the Lubbock VBUS
> irqs ... which come from users connecting (by hand!) a USB cable.  :)

Really I removed it because I want SAMPLE_RANDOM to go away and most
of the users were either pretty trivial (the Lubbock case), wrong (a
bunch of block devices, etc), or suspect (network, i2c).
 
> You shouldn't add spaces before labels, or change indents from
> pure-tab to tabs-plus-four-spaces.

Show me where I did that, please.
 
> Admittedly OMAP _now_ has access to the FIPS-certified hardware RNG,
> so for that platform it's hard to justify needing other entropy sources.
> But on the other hand, DMA completion IRQs aren't exactly predictable
> either, and it doesn't necessarily hurt to salt a high entropy pool
> with some less-high entropy inputs.

The sampling is fine. It's the _accounting_ that's at issue.

-- 
Mathematics is the supreme nostalgia of our time.
