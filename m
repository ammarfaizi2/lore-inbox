Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313638AbSGYON6>; Thu, 25 Jul 2002 10:13:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314078AbSGYON6>; Thu, 25 Jul 2002 10:13:58 -0400
Received: from draco.netpower.no ([212.33.133.34]:47368 "EHLO
	draco.netpower.no") by vger.kernel.org with ESMTP
	id <S313638AbSGYON4>; Thu, 25 Jul 2002 10:13:56 -0400
Date: Thu, 25 Jul 2002 16:16:30 +0200
From: Erlend Aasland <erlend-a@innova.no>
To: Patchmonkey <trivial@rustcorp.com.au>
Cc: LKML <linux-kernel@vger.kernel.org>, jffs-dev <jffs-dev@axis.com>
Subject: [TRIVIAL][PATCH 2.5] Fix JFFS when procfs is not enabled
Message-ID: <20020725161630.A23807@innova.no>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Here's a trivial one. Only ask for procfs support when procfs is
enabled.

It's against a clean 2.5.28 tree.


Regards,
	Erlend Aasland

--- linux-2.5.28/fs/Config.in	2002-07-18 12:34:26.000000000 +0200
+++ linux-2.5.28-dirty/fs/Config.in	2002-07-23 03:56:10.000000000 +0200
@@ -44,8 +44,8 @@
 dep_tristate 'EFS file system support (read only) (EXPERIMENTAL)' CONFIG_EFS_FS $CONFIG_EXPERIMENTAL
 dep_tristate 'Journalling Flash File System (JFFS) support' CONFIG_JFFS_FS $CONFIG_MTD
 if [ "$CONFIG_JFFS_FS" = "y" -o "$CONFIG_JFFS_FS" = "m" ] ; then
-   int 'JFFS debugging verbosity (0 = quiet, 3 = noisy)' CONFIG_JFFS_FS_VERBOSE 0
-   bool 'JFFS stats available in /proc filesystem' CONFIG_JFFS_PROC_FS
+   int '  JFFS debugging verbosity (0 = quiet, 3 = noisy)' CONFIG_JFFS_FS_VERBOSE 0
+   dep_bool '  JFFS stats available in /proc filesystem' CONFIG_JFFS_PROC_FS $CONFIG_PROC_FS
 fi
 dep_tristate 'Journalling Flash File System v2 (JFFS2) support' CONFIG_JFFS2_FS $CONFIG_MTD
 if [ "$CONFIG_JFFS2_FS" = "y" -o "$CONFIG_JFFS2_FS" = "m" ] ; then
