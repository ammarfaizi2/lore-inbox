Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266252AbUBDG3b (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Feb 2004 01:29:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266261AbUBDG3a
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Feb 2004 01:29:30 -0500
Received: from mo02.iij4u.or.jp ([210.130.0.19]:26107 "EHLO mo02.iij4u.or.jp")
	by vger.kernel.org with ESMTP id S266252AbUBDG33 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Feb 2004 01:29:29 -0500
Date: Wed, 4 Feb 2004 15:29:17 +0900
From: Yoichi Yuasa <yuasa@hh.iij4u.or.jp>
To: marcelo.tosatti@cyclades.com.br
Cc: yuasa@hh.iij4u.or.jp, linux-kernel@vger.kernel.org
Subject: [PATCH 2.4] Fixed compile warning about IDE driver
Message-Id: <20040204152917.2fbd07b3.yuasa@hh.iij4u.or.jp>
X-Mailer: Sylpheed version 0.9.8a (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

When I was compiling by config of CASIO E55, I found the following warnings.

ide.c:175: warning: `ide_scan_direction' defined but not used
ide-lib.c: In function `ide_rate_filter':
ide-lib.c:174: warning: comparison of distinct pointer types lacks a cast

I made a patch for fixing this warnings.
Please apply this patch to v2.4.

Yoichi

diff -urN -X dontdiff mips-orig/drivers/ide/ide-lib.c mips/drivers/ide/ide-lib.c
--- mips-orig/drivers/ide/ide-lib.c	2004-02-04 12:57:41.000000000 +0900
+++ mips/drivers/ide/ide-lib.c	2004-02-04 12:51:59.000000000 +0900
@@ -171,7 +171,7 @@
 		BUG();
 	return min(speed, speed_max[mode]);
 #else /* !CONFIG_BLK_DEV_IDEDMA */
-	return min(speed, XFER_PIO_4);
+	return min(speed, (u8)XFER_PIO_4);
 #endif /* CONFIG_BLK_DEV_IDEDMA */
 }
 
diff -urN -X dontdiff mips-orig/drivers/ide/ide.c mips/drivers/ide/ide.c
--- mips-orig/drivers/ide/ide.c	2004-02-04 13:00:43.000000000 +0900
+++ mips/drivers/ide/ide.c	2004-02-04 12:51:00.000000000 +0900
@@ -172,7 +172,9 @@
 static int system_bus_speed;	/* holds what we think is VESA/PCI bus speed */
 static int initializing;	/* set while initializing built-in drivers */
 
+#ifdef CONFIG_BLK_DEV_IDEPCI
 static int ide_scan_direction;	/* THIS was formerly 2.2.x pci=reverse */
+#endif
 
 #ifdef CONFIG_IDEDMA_AUTO
 int noautodma = 0;
