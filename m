Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261660AbSJJQoL>; Thu, 10 Oct 2002 12:44:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261664AbSJJQoL>; Thu, 10 Oct 2002 12:44:11 -0400
Received: from mail2.sonytel.be ([195.0.45.172]:33436 "EHLO mail.sonytel.be")
	by vger.kernel.org with ESMTP id <S261660AbSJJQoK>;
	Thu, 10 Oct 2002 12:44:10 -0400
Date: Thu, 10 Oct 2002 18:48:55 +0200 (MEST)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: "Andre M. Hedrick" <andre@linux-ide.org>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: Linux Kernel Development <linux-kernel@vger.kernel.org>
Subject: [PATCH] kill ide-lib.c warning
Message-ID: <Pine.GSO.4.21.0210101846170.2509-100000@vervain.sonytel.be>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Kill warning (speed is u8, while XFER_PIO_4 is int)

--- linux-2.5.41/drivers/ide/ide-lib.c	Sun Sep 29 11:03:01 2002
+++ linux-m68k-2.5.41/drivers/ide/ide-lib.c	Thu Oct 10 17:51:25 2002
@@ -171,7 +171,7 @@
 		BUG();
 	return min(speed, speed_max[mode]);
 #else /* !CONFIG_BLK_DEV_IDEDMA */
-	return min(speed, XFER_PIO_4);
+	return min(speed, (__typeof(speed))XFER_PIO_4);
 #endif /* CONFIG_BLK_DEV_IDEDMA */
 }
 
Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds

