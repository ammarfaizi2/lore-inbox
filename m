Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262305AbTEIGkz (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 May 2003 02:40:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262306AbTEIGkz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 May 2003 02:40:55 -0400
Received: from phoenix.infradead.org ([195.224.96.167]:27915 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S262305AbTEIGkv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 May 2003 02:40:51 -0400
Date: Fri, 9 May 2003 07:53:19 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: Marcelo Tosatti <marcelo@conectiva.com.br>, alan@lxorguk.ukuu.org.uk,
       linux-kernel@vger.kernel.org
Subject: Re: 2.4.21-rc2 IDE Modular non-compile
Message-ID: <20030509075319.A10102@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Rusty Russell <rusty@rustcorp.com.au>,
	Marcelo Tosatti <marcelo@conectiva.com.br>,
	alan@lxorguk.ukuu.org.uk, linux-kernel@vger.kernel.org
References: <20030509064035.4C6612C014@lists.samba.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20030509064035.4C6612C014@lists.samba.org>; from rusty@rustcorp.com.au on Fri, May 09, 2003 at 04:35:58PM +1000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is the patch I sent marcelo just after rc1 was released, I gues
it will still apply..


--- 1.26/drivers/ide/Config.in	Tue Mar 11 14:29:21 2003
+++ edited/drivers/ide/Config.in	Wed Apr 23 17:02:53 2003
@@ -43,40 +43,42 @@
 	    define_bool CONFIG_BLK_DEV_IDEDMA $CONFIG_BLK_DEV_IDEDMA_PCI
 	    dep_bool '      ATA Work(s) In Progress (EXPERIMENTAL)' CONFIG_IDEDMA_PCI_WIP $CONFIG_BLK_DEV_IDEDMA_PCI $CONFIG_EXPERIMENTAL
 #	    dep_bool '      Good-Bad DMA Model-Firmware (WIP)' CONFIG_IDEDMA_NEW_DRIVE_LISTINGS $CONFIG_IDEDMA_PCI_WIP
-            dep_tristate '    Pacific Digital ADMA-100 basic support' CONFIG_BLK_DEV_ADMA100
-	    dep_tristate '    AEC62XX chipset support' CONFIG_BLK_DEV_AEC62XX $CONFIG_BLK_DEV_IDEDMA_PCI
-	    dep_tristate '    ALI M15x3 chipset support' CONFIG_BLK_DEV_ALI15X3 $CONFIG_BLK_DEV_IDEDMA_PCI
+            dep_tristate '    Pacific Digital ADMA-100 basic support' CONFIG_BLK_DEV_ADMA100 $CONFIG_BLK_DEV_IDE
+	    dep_tristate '    AEC62XX chipset support' CONFIG_BLK_DEV_AEC62XX $CONFIG_BLK_DEV_IDEDMA_PCI $CONFIG_BLK_DEV_IDE
+	    dep_tristate '    ALI M15x3 chipset support' CONFIG_BLK_DEV_ALI15X3 $CONFIG_BLK_DEV_IDEDMA_PCI $CONFIG_BLK_DEV_IDE
 	    dep_mbool    '      ALI M15x3 WDC support (DANGEROUS)' CONFIG_WDC_ALI15X3 $CONFIG_BLK_DEV_ALI15X3
-	    dep_tristate '    AMD Viper support' CONFIG_BLK_DEV_AMD74XX $CONFIG_BLK_DEV_IDEDMA_PCI
-	    dep_mbool    '      AMD Viper ATA-66 Override' CONFIG_AMD74XX_OVERRIDE $CONFIG_BLK_DEV_AMD74XX
-	    dep_tristate '    CMD64{3|6|8|9} chipset support' CONFIG_BLK_DEV_CMD64X $CONFIG_BLK_DEV_IDEDMA_PCI
-	    dep_tristate '    Compaq Triflex IDE support' CONFIG_BLK_DEV_TRIFLEX $CONFIG_BLK_DEV_IDEDMA_PCI
-	    dep_tristate '    CY82C693 chipset support' CONFIG_BLK_DEV_CY82C693 $CONFIG_BLK_DEV_IDEDMA_PCI
-	    dep_tristate '    Cyrix CS5530 MediaGX chipset support' CONFIG_BLK_DEV_CS5530 $CONFIG_BLK_DEV_IDEDMA_PCI
-  	    dep_tristate '    HPT34X chipset support' CONFIG_BLK_DEV_HPT34X $CONFIG_BLK_DEV_IDEDMA_PCI
+
+	    dep_tristate '    AMD Viper support' CONFIG_BLK_DEV_AMD74XX $CONFIG_BLK_DEV_IDEDMA_PCI $CONFIG_IDE
+
+	    dep_mbool    '      AMD Viper ATA-66 Override' CONFIG_AMD74XX_OVERRIDE $CONFIG_BLK_DEV_AMD74XX $CONFIG_IDE
+	    dep_tristate '    CMD64{3|6|8|9} chipset support' CONFIG_BLK_DEV_CMD64X $CONFIG_BLK_DEV_IDEDMA_PCI $CONFIG_BLK_DEV_IDE
+	    dep_tristate '    Compaq Triflex IDE support' CONFIG_BLK_DEV_TRIFLEX $CONFIG_BLK_DEV_IDEDMA_PCI $CONFIG_BLK_DEV_IDE
+	    dep_tristate '    CY82C693 chipset support' CONFIG_BLK_DEV_CY82C693 $CONFIG_BLK_DEV_IDEDMA_PCI $CONFIG_BLK_DEV_IDE
+	    dep_tristate '    Cyrix CS5530 MediaGX chipset support' CONFIG_BLK_DEV_CS5530 $CONFIG_BLK_DEV_IDEDMA_PCI $CONFIG_BLK_DEV_IDE
+  	    dep_tristate '    HPT34X chipset support' CONFIG_BLK_DEV_HPT34X $CONFIG_BLK_DEV_IDEDMA_PCI $CONFIG_BLK_DEV_IDE
 	    dep_mbool    '      HPT34X AUTODMA support (WIP)' CONFIG_HPT34X_AUTODMA $CONFIG_BLK_DEV_HPT34X $CONFIG_IDEDMA_PCI_WIP
-	    dep_tristate '    HPT36X/37X chipset support' CONFIG_BLK_DEV_HPT366 $CONFIG_BLK_DEV_IDEDMA_PCI
-	    dep_tristate '    Intel PIIXn chipsets support' CONFIG_BLK_DEV_PIIX $CONFIG_BLK_DEV_IDEDMA_PCI
+	    dep_tristate '    HPT36X/37X chipset support' CONFIG_BLK_DEV_HPT366 $CONFIG_BLK_DEV_IDEDMA_PCI $CONFIG_BLK_DEV_IDE
+	    dep_tristate '    Intel PIIXn chipsets support' CONFIG_BLK_DEV_PIIX $CONFIG_BLK_DEV_IDEDMA_PCI $CONFIG_BLK_DEV_IDE
 	    if [ "$CONFIG_MIPS_ITE8172" = "y" -o "$CONFIG_MIPS_IVR" = "y" ]; then
 	       dep_mbool '    IT8172 IDE support' CONFIG_BLK_DEV_IT8172 $CONFIG_BLK_DEV_IDEDMA_PCI
 	    fi
-	    dep_tristate '    NS87415 chipset support' CONFIG_BLK_DEV_NS87415 $CONFIG_BLK_DEV_IDEDMA_PCI
-	    dep_tristate '    OPTi 82C621 chipset enhanced support (EXPERIMENTAL)' CONFIG_BLK_DEV_OPTI621 $CONFIG_EXPERIMENTAL
-	    dep_tristate '    PROMISE PDC202{46|62|65|67} support' CONFIG_BLK_DEV_PDC202XX_OLD $CONFIG_BLK_DEV_IDEDMA_PCI
+	    dep_tristate '    NS87415 chipset support' CONFIG_BLK_DEV_NS87415 $CONFIG_BLK_DEV_IDEDMA_PCI $CONFIG_BLK_DEV_IDE
+	    dep_tristate '    OPTi 82C621 chipset enhanced support (EXPERIMENTAL)' CONFIG_BLK_DEV_OPTI621 $CONFIG_EXPERIMENTAL $CONFIG_BLK_DEV_IDE
+	    dep_tristate '    PROMISE PDC202{46|62|65|67} support' CONFIG_BLK_DEV_PDC202XX_OLD $CONFIG_BLK_DEV_IDEDMA_PCI $CONFIG_BLK_DEV_IDE
 	    dep_bool     '      Special UDMA Feature' CONFIG_PDC202XX_BURST $CONFIG_BLK_DEV_PDC202XX_OLD $CONFI_BLK_DEV_IDEDMA_PCI
-	    dep_tristate '    PROMISE PDC202{68|69|70|71|75|76|77} support' CONFIG_BLK_DEV_PDC202XX_NEW $CONFIG_BLK_DEV_IDEDMA_PCI
+	    dep_tristate '    PROMISE PDC202{68|69|70|71|75|76|77} support' CONFIG_BLK_DEV_PDC202XX_NEW $CONFIG_BLK_DEV_IDEDMA_PCI $CONFIG_BLK_DEV_IDE
 		# FIXME - probably wants to be one for old and for new
 	    dep_bool     '      Special FastTrak Feature' CONFIG_PDC202XX_FORCE $CONFIG_BLK_DEV_PDC202XX_NEW
-	    dep_tristate '    RZ1000 chipset bugfix/support' CONFIG_BLK_DEV_RZ1000 $CONFIG_X86
-	    dep_tristate '    SCx200 chipset support' CONFIG_BLK_DEV_SC1200 $CONFIG_BLK_DEV_IDEDMA_PCI
-	    dep_tristate '    ServerWorks OSB4/CSB5/CSB6 chipsets support' CONFIG_BLK_DEV_SVWKS $CONFIG_BLK_DEV_IDEDMA_PCI
-	    dep_tristate '    Silicon Image chipset support' CONFIG_BLK_DEV_SIIMAGE $CONFIG_BLK_DEV_IDEDMA_PCI
-	    dep_tristate '    SiS5513 chipset support' CONFIG_BLK_DEV_SIS5513 $CONFIG_BLK_DEV_IDEDMA_PCI $CONFIG_X86
-	    dep_tristate '    SLC90E66 chipset support' CONFIG_BLK_DEV_SLC90E66 $CONFIG_BLK_DEV_IDEDMA_PCI
-	    dep_tristate '    Tekram TRM290 chipset support' CONFIG_BLK_DEV_TRM290 $CONFIG_BLK_DEV_IDEDMA_PCI
-	    dep_tristate '    VIA82CXXX chipset support' CONFIG_BLK_DEV_VIA82CXXX $CONFIG_BLK_DEV_IDEDMA_PCI
+	    dep_tristate '    RZ1000 chipset bugfix/support' CONFIG_BLK_DEV_RZ1000 $CONFIG_X86 $CONFIG_BLK_DEV_IDE
+	    dep_tristate '    SCx200 chipset support' CONFIG_BLK_DEV_SC1200 $CONFIG_BLK_DEV_IDEDMA_PCI $CONFIG_BLK_DEV_IDE
+	    dep_tristate '    ServerWorks OSB4/CSB5/CSB6 chipsets support' CONFIG_BLK_DEV_SVWKS $CONFIG_BLK_DEV_IDEDMA_PCI $CONFIG_BLK_DEV_IDE
+	    dep_tristate '    Silicon Image chipset support' CONFIG_BLK_DEV_SIIMAGE $CONFIG_BLK_DEV_IDEDMA_PCI $CONFIG_BLK_DEV_IDE
+	    dep_tristate '    SiS5513 chipset support' CONFIG_BLK_DEV_SIS5513 $CONFIG_BLK_DEV_IDEDMA_PCI $CONFIG_X86 $CONFIG_BLK_DEV_IDE
+	    dep_tristate '    SLC90E66 chipset support' CONFIG_BLK_DEV_SLC90E66 $CONFIG_BLK_DEV_IDEDMA_PCI $CONFIG_BLK_DEV_IDE
+	    dep_tristate '    Tekram TRM290 chipset support' CONFIG_BLK_DEV_TRM290 $CONFIG_BLK_DEV_IDEDMA_PCI $CONFIG_BLK_DEV_IDE
+	    dep_tristate '    VIA82CXXX chipset support' CONFIG_BLK_DEV_VIA82CXXX $CONFIG_BLK_DEV_IDEDMA_PCI $CONFIG_BLK_DEV_IDE
 	    if [ "$CONFIG_PPC" = "y" -o "$CONFIG_ARM" = "y" ]; then
-	       dep_tristate '    Winbond SL82c105 support' CONFIG_BLK_DEV_SL82C105 $CONFIG_BLK_DEV_IDEPCI
+	       dep_tristate '    Winbond SL82c105 support' CONFIG_BLK_DEV_SL82C105 $CONFIG_BLK_DEV_IDEPCI $CONFIG_BLK_DEV_IDE
 	    fi
          fi
       fi
--- 1.11/drivers/ide/Makefile	Mon Mar 24 13:04:35 2003
+++ edited/drivers/ide/Makefile	Wed Apr 23 17:03:34 2003
@@ -35,8 +35,12 @@
 obj-$(CONFIG_BLK_DEV_IDETAPE)		+= ide-tape.o
 obj-$(CONFIG_BLK_DEV_IDEFLOPPY)		+= ide-floppy.o
 
-obj-$(CONFIG_BLK_DEV_IDEPCI)		+= setup-pci.o
-obj-$(CONFIG_BLK_DEV_IDEDMA_PCI)	+= ide-dma.o
+ifeq ($(CONFIG_BLK_DEV_IDEPCI),y)
+obj-$(CONFIG_BLK_DEV_IDE)		+= setup-pci.o
+endif
+ifeq ($(CONFIG_BLK_DEV_IDEDMA_PCI),y)
+obj-$(CONFIG_BLK_DEV_IDE)		+= ide-dma.o
+endif
 obj-$(CONFIG_BLK_DEV_ISAPNP)		+= ide-pnp.o
 
 
