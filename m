Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272738AbTHEMnq (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Aug 2003 08:43:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272743AbTHEMnp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Aug 2003 08:43:45 -0400
Received: from meryl.it.uu.se ([130.238.12.42]:32987 "EHLO meryl.it.uu.se")
	by vger.kernel.org with ESMTP id S272738AbTHEMmb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Aug 2003 08:42:31 -0400
Date: Tue, 5 Aug 2003 14:42:28 +0200 (MEST)
Message-Id: <200308051242.h75CgSj6028203@harpo.it.uu.se>
From: Mikael Pettersson <mikpe@csd.uu.se>
To: alan@lxorguk.ukuu.org.uk
Subject: Re: time for some drivers to be removed?
Cc: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 27 Jul 2003 21:56:11 +0100, Alan Cox wrote:
> On Sul, 2003-07-27 at 21:56, Adrian Bunk wrote:
> > That's no problem for me.
> > 
> > The only question is how to call the option that allows building only on
> > UP (e.g. cli/sti usage in the driver)? My suggestion was BROKEN_ON_SMP,
> > would you suggest OBSOLETE_ON_SMP?
> 
> Interesting question - whatever I guess. We don't have an existing convention.
> How many drivers have we got nowdays that failing on just SMP ?

ftape fails on SMP due to sti/save_flags/restore_flags removal.

My .config:

CONFIG_SMP=y
...
CONFIG_FTAPE=m
CONFIG_ZFTAPE=m
...
# CONFIG_FT_STD_FDC is not set
# CONFIG_FT_MACH2 is not set
# CONFIG_FT_PROBE_FC10 is not set
CONFIG_FT_ALT_FDC=y

#
# Consult the manuals of your tape drive for the correct settings!
#
CONFIG_FT_FDC_BASE=0x360
CONFIG_FT_FDC_IRQ=6
CONFIG_FT_FDC_DMA=2
CONFIG_FT_ALPHA_CLOCK=0

And the warnings:

drivers/char/ftape/lowlevel/fdc-io.c: In function `fdc_command':
drivers/char/ftape/lowlevel/fdc-io.c:221: warning: implicit declaration of function `restore_flags'
drivers/char/ftape/lowlevel/fdc-isr.c: In function `fdc_isr':
drivers/char/ftape/lowlevel/fdc-isr.c:1094: warning: implicit declaration of function `sti'
drivers/char/ftape/lowlevel/ftape-io.c: In function `ftape_sleep':
drivers/char/ftape/lowlevel/ftape-io.c:97: warning: implicit declaration of function `save_flags'
drivers/char/ftape/lowlevel/ftape-io.c:98: warning: implicit declaration of function `sti'
drivers/char/ftape/lowlevel/ftape-io.c:112: warning: implicit declaration of function `restore_flags'
drivers/char/ftape/lowlevel/ftape-format.c: In function `ftape_format_track':
drivers/char/ftape/lowlevel/ftape-format.c:135: warning: implicit declaration of function `restore_flags'
*** Warning: "sti" [drivers/char/ftape/lowlevel/ftape.ko] undefined!
*** Warning: "save_flags" [drivers/char/ftape/lowlevel/ftape.ko] undefined!
*** Warning: "restore_flags" [drivers/char/ftape/lowlevel/ftape.ko] undefined!

I have the HW so I can test patches if someone feels like fixing this.

/Mikael
