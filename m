Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263614AbTEDOcj (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 4 May 2003 10:32:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263617AbTEDOcj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 4 May 2003 10:32:39 -0400
Received: from smtp-out.comcast.net ([24.153.64.115]:43251 "EHLO
	smtp-out.comcast.net") by vger.kernel.org with ESMTP
	id S263614AbTEDOci (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 4 May 2003 10:32:38 -0400
Date: Sun, 04 May 2003 10:47:01 -0400
From: Chris Heath <chris@heathens.co.nz>
Subject: [PATCH][2.5] keyboard.c Fix CONFIG_MAGIC_SYSRQ+PrintScreen
To: linux-kernel@vger.kernel.org
Message-id: <20030504103511.16C2.CHRIS@heathens.co.nz>
MIME-version: 1.0
X-Mailer: Becky! ver. 2.05.10
Content-type: text/plain; charset=US-ASCII
Content-transfer-encoding: 7BIT
X-Antirelay: Good relay from local net2 68.61.224.73/32
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch fixes the PrintScreen key when CONFIG_MAGIC_SYSRQ is enabled.
It allows you to use that key normally when Alt is not being pressed.
Patch is against kernel 2.5.68.

Chris



--- a/drivers/char/keyboard.c	2003-04-19 12:52:01.000000000 -0400
+++ b/drivers/char/keyboard.c	2003-04-19 12:57:10.000000000 -0400
@@ -1047,8 +1047,8 @@
 				printk(KERN_WARNING "keyboard.c: can't emulate rawmode for keycode %d\n", keycode);
 
 #ifdef CONFIG_MAGIC_SYSRQ	       /* Handle the SysRq Hack */
-	if (keycode == KEY_SYSRQ && !rep) {
-		sysrq_down = sysrq_alt && down;
+	if (keycode == KEY_SYSRQ && (sysrq_down || (down == 1 && sysrq_alt))) {
+		sysrq_down = down;
 		return;
 	}
 	if (sysrq_down && down && !rep) {

