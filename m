Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262417AbUKKXF2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262417AbUKKXF2 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Nov 2004 18:05:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262305AbUKKXED
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Nov 2004 18:04:03 -0500
Received: from hera.cwi.nl ([192.16.191.8]:4065 "EHLO hera.cwi.nl")
	by vger.kernel.org with ESMTP id S262292AbUKKXCa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Nov 2004 18:02:30 -0500
Date: Fri, 12 Nov 2004 00:02:25 +0100 (MET)
From: <Andries.Brouwer@cwi.nl>
Message-Id: <200411112302.iABN2Pu01711@apps.cwi.nl>
To: akpm@osdl.org, torvalds@osdl.org
Subject: [PATCH] remove if !PARTITION_ADVANCED condition in defaults
Cc: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Many people are being bitten by the fact that if they select
CONFIG_PARTITION_ADVANCED in order to get some additional support,
they suddenly lose support for the MSDOS_PARTITION type.

Moreover, everybody needs MSDOS_PARTITION - also people not on i386,
since it is the type used on smart media and compact flash and
similar cards.

So, the below advises people "Say Y here" for MSDOS_PARTITION,
and does not change the default choices when PARTITION_ADVANCED
is selected.

Andries

diff -uprN -X /linux/dontdiff a/fs/partitions/Kconfig b/fs/partitions/Kconfig
--- a/fs/partitions/Kconfig	2004-08-26 22:05:38.000000000 +0200
+++ b/fs/partitions/Kconfig	2004-11-11 23:53:11.000000000 +0100
@@ -16,31 +16,31 @@ config PARTITION_ADVANCED
 
 config ACORN_PARTITION
 	bool "Acorn partition support" if PARTITION_ADVANCED
-	default y if !PARTITION_ADVANCED && ARCH_ACORN
+	default y if ARCH_ACORN
 	help
 	  Support hard disks partitioned under Acorn operating systems.
 
 config ACORN_PARTITION_CUMANA
 	bool "Cumana partition support" if PARTITION_ADVANCED && ACORN_PARTITION
-	default y if !PARTITION_ADVANCED && ARCH_ACORN
+	default y if ARCH_ACORN
 	help
 	  Say Y here if you would like to use hard disks under Linux which
 	  were partitioned using the Cumana interface on Acorn machines.
 
 config ACORN_PARTITION_EESOX
 	bool "EESOX partition support" if PARTITION_ADVANCED && ACORN_PARTITION
-	default y if !PARTITION_ADVANCED && ARCH_ACORN
+	default y if ARCH_ACORN
 
 config ACORN_PARTITION_ICS
 	bool "ICS partition support" if PARTITION_ADVANCED && ACORN_PARTITION
-	default y if !PARTITION_ADVANCED && ARCH_ACORN
+	default y if ARCH_ACORN
 	help
 	  Say Y here if you would like to use hard disks under Linux which
 	  were partitioned using the ICS interface on Acorn machines.
 
 config ACORN_PARTITION_ADFS
 	bool "Native filecore partition support" if PARTITION_ADVANCED && ACORN_PARTITION
-	default y if !PARTITION_ADVANCED && ARCH_ACORN
+	default y if ARCH_ACORN
 	help
 	  The Acorn Disc Filing System is the standard file system of the
 	  RiscOS operating system which runs on Acorn's ARM-based Risc PC
@@ -49,14 +49,14 @@ config ACORN_PARTITION_ADFS
 
 config ACORN_PARTITION_POWERTEC
 	bool "PowerTec partition support" if PARTITION_ADVANCED && ACORN_PARTITION
-	default y if !PARTITION_ADVANCED && ARCH_ACORN
+	default y if ARCH_ACORN
 	help
 	  Support reading partition tables created on Acorn machines using
 	  the PowerTec SCSI drive.
 
 config ACORN_PARTITION_RISCIX
 	bool "RISCiX partition support" if PARTITION_ADVANCED && ACORN_PARTITION
-	default y if !PARTITION_ADVANCED && ARCH_ACORN
+	default y if ARCH_ACORN
 	help
 	  Once upon a time, there was a native Unix port for the Acorn series
 	  of machines called RISCiX.  If you say 'Y' here, Linux will be able
@@ -64,21 +64,21 @@ config ACORN_PARTITION_RISCIX
 
 config OSF_PARTITION
 	bool "Alpha OSF partition support" if PARTITION_ADVANCED
-	default y if !PARTITION_ADVANCED && ALPHA
+	default y if ALPHA
 	help
 	  Say Y here if you would like to use hard disks under Linux which
 	  were partitioned on an Alpha machine.
 
 config AMIGA_PARTITION
 	bool "Amiga partition table support" if PARTITION_ADVANCED
-	default y if !PARTITION_ADVANCED && (AMIGA || AFFS_FS=y)
+	default y if (AMIGA || AFFS_FS=y)
 	help
 	  Say Y here if you would like to use hard disks under Linux which
 	  were partitioned under AmigaOS.
 
 config ATARI_PARTITION
 	bool "Atari partition table support" if PARTITION_ADVANCED
-	default y if !PARTITION_ADVANCED && ATARI
+	default y if ATARI
 	help
 	  Say Y here if you would like to use hard disks under Linux which
 	  were partitioned under the Atari OS.
@@ -93,17 +93,16 @@ config IBM_PARTITION
 
 config MAC_PARTITION
 	bool "Macintosh partition map support" if PARTITION_ADVANCED
-	default y if !PARTITION_ADVANCED && MAC
+	default y if MAC
 	help
 	  Say Y here if you would like to use hard disks under Linux which
 	  were partitioned on a Macintosh.
 
 config MSDOS_PARTITION
 	bool "PC BIOS (MSDOS partition tables) support" if PARTITION_ADVANCED
-	default y if !PARTITION_ADVANCED && !AMIGA && !ATARI && !MAC && !SGI_IP22 && !ARM && !SGI_IP27
+	default y
 	help
-	  Say Y here if you would like to use hard disks under Linux which
-	  were partitioned on an x86 PC (not necessarily by DOS).
+	  Say Y here.
 
 config BSD_DISKLABEL
 	bool "BSD disklabel (FreeBSD partition tables) support"
@@ -189,14 +188,14 @@ config LDM_DEBUG
 
 config SGI_PARTITION
 	bool "SGI partition support" if PARTITION_ADVANCED
-	default y if !PARTITION_ADVANCED && (SGI_IP22 || SGI_IP27)
+	default y if (SGI_IP22 || SGI_IP27)
 	help
 	  Say Y here if you would like to be able to read the hard disk
 	  partition table format used by SGI machines.
 
 config ULTRIX_PARTITION
 	bool "Ultrix partition table support" if PARTITION_ADVANCED
-	default y if !PARTITION_ADVANCED && DECSTATION
+	default y if DECSTATION
 	help
 	  Say Y here if you would like to be able to read the hard disk
 	  partition table format used by DEC (now Compaq) Ultrix machines.
@@ -204,7 +203,7 @@ config ULTRIX_PARTITION
 
 config SUN_PARTITION
 	bool "Sun partition tables support" if PARTITION_ADVANCED
-	default y if !PARTITION_ADVANCED && (SPARC32 || SPARC64)
+	default y if (SPARC32 || SPARC64)
 	---help---
 	  Like most systems, SunOS uses its own hard disk partition table
 	  format, incompatible with all others. Saying Y here allows you to
