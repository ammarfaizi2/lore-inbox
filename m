Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261363AbVGQTnN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261363AbVGQTnN (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 17 Jul 2005 15:43:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261385AbVGQTnM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 17 Jul 2005 15:43:12 -0400
Received: from mailout.stusta.mhn.de ([141.84.69.5]:59406 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S261363AbVGQTmK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 17 Jul 2005 15:42:10 -0400
Date: Sun, 17 Jul 2005 21:42:08 +0200
From: Adrian Bunk <bunk@stusta.de>
To: ocfs2-devel@oss.oracle.com
Cc: linux-kernel@vger.kernel.org
Subject: [-mm patch] OCFS2_FS must depend on NET
Message-ID: <20050717194207.GB3753@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

If you select some variable, you have to ensure that the dependencies of 
the select'ed variable are fulfilled.

OCFS2_FS=y, NET=n, INET=y is not a legal combination (resulting in link 
errors).

Signed-off-by: Adrian Bunk <bunk@stusta.de>

--- linux-2.6.13-rc3-mm1-full/fs/Kconfig.old	2005-07-17 21:35:15.000000000 +0200
+++ linux-2.6.13-rc3-mm1-full/fs/Kconfig	2005-07-17 21:35:54.000000000 +0200
@@ -327,11 +327,11 @@
 
 source "fs/xfs/Kconfig"
 
 config OCFS2_FS
 	tristate "OCFS2 file system support (EXPERIMENTAL)"
-	depends on EXPERIMENTAL && (X86 || IA64 || X86_64 || BROKEN)
+	depends on NET && EXPERIMENTAL && (X86 || IA64 || X86_64 || BROKEN)
 	select CONFIGFS_FS
 	select JBD
 	select CRC32
 	select INET
 	help


