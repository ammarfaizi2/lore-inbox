Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261932AbUGLTzT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261932AbUGLTzT (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Jul 2004 15:55:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262079AbUGLTzS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Jul 2004 15:55:18 -0400
Received: from mail.convergence.de ([212.84.236.4]:16539 "EHLO
	mail.convergence.de") by vger.kernel.org with ESMTP id S261932AbUGLTy4
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Jul 2004 15:54:56 -0400
Message-ID: <40F2EC8C.7080101@convergence.de>
Date: Mon, 12 Jul 2004 21:54:52 +0200
From: Michael Hunold <hunold@convergence.de>
User-Agent: Mozilla Thunderbird 0.7 (X11/20040615)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@osdl.org>
CC: Arthur Othieno <a.othieno@bluewin.ch>, Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       a.othieno@bluewin.ch
Subject: [PATCH][2.6] fix return codes after i2c_add_driver() in tea6415c
 and tea6420
References: <20040622154839.GI1473@mars>
In-Reply-To: <20040622154839.GI1473@mars>
Content-Type: multipart/mixed;
 boundary="------------030206030800090904080902"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------030206030800090904080902
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Hello Linus, Andrew,

in two of my i2c helper drivers the return value of i2c_add_driver() is 
ignored. Thanks to Arthur Othieno for finding these bugs.

The patch is trivial. Please apply.

CU
Michael.

--------------030206030800090904080902
Content-Type: text/plain;
 name="misc-i2c-module-fixes.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="misc-i2c-module-fixes.diff"

- [V4L] - i2c_add_driver() may actually fail, but both tea6420 and tea6415c driver return 0 regardless

Signed-off-by: Arthur Othieno <a.othieno@bluewin.ch>
Signed-off-by: Michael Hunold <hunold@linuxtv.org>

--- a/drivers/media/video/tea6420.c	2003-12-18 03:58:49.000000000 +0100
+++ b/drivers/media/video/tea6420.c	2004-06-04 18:14:36.000000000 +0200
@@ -197,13 +197,12 @@ static struct i2c_driver driver = {
         .command	= tea6420_command,
 };
 
-static int tea6420_init_module(void)
+static int __init tea6420_init_module(void)
 {
-	i2c_add_driver(&driver);
-	return 0;
+	return i2c_add_driver(&driver);
 }
 
-static void tea6420_cleanup_module(void)
+static void __exit tea6420_cleanup_module(void)
 {
         i2c_del_driver(&driver);
 }
--- a/drivers/media/video/tea6415c.c	2003-12-18 03:59:16.000000000 +0100
+++ b/drivers/media/video/tea6415c.c	2004-03-31 20:24:35.000000000 +0200
@@ -217,13 +217,12 @@ static struct i2c_driver driver = {
         .command	= tea6415c_command,
 };
 
-static int tea6415c_init_module(void)
+static int __init tea6415c_init_module(void)
 {
-	i2c_add_driver(&driver);
-	return 0;
+	return i2c_add_driver(&driver);
 }
 
-static void tea6415c_cleanup_module(void)
+static void __exit tea6415c_cleanup_module(void)
 {
         i2c_del_driver(&driver);
 }

--------------030206030800090904080902--
