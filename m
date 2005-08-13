Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932285AbVHMWYY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932285AbVHMWYY (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 13 Aug 2005 18:24:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932377AbVHMWYX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 13 Aug 2005 18:24:23 -0400
Received: from nic.upatras.gr ([150.140.129.30]:17596 "HELO nic.upatras.gr")
	by vger.kernel.org with SMTP id S932285AbVHMWYX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 13 Aug 2005 18:24:23 -0400
From: Michael Iatrou <m.iatrou@freemail.gr>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] configurable debug info from radeonfb old driver
Date: Sun, 14 Aug 2005 01:18:27 +0300
User-Agent: KMail/1.8.2
X-Face: *8Gl!va:8&HzlgC%IRQaxD*[{;>3OMj];U1I;[rtNn@,hA7h/cTR1!!0J`koxA2)=?iso-8859-7?q?xj=7ELd9=0A=09N4LpVN=24=5CaU=27r?=<dFtnPd*,?d&u_g_kAnTwdv>2l}1-ae/$k1heNY.:5"9IYPy>X$msqG
MIME-Version: 1.0
Message-Id: <200508140118.27921.m.iatrou@freemail.gr>
Cc: ajoshi@shell.unixbox.com, akpm@osdl.org
Content-Type: text/plain;
  charset="iso-8859-7"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Currently, radeonfb old driver always prints debugging informations. This 
patch makes debug info reporting configurable.
 

diff -urN linux-2.6.13-rc6/drivers/video/Kconfig linux-2.6.13-rc6.new/drivers/video/Kconfig
--- linux-2.6.13-rc6/drivers/video/Kconfig      2005-08-14 00:48:34.000000000 +0300
+++ linux-2.6.13-rc6.new/drivers/video/Kconfig  2005-08-14 00:54:10.000000000 +0300
@@ -936,6 +936,15 @@
          There is a product page at
          <http://www.ati.com/na/pages/products/pc/radeon32/index.html>.

+config FB_RADEON_OLD_DEBUG
+    bool "Enable debug output from Old Radeon driver"
+    depends on FB_RADEON_OLD
+    default n
+    help
+      Say Y here if you want the Radeon driver to output all sorts
+      of debugging informations to provide to the maintainer when
+      something goes wrong.
+
 config FB_RADEON
        tristate "ATI Radeon display support"
        depends on FB && PCI
diff -urN linux-2.6.13-rc6/drivers/video/radeonfb.c linux-2.6.13-rc6.new/drivers/video/radeonfb.c
--- linux-2.6.13-rc6/drivers/video/radeonfb.c   2005-06-19 14:49:29.000000000 +0300
+++ linux-2.6.13-rc6.new/drivers/video/radeonfb.c       2005-08-14 00:55:16.000000000 +0300
@@ -80,7 +80,11 @@
 #include <video/radeon.h>
 #include <linux/radeonfb.h>

-#define DEBUG  1
+#ifdef CONFIG_FB_RADEON_OLD_DEBUG
+#define DEBUG       1
+#else
+#define DEBUG       0
+#endif

 #if DEBUG
 #define RTRACE         printk


-- 
 Michael Iatrou

