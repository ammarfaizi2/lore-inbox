Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316223AbSFDSiN>; Tue, 4 Jun 2002 14:38:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316235AbSFDSiL>; Tue, 4 Jun 2002 14:38:11 -0400
Received: from medelec.uia.ac.be ([143.169.17.1]:23303 "EHLO medelec.uia.ac.be")
	by vger.kernel.org with ESMTP id <S316223AbSFDSiK>;
	Tue, 4 Jun 2002 14:38:10 -0400
Date: Tue, 4 Jun 2002 20:37:39 +0200
From: Wim Van Sebroeck <wim@iguana.be>
To: Marcelo Tosatti <marcelo@conectiva.com.br>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] linux-2.4.19-pre10 - i8xx series chipsets patches (patch 2)
Message-ID: <20020604203739.A14643@medelec.uia.ac.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Marcelo,

I redid my i8xx series patches for v2.4.19-pre10 . They include support for the 82801DB and 82801E 
I/O Controller Hubs for various modules.

Patch 2 adds detection for these ICH's in the i810_rng module.

Greetings,
Wim.


# This is a BitKeeper generated patch for the following project:
# Project Name: Linux kernel tree
# This patch format is intended for GNU patch command version 2.5 or higher.
# This patch includes the following deltas:
#	           ChangeSet	1.538   -> 1.539  
#	drivers/char/i810_rng.c	1.9     -> 1.10   
#	Documentation/i810_rng.txt	1.3     -> 1.4    
#
# The following is the BitKeeper ChangeSet Log
# --------------------------------------------
# 02/06/04	wim@iguana.be	1.539
# [PATCH] 2.4.19-pre10 - i8xx series chipsets patches (patch 2)
# 
# i810_rng: add support for other i8xx chipsets to the Random Number Generator module.
# This is being done by adding the detection of the 82801E I/O Controller Hub.
# --------------------------------------------
#
diff -Nru a/Documentation/i810_rng.txt b/Documentation/i810_rng.txt
--- a/Documentation/i810_rng.txt	Tue Jun  4 19:04:18 2002
+++ b/Documentation/i810_rng.txt	Tue Jun  4 19:04:18 2002
@@ -70,6 +70,10 @@
 
 Change history:
 
+	Version 0.9.8:
+	* Support other i8xx chipsets by adding 82801E detection
+	* 82801DB detection is the same as for 82801CA.
+
 	Version 0.9.7:
 	* Support other i8xx chipsets too (by adding 82801BA(M) and
 	  82801CA(M) detection)
diff -Nru a/drivers/char/i810_rng.c b/drivers/char/i810_rng.c
--- a/drivers/char/i810_rng.c	Tue Jun  4 19:04:18 2002
+++ b/drivers/char/i810_rng.c	Tue Jun  4 19:04:18 2002
@@ -35,7 +35,7 @@
 /*
  * core module and version information
  */
-#define RNG_VERSION "0.9.7"
+#define RNG_VERSION "0.9.8"
 #define RNG_MODULE_NAME "i810_rng"
 #define RNG_DRIVER_NAME   RNG_MODULE_NAME " hardware driver " RNG_VERSION
 #define PFX RNG_MODULE_NAME ": "
@@ -336,6 +336,7 @@
 	{ 0x8086, 0x2428, PCI_ANY_ID, PCI_ANY_ID, },
 	{ 0x8086, 0x2448, PCI_ANY_ID, PCI_ANY_ID, },
 	{ 0x8086, 0x244e, PCI_ANY_ID, PCI_ANY_ID, },
+	{ 0x8086, 0x245e, PCI_ANY_ID, PCI_ANY_ID, },
 	{ 0, },
 };
 MODULE_DEVICE_TABLE (pci, rng_pci_tbl);
