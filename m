Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267553AbSLMACV>; Thu, 12 Dec 2002 19:02:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267554AbSLMACV>; Thu, 12 Dec 2002 19:02:21 -0500
Received: from gandalf.math.uni-mannheim.de ([134.155.88.152]:26885 "EHLO
	gandalf.math.uni-mannheim.de") by vger.kernel.org with ESMTP
	id <S267553AbSLMACR>; Thu, 12 Dec 2002 19:02:17 -0500
Content-Type: text/plain; charset=US-ASCII
From: Matthias Juchem <lists@konfido.de>
Reply-To: lists@konfido.de
To: linux-kernel@vger.kernel.org
Subject: [RFC] Hide dangerous configuration options
Date: Fri, 13 Dec 2002 01:10:04 +0100
X-Mailer: KMail [version 1.3.2]
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <E18MdP2-0002WU-00@gandalf.math.uni-mannheim.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

The patch below adds a configuration option 'DANGEROUS'.

Idea is to prevent people from enabling such options unintentionally. 

Set to N, options which were labelled DANGEROUS are hidden,
set to Y, they are show.

DANGEROUS does not depend on EXPERIMENTAL, because there are options that are 
dangerous but not experimental.

Patch is against 2.5.51.

Regards,
 Matthias


diff -urN linux-2.5.51/arch/ppc/Kconfig linux-2.5.51-mj/arch/ppc/Kconfig
--- linux-2.5.51/arch/ppc/Kconfig	Tue Dec 10 03:46:25 2002
+++ linux-2.5.51-mj/arch/ppc/Kconfig	Fri Dec 13 00:19:17 2002
@@ -694,7 +694,7 @@
 
 config TAU_INT
 	bool "Interrupt driven TAU driver (DANGEROUS)"
-	depends on TAU
+	depends on TAU && DANGEROUS
 	---help---
 	  The TAU supports an interrupt driven mode which causes an interrupt
 	  whenever the temperature goes out of range. This is the fastest way
diff -urN linux-2.5.51/drivers/ide/Kconfig linux-2.5.51-mj/drivers/ide/Kconfig
--- linux-2.5.51/drivers/ide/Kconfig	Tue Dec 10 03:45:56 2002
+++ linux-2.5.51-mj/drivers/ide/Kconfig	Fri Dec 13 00:17:52 2002
@@ -424,7 +424,7 @@
 
 config WDC_ALI15X3
 	bool "ALI M15x3 WDC support (DANGEROUS)"
-	depends on BLK_DEV_ALI15X3
+	depends on BLK_DEV_ALI15X3 && DANGEROUS
 	---help---
 	  This allows for UltraDMA support for WDC drives that ignore CRC
 	  checking. You are a fool for enabling this option, but there have
diff -urN linux-2.5.51/fs/Kconfig linux-2.5.51-mj/fs/Kconfig
--- linux-2.5.51/fs/Kconfig	Tue Dec 10 03:46:10 2002
+++ linux-2.5.51-mj/fs/Kconfig	Fri Dec 13 00:18:55 2002
@@ -159,7 +159,7 @@
 
 config ADFS_FS_RW
 	bool "ADFS write support (DANGEROUS)"
-	depends on ADFS_FS
+	depends on ADFS_FS && DANGEROUS
 	help
 	  If you say Y here, you will be able to write to ADFS partitions on
 	  hard drives and ADFS-formatted floppy disks. This is experimental
@@ -773,7 +773,7 @@
 
 config NTFS_RW
 	bool "NTFS write support (DANGEROUS)"
-	depends on NTFS_FS && EXPERIMENTAL
+	depends on NTFS_FS && EXPERIMENTAL && DANGEROUS
 	help
 	  This enables the experimental write support in the NTFS driver.
 
@@ -916,7 +916,7 @@
 
 config QNX4FS_RW
 	bool "QNX4FS write support (DANGEROUS)"
-	depends on QNX4FS_FS && EXPERIMENTAL
+	depends on QNX4FS_FS && EXPERIMENTAL && DANGEROUS
 	help
 	  Say Y if you want to test write support for QNX4 file systems.
 
@@ -1098,7 +1098,7 @@
 
 config UFS_FS_WRITE
 	bool "UFS file system write support (DANGEROUS)"
-	depends on UFS_FS && EXPERIMENTAL
+	depends on UFS_FS && EXPERIMENTAL && DANGEROUS
 	help
 	  Say Y here if you want to try writing to UFS partitions. This is
 	  experimental, so you should back up your UFS partitions beforehand.
diff -urN linux-2.5.51/init/Kconfig linux-2.5.51-mj/init/Kconfig
--- linux-2.5.51/init/Kconfig	Tue Dec 10 03:46:15 2002
+++ linux-2.5.51-mj/init/Kconfig	Fri Dec 13 00:40:51 2002
@@ -32,6 +32,13 @@
 	  you say Y here, you will be offered the choice of using features or
 	  drivers that are currently considered to be in the alpha-test phase.
 
+config DANGEROUS
+	bool "Prompt for dangerous code/drivers"
+	---help---
+	  If you say Y here, options that enable dangerous code will be shown.
+
+	  Say N.
+
 endmenu
 
 
