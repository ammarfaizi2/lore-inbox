Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261396AbVBOAUq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261396AbVBOAUq (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Feb 2005 19:20:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261400AbVBOAUp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Feb 2005 19:20:45 -0500
Received: from waste.org ([216.27.176.166]:44945 "EHLO waste.org")
	by vger.kernel.org with ESMTP id S261396AbVBOAU3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Feb 2005 19:20:29 -0500
Date: Mon, 14 Feb 2005 16:20:25 -0800
From: Matt Mackall <mpm@selenic.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: linux-kernel <linux-kernel@vger.kernel.org>, adaplas@pol.net
Subject: Re: Radeon FB troubles with recent kernels
Message-ID: <20050215002025.GQ15058@waste.org>
References: <20050214203902.GH15058@waste.org> <1108420723.12740.17.camel@gaston> <1108422492.12653.30.camel@gaston>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1108422492.12653.30.camel@gaston>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 15, 2005 at 10:08:11AM +1100, Benjamin Herrenschmidt wrote:
> 
> > Appeared ? hah... that's strange. X is known to fuck up the chip when
> > quit, but I wouldn't have expected any change due to the new version of
> > radeonfb. From what you describe, it looks like an offset register is
> > changed by X, or the surface control.
> > 
> > My patch did not change any of radeonfb accel code though...
> > 
> > I'll catch up with you on IRC ...
> 
> Ok, from our discussions, it's not related to the power management code,
> and an engine reset triggered by fbset fixes it. So at this point, I can
> see no change in the driver explaining it...
> 
> We did some changes to the VT layer to force a mode setting (and thus an
> engine reset) when going away from X, so I can't see why that wouldn't
> work, while using fbset later on works ... this goes through the same
> code path in the driver... unless we are facing a timing issue...
> 
> X is known to play funny tricks, like touching the engine when it's in
> the background (not frontmost VT) and quit, or possibly other bad things
> on console switch. Maybe I changed enough delays (speeded up) the mode
> switch so that we fall into a case where X has not finished mucking up
> with us...
> 
> Can you try adding some msleep(200) or so at the beginning at
> radeonfb_set_par() or radeon_write_mode() to see if that makes any
> difference ?

Nope. No printk outputs from _set_par, _write_mode, or _engine_init.

Just to clarify: the gdm stop is done from tty1 while gdm is running
on tty7, so I don't think it's a matter of mode switch logic.

If I do "sleep 5; /etc/init.d/gdm stop" and then switch to tty7 and
wait for it to stop, all is fine.


Also, I'm still seeing the LCD blooming + hang on starting radeonfb.
It's something like 1 in 10 boots rather than every boot now though.

-- 
Mathematics is the supreme nostalgia of our time.
