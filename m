Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263282AbTECJao (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 3 May 2003 05:30:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263285AbTECJao
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 3 May 2003 05:30:44 -0400
Received: from natsmtp01.webmailer.de ([192.67.198.81]:24448 "EHLO
	post.webmailer.de") by vger.kernel.org with ESMTP id S263282AbTECJam
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 3 May 2003 05:30:42 -0400
Message-Id: <200305030943.h439h41I015669@post.webmailer.de>
From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: Compile error kernel 2.4.20-rc1
To: Anders Karlsson <anders@trudheim.com>, linux-kernel@vger.kernel.org
Date: Sat, 03 May 2003 11:40:23 +0200
References: <20030503051007$7bb4@gated-at.bofh.it>
User-Agent: KNode/0.7.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Anders Karlsson wrote:

> Just tried to compile kernel 2.4.21-rc1 and I get the compile error as
> per attached file 'compile_error.txt'. The config file used is also
> attached. This happened while doing 'make rpm'. This is being compiled
> on SuSE Pro 8.2 which is using GCC 3.3.
> 
> I'll happily try out patches.

Try this one. Note that you can use 'make -k vmlinux modules' to find
all the broken files in one run.

        Arnd <><

--- ./drivers/atm/ambassador.c.bak      2003-05-03 11:31:39.000000000 +0200
+++ ./drivers/atm/ambassador.c  2003-05-03 11:34:57.000000000 +0200
@@ -290,12 +290,12 @@
 /********** microcode **********/
 
 #ifdef AMB_NEW_MICROCODE
-#define UCODE(x) UCODE1(atmsar12.,x)
+#define UCODE(x) UCODE1(atmsar12,x)
 #else
-#define UCODE(x) UCODE1(atmsar11.,x)
+#define UCODE(x) UCODE1(atmsar11,x)
 #endif
 #define UCODE2(x) #x
-#define UCODE1(x,y) UCODE2(x ## y)
+#define UCODE1(x,y) UCODE2(x.y)
 
 static u32 __initdata ucode_start = 
 #include UCODE(start)
--- ./drivers/net/tokenring/olympic.c.bak       2003-05-03 11:22:36.000000000 +0200
+++ ./drivers/net/tokenring/olympic.c   2003-05-03 11:22:48.000000000 +0200
@@ -655,8 +655,7 @@
        printk(" stat_ring[7]: %p\n", &(olympic_priv->olympic_rx_status_ring[7])  );
 
        printk("RXCDA: %x, rx_ring[0]: %p\n",readl(olympic_mmio+RXCDA),&olympic_priv->olympic_rx_ring[0]);
-       printk("Rx_ring_dma_addr = %08x, rx_status_dma_addr =
-%08x\n",olympic_priv->rx_ring_dma_addr,olympic_priv->rx_status_ring_dma_addr) ; 
+       printk("Rx_ring_dma_addr = %08x, rx_status_dma_addr = %08x\n",olympic_priv->rx_ring_dma_addr,olympic_priv->rx_status_ring_dma_addr) ; 
 #endif
 
        writew((((readw(olympic_mmio+RXENQ)) & 0x8000) ^ 0x8000) | i,olympic_mmio+RXENQ);
diff -ur kernel-source-2.4.20-hammer-orig/drivers/net/irda/ma600.c kernel-source-2.4.20-hammer/drivers/net/irda/ma600.c
--- kernel-source-2.4.20-hammer-orig/drivers/net/irda/ma600.c   2002-11-29 00:53:13.000000000 +0100
+++ kernel-source-2.4.20-hammer/drivers/net/irda/ma600.c        2003-04-24 11:26:45.000000000 +0200
@@ -53,7 +53,7 @@
        if(!(expr)) { \
                printk( "Assertion failed! %s,%s,%s,line=%d\n",\
                #expr,__FILE__,__FUNCTION__,__LINE__); \
-               ##func}
+               func}
 #endif
 
 /* convert hex value to ascii hex */
diff -ur kernel-source-2.4.20-hammer-orig/drivers/net/wan/sdla_chdlc.c kernel-source-2.4.20-hammer/drivers/net/wan/sdla_chdlc.c
--- kernel-source-2.4.20-hammer-orig/drivers/net/wan/sdla_chdlc.c       2002-11-29 00:53:14.000000000 +0100
+++ kernel-source-2.4.20-hammer/drivers/net/wan/sdla_chdlc.c    2003-04-24 11:28:24.000000000 +0200
@@ -591,8 +591,8 @@
        
 
                if (chdlc_set_intr_mode(card, APP_INT_ON_TIMER)){
-                       printk (KERN_INFO "%s: 
-                               Failed to set interrupt triggers!\n",
+                       printk (KERN_INFO "%s: "
+                               "Failed to set interrupt triggers!\n",
                                card->devname);
                        return -EIO;    
                }
--- ./drivers/sound/cs46xx.c.orig       2003-04-25 01:53:02.000000000 +0200
+++ ./drivers/sound/cs46xx.c    2003-04-25 01:53:26.000000000 +0200
@@ -947,8 +947,8 @@
 
 struct InitStruct
 {
-    u32 long off;
-    u32 long val;
+    u32 off;
+    u32 val;
 } InitArray[] = { {0x00000040, 0x3fc0000f},
                   {0x0000004c, 0x04800000},
 
