Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267935AbUIAVgv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267935AbUIAVgv (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Sep 2004 17:36:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268074AbUIAVHT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Sep 2004 17:07:19 -0400
Received: from baikonur.stro.at ([213.239.196.228]:16345 "EHLO
	baikonur.stro.at") by vger.kernel.org with ESMTP id S267953AbUIAU42
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Sep 2004 16:56:28 -0400
Subject: [patch 09/25]  drivers/char/rocket.c MIN/MAX removal
To: linux-kernel@vger.kernel.org
Cc: akpm@digeo.com, janitor@sternwelten.at
From: janitor@sternwelten.at
Date: Wed, 01 Sep 2004 22:56:27 +0200
Message-ID: <E1C2c9c-0007LZ-6R@sputnik>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Patch (against 2.6.7) removes unnecessary min/max macros and changes
calls to use kernel.h macros instead.

Feedback is always welcome
Michael

Signed-off-by: Maximilian Attems <janitor@sternwelten.at>



---

 linux-2.6.9-rc1-bk7-max/drivers/char/rocket.c |    8 ++++----
 1 files changed, 4 insertions(+), 4 deletions(-)

diff -puN drivers/char/rocket.c~min-max-char_rocket drivers/char/rocket.c
--- linux-2.6.9-rc1-bk7/drivers/char/rocket.c~min-max-char_rocket	2004-09-01 19:34:09.000000000 +0200
+++ linux-2.6.9-rc1-bk7-max/drivers/char/rocket.c	2004-09-01 19:34:09.000000000 +0200
@@ -389,7 +389,7 @@ static void rp_do_transmit(struct r_port
 	while (1) {
 		if (tty->stopped || tty->hw_stopped)
 			break;
-		c = MIN(info->xmit_fifo_room, MIN(info->xmit_cnt, XMIT_BUF_SIZE - info->xmit_tail));
+		c = min(info->xmit_fifo_room, min(info->xmit_cnt, XMIT_BUF_SIZE - info->xmit_tail));
 		if (c <= 0 || info->xmit_fifo_room <= 0)
 			break;
 		sOutStrW(sGetTxRxDataIO(cp), (unsigned short *) (info->xmit_buf + info->xmit_tail), c / 2);
@@ -1658,7 +1658,7 @@ static int rp_write(struct tty_struct *t
 	 *  into FIFO.  Use the write queue for temp storage.
          */
 	if (!tty->stopped && !tty->hw_stopped && info->xmit_cnt == 0 && info->xmit_fifo_room > 0) {
-		c = MIN(count, info->xmit_fifo_room);
+		c = min(count, info->xmit_fifo_room);
 		b = buf;
 		if (from_user) {
 			if (copy_from_user(info->xmit_buf, buf, c)) {
@@ -1668,7 +1668,7 @@ static int rp_write(struct tty_struct *t
 			if (info->tty == 0)
 				goto end;
 			b = info->xmit_buf;
-			c = MIN(c, info->xmit_fifo_room);
+			c = min(c, info->xmit_fifo_room);
 		}
 
 		/*  Push data into FIFO, 2 bytes at a time */
@@ -1696,7 +1696,7 @@ static int rp_write(struct tty_struct *t
 		if (info->tty == 0)	/*   Seemingly obligatory check... */
 			goto end;
 
-		c = MIN(count, MIN(XMIT_BUF_SIZE - info->xmit_cnt - 1, XMIT_BUF_SIZE - info->xmit_head));
+		c = min(count, min(XMIT_BUF_SIZE - info->xmit_cnt - 1, XMIT_BUF_SIZE - info->xmit_head));
 		if (c <= 0)
 			break;
 

_
