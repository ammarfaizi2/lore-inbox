Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261670AbVCaToB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261670AbVCaToB (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 31 Mar 2005 14:44:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261675AbVCaToB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 31 Mar 2005 14:44:01 -0500
Received: from verein.lst.de ([213.95.11.210]:2536 "EHLO mail.lst.de")
	by vger.kernel.org with ESMTP id S261670AbVCaTn4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 31 Mar 2005 14:43:56 -0500
Date: Thu, 31 Mar 2005 21:43:44 +0200
From: Christoph Hellwig <hch@lst.de>
To: akpm@osdl.org
Cc: ak@muc.de, linux-kernel@vger.kernel.org
Subject: [PATCH] officially deprecate register_ioctl32_conversion
Message-ID: <20050331194344.GA8965@lst.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
X-Spam-Score: -4.901 () BAYES_00
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

These have been deprecated since ->compat_ioctl when in, thus only a
short deprecation period.  There's four users left:  i2o_config,
s390/z90crypy, s390/dasd and s390/zfcp and for the first two patches
are about to be submitted to get rid of it.


--- 1.8/Documentation/feature-removal-schedule.txt	2005-03-29 00:21:41 +02:00
+++ edited/Documentation/feature-removal-schedule.txt	2005-03-31 17:17:42 +02:00
@@ -46,3 +46,11 @@
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
--- 1.5/include/linux/ioctl32.h	2004-08-27 08:30:32 +02:00
+++ edited/include/linux/ioctl32.h	2005-03-31 17:18:24 +02:00
@@ -1,6 +1,8 @@
 #ifndef IOCTL32_H
 #define IOCTL32_H 1
 
+#include <linux/compilers.h> /* for __deprecated */
+
 struct file;
 
 typedef int (*ioctl_trans_handler_t)(unsigned int, unsigned int,
@@ -23,9 +25,9 @@
  */ 
 
 #ifdef CONFIG_COMPAT
-extern int register_ioctl32_conversion(unsigned int cmd,
+extern int __deprecated register_ioctl32_conversion(unsigned int cmd,
 				ioctl_trans_handler_t handler);
-extern int unregister_ioctl32_conversion(unsigned int cmd);
+extern int __deprecated unregister_ioctl32_conversion(unsigned int cmd);
 
 #else
 
