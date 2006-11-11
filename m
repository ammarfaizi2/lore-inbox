Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1754887AbWKKWlH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754887AbWKKWlH (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 11 Nov 2006 17:41:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754890AbWKKWlH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 11 Nov 2006 17:41:07 -0500
Received: from cacti2.profiwh.com ([85.93.165.64]:63420 "EHLO
	cacti.profiwh.com") by vger.kernel.org with ESMTP id S1754888AbWKKWlE
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 11 Nov 2006 17:41:04 -0500
Message-id: <27094265271711311084@wsc.cz>
In-reply-to: <30973309282550314198@wsc.cz>
Subject: [PATCH 4/4] Char: cyclades, fix warnings
From: Jiri Slaby <jirislaby@gmail.com>
To: Andrew Morton <akpm@osdl.org>
Cc: <linux-kernel@vger.kernel.org>
Cc: <support@cyclades.com>
Date: Sat, 11 Nov 2006 23:41:16 +0100 (CET)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

cyclades, fix warnings

fix gcc signed/unsigned warnings

Signed-off-by: Jiri Slaby <jirislaby@gmail.com>

---
commit d58848fe07c13a82e9d429d481f9677857e73019
tree f3bb653ef8a7de4d91d172f1763904051849055b
parent 76495d5f78bf804b07f646abfbcb7a0a12938e11
author Jiri Slaby <jirislaby@gmail.com> Thu, 09 Nov 2006 22:21:54 +0100
committer Jiri Slaby <jirislaby@gmail.com> Thu, 09 Nov 2006 22:21:54 +0100

 drivers/char/cyclades.c |    5 +++--
 1 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/char/cyclades.c b/drivers/char/cyclades.c
index f3efe85..4711a7b 100644
--- a/drivers/char/cyclades.c
+++ b/drivers/char/cyclades.c
@@ -1647,7 +1647,8 @@ #ifdef CONFIG_CYZ_INTR
 				char_count = rx_put - rx_get;
 			else
 				char_count = rx_put - rx_get + rx_bufsize;
-			if (char_count >= cy_readl(&buf_ctrl->rx_threshold)) {
+			if (char_count >= (int)cy_readl(&buf_ctrl->
+					rx_threshold)) {
 				cy_sched_event(info, Cy_EVENT_Z_RX_FULL);
 			}
 #endif
@@ -2944,7 +2945,7 @@ #endif
 		return;
 
 	CY_LOCK(info, flags);
-	if (info->xmit_cnt >= SERIAL_XMIT_SIZE - 1) {
+	if (info->xmit_cnt >= (int)(SERIAL_XMIT_SIZE - 1)) {
 		CY_UNLOCK(info, flags);
 		return;
 	}
