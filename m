Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261895AbTKHRnC (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 8 Nov 2003 12:43:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261901AbTKHRnC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 8 Nov 2003 12:43:02 -0500
Received: from galileo.bork.org ([66.11.174.156]:47531 "HELO galileo.bork.org")
	by vger.kernel.org with SMTP id S261895AbTKHRm7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 8 Nov 2003 12:42:59 -0500
Subject: [PATCH 2.6] Number of proc entries based on NR_CPUS ?
From: Martin Hicks <mort@wildopensource.com>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Organization: Wild Open Source Inc.
Message-Id: <1068313378.685.7.camel@socrates>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Sat, 08 Nov 2003 12:42:58 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Here is a patch that makes the number of /proc entries be based on
NR_CPUS instead of just having a fixed number.  I think it is a good
idea now that big Linux machines are starting to appear.

The proper constant and slope of increase are up for argument too.

Patch is against the latest linux-2.5 bk tree.

Opinions?
mh

-- 
Martin Hicks                Wild Open Source Inc.
mort@wildopensource.com     613-266-2296


# This is a BitKeeper generated patch for the following project:
# Project Name: Linux kernel tree
# This patch format is intended for GNU patch command version 2.5 or higher.
# This patch includes the following deltas:
#	           ChangeSet	1.1359  -> 1.1360 
#	include/linux/proc_fs.h	1.27    -> 1.28   
#
# The following is the BitKeeper ChangeSet Log
# --------------------------------------------
# 03/11/08	mort@green.i.bork.org	1.1360
# Make PROC_NDYNAMIC based on NR_CPUS.
# --------------------------------------------
#
diff -Nru a/include/linux/proc_fs.h b/include/linux/proc_fs.h
--- a/include/linux/proc_fs.h	Sat Nov  8 12:38:34 2003
+++ b/include/linux/proc_fs.h	Sat Nov  8 12:38:34 2003
@@ -27,7 +27,7 @@
 /* Finally, the dynamically allocatable proc entries are reserved: */
 
 #define PROC_DYNAMIC_FIRST 4096
-#define PROC_NDYNAMIC      16384
+#define PROC_NDYNAMIC      (4096+32*NR_CPUS)
 
 #define PROC_SUPER_MAGIC 0x9fa0
 


