Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261656AbVAMPdJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261656AbVAMPdJ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Jan 2005 10:33:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261660AbVAMPcv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Jan 2005 10:32:51 -0500
Received: from www.ssc.unict.it ([151.97.230.9]:61956 "HELO ssc.unict.it")
	by vger.kernel.org with SMTP id S261658AbVAMPbN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Jan 2005 10:31:13 -0500
Subject: [patch 8/8] uml: depend on !USERMODE in drivers/block/Kconfig and drop arch/um/Kconfig_block
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org, jdike@addtoit.com,
       user-mode-linux-devel@lists.sourceforge.net, blaisorblade_spam@yahoo.it
From: blaisorblade_spam@yahoo.it
Date: Thu, 13 Jan 2005 06:13:41 +0100
Message-Id: <20050113051341.DD29D6325A@zion>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


From: Paolo 'Blaisorblade' Giarrusso <blaisorblade_spam@yahoo.it>

Finally, we end with this the need to update arch/um/Kconfig_block with
changes in drivers/block/Kconfig - we include directly that; UML-specific
entries were moved into it (they are very few).

Signed-off-by: Paolo 'Blaisorblade' Giarrusso <blaisorblade_spam@yahoo.it>
---

 linux-2.6.11-paolo/arch/um/Kconfig       |    2 
 linux-2.6.11-paolo/drivers/block/Kconfig |   57 ++++++++++++++++
 linux-2.6.11/arch/um/Kconfig_block       |  105 -------------------------------
 3 files changed, 56 insertions(+), 108 deletions(-)

diff -L arch/um/Kconfig_block -puN arch/um/Kconfig_block~uml-kconfig-block-update /dev/null
--- linux-2.6.11/arch/um/Kconfig_block
+++ /dev/null	2005-01-10 11:39:51.461898480 +0100
@@ -1,105 +0,0 @@
-
-menu "Block Devices"
-
-config BLK_DEV_UBD
-	bool "Virtual block device"
-	help
-        The User-Mode Linux port includes a driver called UBD which will let
-        you access arbitrary files on the host computer as block devices.
-        Unless you know that you do not need such virtual block devices say
-        Y here.
-
-config BLK_DEV_UBD_SYNC
-	bool "Always do synchronous disk IO for UBD"
-	depends on BLK_DEV_UBD
-	help
-        Writes to the virtual block device are not immediately written to the 
-	host's disk; this may cause problems if, for example, the 
-	User-Mode Linux 'Virtual Machine' uses a journalling filesystem and 
-	the host computer crashes.
-
-        Synchronous operation (i.e. always writing data to the host's disk
-        immediately) is configurable on a per-UBD basis by using a special
-        kernel command line option.  Alternatively, you can say Y here to
-        turn on synchronous operation by default for all block devices.
-
-        If you're running a journalling file system (like reiserfs, for
-        example) in your virtual machine, you will want to say Y here.  If
-        you care for the safety of the data in your virtual machine, Y is a
-        wise choice too.  In all other cases (for example, if you're just
-        playing around with User-Mode Linux) you can choose N.
-
-config BLK_DEV_COW_COMMON
-	bool
-	default BLK_DEV_UBD
-
-config BLK_DEV_LOOP
-	tristate "Loopback device support"
-
-config BLK_DEV_NBD
-	tristate "Network block device support"
-	depends on NET
-
-config BLK_DEV_RAM
-	tristate "RAM disk support"
-
-config BLK_DEV_RAM_COUNT
-	int "Default number of RAM disks" if BLK_DEV_RAM
-	default "16"
-
-config BLK_DEV_RAM_SIZE
-	int "Default RAM disk size"
-	depends on BLK_DEV_RAM
-	default "4096"
-
-config BLK_DEV_INITRD
-	bool "Initial RAM disk (initrd) support"
-	depends on BLK_DEV_RAM=y
-
-#Copied directly from drivers/block/Kconfig
-config INITRAMFS_SOURCE
-	string "Source directory of cpio_list"
-	default ""
-	help
-	  This can be set to either a directory containing files, etc to be
-	  included in the initramfs archive, or a file containing newline
-	  separated entries.
-
-	  If it is a file, it should be in the following format:
-	    # a comment
-	    file <name> <location> <mode> <uid> <gid>
-	    dir <name> <mode> <uid> <gid>
-	    nod <name> <mode> <uid> <gid> <dev_type> <maj> <min>
-
-	  Where:
-	    <name>      name of the file/dir/nod in the archive
-	    <location>  location of the file in the current filesystem
-	    <mode>      mode/permissions of the file
-	    <uid>       user id (0=root)
-	    <gid>       group id (0=root)
-	    <dev_type>  device type (b=block, c=character)
-	    <maj>       major number of nod
-	    <min>       minor number of nod
-
-	  If you are not sure, leave it blank.
-
-config MMAPPER
-	tristate "Example IO memory driver"
-	depends on BROKEN
-	help
-        The User-Mode Linux port can provide support for IO Memory
-        emulation with this option.  This allows a host file to be
-        specified as an I/O region on the kernel command line. That file
-        will be mapped into UML's kernel address space where a driver can
-        locate it and do whatever it wants with the memory, including
-        providing an interface to it for UML processes to use.
-
-        For more information, see
-        <http://user-mode-linux.sourceforge.net/iomem.html>.
-
-        If you'd like to be able to provide a simulated IO port space for
-        User-Mode Linux processes, say Y.  If unsure, say N.
-
-source "drivers/block/Kconfig.iosched"
-
-endmenu
diff -puN arch/um/Kconfig~uml-kconfig-block-update arch/um/Kconfig
--- linux-2.6.11/arch/um/Kconfig~uml-kconfig-block-update	2005-01-13 02:07:57.605331688 +0100
+++ linux-2.6.11-paolo/arch/um/Kconfig	2005-01-13 02:07:57.610330928 +0100
@@ -263,7 +263,7 @@ source "drivers/base/Kconfig"
 
 source "arch/um/Kconfig_char"
 
-source "arch/um/Kconfig_block"
+source "drivers/block/Kconfig"
 
 config NETDEVICES
 	bool
diff -puN drivers/block/Kconfig~uml-kconfig-block-update drivers/block/Kconfig
--- linux-2.6.11/drivers/block/Kconfig~uml-kconfig-block-update	2005-01-13 02:07:57.607331384 +0100
+++ linux-2.6.11-paolo/drivers/block/Kconfig	2005-01-13 02:12:59.998360960 +0100
@@ -6,7 +6,7 @@ menu "Block devices"
 
 config BLK_DEV_FD
 	tristate "Normal floppy disk support"
-	depends on (!ARCH_S390 && !M68K && !IA64) || Q40 || (SUN3X && BROKEN)
+	depends on (!ARCH_S390 && !M68K && !IA64 && !USERMODE) || Q40 || (SUN3X && BROKEN)
 	---help---
 	  If you want to use the floppy disk drive(s) of your PC under Linux,
 	  say Y. Information about this driver, especially important for IBM
@@ -208,6 +208,56 @@ config BLK_DEV_UMEM
 	  one is chosen dynamically.  Use "devfs" or look in /proc/devices
 	  for the device number
 
+config BLK_DEV_UBD
+	bool "Virtual block device"
+	depends on USERMODE
+	---help---
+          The User-Mode Linux port includes a driver called UBD which will let
+          you access arbitrary files on the host computer as block devices.
+          Unless you know that you do not need such virtual block devices say
+          Y here.
+
+config BLK_DEV_UBD_SYNC
+	bool "Always do synchronous disk IO for UBD"
+	depends on BLK_DEV_UBD
+	---help---
+	  Writes to the virtual block device are not immediately written to the
+	  host's disk; this may cause problems if, for example, the User-Mode
+	  Linux 'Virtual Machine' uses a journalling filesystem and the host
+	  computer crashes.
+
+          Synchronous operation (i.e. always writing data to the host's disk
+          immediately) is configurable on a per-UBD basis by using a special
+          kernel command line option.  Alternatively, you can say Y here to
+          turn on synchronous operation by default for all block devices.
+
+          If you're running a journalling file system (like reiserfs, for
+          example) in your virtual machine, you will want to say Y here.  If
+          you care for the safety of the data in your virtual machine, Y is a
+          wise choice too.  In all other cases (for example, if you're just
+          playing around with User-Mode Linux) you can choose N.
+
+config BLK_DEV_COW_COMMON
+	bool
+	default BLK_DEV_UBD
+
+config MMAPPER
+	tristate "Example IO memory driver (BROKEN)"
+	depends on USERMODE && BROKEN
+	---help---
+          The User-Mode Linux port can provide support for IO Memory
+          emulation with this option.  This allows a host file to be
+          specified as an I/O region on the kernel command line. That file
+          will be mapped into UML's kernel address space where a driver can
+          locate it and do whatever it wants with the memory, including
+          providing an interface to it for UML processes to use.
+
+          For more information, see
+          <http://user-mode-linux.sourceforge.net/iomem.html>.
+
+          If you'd like to be able to provide a simulated IO port space for
+          User-Mode Linux processes, say Y.  If unsure, say N.
+
 config BLK_DEV_LOOP
 	tristate "Loopback device support"
 	---help---
@@ -401,9 +451,11 @@ config INITRAMFS_ROOT_GID
 
 	  If you are not sure, leave it set to "0".
 
+#XXX - it makes sense to enable this only for 32-bit subarch's, not for x86_64
+#for instance.
 config LBD
 	bool "Support for Large Block Devices"
-	depends on X86 || MIPS32 || PPC32 || ARCH_S390_31 || SUPERH
+	depends on X86 || MIPS32 || PPC32 || ARCH_S390_31 || SUPERH || USERMODE
 	help
 	  Say Y here if you want to attach large (bigger than 2TB) discs to
 	  your machine, or if you want to have a raid or loopback device
@@ -411,6 +463,7 @@ config LBD
 
 config CDROM_PKTCDVD
 	tristate "Packet writing on CD/DVD media"
+	depends on !USERMODE
 	help
 	  If you have a CDROM drive that supports packet writing, say Y to
 	  include preliminary support. It should work with any MMC/Mt Fuji
_
