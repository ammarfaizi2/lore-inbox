Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263790AbUDFLfH (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Apr 2004 07:35:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263789AbUDFLev
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Apr 2004 07:34:51 -0400
Received: from witte.sonytel.be ([80.88.33.193]:5252 "EHLO witte.sonytel.be")
	by vger.kernel.org with ESMTP id S263784AbUDFLcH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Apr 2004 07:32:07 -0400
Date: Tue, 6 Apr 2004 13:31:55 +0200 (MEST)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Andrew Morton <akpm@osdl.org>,
       Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
cc: Linux Kernel Development <linux-kernel@vger.kernel.org>,
       linux-ide@vger.kernel.org
Subject: [PATCH] QD65xx I/O ports
Message-ID: <Pine.GSO.4.58.0404061330470.4158@waterleaf.sonytel.be>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I/O port numbers can be larger than 8-bit on many platforms (this caused a
warning when {out,in}b() cast reg to a pointer on platforms with memory mapped
I/O)

--- linux-2.6.5/drivers/ide/legacy/qd65xx.c.orig	2003-10-09 10:02:47.000000000 +0200
+++ linux-2.6.5/drivers/ide/legacy/qd65xx.c	2004-04-01 13:31:54.000000000 +0200
@@ -92,7 +92,7 @@

 static int timings[4]={-1,-1,-1,-1}; /* stores current timing for each timer */

-static void qd_write_reg (u8 content, u8 reg)
+static void qd_write_reg (u8 content, unsigned long reg)
 {
 	unsigned long flags;

@@ -101,7 +101,7 @@
 	spin_unlock_irqrestore(&ide_lock, flags);
 }

-u8 __init qd_read_reg (u8 reg)
+u8 __init qd_read_reg (unsigned long reg)
 {
 	unsigned long flags;
 	u8 read;

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
