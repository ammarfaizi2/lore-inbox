Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262279AbSIZJuD>; Thu, 26 Sep 2002 05:50:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262280AbSIZJuD>; Thu, 26 Sep 2002 05:50:03 -0400
Received: from mail2.sonytel.be ([195.0.45.172]:58766 "EHLO mail.sonytel.be")
	by vger.kernel.org with ESMTP id <S262279AbSIZJuC>;
	Thu, 26 Sep 2002 05:50:02 -0400
Date: Thu, 26 Sep 2002 11:54:28 +0200 (MEST)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: "Andre M. Hedrick" <andre@linux-ide.org>
cc: Linux Kernel Development <linux-kernel@vger.kernel.org>
Subject: [PATCH] IDE wrong lock
Message-ID: <Pine.GSO.4.21.0209261153010.25364-100000@vervain.sonytel.be>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


One missing instance: ide_{get,release}_lock() operate on ide_intr_lock, not on ide_lock.

--- linux-2.5.38/drivers/ide/ide.c	Wed Sep 18 10:36:42 2002
+++ linux-m68k-2.5.38/drivers/ide/ide.c	Wed Sep 18 10:48:17 2002
@@ -1097,7 +1097,7 @@
 				 */
 
 				/* for atari only */
-				ide_release_lock(&ide_lock);
+				ide_release_lock(&ide_intr_lock);
 				hwgroup->busy = 0;
 			}
 

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds

