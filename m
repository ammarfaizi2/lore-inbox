Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267951AbUIAVgZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267951AbUIAVgZ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Sep 2004 17:36:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267986AbUIAVFe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Sep 2004 17:05:34 -0400
Received: from baikonur.stro.at ([213.239.196.228]:4023 "EHLO baikonur.stro.at")
	by vger.kernel.org with ESMTP id S267709AbUIAU4u (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Sep 2004 16:56:50 -0400
Subject: [patch 13/25]  drivers/char/specialix.c MIN/MAX removal
To: linux-kernel@vger.kernel.org
Cc: akpm@digeo.com, janitor@sternwelten.at
From: janitor@sternwelten.at
Date: Wed, 01 Sep 2004 22:56:49 +0200
Message-ID: <E1C2c9y-0007OP-3F@sputnik>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Patch (against 2.6.7) removes unnecessary min/max macros and changes
calls to use kernel.h macros instead.

Feedback is always welcome
Michael

Signed-off-by: Maximilian Attems <janitor@sternwelten.at>



---

 linux-2.6.9-rc1-bk7-max/drivers/char/specialix.c |   14 +++++---------
 1 files changed, 5 insertions(+), 9 deletions(-)

diff -puN drivers/char/specialix.c~min-max-char_specialix drivers/char/specialix.c
--- linux-2.6.9-rc1-bk7/drivers/char/specialix.c~min-max-char_specialix	2004-09-01 19:34:12.000000000 +0200
+++ linux-2.6.9-rc1-bk7-max/drivers/char/specialix.c	2004-09-01 19:34:12.000000000 +0200
@@ -135,10 +135,6 @@
 	 ASYNC_SPD_HI       | ASYNC_SPEED_VHI    | ASYNC_SESSION_LOCKOUT | \
 	 ASYNC_PGRP_LOCKOUT | ASYNC_CALLOUT_NOHUP)
 
-#ifndef MIN
-#define MIN(a,b) ((a) < (b) ? (a) : (b))
-#endif
-
 #undef RS_EVENT_WRITE_WAKEUP
 #define RS_EVENT_WRITE_WAKEUP	0
 
@@ -159,7 +155,7 @@ static struct specialix_board sx_board[S
 };
 
 static struct specialix_port sx_port[SX_NBOARD * SX_NPORT];
-		
+
 
 #ifdef SPECIALIX_TIMER
 static struct timer_list missed_irq_timer;
@@ -715,7 +711,7 @@ static inline void sx_transmit(struct sp
 				sx_out(bp, CD186x_TDR, CD186x_C_SBRK);
 				port->COR2 &= ~COR2_ETC;
 			}
-			count = MIN(port->break_length, 0xff);
+			count = min_t(int, port->break_length, 0xff);
 			sx_out(bp, CD186x_TDR, CD186x_C_ESC);
 			sx_out(bp, CD186x_TDR, CD186x_C_DELAY);
 			sx_out(bp, CD186x_TDR, count);
@@ -1506,7 +1502,7 @@ static int sx_write(struct tty_struct * 
 	if (from_user) {
 		down(&tmp_buf_sem);
 		while (1) {
-			c = MIN(count, MIN(SERIAL_XMIT_SIZE - port->xmit_cnt - 1,
+			c = min_t(int, count, min(SERIAL_XMIT_SIZE - port->xmit_cnt - 1,
 					   SERIAL_XMIT_SIZE - port->xmit_head));
 			if (c <= 0)
 				break;
@@ -1519,7 +1515,7 @@ static int sx_write(struct tty_struct * 
 			}
 
 			cli();
-			c = MIN(c, MIN(SERIAL_XMIT_SIZE - port->xmit_cnt - 1,
+			c = min_t(int, c, min(SERIAL_XMIT_SIZE - port->xmit_cnt - 1,
 				       SERIAL_XMIT_SIZE - port->xmit_head));
 			memcpy(port->xmit_buf + port->xmit_head, tmp_buf, c);
 			port->xmit_head = (port->xmit_head + c) & (SERIAL_XMIT_SIZE-1);
@@ -1534,7 +1530,7 @@ static int sx_write(struct tty_struct * 
 	} else {
 		while (1) {
 			cli();
-			c = MIN(count, MIN(SERIAL_XMIT_SIZE - port->xmit_cnt - 1,
+			c = min_t(int, count, min(SERIAL_XMIT_SIZE - port->xmit_cnt - 1,
 					   SERIAL_XMIT_SIZE - port->xmit_head));
 			if (c <= 0) {
 				restore_flags(flags);

_
