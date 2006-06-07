Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932440AbWFGWLR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932440AbWFGWLR (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Jun 2006 18:11:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932441AbWFGWLR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Jun 2006 18:11:17 -0400
Received: from mail.gmx.net ([213.165.64.20]:35487 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S932440AbWFGWLQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Jun 2006 18:11:16 -0400
X-Authenticated: #704063
Subject: [PATCH] Synclink.c cleanup
From: Eric Sesterhenn <snakebyte@gmx.de>
To: linux-kernel@vger.kernel.org
Cc: paulkf@microgate.com
Content-Type: text/plain
Date: Thu, 08 Jun 2006 00:11:09 +0200
Message-Id: <1149718269.16898.3.camel@alice>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hi,

coverity was lead to two false bug reports ( #782, #783 )
where the driver checked if tty was valid, when it should
always be. All cases which I found call these functions
by tty->driver->mgsl_write(...) so tty has to be valid.
This patch removes those two checks.

Signed-off-by: Eric Sesterhenn <snakebyte@gmx.de>

--- linux-2.6.17-rc5/drivers/char/synclink.c.orig	2006-06-08 00:06:04.000000000 +0200
+++ linux-2.6.17-rc5/drivers/char/synclink.c	2006-06-08 00:06:56.000000000 +0200
@@ -2049,7 +2049,7 @@ static void mgsl_put_char(struct tty_str
 	if (mgsl_paranoia_check(info, tty->name, "mgsl_put_char"))
 		return;
 
-	if (!tty || !info->xmit_buf)
+	if (!info->xmit_buf)
 		return;
 
 	spin_lock_irqsave(&info->irq_spinlock,flags);
@@ -2139,7 +2139,7 @@ static int mgsl_write(struct tty_struct 
 	if (mgsl_paranoia_check(info, tty->name, "mgsl_write"))
 		goto cleanup;
 
-	if (!tty || !info->xmit_buf)
+	if (!info->xmit_buf)
 		goto cleanup;
 
 	if ( info->params.mode == MGSL_MODE_HDLC ||


