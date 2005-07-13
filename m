Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262737AbVGMLAE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262737AbVGMLAE (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Jul 2005 07:00:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262612AbVGMK6P
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Jul 2005 06:58:15 -0400
Received: from amsfep11-int.chello.nl ([213.46.243.19]:51756 "EHLO
	amsfep19-int.chello.nl") by vger.kernel.org with ESMTP
	id S262631AbVGMK4p (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Jul 2005 06:56:45 -0400
Date: Wed, 13 Jul 2005 12:56:42 +0200 (CEST)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Dmitry Torokhov <dtor@mail.ru>, Linus Torvalds <torvalds@osdl.org>,
       Andrew Morton <akpm@osdl.org>
cc: Linux Kernel Development <linux-kernel@vger.kernel.org>
Subject: [PATCH] Amiga joystick typo (was: Re: Input: fix open/close races
 in joystick drivers - add a semaphore)
In-Reply-To: <200506280052.j5S0qDQT010792@hera.kernel.org>
Message-ID: <Pine.LNX.4.62.0507131254590.5536@anakin>
References: <200506280052.j5S0qDQT010792@hera.kernel.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 27 Jun 2005, Linux Kernel Mailing List wrote:
> tree 11d80109ddc2f61de6a75a37941346100a67a0d1
> parent af246041277674854383cf91b8f0b01217b521e8
> author Dmitry Torokhov <dtor_core@ameritech.net> Sun, 29 May 2005 12:29:52 -0500
> committer Dmitry Torokhov <dtor_core@ameritech.net> Sun, 29 May 2005 12:29:52 -0500
> 
> Input: fix open/close races in joystick drivers - add a semaphore
>        to the ones that register more than one input device.
> 
> Signed-off-by: Dmitry Torokhov <dtor@mail.ru>
> 
>  drivers/input/joystick/amijoy.c     |   29 ++++++++++++++++-------------

This patch broke compilation of amijoy. Trivial fix below.

Amiga joystick: Fix typo introduced by fixing the open/close races in
2.6.13-rc1

Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>

--- linux-2.6.13-rc1/drivers/input/joystick/amijoy.c	2005-06-29 22:15:20.000000000 +0200
+++ linux-m68k-2.6.13-rc1/drivers/input/joystick/amijoy.c	2005-07-12 13:20:20.000000000 +0200
@@ -105,7 +105,7 @@ out:
 
 static void amijoy_close(struct input_dev *dev)
 {
-	down(&amijoysem);
+	down(&amijoy_sem);
 	if (!--amijoy_used)
 		free_irq(IRQ_AMIGA_VERTB, amijoy_interrupt);
 	up(&amijoy_sem);

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
