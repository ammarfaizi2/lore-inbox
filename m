Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751678AbVJ1Ud2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751678AbVJ1Ud2 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Oct 2005 16:33:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751679AbVJ1Ud2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Oct 2005 16:33:28 -0400
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:45072 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1751677AbVJ1Ud1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Oct 2005 16:33:27 -0400
Date: Fri, 28 Oct 2005 22:33:25 +0200
From: Adrian Bunk <bunk@stusta.de>
To: Andrew Morton <akpm@osdl.org>, stable@kernel.org
Cc: linux-kernel@vger.kernel.org, xfs-masters@oss.sgi.com, nathans@sgi.com,
       linux-xfs@oss.sgi.com, Dimitri Puzin <tristan-777@ddkom-online.de>
Subject: [2.6 patch] fix XFS_QUOTA for modular XFS
Message-ID: <20051028203325.GD4180@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch by Dimitri Puzin submitted through kernel Bugzilla #5514 
fixes the following issue:

Cannot build XFS filesystem support as module with quota support. It 
works only when the XFS filesystem support is compiled into the kernel. 
Menuconfig prevents from setting CONFIG_XFS_FS=m and CONFIG_XFS_QUOTA=y.

How to reproduce: configure the XFS filesystem with quota support as 
module. The resulting kernel won't have quota support compiled into 
xfs.ko.

Fix: Changing the fs/xfs/Kconfig file from tristate to bool lets you 
configure the quota support to be compiled into the XFS module. The 
Makefile-linux-2.6 checks only for CONFIG_XFS_QUOTA=y.


From: Dimitri Puzin <tristan-777@ddkom-online.de>
Signed-off-by: Adrian Bunk <bunk@stusta.de>

--- linux-2.6.14-rc5-mm1/fs/xfs/Kconfig.old	2005-10-28 19:51:02.000000000 +0200
+++ linux-2.6.14-rc5-mm1/fs/xfs/Kconfig	2005-10-28 19:51:12.000000000 +0200
@@ -24,7 +24,7 @@
 	default y
 
 config XFS_QUOTA
-	tristate "XFS Quota support"
+	bool "XFS Quota support"
 	depends on XFS_FS
 	help
 	  If you say Y here, you will be able to set limits for disk usage on

