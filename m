Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267958AbUIAVgw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267958AbUIAVgw (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Sep 2004 17:36:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268073AbUIAVGJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Sep 2004 17:06:09 -0400
Received: from baikonur.stro.at ([213.239.196.228]:50904 "EHLO
	baikonur.stro.at") by vger.kernel.org with ESMTP id S267974AbUIAU4p
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Sep 2004 16:56:45 -0400
Subject: [patch 12/25]  drivers/char/serial167.c MIN/MAX removal
To: linux-kernel@vger.kernel.org
Cc: akpm@digeo.com, janitor@sternwelten.at
From: janitor@sternwelten.at
Date: Wed, 01 Sep 2004 22:56:44 +0200
Message-ID: <E1C2c9s-0007Nh-JW@sputnik>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Patch (against 2.6.7) removes unnecessary min/max macros and changes
calls to use kernel.h macros instead.

Feedback is always welcome
Michael

Signed-off-by: Maximilian Attems <janitor@sternwelten.at>



---

 linux-2.6.9-rc1-bk7-max/drivers/char/serial167.c |   16 ++++++----------
 1 files changed, 6 insertions(+), 10 deletions(-)

diff -puN drivers/char/serial167.c~min-max-char_serial167 drivers/char/serial167.c
--- linux-2.6.9-rc1-bk7/drivers/char/serial167.c~min-max-char_serial167	2004-09-01 19:34:12.000000000 +0200
+++ linux-2.6.9-rc1-bk7-max/drivers/char/serial167.c	2004-09-01 19:34:12.000000000 +0200
@@ -83,10 +83,6 @@
 #undef  CYCLOM_16Y_HACK
 #define  CYCLOM_ENABLE_MONITORING
 
-#ifndef MIN
-#define MIN(a,b)	((a) < (b) ? (a) : (b))
-#endif
-
 #define WAKEUP_CHARS 256
 
 #define STD_COM_FLAGS (0)
@@ -1238,8 +1234,8 @@ cy_write(struct tty_struct * tty, int fr
     if (from_user) {
 	    down(&tmp_buf_sem);
 	    while (1) {
-		    c = MIN(count, MIN(SERIAL_XMIT_SIZE - info->xmit_cnt - 1,
-				       SERIAL_XMIT_SIZE - info->xmit_head));
+		    c = min_t(int, count, min(SERIAL_XMIT_SIZE - info->xmit_cnt - 1,
+					      SERIAL_XMIT_SIZE - info->xmit_head));
 		    if (c <= 0)
 			    break;
 
@@ -1251,8 +1247,8 @@ cy_write(struct tty_struct * tty, int fr
 		    }
 
 		    local_irq_save(flags);
-		    c = MIN(c, MIN(SERIAL_XMIT_SIZE - info->xmit_cnt - 1,
-				   SERIAL_XMIT_SIZE - info->xmit_head));
+		    c = min_t(int, c, min(SERIAL_XMIT_SIZE - info->xmit_cnt - 1,
+					  SERIAL_XMIT_SIZE - info->xmit_head));
 		    memcpy(info->xmit_buf + info->xmit_head, tmp_buf, c);
 		    info->xmit_head = (info->xmit_head + c) & (SERIAL_XMIT_SIZE-1);
 		    info->xmit_cnt += c;
@@ -1266,8 +1262,8 @@ cy_write(struct tty_struct * tty, int fr
     } else {
 	    while (1) {
 		    local_irq_save(flags);
-		    c = MIN(count, MIN(SERIAL_XMIT_SIZE - info->xmit_cnt - 1,
-				       SERIAL_XMIT_SIZE - info->xmit_head));
+		    c = min_t(int, count, min(SERIAL_XMIT_SIZE - info->xmit_cnt - 1,
+					      SERIAL_XMIT_SIZE - info->xmit_head));
 		    if (c <= 0) {
 			    local_irq_restore(flags);
 			    break;

_
