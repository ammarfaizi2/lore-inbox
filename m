Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261769AbTEMPlK (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 May 2003 11:41:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261757AbTEMPlK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 May 2003 11:41:10 -0400
Received: from ns2.uk.superh.com ([193.128.105.170]:16515 "EHLO
	ns2.uk.superh.com") by vger.kernel.org with ESMTP id S261769AbTEMPlB
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 May 2003 11:41:01 -0400
Date: Tue, 13 May 2003 16:53:41 +0100
From: Richard Curnow <Richard.Curnow@superh.com>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH] ehci-hcd.c needs to include <linux/bitops.h>
Message-ID: <20030513155341.GB1609@malvern.uk.w2k.superh.com>
Mail-Followup-To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
X-OS: Linux 2.4.19 i686
X-OriginalArrivalTime: 13 May 2003 15:54:01.0006 (UTC) FILETIME=[DEFE9CE0:01C31967]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

When I try to configure in EHCI support without this patch, I get
generic_ffs undefined at link time.  (This is with 2.4.21-rc2 on our
sh64 (SH-5) port).  Perhaps there are other ways to achieve this, but
this worked for me.

# This is a BitKeeper generated patch for the following project:
# Project Name: Linux kernel tree
# This patch format is intended for GNU patch command version 2.5 or higher.
# This patch includes the following deltas:
#	           ChangeSet	1.1212  -> 1.1213 
#	drivers/usb/host/ehci-hcd.c	1.12    -> 1.13   
#
# The following is the BitKeeper ChangeSet Log
# --------------------------------------------
# 03/05/13	curnowr@linsvr6.uk.superh.com	1.1213
# ehci-hcd.c needs to include <linux/bitops.h>, otherwise the inline
# definition of generic_ffs is not visible and it becomes an undefined
# symbol at link time.
# --------------------------------------------
#
diff -Nru a/drivers/usb/host/ehci-hcd.c b/drivers/usb/host/ehci-hcd.c
--- a/drivers/usb/host/ehci-hcd.c	Tue May 13 16:50:22 2003
+++ b/drivers/usb/host/ehci-hcd.c	Tue May 13 16:50:22 2003
@@ -31,6 +31,7 @@
 #include <linux/list.h>
 #include <linux/interrupt.h>
 #include <linux/reboot.h>
+#include <linux/bitops.h> /* for generic_ffs */
 
 #ifdef CONFIG_USB_DEBUG
 	#define DEBUG

-- 
Richard \\\ SuperH Core+Debug Architect /// .. At home ..
  P.    /// richard.curnow@superh.com  ///  rc@rc0.org.uk
Curnow  \\\ http://www.superh.com/    ///  www.rc0.org.uk
Speaking for myself, not on behalf of SuperH
