Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751511AbVIZMKx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751511AbVIZMKx (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Sep 2005 08:10:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751508AbVIZMKw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Sep 2005 08:10:52 -0400
Received: from web51004.mail.yahoo.com ([206.190.38.135]:14217 "HELO
	web51004.mail.yahoo.com") by vger.kernel.org with SMTP
	id S1751451AbVIZMKn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Sep 2005 08:10:43 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=Message-ID:Received:Date:From:Subject:To:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=bVfC0HWK02eM/6mGdUmyP+2nrJHoKkwcNuJy1PmzbXPPkTs25bD2lsdbXZNgTSxhz7JaYwrjyjNAxCkodyOgSZlxDBAUz/tq1HPB3juFQDts4AvechURLXvFMf1PitIUgWyK4aSTBHdwRgpe5YGaMt00bwUDUiE+Ncqbx+VRTzA=  ;
Message-ID: <20050926121042.53606.qmail@web51004.mail.yahoo.com>
Date: Mon, 26 Sep 2005 05:10:42 -0700 (PDT)
From: Ahmad Reza Cheraghi <a_r_cheraghi@yahoo.com>
Subject: [PATCH](Kconfig) Automatic Configuration of a Kernel
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--- linux.org/arch/i386/Kconfig	2005-09-23
09:27:06.000000000 +0200
+++ linux-2.6.13.2/arch/i386/Kconfig	2005-09-24
11:55:24.000000000 +0200
@@ -43,6 +43,7 @@
 
 config X86_PC
 	bool "PC-compatible"
+	autorule arch.sh "i386"	
 	help
 	  Choose this option if your computer is a standard
PC or compatible.
 
@@ -240,13 +241,15 @@
 	  extensions.
 
 config MPENTIUMM
-	bool "Pentium M"
+	bool "Pentium(R) M"
+	autorule cpugrep.sh "Pentium(R) M"
 	help
 	  Select this for Intel Pentium M (not Pentium-4 M)
 	  notebook chips.
 
 config MPENTIUM4
 	bool "Pentium-4/Celeron(P4-based)/Pentium-4 M/Xeon"
+	autorule cpugrep.sh "Pentium(R) 4"
 	help
 	  Select this for Intel Pentium 4 chips.  This
includes the
 	  Pentium 4, P4-based Celeron and Xeon, and
Pentium-4 M
@@ -263,6 +266,7 @@
 
 config MK7
 	bool "Athlon/Duron/K7"
+	autorule cpugrep.sh "Athlon"
 	help
 	  Select this for an AMD Athlon K7-family processor.
 Enables use of
 	  some extended instructions, and passes appropriate
optimization
@@ -1146,6 +1150,7 @@
 	bool "PCI support" if !X86_VISWS
 	depends on !X86_VOYAGER
 	default y if X86_VISWS
+	autorule hw_grep.sh "PCI bridge"
 	help
 	  Find out whether you have a PCI motherboard. PCI
is the name of a
 	  bus system, i.e. the way the CPU talks to the
other stuff inside
--- linux.org/sound/Kconfig	2005-09-23
09:27:39.000000000 +0200
+++ linux-2.6.13.2/sound/Kconfig	2005-09-24
11:55:41.000000000 +0200
@@ -5,6 +5,7 @@
 
 config SOUND
 	tristate "Sound card support"
+	autorule hw_egrep.sh "audio"
 	help
 	  If you have a sound card in your computer, i.e. if
it can say more
 	  than an occasional beep, say Y.  Be sure to have
all the information
@@ -42,6 +43,7 @@
 config SND
 	tristate "Advanced Linux Sound Architecture"
 	depends on SOUND
+	autorule hw_egrep.sh "audio"
 	help
 	  Say 'Y' or 'M' to enable ALSA (Advanced Linux
Sound Architecture),
 	  the new base sound system.
--- linux.org/drivers/usb/host/Kconfig	2005-09-23
09:27:25.000000000 +0200
+++ linux-2.6.13.2/drivers/usb/host/Kconfig	2005-09-24
11:55:24.000000000 +0200
@@ -7,6 +7,7 @@
 config USB_EHCI_HCD
 	tristate "EHCI HCD (USB 2.0) support"
 	depends on USB && PCI
+	autorule hw_grep.sh "EHCI"
 	---help---
 	  The Enhanced Host Controller Interface (EHCI) is
standard for USB 2.0
 	  "high speed" (480 Mbit/sec, 60 Mbyte/sec) host
controller hardware.
@@ -111,6 +112,7 @@
 config USB_UHCI_HCD
 	tristate "UHCI HCD (most Intel and VIA) support"
 	depends on USB && PCI
+	autorule hw_grep.sh "UHCI"
 	---help---
 	  The Universal Host Controller Interface is a
standard by Intel for
 	  accessing the USB hardware in the PC (which is
also called the USB
--- linux.org/drivers/usb/Kconfig	2005-09-23
09:27:25.000000000 +0200
+++ linux-2.6.13.2/drivers/usb/Kconfig	2005-09-24
11:55:24.000000000 +0200
@@ -34,6 +34,7 @@
 config USB
 	tristate "Support for Host-side USB"
 	depends on USB_ARCH_HAS_HCD
+	autorule hw_grep.sh "USB"
 	---help---
 	  Universal Serial Bus (USB) is a specification for
a serial bus
 	  subsystem which offers higher speeds and more
features than the
--- linux.org/drivers/ide/Kconfig	2005-09-23
09:27:12.000000000 +0200
+++ linux-2.6.13.2/drivers/ide/Kconfig	2005-09-24
11:55:24.000000000 +0200
@@ -8,6 +8,7 @@
 
 config IDE
 	tristate "ATA/ATAPI/MFM/RLL support"
+	autorule hw_egrep.sh "ATA|ATAPI|MFM|RLL"
 	---help---
 	  If you say Y here, your kernel will be able to
manage low cost mass
 	  storage units such as ATA/(E)IDE and ATAPI units.
The most common
@@ -135,6 +136,7 @@
 
 config BLK_DEV_IDEDISK
 	tristate "Include IDE/ATA-2 DISK support"
+	autorule hw_egrep.sh "ATA|IDE"
 	---help---
 	  This will include enhanced support for MFM/RLL/IDE
hard disks.  If
 	  you have a MFM/RLL/IDE disk, and there is no
special reason to use
@@ -167,6 +169,7 @@
 
 config BLK_DEV_IDECD
 	tristate "Include IDE/ATAPI CDROM support"
+	autorule hw_egrep.sh "ATAPI|IDE"
 	---help---
 	  If you have a CD-ROM drive using the ATAPI
protocol, say Y. ATAPI is
 	  a newer protocol used by IDE CD-ROM and TAPE
drives, similar to the
@@ -333,6 +336,7 @@
 config IDEPCI_SHARE_IRQ
 	bool "Sharing PCI IDE interrupts support"
 	depends on PCI && BLK_DEV_IDEPCI
+	autorule hw_egrep.sh "IDE|PCI"
 	help
 	  Some ATA/IDE chipsets have hardware support which
allows for
 	  sharing a single IRQ with other cards. To enable
support for
@@ -367,6 +371,7 @@
 config BLK_DEV_GENERIC
 	tristate "Generic PCI IDE Chipset Support"
 	depends on BLK_DEV_IDEPCI
+	autorule hw_egrep.sh "IDE|PCI"
 
 config BLK_DEV_OPTI621
 	tristate "OPTi 82C621 chipset enhanced support
(EXPERIMENTAL)"
@@ -398,6 +403,7 @@
 config BLK_DEV_IDEDMA_PCI
 	bool "Generic PCI bus-master DMA support"
 	depends on PCI && BLK_DEV_IDEPCI
+	autorule hw_grep.sh "PCI"
 	---help---
 	  If your PCI system uses IDE drive(s) (as opposed
to SCSI, say) and
 	  is capable of bus-master DMA operation (most
Pentium PCI systems),
@@ -591,6 +597,7 @@
 
 config BLK_DEV_PIIX
 	tristate "Intel PIIXn chipsets support"
+	autorule hw_grep.sh "ICH"
 	help
 	  This driver adds explicit support for Intel PIIX
and ICH chips
 	  and also for the Efar Victory66 (slc90e66) chip. 
This allows
--- linux.org/drivers/net/Kconfig	2005-09-23
09:27:16.000000000 +0200
+++ linux-2.6.13.2/drivers/net/Kconfig	2005-09-24
11:55:24.000000000 +0200
@@ -8,6 +8,7 @@
 config NETDEVICES
 	depends on NET
 	bool "Network device support"
+	autorule hw_egrep.sh "Network|Ethernet"
 	---help---
 	  You can say N here if you don't intend to connect
your Linux box to
 	  any other computer at all.
--- linux.org/drivers/ieee1394/Kconfig	2005-09-23
09:27:12.000000000 +0200
+++ linux-2.6.13.2/drivers/ieee1394/Kconfig	2005-09-24
11:55:24.000000000 +0200
@@ -6,6 +6,7 @@
 	tristate "IEEE 1394 (FireWire) support"
 	depends on PCI || BROKEN
 	select NET
+	autorule hw_grep.sh "FireWire (IEEE 1394)"
 	help
 	  IEEE 1394 describes a high performance serial bus,
which is also
 	  known as FireWire(tm) or i.Link(tm) and is used
for connecting all
--- linux.org/drivers/char/agp/Kconfig	2005-09-23
09:27:10.000000000 +0200
+++ linux-2.6.13.2/drivers/char/agp/Kconfig	2005-09-25
21:54:11.000000000 +0200
@@ -1,6 +1,7 @@
 config AGP
 	tristate "/dev/agpgart (AGP Support)" if !GART_IOMMU
 	depends on ALPHA || IA64 || PPC || X86
+	autorule hw_grep.sh "AGP"
 	default y if GART_IOMMU
 	---help---
 	  AGP (Accelerated Graphics Port) is a bus system
mainly used to
@@ -46,6 +47,7 @@
 config AGP_ATI
 	tristate "ATI chipset support"
 	depends on AGP && X86 && !X86_64
+	autorule hw_grep.sh "Radeon"
 	---help---
       This option gives you AGP support for the GLX
component of
       XFree86 4.x on the ATI RadeonIGP family of
chipsets.
--- linux.org/drivers/char/drm/Kconfig	2005-09-23
09:27:10.000000000 +0200
+++ linux-2.6.13.2/drivers/char/drm/Kconfig	2005-09-25
21:56:49.000000000 +0200
@@ -7,6 +7,7 @@
 config DRM
 	tristate "Direct Rendering Manager (XFree86 4.1.0
and higher DRI support)"
 	depends on (AGP || AGP=n) && PCI
+	autorule hw_egrep.sh "Rage|Radeon|Banshee|Voodoo"
 	help
 	  Kernel-level support for the Direct Rendering
Infrastructure (DRI)
 	  introduced in XFree86 4.0. If you say Y here, you
need to select
@@ -41,6 +42,7 @@
 config DRM_RADEON
 	tristate "ATI Radeon"
 	depends on DRM && PCI
+	autorule hw_grep.sh "Radeon"
 	help
 	  Choose this option if you have an ATI Radeon
graphics card.  There
 	  are both PCI and AGP versions.  You don't need to
choose this to





		
__________________________________ 
Yahoo! Mail - PC Magazine Editors' Choice 2005 
http://mail.yahoo.com
