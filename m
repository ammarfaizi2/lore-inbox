Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263862AbUDOHVZ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Apr 2004 03:21:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263866AbUDOHVY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Apr 2004 03:21:24 -0400
Received: from gate.crashing.org ([63.228.1.57]:23937 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S263862AbUDOHVG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Apr 2004 03:21:06 -0400
Subject: [PATCH] ppc64: update g5_defconfig
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Andrew Morton <akpm@osdl.org>
Cc: Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel list <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Message-Id: <1082013405.2499.146.camel@gaston>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Thu, 15 Apr 2004 17:16:45 +1000
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds IOMMU support & IOMU virtual merging to the default
g5 config. This will not impair performances of machines that don't
need the iommu (the kernel will only enable it if you have more than
2Gb of RAM, though you can explicitely enable it using a command line
argument).

Please apply,
Ben.


===== arch/ppc64/configs/g5_defconfig 1.6 vs edited =====
--- 1.6/arch/ppc64/configs/g5_defconfig	Wed Mar 24 05:18:46 2004
+++ edited/arch/ppc64/configs/g5_defconfig	Thu Apr 15 17:15:11 2004
@@ -23,8 +23,10 @@
 #
 CONFIG_SWAP=y
 CONFIG_SYSVIPC=y
+# CONFIG_POSIX_MQUEUE is not set
 # CONFIG_BSD_PROCESS_ACCT is not set
 CONFIG_SYSCTL=y
+# CONFIG_AUDIT is not set
 CONFIG_LOG_BUF_SHIFT=17
 CONFIG_HOTPLUG=y
 # CONFIG_IKCONFIG is not set
@@ -35,6 +37,7 @@
 CONFIG_IOSCHED_NOOP=y
 CONFIG_IOSCHED_AS=y
 CONFIG_IOSCHED_DEADLINE=y
+CONFIG_IOSCHED_CFQ=y
 # CONFIG_CC_OPTIMIZE_FOR_SIZE is not set
 
 #
@@ -58,11 +61,11 @@
 CONFIG_PPC_OF=y
 CONFIG_ALTIVEC=y
 CONFIG_PPC_PMAC=y
-# CONFIG_PMAC_DART is not set
+CONFIG_PMAC_DART=y
 CONFIG_PPC_PMAC64=y
 CONFIG_BOOTX_TEXT=y
 CONFIG_POWER4_ONLY=y
-# CONFIG_IOMMU_VMERGE is not set
+CONFIG_IOMMU_VMERGE=y
 CONFIG_SMP=y
 CONFIG_IRQ_ALL_CPUS=y
 CONFIG_NR_CPUS=2
@@ -80,6 +83,7 @@
 # CONFIG_BINFMT_MISC is not set
 CONFIG_PCI_LEGACY_PROC=y
 CONFIG_PCI_NAMES=y
+# CONFIG_HOTPLUG_CPU is not set
 
 #
 # PCMCIA/CardBus support
@@ -224,7 +228,7 @@
 #
 # SCSI Transport Attributes
 #
-# CONFIG_SCSI_SPI_ATTRS is not set
+CONFIG_SCSI_SPI_ATTRS=y
 # CONFIG_SCSI_FC_ATTRS is not set
 
 #
@@ -242,6 +246,8 @@
 CONFIG_SCSI_SATA_SVW=y
 # CONFIG_SCSI_ATA_PIIX is not set
 # CONFIG_SCSI_SATA_PROMISE is not set
+# CONFIG_SCSI_SATA_SIL is not set
+# CONFIG_SCSI_SATA_SIS is not set
 # CONFIG_SCSI_SATA_VIA is not set
 # CONFIG_SCSI_SATA_VITESSE is not set
 # CONFIG_SCSI_BUSLOGIC is not set
@@ -359,7 +365,6 @@
 # CONFIG_NET_IPGRE is not set
 # CONFIG_IP_MROUTE is not set
 # CONFIG_ARPD is not set
-# CONFIG_INET_ECN is not set
 CONFIG_SYN_COOKIES=y
 CONFIG_INET_AH=m
 CONFIG_INET_ESP=m
@@ -431,7 +436,6 @@
 #
 # SCTP Configuration (EXPERIMENTAL)
 #
-CONFIG_IPV6_SCTP__=y
 # CONFIG_IP_SCTP is not set
 # CONFIG_ATM is not set
 # CONFIG_VLAN_8021Q is not set
@@ -498,7 +502,6 @@
 # CONFIG_HAMACHI is not set
 # CONFIG_YELLOWFIN is not set
 # CONFIG_R8169 is not set
-# CONFIG_SIS190 is not set
 # CONFIG_SK98LIN is not set
 CONFIG_TIGON3=m
 
@@ -506,6 +509,7 @@
 # Ethernet (10000 Mbit)
 #
 # CONFIG_IXGB is not set
+# CONFIG_S2IO is not set
 # CONFIG_FDDI is not set
 # CONFIG_HIPPI is not set
 # CONFIG_IBMVETH is not set
@@ -675,6 +679,7 @@
 # I2C Hardware Bus support
 #
 # CONFIG_I2C_ALI1535 is not set
+# CONFIG_I2C_ALI1563 is not set
 # CONFIG_I2C_ALI15X3 is not set
 # CONFIG_I2C_AMD756 is not set
 # CONFIG_I2C_AMD8111 is not set
@@ -719,6 +724,8 @@
 # Other I2C Chip support
 #
 # CONFIG_SENSORS_EEPROM is not set
+# CONFIG_SENSORS_PCF8574 is not set
+# CONFIG_SENSORS_PCF8591 is not set
 # CONFIG_I2C_DEBUG_CORE is not set
 # CONFIG_I2C_DEBUG_ALGO is not set
 # CONFIG_I2C_DEBUG_BUS is not set
@@ -811,6 +818,7 @@
 #
 CONFIG_USB_EHCI_HCD=y
 # CONFIG_USB_EHCI_SPLIT_ISO is not set
+# CONFIG_USB_EHCI_ROOT_HUB_TT is not set
 CONFIG_USB_OHCI_HCD=y
 # CONFIG_USB_UHCI_HCD is not set
 
@@ -951,6 +959,7 @@
 # CONFIG_USB_LEGOTOWER is not set
 # CONFIG_USB_LCD is not set
 # CONFIG_USB_LED is not set
+# CONFIG_USB_CYTHERM is not set
 # CONFIG_USB_TEST is not set
 
 #
@@ -1003,6 +1012,7 @@
 #
 CONFIG_PROC_FS=y
 CONFIG_PROC_KCORE=y
+CONFIG_SYSFS=y
 # CONFIG_DEVFS_FS is not set
 CONFIG_DEVPTS_FS_XATTR=y
 # CONFIG_DEVPTS_FS_SECURITY is not set
@@ -1157,9 +1167,9 @@
 CONFIG_CRYPTO_AES=m
 CONFIG_CRYPTO_CAST5=m
 CONFIG_CRYPTO_CAST6=m
-# CONFIG_CRYPTO_ARC4 is not set
+CONFIG_CRYPTO_ARC4=m
 CONFIG_CRYPTO_DEFLATE=m
-# CONFIG_CRYPTO_MICHAEL_MIC is not set
+CONFIG_CRYPTO_MICHAEL_MIC=m
 CONFIG_CRYPTO_TEST=m
 
 #


