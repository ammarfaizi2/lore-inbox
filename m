Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264627AbUFPTe3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264627AbUFPTe3 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Jun 2004 15:34:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264658AbUFPTe3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Jun 2004 15:34:29 -0400
Received: from [63.137.246.162] ([63.137.246.162]:39948 "EHLO www.ssflabs.com")
	by vger.kernel.org with ESMTP id S264627AbUFPTe0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Jun 2004 15:34:26 -0400
Message-Id: <200406161934.i5GJY5M24989@sfendt.octagonsystems.com>
From: Sean S Fendt <sfendt@octagonsystems.com>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] g_NCR5380_mmio, kernel 2.6.7
Date: Wed, 16 Jun 2004 13:34:00 -0600
X-Mailer: KMail [version 1.3.1]
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="------------Boundary-00=_OC2FHRC6ZUFBFMMTYGYD"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--------------Boundary-00=_OC2FHRC6ZUFBFMMTYGYD
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8bit

g_NCR5380_mmio.ko does not find hardware.

I found that this very short file g_NCR5380_mmio.c, simply rebuilds 
g_NCR5380.c with a symbol defined for compile-time changes.  However, the #if 
statements in the latter use a slightly different symbol (prefixed with 
CONFIG_) which doesn't seem be get set in 2.6.x at compile time.  This patch 
allows the driver to ID the hardware.

We, here at Octagon Systems, still make an old micro-pc (8-bit ISA) SCSI host 
adapter based on the 53C400A chip supported by this driver.  I doubt many 
still use it, but as this is still an active product, we need to continue to 
offer support with our CPUs now available / compatable with Linux 2.6 
kernels.  If anyone has a similar card and it is working without this patch, 
please let me know what I did wrong.

Since we're an x86 shop, this has only been tested on x86 systems.  I doubt 
that will make any difference, however.
-- 
-- Sean Fendt
sfendt@octagonsystems.com
Ph: 303 430 1500 Ext 3048

--------------Boundary-00=_OC2FHRC6ZUFBFMMTYGYD
Content-Type: text/plain;
  charset="iso-8859-1";
  name="my_patch"
Content-Transfer-Encoding: 8bit
Content-Disposition: attachment; filename="my_patch"

--- linux-2.6.7/drivers/scsi/g_NCR5380_mmio.c	Tue Jun 15 23:19:43 2004
+++ linux/drivers/scsi/g_NCR5380_mmio.c	Wed Jun 16 13:13:31 2004
@@ -5,6 +5,7 @@
  */
 
 #define SCSI_G_NCR5380_MEM
+#define CONFIG_SCSI_G_NCR5380_MEM
 
 #include "g_NCR5380.c"
 

--------------Boundary-00=_OC2FHRC6ZUFBFMMTYGYD--
