Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261366AbVDTL1l@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261366AbVDTL1l (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Apr 2005 07:27:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261303AbVDTL1l
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Apr 2005 07:27:41 -0400
Received: from gsecone.com ([59.144.0.4]:38791 "EHLO gsecone.com")
	by vger.kernel.org with ESMTP id S261366AbVDTL1f (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Apr 2005 07:27:35 -0400
Subject: Re: [PATCH][2.6.12-rc2] __attribute__ placement
From: Vinay K Nallamothu <vinay.nallamothu@gsecone.com>
To: akpm@osdl.org
Cc: LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <1113994849.10792.46.camel@vinay.gsecone.com>
References: <1113837404.4217.15.camel@vinay.gsecone.com>
	 <1113994849.10792.46.camel@vinay.gsecone.com>
Content-Type: text/plain
Organization: Global Security One
Date: Wed, 20 Apr 2005 16:54:08 +0530
Message-Id: <1113996248.13256.3.camel@vinay.gsecone.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-2) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Apparently my previous patch incorrectly fixed few cases where the
problem didn't exist. The __attribute__((packed)) issue is applicable
only to typedefed structs and the correct syntax for this should be:

typedef struct ... { ... } __attribute__((packed)) new_type;

Please find the updated patch. Hope I haven't introduced any new bugs.

Thanks
Vinay

 drivers/net/gt96100eth.h          |    4 ++--
 include/asm-m68knommu/MC68328.h   |    2 +-
 include/asm-m68knommu/MC68EZ328.h |    2 +-
 include/asm-m68knommu/MC68VZ328.h |    2 +-
 4 files changed, 5 insertions(+), 5 deletions(-)

=============================================================================
diff -urN linux-2.6.12-rc2/drivers/net/gt96100eth.h linux-2.6.12-rc2-nvk/drivers/net/gt96100eth.h
--- linux-2.6.12-rc2/drivers/net/gt96100eth.h	2005-04-07 18:56:46.000000000 +0530
+++ linux-2.6.12-rc2-nvk/drivers/net/gt96100eth.h	2005-04-20 15:50:20.000000000 +0530
@@ -214,7 +214,7 @@
 	u32 cmdstat;
 	u32 next;
 	u32 buff_ptr;
-} gt96100_td_t __attribute__ ((packed));
+} __attribute__ ((packed)) gt96100_td_t;
 
 typedef struct {
 #ifdef DESC_BE
@@ -227,7 +227,7 @@
 	u32 cmdstat;
 	u32 next;
 	u32 buff_ptr;
-} gt96100_rd_t __attribute__ ((packed));
+} __attribute__ ((packed)) gt96100_rd_t;
 
 
 /* Values for the Tx command-status descriptor entry. */
diff -urN linux-2.6.12-rc2/include/asm-m68knommu/MC68328.h linux-2.6.12-rc2-nvk/include/asm-m68knommu/MC68328.h
--- linux-2.6.12-rc2/include/asm-m68knommu/MC68328.h	2005-04-07 18:55:40.000000000 +0530
+++ linux-2.6.12-rc2-nvk/include/asm-m68knommu/MC68328.h	2005-04-20 15:47:37.000000000 +0530
@@ -993,7 +993,7 @@
   volatile unsigned short int pad1;
   volatile unsigned short int pad2;
   volatile unsigned short int pad3;
-} m68328_uart __attribute__((packed));
+} __attribute__((packed)) m68328_uart;
 
 
 /**********
diff -urN linux-2.6.12-rc2/include/asm-m68knommu/MC68EZ328.h linux-2.6.12-rc2-nvk/include/asm-m68knommu/MC68EZ328.h
--- linux-2.6.12-rc2/include/asm-m68knommu/MC68EZ328.h	2005-04-07 18:55:40.000000000 +0530
+++ linux-2.6.12-rc2-nvk/include/asm-m68knommu/MC68EZ328.h	2005-04-20 15:48:27.000000000 +0530
@@ -815,7 +815,7 @@
   volatile unsigned short int nipr;
   volatile unsigned short int pad1;
   volatile unsigned short int pad2;
-} m68328_uart __attribute__((packed));
+} __attribute__((packed)) m68328_uart;
 
 
 /**********
diff -urN linux-2.6.12-rc2/include/asm-m68knommu/MC68VZ328.h linux-2.6.12-rc2-nvk/include/asm-m68knommu/MC68VZ328.h
--- linux-2.6.12-rc2/include/asm-m68knommu/MC68VZ328.h	2005-04-07 18:55:40.000000000 +0530
+++ linux-2.6.12-rc2-nvk/include/asm-m68knommu/MC68VZ328.h	2005-04-20 15:48:01.000000000 +0530
@@ -909,7 +909,7 @@
   volatile unsigned short int nipr;
   volatile unsigned short int hmark;
   volatile unsigned short int unused;
-} m68328_uart __attribute__((packed));
+} __attribute__((packed)) m68328_uart;
 
 
 

=============================================================================
> On Mon, 2005-04-18 at 20:46 +0530, Vinay K Nallamothu wrote:
> > Hi,
> > 
> > The variable attributes "packed" and "align" when used with struct,
> > should have the following order:
> > 
> > struct ... {...} __attribute__((packed)) var;
> > 
> > This patch fixes few instances where the variable and attributes are
> > placed the other way around and had no affect.
> > 

-- 
Views expressed in this mail are those of the individual sender and 
do not bind Gsec1 Limited. or its subsidiary, unless the sender has done
so expressly with due authority of Gsec1.
_________________________________________________________________________


