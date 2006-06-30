Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932305AbWF3VFY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932305AbWF3VFY (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Jun 2006 17:05:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932399AbWF3VFY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Jun 2006 17:05:24 -0400
Received: from web50103.mail.yahoo.com ([206.190.38.31]:11909 "HELO
	web50103.mail.yahoo.com") by vger.kernel.org with SMTP
	id S932305AbWF3VFX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Jun 2006 17:05:23 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=Message-ID:Received:Date:From:Subject:To:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=dYkGV5PhORB8M7FDQ1tmDe+RI0cOB8GkI1qV8R+eKTLGBbjZm3DYfZXJtlyQUZFiffDNGQA3T8IrjOzKR6wpNz4TXjmdcS4P83QBlfOtpwQf4fQCbVhhp5+m3hIV5yX2kT1xpFRNWr9BnC4Ady8FhKCsH/yoK6KY7MFbPOVCj6E=  ;
Message-ID: <20060630210517.52690.qmail@web50103.mail.yahoo.com>
Date: Fri, 30 Jun 2006 14:05:17 -0700 (PDT)
From: Doug Thompson <norsk5@yahoo.com>
Subject: [PATCH]  EDAC BUG FIX module names quoted in sysfs
To: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Doug Thompson <norsk5@xmission.com>

This patch applies to kernel 2.6.17-mm4

This patch does the following:

Fix the quoted module name in the sysfs for EDAC modules and reported by several
people.

Instead of  ../”edac_e752x”/   now the following will be presented, like other
modules:   ../edac_e752x/


Signed-off-by:		Doug Thompson <norsk5@xmission.com>
---

 amd76x_edac.c  |    2 +-
 e752x_edac.c   |    1 +
 e7xxx_edac.c   |    1 +
 edac_mc.h      |    4 ----
 i82860_edac.c  |    1 +
 i82875p_edac.c |    1 +
 r82600_edac.c  |    1 +
 7 files changed, 6 insertions(+), 5 deletions(-)



Index: linux-2.6.17.edac/drivers/edac/amd76x_edac.c
===================================================================
--- linux-2.6.17.edac.orig/drivers/edac/amd76x_edac.c	2006-06-30 14:21:23.000000000
-0600
+++ linux-2.6.17.edac/drivers/edac/amd76x_edac.c	2006-06-30 14:22:19.000000000 -0600
@@ -20,8 +20,8 @@
 #include <linux/slab.h>
 #include "edac_mc.h"
 
-#define AMD76X_REVISION	" Ver: 2.0.0 "  __DATE__
-
+#define AMD76X_REVISION	" Ver: 2.0.1 "  __DATE__
+#define EDAC_MOD_STR	"amd76x_edac"
 
 #define amd76x_printk(level, fmt, arg...) \
 	edac_printk(level, "amd76x", fmt, ##arg)
Index: linux-2.6.17.edac/drivers/edac/e752x_edac.c
===================================================================
--- linux-2.6.17.edac.orig/drivers/edac/e752x_edac.c	2006-06-30 14:21:23.000000000
-0600
+++ linux-2.6.17.edac/drivers/edac/e752x_edac.c	2006-06-30 14:22:02.000000000 -0600
@@ -25,7 +25,8 @@
 #include <linux/slab.h>
 #include "edac_mc.h"
 
-#define E752X_REVISION	" Ver: 2.0.0 " __DATE__
+#define E752X_REVISION	" Ver: 2.0.1 " __DATE__
+#define EDAC_MOD_STR	"e752x_edac"
 
 static int force_function_unhide;
 
Index: linux-2.6.17.edac/drivers/edac/e7xxx_edac.c
===================================================================
--- linux-2.6.17.edac.orig/drivers/edac/e7xxx_edac.c	2006-06-30 14:21:23.000000000
-0600
+++ linux-2.6.17.edac/drivers/edac/e7xxx_edac.c	2006-06-30 14:22:33.000000000 -0600
@@ -30,7 +30,8 @@
 #include <linux/slab.h>
 #include "edac_mc.h"
 
-#define	E7XXX_REVISION " Ver: 2.0.0 " __DATE__
+#define	E7XXX_REVISION " Ver: 2.0.1 " __DATE__
+#define	EDAC_MOD_STR	"e7xxx_edac"
 
 #define e7xxx_printk(level, fmt, arg...) \
 	edac_printk(level, "e7xxx", fmt, ##arg)
Index: linux-2.6.17.edac/drivers/edac/edac_mc.h
===================================================================
--- linux-2.6.17.edac.orig/drivers/edac/edac_mc.h	2006-06-30 14:21:21.000000000
-0600
+++ linux-2.6.17.edac/drivers/edac/edac_mc.h	2006-06-30 14:21:25.000000000 -0600
@@ -79,10 +79,6 @@
 
 #endif  /* !CONFIG_EDAC_DEBUG */
 
-#define edac_xstr(s) edac_str(s)
-#define edac_str(s) #s
-#define EDAC_MOD_STR edac_xstr(KBUILD_BASENAME)
-
 #define BIT(x) (1 << (x))
 
 #define PCI_VEND_DEV(vend, dev) PCI_VENDOR_ID_ ## vend, \
Index: linux-2.6.17.edac/drivers/edac/i82860_edac.c
===================================================================
--- linux-2.6.17.edac.orig/drivers/edac/i82860_edac.c	2006-06-30 14:21:23.000000000
-0600
+++ linux-2.6.17.edac/drivers/edac/i82860_edac.c	2006-06-30 14:22:46.000000000 -0600
@@ -17,7 +17,8 @@
 #include <linux/slab.h>
 #include "edac_mc.h"
 
-#define  I82860_REVISION " Ver: 2.0.0 " __DATE__
+#define  I82860_REVISION " Ver: 2.0.1 " __DATE__
+#define EDAC_MOD_STR	"i82860_edac"
 
 #define i82860_printk(level, fmt, arg...) \
 	edac_printk(level, "i82860", fmt, ##arg)
Index: linux-2.6.17.edac/drivers/edac/i82875p_edac.c
===================================================================
--- linux-2.6.17.edac.orig/drivers/edac/i82875p_edac.c	2006-06-30 14:21:23.000000000
-0600
+++ linux-2.6.17.edac/drivers/edac/i82875p_edac.c	2006-06-30 14:22:57.000000000
-0600
@@ -21,7 +21,8 @@
 #include <linux/slab.h>
 #include "edac_mc.h"
 
-#define I82875P_REVISION	" Ver: 2.0.0 " __DATE__
+#define I82875P_REVISION	" Ver: 2.0.1 " __DATE__
+#define EDAC_MOD_STR		"i82875p_edac"
 
 #define i82875p_printk(level, fmt, arg...) \
 	edac_printk(level, "i82875p", fmt, ##arg)
Index: linux-2.6.17.edac/drivers/edac/r82600_edac.c
===================================================================
--- linux-2.6.17.edac.orig/drivers/edac/r82600_edac.c	2006-06-30 14:21:23.000000000
-0600
+++ linux-2.6.17.edac/drivers/edac/r82600_edac.c	2006-06-30 14:23:18.000000000 -0600
@@ -23,7 +23,8 @@
 #include <linux/slab.h>
 #include "edac_mc.h"
 
-#define R82600_REVISION	" Ver: 2.0.0 " __DATE__
+#define R82600_REVISION	" Ver: 2.0.1 " __DATE__
+#define EDAC_MOD_STR	"r82600_edac"
 
 #define r82600_printk(level, fmt, arg...) \
 	edac_printk(level, "r82600", fmt, ##arg)

