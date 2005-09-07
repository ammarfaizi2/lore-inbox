Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932069AbVIGWS0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932069AbVIGWS0 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Sep 2005 18:18:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932077AbVIGWS0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Sep 2005 18:18:26 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:17628 "EHLO
	ZenIV.linux.org.uk") by vger.kernel.org with ESMTP id S932069AbVIGWSZ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Sep 2005 18:18:25 -0400
Date: Wed, 7 Sep 2005 23:18:24 +0100
From: viro@ZenIV.linux.org.uk
To: Linus Torvalds <torvalds@osdl.org>
Cc: linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] -Wundef fixes (ncr5380)
Message-ID: <20050907221824.GB13549@ZenIV.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

NDEBUG and NDEBUG_ABORT are almost always used as integers in NCR5380; added
define to 0 if they are not defined, switched lone ifdef NDEBUG into if.

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
----
diff -urN RC13-git7-smc-undef/drivers/scsi/NCR5380.c RC13-git7-ncr5380/drivers/scsi/NCR5380.c
--- RC13-git7-smc-undef/drivers/scsi/NCR5380.c	2005-08-28 23:09:45.000000000 -0400
+++ RC13-git7-ncr5380/drivers/scsi/NCR5380.c	2005-09-07 13:55:45.000000000 -0400
@@ -88,6 +88,13 @@
  */
 #include <scsi/scsi_dbg.h>
 
+#ifndef NDEBUG
+#define NDEBUG 0
+#endif
+#ifndef NDEBUG
+#define NDEBUG_ABORT 0
+#endif
+
 #if (NDEBUG & NDEBUG_LISTS)
 #define LIST(x,y) {printk("LINE:%d   Adding %p to %p\n", __LINE__, (void*)(x), (void*)(y)); if ((x)==(y)) udelay(5); }
 #define REMOVE(w,x,y,z) {printk("LINE:%d   Removing: %p->%p  %p->%p \n", __LINE__, (void*)(w), (void*)(x), (void*)(y), (void*)(z)); if ((x)==(y)) udelay(5); }
@@ -359,7 +366,7 @@
 	{PHASE_UNKNOWN, "UNKNOWN"}
 };
 
-#ifdef NDEBUG
+#if NDEBUG
 static struct {
 	unsigned char mask;
 	const char *name;
