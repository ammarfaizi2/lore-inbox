Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265922AbTHJNuS (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 10 Aug 2003 09:50:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267186AbTHJNuS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 10 Aug 2003 09:50:18 -0400
Received: from [203.145.184.221] ([203.145.184.221]:6674 "EHLO naturesoft.net")
	by vger.kernel.org with ESMTP id S265922AbTHJNuO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 10 Aug 2003 09:50:14 -0400
Subject: [PATCH 2.6.0-test3][OSS] ac97_plugin_ad1980.c: warning fix
From: Vinay K Nallamothu <vinay-rc@naturesoft.net>
To: trivial@rustcorp.com.au
Cc: LKML <linux-kernel@vger.kernel.org>, linux-sound@vger.kernel.org
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-11) 
Date: 10 Aug 2003 19:40:19 +0530
Message-Id: <1060524619.1354.55.camel@lima.royalchallenge.com>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

sound/oss/ac97_plugin_ad1980.c:
fix ad1980_remove to have correct number of arguments

without the patch the following compilation warning is thrown:

sound/oss/ac97_plugin_ad1980.c:90: warning: initialization from
incompatible pointer type



--- linux-2.6.0-test3/sound/oss/ac97_plugin_ad1980.c	2003-07-28 10:44:11.000000000 +0530
+++ linux-2.6.0-test3-nvk/sound/oss/ac97_plugin_ad1980.c	2003-08-10 19:36:14.000000000 +0530
@@ -28,6 +28,7 @@
 
 */
 
+#include <linux/config.h>
 #include <linux/module.h>
 #include <linux/init.h>
 #include <linux/kernel.h>
@@ -45,7 +46,7 @@
  *	use of the codec after the probe function.
  */
  
-static void ad1980_remove(struct ac97_codec *codec)
+static void __devexit ad1980_remove(struct ac97_codec *codec, struct ac97_driver *driver)
 {
 	/* Nothing to do in the simple example */
 }

