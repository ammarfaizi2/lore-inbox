Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262238AbVDLSod@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262238AbVDLSod (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Apr 2005 14:44:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262535AbVDLSme
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Apr 2005 14:42:34 -0400
Received: from fire.osdl.org ([65.172.181.4]:13002 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262238AbVDLKc5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Apr 2005 06:32:57 -0400
Message-Id: <200504121032.j3CAWlw4005676@shell0.pdx.osdl.net>
Subject: [patch 134/198] officially deprecate register_ioctl32_conversion
To: torvalds@osdl.org
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org, hch@lst.de
From: akpm@osdl.org
Date: Tue, 12 Apr 2005 03:32:40 -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


From: Christoph Hellwig <hch@lst.de>

These have been deprecated since ->compat_ioctl when in, thus only a short
deprecation period.  There's four users left: i2o_config, s390/z90crypy,
s390/dasd and s390/zfcp and for the first two patches are about to be
submitted to get rid of it.

Signed-off-by: Andrew Morton <akpm@osdl.org>
---

 25-akpm/Documentation/feature-removal-schedule.txt |    8 ++++++++
 25-akpm/include/linux/ioctl32.h                    |    6 ++++--
 2 files changed, 12 insertions(+), 2 deletions(-)

diff -puN Documentation/feature-removal-schedule.txt~officially-deprecate-register_ioctl32_conversion Documentation/feature-removal-schedule.txt
--- 25/Documentation/feature-removal-schedule.txt~officially-deprecate-register_ioctl32_conversion	2005-04-12 03:21:35.861685096 -0700
+++ 25-akpm/Documentation/feature-removal-schedule.txt	2005-04-12 03:21:35.866684336 -0700
@@ -40,3 +40,11 @@ Why:	Replaced by io_remap_pfn_range() wh
 	addressabilty (by using a pfn) and supports sparc & sparc64
 	iospace as part of the pfn.
 Who:	Randy Dunlap <rddunlap@osdl.org>
+
+---------------------------
+
+What:	register_ioctl32_conversion() / unregister_ioctl32_conversion()
+When:	April 2005
+Why:	Replaced by ->compat_ioctl in file_operations and other method
+	vecors.
+Who:	Andi Kleen <ak@muc.de>, Christoph Hellwig <hch@lst.de>
diff -puN include/linux/ioctl32.h~officially-deprecate-register_ioctl32_conversion include/linux/ioctl32.h
--- 25/include/linux/ioctl32.h~officially-deprecate-register_ioctl32_conversion	2005-04-12 03:21:35.863684792 -0700
+++ 25-akpm/include/linux/ioctl32.h	2005-04-12 03:21:35.866684336 -0700
@@ -1,6 +1,8 @@
 #ifndef IOCTL32_H
 #define IOCTL32_H 1
 
+#include <linux/compiler.h>	/* for __deprecated */
+
 struct file;
 
 typedef int (*ioctl_trans_handler_t)(unsigned int, unsigned int,
@@ -23,9 +25,9 @@ struct ioctl_trans {
  */ 
 
 #ifdef CONFIG_COMPAT
-extern int register_ioctl32_conversion(unsigned int cmd,
+extern int __deprecated register_ioctl32_conversion(unsigned int cmd,
 				ioctl_trans_handler_t handler);
-extern int unregister_ioctl32_conversion(unsigned int cmd);
+extern int __deprecated unregister_ioctl32_conversion(unsigned int cmd);
 
 #else
 
_
