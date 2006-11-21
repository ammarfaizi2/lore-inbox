Return-Path: <linux-kernel-owner+willy=40w.ods.org-S966596AbWKUFPk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S966596AbWKUFPk (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Nov 2006 00:15:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S966908AbWKUFPk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Nov 2006 00:15:40 -0500
Received: from mo30.po.2iij.net ([210.128.50.53]:25134 "EHLO mo30.po.2iij.net")
	by vger.kernel.org with ESMTP id S966596AbWKUFPk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Nov 2006 00:15:40 -0500
Date: Tue, 21 Nov 2006 14:15:28 +0900
From: Yoichi Yuasa <yoichi_yuasa@tripeaks.co.jp>
To: Andrew Morton <akpm@osdl.org>
Cc: yoichi_yuasa@tripeaks.co.jp,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH] add return value checking of get_user() in
 set_vesa_blanking()
Message-Id: <20061121141528.234a9335.yoichi_yuasa@tripeaks.co.jp>
Organization: TriPeaks Corporation
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This patch has added return value checking of get_user() in set_vesa_blanking().

Yoichi

Signed-off-by: Yoichi Yuasa <yoichi_yuasa@tripeaks.co.jp>
 
diff -pruN -X generic/Documentation/dontdiff generic-orig/drivers/char/vt.c generic/drivers/char/vt.c
--- generic-orig/drivers/char/vt.c	2006-11-21 10:23:39.409667250 +0900
+++ generic/drivers/char/vt.c	2006-11-21 10:11:48.037209250 +0900
@@ -3318,9 +3318,10 @@ postcore_initcall(vtconsole_class_init);
 
 static void set_vesa_blanking(char __user *p)
 {
-    unsigned int mode;
-    get_user(mode, p + 1);
-    vesa_blank_mode = (mode < 4) ? mode : 0;
+	unsigned int mode;
+
+	if (!get_user(mode, p + 1))
+		vesa_blank_mode = (mode < 4) ? mode : 0;
 }
 
 void do_blank_screen(int entering_gfx)
