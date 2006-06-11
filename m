Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751040AbWFKVOp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751040AbWFKVOp (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 11 Jun 2006 17:14:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751047AbWFKVOo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 11 Jun 2006 17:14:44 -0400
Received: from mail.gmx.de ([213.165.64.20]:20458 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1751039AbWFKVOo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 11 Jun 2006 17:14:44 -0400
X-Authenticated: #704063
Subject: [Patch] Cyclades Cleanup
From: Eric Sesterhenn <snakebyte@gmx.de>
To: linux-kernel@vger.kernel.org
Cc: async@cyclades.com
Content-Type: text/plain
Date: Sun, 11 Jun 2006 23:14:40 +0200
Message-Id: <1150060480.9319.2.camel@alice>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hi,

coverity choked at two !tty checks, in places where tty can
never be NULL. Since it removes some code we should remove
these checks. (Coverity ids #763,#762)

Signed-off-by Eric Sesterhenn <snakebyte@gmx.de>

--- linux-2.6.17-rc5/drivers/char/cyclades.c.orig	2006-06-11 23:11:35.000000000 +0200
+++ linux-2.6.17-rc5/drivers/char/cyclades.c	2006-06-11 23:11:55.000000000 +0200
@@ -2833,7 +2833,7 @@ cy_write(struct tty_struct * tty, const 
         return 0;
     }
         
-    if (!tty || !info->xmit_buf || !tmp_buf){
+    if (!info->xmit_buf || !tmp_buf){
         return 0;
     }
 
@@ -2884,7 +2884,7 @@ cy_put_char(struct tty_struct *tty, unsi
     if (serial_paranoia_check(info, tty->name, "cy_put_char"))
         return;
 
-    if (!tty || !info->xmit_buf)
+    if (!info->xmit_buf)
         return;
 
     CY_LOCK(info, flags);


