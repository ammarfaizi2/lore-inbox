Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268080AbUIAVJm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268080AbUIAVJm (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Sep 2004 17:09:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268076AbUIAVIg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Sep 2004 17:08:36 -0400
Received: from baikonur.stro.at ([213.239.196.228]:52187 "EHLO
	baikonur.stro.at") by vger.kernel.org with ESMTP id S267918AbUIAU4G
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Sep 2004 16:56:06 -0400
Subject: [patch 05/25]  drivers/char/mxser.c MIN/MAX removal
To: linux-kernel@vger.kernel.org
Cc: akpm@digeo.com, janitor@sternwelten.at
From: janitor@sternwelten.at
Date: Wed, 01 Sep 2004 22:56:06 +0200
Message-ID: <E1C2c9G-0007Ij-BG@sputnik>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Patch (against 2.6.7) removes unnecessary min/max macros and changes
calls to use kernel.h macros instead.

Feedback is always welcome
Michael

Signed-off-by: Maximilian Attems <janitor@sternwelten.at>




---

 linux-2.6.9-rc1-bk7-max/drivers/char/mxser.c |   10 +++-------
 1 files changed, 3 insertions(+), 7 deletions(-)

diff -puN drivers/char/mxser.c~min-max-char_mxser drivers/char/mxser.c
--- linux-2.6.9-rc1-bk7/drivers/char/mxser.c~min-max-char_mxser	2004-09-01 19:33:54.000000000 +0200
+++ linux-2.6.9-rc1-bk7-max/drivers/char/mxser.c	2004-09-01 19:33:54.000000000 +0200
@@ -101,10 +101,6 @@
 
 #define IRQ_T(info) ((info->flags & ASYNC_SHARE_IRQ) ? SA_SHIRQ : SA_INTERRUPT)
 
-#ifndef MIN
-#define MIN(a,b)	((a) < (b) ? (a) : (b))
-#endif
-
 /*
  *    Define the Moxa PCI vendor and device IDs.
  */
@@ -849,7 +845,7 @@ static int mxser_write(struct tty_struct
 	if (from_user) {
 		down(&mxvar_tmp_buf_sem);
 		while (1) {
-			c = MIN(count, MIN(SERIAL_XMIT_SIZE - info->xmit_cnt - 1,
+			c = min_t(int, count, min(SERIAL_XMIT_SIZE - info->xmit_cnt - 1,
 					   SERIAL_XMIT_SIZE - info->xmit_head));
 			if (c <= 0)
 				break;
@@ -862,7 +858,7 @@ static int mxser_write(struct tty_struct
 			}
 
 			cli();
-			c = MIN(c, MIN(SERIAL_XMIT_SIZE - info->xmit_cnt - 1,
+			c = min_t(int, c, min(SERIAL_XMIT_SIZE - info->xmit_cnt - 1,
 				       SERIAL_XMIT_SIZE - info->xmit_head));
 			memcpy(info->xmit_buf + info->xmit_head, mxvar_tmp_buf, c);
 			info->xmit_head = (info->xmit_head + c) & (SERIAL_XMIT_SIZE - 1);
@@ -877,7 +873,7 @@ static int mxser_write(struct tty_struct
 	} else {
 		while (1) {
 			cli();
-			c = MIN(count, MIN(SERIAL_XMIT_SIZE - info->xmit_cnt - 1,
+			c = min_t(int, count, min(SERIAL_XMIT_SIZE - info->xmit_cnt - 1,
 					   SERIAL_XMIT_SIZE - info->xmit_head));
 			if (c <= 0) {
 				restore_flags(flags);

_
