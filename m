Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261175AbUJaMCt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261175AbUJaMCt (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 31 Oct 2004 07:02:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261565AbUJaMCV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 31 Oct 2004 07:02:21 -0500
Received: from amsfep18-int.chello.nl ([213.46.243.13]:59993 "EHLO
	amsfep18-int.chello.nl") by vger.kernel.org with ESMTP
	id S261539AbUJaL7H (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 31 Oct 2004 06:59:07 -0500
Date: Sun, 31 Oct 2004 12:58:58 +0100 (CET)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Vojtech Pavlik <vojtech@suse.cz>
cc: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       Linux Kernel Development <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 517] M68k: Disable SERIO_I8042, except on Q40/Q60
In-Reply-To: <20041031101425.GA1343@ucw.cz>
Message-ID: <Pine.LNX.4.61.0410311256520.18354@anakin>
References: <200410311003.i9VA3f6H009703@anakin.of.borg> <20041031101425.GA1343@ucw.cz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 31 Oct 2004, Vojtech Pavlik wrote:
> On Sun, Oct 31, 2004 at 11:03:41AM +0100, Geert Uytterhoeven wrote:
> 
> > M68k: Disable SERIO_I8042, except on Q40/Q60
> 
> I thought Q40 uses the q40kbd.c driver and shouldn't need i8042 either?

Bummer. I got confused by Q40 having an i8042-alike controller, but
you're right that it uses a different driver (and no Q40 guy complained).

Here's an updated patch:

M68k: Disable SERIO_I8042

Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>

--- linux-2.6.10-rc1/drivers/input/serio/Kconfig	2004-09-30 12:53:37.000000000 +0200
+++ linux-m68k-2.6.10-rc1/drivers/input/serio/Kconfig	2004-10-27 23:16:43.000000000 +0200
@@ -20,7 +20,7 @@ config SERIO_I8042
 	tristate "i8042 PC Keyboard controller" if EMBEDDED || !X86
 	default y
 	select SERIO
-	depends on !PARISC && (!ARM || ARCH_SHARK || FOOTBRIDGE_HOST)
+	depends on !PARISC && (!ARM || ARCH_SHARK || FOOTBRIDGE_HOST) && !M68K
 	---help---
 	  i8042 is the chip over which the standard AT keyboard and PS/2
 	  mouse are connected to the computer. If you use these devices,

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
