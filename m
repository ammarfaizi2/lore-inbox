Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932269AbWFGPnL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932269AbWFGPnL (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Jun 2006 11:43:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932270AbWFGPnK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Jun 2006 11:43:10 -0400
Received: from adsl-70-250-156-241.dsl.austtx.swbell.net ([70.250.156.241]:63945
	"EHLO gw.microgate.com") by vger.kernel.org with ESMTP
	id S932269AbWFGPnJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Jun 2006 11:43:09 -0400
Subject: [PATCH] fix generic HDLC synclink mismatch build error
From: Paul Fulghum <paulkf@microgate.com>
To: Andrew Morton <akpm@osdl.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Date: Wed, 07 Jun 2006 10:42:58 -0500
Message-Id: <1149694978.12920.14.camel@amdx2.microgate.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-4.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Fix build errors caused by generic HDLC
and synclink configuration mismatch. Generic HDLC
symbols referenced from synclink drivers do not
resolve if synclink drivers are built-in and generic
HDLC is modularized.

kbuild depends statement to demote synclink can't be
used because generic HDLC support is optional for
synclink driver

kbuild select statement to promote generic HDLC can't
be used because some kernel developers consider it
ugly and believe it should never be used
(so I surrender to the flow)

The last remaining alternative suppresses inclusion
of generic HDLC support in the synclink drivers if
the kernel configuration has synclink built-in and
generic HDLC modularized.

Signed-off-by: Paul Fulghum <paulkf@microgate.com>

--- a/drivers/char/synclink.c	2006-06-07 10:07:13.000000000 -0500
+++ b/drivers/char/synclink.c	2006-06-07 10:06:00.000000000 -0500
@@ -103,7 +103,7 @@
 #include <linux/hdlc.h>
 #include <linux/dma-mapping.h>
 
-#ifdef CONFIG_HDLC_MODULE
+#if defined(CONFIG_HDLC_MODULE) && defined(CONFIG_SYNCLINK_MODULE)
 #define CONFIG_HDLC 1
 #endif
 
--- a/drivers/char/pcmcia/synclink_cs.c	2006-06-07 09:35:05.000000000 -0500
+++ b/drivers/char/pcmcia/synclink_cs.c	2006-06-07 10:09:49.000000000 -0500
@@ -77,7 +77,7 @@
 #include <pcmcia/cisreg.h>
 #include <pcmcia/ds.h>
 
-#ifdef CONFIG_HDLC_MODULE
+#if defined(CONFIG_HDLC_MODULE) && defined(CONFIG_SYNCLINK_CS_MODULE)
 #define CONFIG_HDLC 1
 #endif
 
--- a/drivers/char/synclink_gt.c	2006-06-07 09:35:05.000000000 -0500
+++ b/drivers/char/synclink_gt.c	2006-06-07 10:09:25.000000000 -0500
@@ -84,7 +84,7 @@
 
 #include "linux/synclink.h"
 
-#ifdef CONFIG_HDLC_MODULE
+#if defined(CONFIG_HDLC_MODULE) && defined(CONFIG_SYNCLINK_GT_MODULE)
 #define CONFIG_HDLC 1
 #endif
 
--- a/drivers/char/synclinkmp.c	2006-06-07 09:35:05.000000000 -0500
+++ b/drivers/char/synclinkmp.c	2006-06-07 10:08:46.000000000 -0500
@@ -68,7 +68,7 @@
 #include <linux/workqueue.h>
 #include <linux/hdlc.h>
 
-#ifdef CONFIG_HDLC_MODULE
+#if defined(CONFIG_HDLC_MODULE) && defined(CONFIG_SYNCLINKMP_MODULE)
 #define CONFIG_HDLC 1
 #endif
 


