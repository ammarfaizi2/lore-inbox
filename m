Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264366AbUBOVBs (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 15 Feb 2004 16:01:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264498AbUBOVBs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 15 Feb 2004 16:01:48 -0500
Received: from vana.vc.cvut.cz ([147.32.240.58]:2947 "EHLO vana.vc.cvut.cz")
	by vger.kernel.org with ESMTP id S264366AbUBOVBq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 15 Feb 2004 16:01:46 -0500
Date: Sun, 15 Feb 2004 22:01:39 +0100
From: Petr Vandrovec <vandrove@vc.cvut.cz>
To: Mike Houston <mikeserv@bmts.com>
Cc: linux-kernel@vger.kernel.org, benh@kernel.crashing.org
Subject: Re: 2.6.3-rc3 radeonfb: Problems with new (and old) driver
Message-ID: <20040215210139.GB3108@vana.vc.cvut.cz>
References: <1076825785.6960.3.camel@gaston> <20040215130214.658e30ab.mikeserv@bmts.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040215130214.658e30ab.mikeserv@bmts.com>
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Feb 15, 2004 at 01:02:14PM -0500, Mike Houston wrote:
> Hello
> 
> The new radeonfb driver appears to work nicely (except a bit of corruption when it first switches, but it's always done that for me in 2.6), until I start and exit XFree86. I then have display corruption. Text is scrambled and appearing where it's not supposed to be. If I type clear, the display becomes unusable. The text appears with lines through it, and I'm then typing blindly. I can still type commands though.

I'm not sure whether it is radeonfb or XFree driver bug. On my system after
I switch from X to console, all "clear rectangle" requests are wrong, like if
line length in hardware was stil 1664*4 (what X do) instead of 1600*1 (what
console wants).

Second problem is that XFree driver (from 4.2.1.1 in Debian unstable) does not
like usefbdev on. It uses fbdev, but somehow it thinks that line length is 1664*4
although fbdev reports that it set 1600*4, and display also looks like that 1600 was
programmed into hardware.

And when console uses 16bpp, after switching from X picture is zoomed by 200%
(giving 800x600).  When console uses 32bpp, it is zoomed by 400% after
switch from X to console. In both cases rerunning fbset fixes problem.

I'm using Compaq Evo 800N, with 1600x1200 DFP.

evon:~# fbset -i

mode "1600x1200-60"
    # D: 162.022 MHz, H: 75.010 kHz, V: 60.008 Hz
    geometry 1600 1200 1600 1200 8
    timings 6172 304 64 46 1 192 3
    rgba 8/0,8/0,8/0,0/0
endmode

Frame buffer device information:
    Name        : ATI Radeon LW
    Address     : 0x48000000
    Size        : 67108864
    Type        : PACKED PIXELS
    Visual      : PSEUDOCOLOR
    XPanStep    : 8
    YPanStep    : 1
    YWrapStep   : 0
    LineLength  : 1600
    MMIO Address: 0x40300000
    MMIO Size   : 16384
    Accelerator : ATI Radeon family
evon:~#
						Petr Vandrovec


