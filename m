Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267918AbUIAVJn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267918AbUIAVJn (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Sep 2004 17:09:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267935AbUIAVIR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Sep 2004 17:08:17 -0400
Received: from baikonur.stro.at ([213.239.196.228]:21895 "EHLO
	baikonur.stro.at") by vger.kernel.org with ESMTP id S267926AbUIAU4M
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Sep 2004 16:56:12 -0400
Subject: [patch 06/25]  drivers/char/pcmcia/synclink_cs.c MIN/MAX 	removal
To: linux-kernel@vger.kernel.org
Cc: akpm@digeo.com, janitor@sternwelten.at
From: janitor@sternwelten.at
Date: Wed, 01 Sep 2004 22:56:11 +0200
Message-ID: <E1C2c9L-0007JR-PK@sputnik>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Patch (against 2.6.7) removes unnecessary min/max macros and changes
calls to use kernel.h macros instead.

Feedback is always welcome
Michael

Signed-off-by: Maximilian Attems <janitor@sternwelten.at>



---

 linux-2.6.9-rc1-bk7-max/drivers/char/pcmcia/synclink_cs.c |   12 ++++--------
 1 files changed, 4 insertions(+), 8 deletions(-)

diff -puN drivers/char/pcmcia/synclink_cs.c~min-max-char_pcmcia_synclink_cs drivers/char/pcmcia/synclink_cs.c
--- linux-2.6.9-rc1-bk7/drivers/char/pcmcia/synclink_cs.c~min-max-char_pcmcia_synclink_cs	2004-09-01 19:33:54.000000000 +0200
+++ linux-2.6.9-rc1-bk7-max/drivers/char/pcmcia/synclink_cs.c	2004-09-01 19:33:54.000000000 +0200
@@ -494,10 +494,6 @@ static struct tty_driver *serial_driver;
 static void mgslpc_change_params(MGSLPC_INFO *info);
 static void mgslpc_wait_until_sent(struct tty_struct *tty, int timeout);
 
-#ifndef MIN
-#define MIN(a,b)	((a) < (b) ? (a) : (b))
-#endif
-
 /* PCMCIA prototypes */
 
 static void mgslpc_config(dev_link_t *link);
@@ -1191,7 +1187,7 @@ void tx_ready(MGSLPC_INFO *info) 
 		return;
 
 	while (info->tx_count && fifo_count) {
-		c = MIN(2, MIN(fifo_count, MIN(info->tx_count, TXBUFSIZE - info->tx_get)));
+		c = min(2, min_t(int, fifo_count, min(info->tx_count, TXBUFSIZE - info->tx_get)));
 		
 		if (c == 1) {
 			write_reg(info, CHA + TXFIFO, *(info->tx_buf + info->tx_get));
@@ -1754,8 +1750,8 @@ static int mgslpc_write(struct tty_struc
 	}
 
 	for (;;) {
-		c = MIN(count,
-			MIN(TXBUFSIZE - info->tx_count - 1,
+		c = min(count,
+			min(TXBUFSIZE - info->tx_count - 1,
 			    TXBUFSIZE - info->tx_put));
 		if (c <= 0)
 			break;
@@ -2641,7 +2637,7 @@ static void mgslpc_wait_until_sent(struc
 		char_time = 1;
 		
 	if (timeout)
-		char_time = MIN(char_time, timeout);
+		char_time = min_t(unsigned long, char_time, timeout);
 		
 	if (info->params.mode == MGSL_MODE_HDLC) {
 		while (info->tx_active) {

_
