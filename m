Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266330AbRGBBDe>; Sun, 1 Jul 2001 21:03:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266331AbRGBBDZ>; Sun, 1 Jul 2001 21:03:25 -0400
Received: from hera.cwi.nl ([192.16.191.8]:56710 "EHLO hera.cwi.nl")
	by vger.kernel.org with ESMTP id <S266330AbRGBBDI>;
	Sun, 1 Jul 2001 21:03:08 -0400
Date: Mon, 2 Jul 2001 03:03:04 +0200 (MET DST)
From: Andries.Brouwer@cwi.nl
Message-Id: <UTC200107020103.DAA501507.aeb@vlet.cwi.nl>
To: alan@lxorguk.ukuu.org.uk, torvalds@transmeta.com
Subject: [PATCH] SAK broken since 2.4.3
Cc: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I wanted to show someone how nice SAK works, pressed it twice,
and lo! it not only killed the processes on the console, but
also the kernel. Very effective.

The patch below (for a private, patched 2.4.3 - line numbers
may differ) diminish this effectiveness a little. My kernel
now survives.

Andries

[PS I intend to come with another SAK patch one of these days,
but it may be for 2.5.]

--- tty_io.c~	Sat Mar 31 09:52:44 2001
+++ tty_io.c	Mon Jul  2 02:45:59 2001
@@ -1867,6 +1867,8 @@
  */
 void do_SAK(struct tty_struct *tty)
 {
+	if (!tty)
+		return;
 	PREPARE_TQUEUE(&tty->SAK_tq, __do_SAK, tty);
 	schedule_task(&tty->SAK_tq);
 }
