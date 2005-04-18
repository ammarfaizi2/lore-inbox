Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262104AbVDRPUw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262104AbVDRPUw (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 18 Apr 2005 11:20:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262103AbVDRPUv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Apr 2005 11:20:51 -0400
Received: from gsecone.com ([59.144.0.4]:54661 "EHLO gsecone.com")
	by vger.kernel.org with ESMTP id S262106AbVDRPTb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Apr 2005 11:19:31 -0400
Subject: [PATCH][2.6.12-rc2] __attribute__ placement
From: Vinay K Nallamothu <vinay.nallamothu@gsecone.com>
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org
Content-Type: text/plain
Organization: Global Security One
Date: Mon, 18 Apr 2005 20:46:44 +0530
Message-Id: <1113837404.4217.15.camel@vinay.gsecone.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-2) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

The variable attributes "packed" and "align" when used with struct,
should have the following order:

struct ... {...} __attribute__((packed)) var;

This patch fixes few instances where the variable and attributes are
placed the other way around and had no affect.

Thanks
Vinay 

 asm-m68knommu/MC68328.h   |    2 +-
 asm-m68knommu/MC68EZ328.h |    2 +-
 asm-m68knommu/MC68VZ328.h |    2 +-
 math-emu/double.h         |    4 ++--
 math-emu/extended.h       |    2 +-
 math-emu/quad.h           |    2 +-
 math-emu/single.h         |    2 +-
 7 files changed, 8 insertions(+), 8 deletions(-)
===========================================================================
diff -urN linux-2.6.12-rc2/include/asm-m68knommu/MC68328.h linux-2.6.12-rc2-nvk/include/asm-m68knommu/MC68328.h
--- linux-2.6.12-rc2/include/asm-m68knommu/MC68328.h	2005-04-07 18:55:40.000000000 +0530
+++ linux-2.6.12-rc2-nvk/include/asm-m68knommu/MC68328.h	2005-04-18 20:02:00.325855096 +0530
@@ -993,7 +993,7 @@
   volatile unsigned short int pad1;
   volatile unsigned short int pad2;
   volatile unsigned short int pad3;
-} m68328_uart __attribute__((packed));
+} __attribute__((packed)) m68328_uart;
 
 
 /**********
diff -urN linux-2.6.12-rc2/include/asm-m68knommu/MC68EZ328.h linux-2.6.12-rc2-nvk/include/asm-m68knommu/MC68EZ328.h
--- linux-2.6.12-rc2/include/asm-m68knommu/MC68EZ328.h	2005-04-07 18:55:40.000000000 +0530
+++ linux-2.6.12-rc2-nvk/include/asm-m68knommu/MC68EZ328.h	2005-04-18 20:03:08.034561808 +0530
@@ -815,7 +815,7 @@
   volatile unsigned short int nipr;
   volatile unsigned short int pad1;
   volatile unsigned short int pad2;
-} m68328_uart __attribute__((packed));
+} __attribute__((packed)) m68328_uart;
 
 
 /**********
diff -urN linux-2.6.12-rc2/include/asm-m68knommu/MC68VZ328.h linux-2.6.12-rc2-nvk/include/asm-m68knommu/MC68VZ328.h
--- linux-2.6.12-rc2/include/asm-m68knommu/MC68VZ328.h	2005-04-07 18:55:40.000000000 +0530
+++ linux-2.6.12-rc2-nvk/include/asm-m68knommu/MC68VZ328.h	2005-04-18 20:02:28.186619616 +0530
@@ -909,7 +909,7 @@
   volatile unsigned short int nipr;
   volatile unsigned short int hmark;
   volatile unsigned short int unused;
-} m68328_uart __attribute__((packed));
+} __attribute__((packed)) m68328_uart;
 
 
 
diff -urN linux-2.6.12-rc2/include/math-emu/double.h linux-2.6.12-rc2-nvk/include/math-emu/double.h
--- linux-2.6.12-rc2/include/math-emu/double.h	2005-04-07 18:55:41.000000000 +0530
+++ linux-2.6.12-rc2-nvk/include/math-emu/double.h	2005-04-18 20:04:55.998148848 +0530
@@ -67,7 +67,7 @@
     unsigned exp   : _FP_EXPBITS_D;
     unsigned sign  : 1;
 #endif
-  } bits __attribute__((packed));
+  } __attribute__((packed)) bits;
 };
 
 #define FP_DECL_D(X)		_FP_DECL(2,X)
@@ -139,7 +139,7 @@
     unsigned exp  : _FP_EXPBITS_D;
     unsigned sign : 1;
 #endif
-  } bits __attribute__((packed));
+  } __attribute__((packed)) bits;
 };
 
 #define FP_DECL_D(X)		_FP_DECL(1,X)
diff -urN linux-2.6.12-rc2/include/math-emu/extended.h linux-2.6.12-rc2-nvk/include/math-emu/extended.h
--- linux-2.6.12-rc2/include/math-emu/extended.h	2005-04-07 18:55:41.000000000 +0530
+++ linux-2.6.12-rc2-nvk/include/math-emu/extended.h	2005-04-18 20:04:14.768416720 +0530
@@ -68,7 +68,7 @@
       unsigned exp : _FP_EXPBITS_E;
       unsigned sign : 1;
 #endif /* not bigendian */
-   } bits __attribute__((packed));
+   } __attribute__((packed)) bits;
 };
 
 
diff -urN linux-2.6.12-rc2/include/math-emu/quad.h linux-2.6.12-rc2-nvk/include/math-emu/quad.h
--- linux-2.6.12-rc2/include/math-emu/quad.h	2005-04-07 18:55:41.000000000 +0530
+++ linux-2.6.12-rc2-nvk/include/math-emu/quad.h	2005-04-18 20:03:55.135401392 +0530
@@ -72,7 +72,7 @@
       unsigned exp : _FP_EXPBITS_Q;
       unsigned sign : 1;
 #endif /* not bigendian */
-   } bits __attribute__((packed));
+   } __attribute__((packed)) bits;
 };
 
 
diff -urN linux-2.6.12-rc2/include/math-emu/single.h linux-2.6.12-rc2-nvk/include/math-emu/single.h
--- linux-2.6.12-rc2/include/math-emu/single.h	2005-04-07 18:55:41.000000000 +0530
+++ linux-2.6.12-rc2-nvk/include/math-emu/single.h	2005-04-18 20:05:20.208468320 +0530
@@ -56,7 +56,7 @@
     unsigned exp  : _FP_EXPBITS_S;
     unsigned sign : 1;
 #endif
-  } bits __attribute__((packed));
+  } __attribute__((packed)) bits;
 };
 
 #define FP_DECL_S(X)		_FP_DECL(1,X)

===========================================================================


-- 
Views expressed in this mail are those of the individual sender and 
do not bind Gsec1 Limited. or its subsidiary, unless the sender has done
so expressly with due authority of Gsec1.
_________________________________________________________________________


