Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267903AbUIAVJk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267903AbUIAVJk (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Sep 2004 17:09:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267918AbUIAVI4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Sep 2004 17:08:56 -0400
Received: from baikonur.stro.at ([213.239.196.228]:48049 "EHLO
	baikonur.stro.at") by vger.kernel.org with ESMTP id S267903AbUIAU4C
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Sep 2004 16:56:02 -0400
Subject: [patch 04/25]  drivers/char/isicom.c MIN/MAX removal
To: linux-kernel@vger.kernel.org
Cc: akpm@digeo.com, janitor@sternwelten.at
From: janitor@sternwelten.at
Date: Wed, 01 Sep 2004 22:56:00 +0200
Message-ID: <E1C2c9A-0007I1-Ry@sputnik>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Patch (against 2.6.7) removes unnecessary min/max macros and changes
calls to use kernel.h macros instead.

Feedback is always welcome
Michael

Signed-off-by: Maximilian Attems <janitor@sternwelten.at>



---

 linux-2.6.9-rc1-bk7-max/drivers/char/isicom.c |   14 +++++++-------
 1 files changed, 7 insertions(+), 7 deletions(-)

diff -puN drivers/char/isicom.c~min-max-char_isicom drivers/char/isicom.c
--- linux-2.6.9-rc1-bk7/drivers/char/isicom.c~min-max-char_isicom	2004-09-01 20:17:48.000000000 +0200
+++ linux-2.6.9-rc1-bk7-max/drivers/char/isicom.c	2004-09-01 21:07:32.000000000 +0200
@@ -389,7 +389,7 @@ static void isicom_tx(unsigned long _dat
 		
 		tty = port->tty;
 		save_flags(flags); cli();
-		txcount = MIN(TX_SIZE, port->xmit_cnt);
+		txcount = min_t(short, TX_SIZE, port->xmit_cnt);
 		if ((txcount <= 0) || tty->stopped || tty->hw_stopped) {
 			restore_flags(flags);
 			continue;
@@ -421,7 +421,7 @@ static void isicom_tx(unsigned long _dat
 		residue = NO;
 		wrd = 0;			
 		while (1) {
-			cnt = MIN(txcount, (SERIAL_XMIT_SIZE - port->xmit_tail));
+			cnt = min_t(int, txcount, (SERIAL_XMIT_SIZE - port->xmit_tail));
 			if (residue == YES) {
 				residue = NO;
 				if (cnt > 0) {
@@ -650,7 +650,7 @@ static irqreturn_t isicom_interrupt(int 
 		}	 
 	}
 	else {				/* Data   Packet */
-		count = MIN(byte_count, (TTY_FLIPBUF_SIZE - tty->flip.count));
+		count = min_t(unsigned short, byte_count, (TTY_FLIPBUF_SIZE - tty->flip.count));
 #ifdef ISICOM_DEBUG
 		printk(KERN_DEBUG "ISICOM: Intr: Can rx %d of %d bytes.\n", 
 					count, byte_count);
@@ -1163,8 +1163,8 @@ static int isicom_write(struct tty_struc
 	save_flags(flags);
 	while(1) {	
 		cli();
-		cnt = MIN(count, MIN(SERIAL_XMIT_SIZE - port->xmit_cnt - 1,
-			SERIAL_XMIT_SIZE - port->xmit_head));
+		cnt = min_t(int, count, min(SERIAL_XMIT_SIZE - port->xmit_cnt - 1,
+					    SERIAL_XMIT_SIZE - port->xmit_head));
 		if (cnt <= 0) 
 			break;
 		
@@ -1180,8 +1180,8 @@ static int isicom_write(struct tty_struc
 				return -EFAULT;
 			}
 			cli();
-			cnt = MIN(cnt, MIN(SERIAL_XMIT_SIZE - port->xmit_cnt - 1,
-			SERIAL_XMIT_SIZE - port->xmit_head));
+			cnt = min_t(int, cnt, min(SERIAL_XMIT_SIZE - port->xmit_cnt - 1,
+						  SERIAL_XMIT_SIZE - port->xmit_head));
 			memcpy(port->xmit_buf + port->xmit_head, tmp_buf, cnt);
 		}	
 		else

_
