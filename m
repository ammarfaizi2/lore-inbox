Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269967AbTHOWDz (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 15 Aug 2003 18:03:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270449AbTHOWDy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Aug 2003 18:03:54 -0400
Received: from pub234.cambridge.redhat.com ([213.86.99.234]:60422 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S269967AbTHOWDw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Aug 2003 18:03:52 -0400
Date: Fri, 15 Aug 2003 23:03:51 +0100 (BST)
From: James Simmons <jsimmons@infradead.org>
To: Kurt Roeckx <Q@ping.be>
cc: linux-kernel@vger.kernel.org
Subject: Re: Problem with framebuffer in 2.6.0-test3
In-Reply-To: <20030815142008.GA22123@ping.be>
Message-ID: <Pine.LNX.4.44.0308152301190.30952-100000@phoenix.infradead.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> When I use "vga=normal", I get this weird screen during boot.
> It doesn't show any text.  It just lots of coloured pixels.

This tells the the BIOS to set the video mode to a VGA text hardware mode. 
This will never work with any of the framebuffer drivers. That is meant 
only for vgacon.

> When I use "vga=0x301" I just get a blank screen during boot.

This will only work with VESA fbdev.

> In the init scripts I call fbset to set the proper resolution,
> which work in both cases.

fbset doesn't work with VESA fbdev because VESA doesn't support mode 
changes. 
 
> Here is part of my .config:
> CONFIG_FB=y
> # CONFIG_FB_CIRRUS is not set
> # CONFIG_FB_PM2 is not set
> # CONFIG_FB_CYBER2000 is not set
> # CONFIG_FB_IMSTT is not set
> CONFIG_FB_VGA16=y
> CONFIG_FB_VESA=y
> CONFIG_VIDEO_SELECT=y
> # CONFIG_FB_HGA is not set
> # CONFIG_FB_RIVA is not set
> # CONFIG_FB_MATROX is not set
> # CONFIG_FB_RADEON is not set
> # CONFIG_FB_ATY128 is not set
> # CONFIG_FB_ATY is not set
> # CONFIG_FB_SIS is not set
> # CONFIG_FB_NEOMAGIC is not set
> CONFIG_FB_3DFX=y
> # CONFIG_FB_VOODOO1 is not set
> # CONFIG_FB_TRIDENT is not set
> # CONFIG_FB_PM3 is not set
> # CONFIG_FB_VIRTUAL is not set

Ah. You have a Voodoo 3 card. Please only us that driver. Also make sure 
you have CONFIG_FRAMEBUFFER_CONSOLE set.


