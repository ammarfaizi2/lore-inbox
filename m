Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263943AbUGYMSO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263943AbUGYMSO (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 25 Jul 2004 08:18:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263962AbUGYMSO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 25 Jul 2004 08:18:14 -0400
Received: from baikonur.stro.at ([213.239.196.228]:49068 "EHLO
	baikonur.stro.at") by vger.kernel.org with ESMTP id S263943AbUGYMSI
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 25 Jul 2004 08:18:08 -0400
Date: Sun, 25 Jul 2004 14:18:05 +0200
From: maximilian attems <janitor@sternwelten.at>
To: support@comtrol.com
Cc: linux-kernel@vger.kernel.org
Subject: [patch-kj] MIN/MAX removal drivers/char/rocket.c
Message-ID: <20040725121805.GB1756@stro.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040523i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Patch (against 2.6.7) removes unnecessary min/max macros and changes
calls to use kernel.h macros instead.

patch applies cleanly to 2.6.8-rc2

From: michael.veeck at gmx.net (Michael Veeck)
Signed-off-by: Maximilian Attems <janitor@sternwelten.at>


---

 linux-2.6.7-bk20-max/drivers/char/rocket.c |    8 ++++----
 1 files changed, 4 insertions(+), 4 deletions(-)

diff -puN drivers/char/rocket.c~min-max-char_rocket drivers/char/rocket.c
--- linux-2.6.7-bk20/drivers/char/rocket.c~min-max-char_rocket	2004-07-11 14:58:48.000000000 +0200
+++ linux-2.6.7-bk20-max/drivers/char/rocket.c	2004-07-11 14:58:48.000000000 +0200
@@ -389,7 +389,7 @@ static void rp_do_transmit(struct r_port
 	while (1) {
 		if (tty->stopped || tty->hw_stopped)
 			break;
-		c = MIN(info->xmit_fifo_room, MIN(info->xmit_cnt, XMIT_BUF_SIZE - info->xmit_tail));
+		c = min(info->xmit_fifo_room, min(info->xmit_cnt, XMIT_BUF_SIZE - info->xmit_tail));
 		if (c <= 0 || info->xmit_fifo_room <= 0)
 			break;
 		sOutStrW(sGetTxRxDataIO(cp), (unsigned short *) (info->xmit_buf + info->xmit_tail), c / 2);
@@ -1662,7 +1662,7 @@ static int rp_write(struct tty_struct *t
 	 *  into FIFO.  Use the write queue for temp storage.
          */
 	if (!tty->stopped && !tty->hw_stopped && info->xmit_cnt == 0 && info->xmit_fifo_room > 0) {
-		c = MIN(count, info->xmit_fifo_room);
+		c = min(count, info->xmit_fifo_room);
 		b = buf;
 		if (from_user) {
 			if (copy_from_user(info->xmit_buf, buf, c)) {
@@ -1672,7 +1672,7 @@ static int rp_write(struct tty_struct *t
 			if (info->tty == 0)
 				goto end;
 			b = info->xmit_buf;
-			c = MIN(c, info->xmit_fifo_room);
+			c = min(c, info->xmit_fifo_room);
 		}
 
 		/*  Push data into FIFO, 2 bytes at a time */
@@ -1700,7 +1700,7 @@ static int rp_write(struct tty_struct *t
 		if (info->tty == 0)	/*   Seemingly obligatory check... */
 			goto end;
 
-		c = MIN(count, MIN(XMIT_BUF_SIZE - info->xmit_cnt - 1, XMIT_BUF_SIZE - info->xmit_head));
+		c = min(count, min(XMIT_BUF_SIZE - info->xmit_cnt - 1, XMIT_BUF_SIZE - info->xmit_head));
 		if (c <= 0)
 			break;
 

