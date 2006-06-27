Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422651AbWF0WRL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422651AbWF0WRL (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Jun 2006 18:17:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422660AbWF0WQp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Jun 2006 18:16:45 -0400
Received: from mail.gmx.de ([213.165.64.21]:35258 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1422651AbWF0WQR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Jun 2006 18:16:17 -0400
X-Authenticated: #704063
Subject: [Patch] Overrun in drivers/input/joystick/db9.c
From: Eric Sesterhenn <snakebyte@gmx.de>
To: linux-kernel@vger.kernel.org
Cc: dmitry.torokhov@gmail.com
Content-Type: text/plain
Date: Wed, 28 Jun 2006 00:16:14 +0200
Message-Id: <1151446574.15289.7.camel@alice>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hi,

coverity spotted this overrun (#id 483), we assign 
db9_mode = &db9_modes[mode]; some lines before, so
if we use mode as index again we might get past the
array once mode is greater than DB9_MAX_PAD/2,
besides this this patch changes the code to what
the author possibly intended it to do.

Signed-off-by: Eric Sesterhenn <snakebyte@gmx.de>

--- linux-2.6.17-git11/drivers/input/joystick/db9.c.orig	2006-06-28 00:06:47.000000000 +0200
+++ linux-2.6.17-git11/drivers/input/joystick/db9.c	2006-06-28 00:08:32.000000000 +0200
@@ -584,7 +584,7 @@ static struct db9 __init *db9_probe(int 
 		goto err_out;
 	}
 
-	if (db9_mode[mode].bidirectional && !(pp->modes & PARPORT_MODE_TRISTATE)) {
+	if (db9_mode->bidirectional && !(pp->modes & PARPORT_MODE_TRISTATE)) {
 		printk(KERN_ERR "db9.c: specified parport is not bidirectional\n");
 		err = -EINVAL;
 		goto err_put_pp;


