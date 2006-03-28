Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932450AbWC1WSn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932450AbWC1WSn (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Mar 2006 17:18:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932449AbWC1WSm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Mar 2006 17:18:42 -0500
Received: from mx2.netapp.com ([216.240.18.37]:40806 "EHLO mx2.netapp.com")
	by vger.kernel.org with ESMTP id S932445AbWC1WSl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Mar 2006 17:18:41 -0500
X-IronPort-AV: i="4.03,140,1141632000"; 
   d="scan'208"; a="370547088:sNHT221255160"
Subject: [PATCH] config: Fix CONFIG_LFS option
From: Trond Myklebust <Trond.Myklebust@netapp.com>
To: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org,
       Linux Filesystem Development <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: Network Appliance, Inc
Date: Tue, 28 Mar 2006 17:18:39 -0500
Message-Id: <1143584319.8199.34.camel@lade.trondhjem.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.1 
X-OriginalArrivalTime: 28 Mar 2006 22:18:40.0668 (UTC) FILETIME=[91490DC0:01C652B5]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The help text says that if you select CONFIG_LBD, then it will
automatically select CONFIG_LFS. Nope... That isn't currently the
case.

 - Fix CONFIG_LBD to automatically select CONFIG_LFS
 - Get rid of the cruft in the help text mentioning CONFIG_LBD
 - Tell unsure users to select CONFIG_LFS.

Signed-off-by: Trond Myklebust <Trond.Myklebust@netapp.com>
---

 block/Kconfig |   11 ++++++-----
 1 files changed, 6 insertions(+), 5 deletions(-)

diff --git a/block/Kconfig b/block/Kconfig
index 5536839..8b4762c 100644
--- a/block/Kconfig
+++ b/block/Kconfig
@@ -6,6 +6,7 @@ #for instance.
 config LBD
 	bool "Support for Large Block Devices"
 	depends on X86 || (MIPS && 32BIT) || PPC32 || (S390 && !64BIT) || SUPERH || UML
+	select LSF
 	help
 	  Say Y here if you want to attach large (bigger than 2TB) discs to
 	  your machine, or if you want to have a raid or loopback device
@@ -27,10 +28,10 @@ config BLK_DEV_IO_TRACE
 config LSF
 	bool "Support for Large Single Files"
 	depends on X86 || (MIPS && 32BIT) || PPC32 || ARCH_S390_31 || SUPERH || UML
-	default n
-	help
-	  When CONFIG_LBD is disabled, say Y here if you want to
-	  handle large file(bigger than 2TB), otherwise say N.
-	  When CONFIG_LBD is enabled, Y is set automatically.
+	help
+	  Say Y here if you want to be able to handle very large files (bigger
+	  than 2TB), otherwise say N.
+
+	  If unsure, say Y.
 
 source block/Kconfig.iosched
