Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265976AbUBBUBO (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Feb 2004 15:01:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265963AbUBBUAg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Feb 2004 15:00:36 -0500
Received: from mailr-2.tiscali.it ([212.123.84.82]:15243 "EHLO
	mailr-2.tiscali.it") by vger.kernel.org with ESMTP id S265898AbUBBT5u
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Feb 2004 14:57:50 -0500
Date: Mon, 2 Feb 2004 20:57:49 +0100
From: Kronos <kronos@kronoz.cjb.net>
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
Cc: linux-kernel@vger.kernel.org
Subject: [Compile Regression in 2.4.25-pre8][PATCH 25/42]
Message-ID: <20040202195749.GY6785@dreamland.darkstar.lan>
Reply-To: kronos@kronoz.cjb.net
References: <20040130204956.GA21643@dreamland.darkstar.lan> <Pine.LNX.4.58L.0401301855410.3140@logos.cnet> <20040202180940.GA6367@dreamland.darkstar.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040202180940.GA6367@dreamland.darkstar.lan>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


it8181fb.c:162: warning: `fontname' defined but not used

fontname is used only when the driver is modular. The initializer is
useless since the variable is static.

diff -Nru -X dontdiff linux-2.4-vanilla/drivers/video/it8181fb.c linux-2.4/drivers/video/it8181fb.c
--- linux-2.4-vanilla/drivers/video/it8181fb.c	Sat Jan 31 15:54:42 2004
+++ linux-2.4/drivers/video/it8181fb.c	Sat Jan 31 18:12:50 2004
@@ -159,7 +159,9 @@
 #define DEFAULT_CONFIG_OFFSET	0
 
 static const char default_mode[] = "800x600-70";
-static char __initdata fontname[40] = { 0 };
+#ifndef MODULE
+static char __initdata fontname[40];
+#endif
 static const char *mode_option __initdata = NULL;
 static int default_bpp __initdata = DEFAULT_BPP;
 static int default_res __initdata = DEFAULT_RES;

-- 
Reply-To: kronos@kronoz.cjb.net
Home: http://kronoz.cjb.net
No matter what you choose, you're still a luser.
