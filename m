Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261685AbVBWXM5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261685AbVBWXM5 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Feb 2005 18:12:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261683AbVBWXMH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Feb 2005 18:12:07 -0500
Received: from mail.aei.ca ([206.123.6.14]:21499 "EHLO aeimail.aei.ca")
	by vger.kernel.org with ESMTP id S261694AbVBWXH7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Feb 2005 18:07:59 -0500
From: Ed Tomlinson <tomlins@cam.org>
Organization: me
To: Andrew Morton <akpm@osdl.org>
Subject: Re: 2.6.11-rc4-mm1
Date: Wed, 23 Feb 2005 18:07:52 -0500
User-Agent: KMail/1.7.2
Cc: linux-kernel@vger.kernel.org
References: <20050223014233.6710fd73.akpm@osdl.org>
In-Reply-To: <20050223014233.6710fd73.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200502231807.52877.tomlins@cam.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 23 February 2005 04:42, Andrew Morton wrote:
> 
> ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.11-rc4/2.6.11-rc4-mm1/
> 
> 
> - Various fixes and updates all over the place.  Things seem to have slowed
>   down a bit.
> 
> - Last, final, ultimate call: if anyone has patches in here which are 2.6.11
>   material, please tell me.

It boots fine here except that my keyboard is dead, rc3-mm2 is fine.  The .config was built via
using rc3-mm2's config and make oldconfig.  Looking it the boot log I see:

in rc3-mm2

Feb 23 17:49:20 grover kernel: Initializing Cryptographic API
Feb 23 17:49:20 grover kernel: Linux agpgart interface v0.101 (c) Dave Jones
Feb 23 17:49:20 grover kernel: [drm] Initialized drm 1.0.0 20040925
Feb 23 17:49:20 grover kernel: ACPI: PS/2 Keyboard Controller [PS2K] at I/O 0x60, 0x64, irq 1
Feb 23 17:49:20 grover kernel: ACPI: PS/2 Mouse Controller [PS2M] at irq 12
Feb 23 17:49:20 grover kernel: serio: i8042 AUX port at 0x60,0x64 irq 12
Feb 23 17:49:20 grover kernel: serio: i8042 KBD port at 0x60,0x64 irq 1
Feb 23 17:49:20 grover kernel: Serial: 8250/16550 driver $Revision: 1.90 $ 48 ports, IRQ sharing enabled

in rc4-mm1

Feb 23 17:46:54 grover kernel: Initializing Cryptographic API
Feb 23 17:46:54 grover kernel: inotify device minor=63
Feb 23 17:46:54 grover kernel: Linux agpgart interface v0.101 (c) Dave Jones
Feb 23 17:46:54 grover kernel: [drm] Initialized drm 1.0.0 20040925
Feb 23 17:46:54 grover kernel: Serial: 8250/16550 driver $Revision: 1.90 $ 48 ports, IRQ sharing enabled
Feb 23 17:46:54 grover kernel: ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A

It does not seem to be finding the keyboard at all...

Ideas?
Ed Tomlinson

diff -u ../11-3-2/.config .config
--- ../11-3-2/.config   2005-02-12 09:55:28.000000000 -0500
+++ .config     2005-02-23 07:10:53.000000000 -0500
@@ -1,7 +1,7 @@
 #
 # Automatically generated make config: don't edit
-# Linux kernel version: 2.6.11-rc3-mm2
-# Sat Feb 12 09:55:28 2005
+# Linux kernel version: 2.6.11-rc4-mm1
+# Wed Feb 23 07:10:53 2005
 #
 CONFIG_X86_64=y
 CONFIG_64BIT=y
@@ -91,6 +91,7 @@
 CONFIG_X86_MCE_INTEL=y
 CONFIG_PHYSICAL_START=0x100000
 CONFIG_KEXEC=y
+CONFIG_SECCOMP=y
 CONFIG_GENERIC_HARDIRQS=y
 CONFIG_GENERIC_IRQ_PROBE=y

@@ -119,6 +120,8 @@
 CONFIG_ACPI_ASUS=m
 # CONFIG_ACPI_IBM is not set
 CONFIG_ACPI_TOSHIBA=m
+# CONFIG_ACPI_PCC is not set
+# CONFIG_ACPI_SONY is not set
 CONFIG_ACPI_BLACKLIST_YEAR=0
 # CONFIG_ACPI_DEBUG is not set
 CONFIG_ACPI_BUS=y
@@ -459,6 +462,7 @@
 CONFIG_BLK_DEV_SR=m
 # CONFIG_BLK_DEV_SR_VENDOR is not set
 CONFIG_CHR_DEV_SG=m
+# CONFIG_CHR_DEV_SCH is not set

 #
 # Some SCSI devices (e.g. CD jukebox) support multiple LUNs
@@ -493,6 +497,7 @@
 # CONFIG_SCSI_ATA_PIIX is not set
 CONFIG_SCSI_SATA_NV=m
 # CONFIG_SCSI_SATA_PROMISE is not set
+# CONFIG_SCSI_SATA_QSTOR is not set
 # CONFIG_SCSI_SATA_SX4 is not set
 # CONFIG_SCSI_SATA_SIL is not set
 # CONFIG_SCSI_SATA_SIS is not set
@@ -543,6 +548,8 @@
 CONFIG_DM_SNAPSHOT=m
 CONFIG_DM_MIRROR=m
 CONFIG_DM_ZERO=m
+CONFIG_DM_MULTIPATH=m
+CONFIG_DM_MULTIPATH_EMC=m

 #
 # Fusion MPT device support
@@ -971,6 +978,11 @@
 CONFIG_BT_HCIBPA10X=m
 CONFIG_BT_HCIBFUSB=m
 CONFIG_BT_HCIVHCI=m
+CONFIG_IEEE80211=m
+# CONFIG_IEEE80211_DEBUG is not set
+CONFIG_IEEE80211_CRYPT_WEP=m
+CONFIG_IEEE80211_CRYPT_CCMP=m
+CONFIG_IEEE80211_CRYPT_TKIP=m
 CONFIG_NETDEVICES=y
 CONFIG_DUMMY=m
 CONFIG_BONDING=m
@@ -1263,6 +1275,8 @@
 # CONFIG_JOYSTICK_JOYDUMP is not set
 CONFIG_INPUT_TOUCHSCREEN=y
 CONFIG_TOUCHSCREEN_GUNZE=m
+# CONFIG_TOUCHSCREEN_ELO is not set
+# CONFIG_TOUCHSCREEN_MK712 is not set
 CONFIG_INPUT_MISC=y
 CONFIG_INPUT_PCSPKR=m
 CONFIG_INPUT_UINPUT=m
@@ -1293,6 +1307,7 @@
 CONFIG_VT=y
 CONFIG_VT_CONSOLE=y
 CONFIG_HW_CONSOLE=y
+CONFIG_INOTIFY=y
 CONFIG_SERIAL_NONSTANDARD=y
 CONFIG_COMPUTONE=m
 CONFIG_ROCKETPORT=m
@@ -1370,6 +1385,7 @@
 CONFIG_IB700_WDT=m
 CONFIG_WAFER_WDT=m
 CONFIG_I8XX_TCO=m
+# CONFIG_I6300ESB_WDT is not set
 CONFIG_SC1200_WDT=m
 CONFIG_SCx200_WDT=m
 CONFIG_60XX_WDT=m
@@ -1444,6 +1460,11 @@
 CONFIG_HANGCHECK_TIMER=m

 #
+# TPM devices
+#
+# CONFIG_TCG_TPM is not set
+
+#
 # I2C support
 #
 CONFIG_I2C=m
@@ -1471,6 +1492,7 @@
 CONFIG_I2C_NFORCE2=m
 CONFIG_I2C_PARPORT=m
 CONFIG_I2C_PARPORT_LIGHT=m
+# CONFIG_I2C_PIIX4 is not set
 CONFIG_I2C_PROSAVAGE=m
 CONFIG_I2C_SAVAGE4=m
 CONFIG_SCx200_ACB=m
@@ -1496,6 +1518,7 @@
 CONFIG_SENSORS_FSCHER=m
 # CONFIG_SENSORS_FSCPOS is not set
 CONFIG_SENSORS_GL518SM=m
+CONFIG_SENSORS_GL520SM=m
 CONFIG_SENSORS_IT87=m
 # CONFIG_SENSORS_LM63 is not set
 CONFIG_SENSORS_LM75=m
@@ -1509,6 +1532,7 @@
 CONFIG_SENSORS_MAX1619=m
 # CONFIG_SENSORS_PC87360 is not set
 # CONFIG_SENSORS_SMSC47B397 is not set
+CONFIG_SENSORS_SIS5595=m
 # CONFIG_SENSORS_SMSC47M1 is not set
 CONFIG_SENSORS_VIA686A=m
 CONFIG_SENSORS_W83781D=m
@@ -1682,6 +1706,10 @@
 # Graphics support
 #
 CONFIG_FB=y
+CONFIG_FB_CFB_FILLRECT=y
+CONFIG_FB_CFB_COPYAREA=y
+CONFIG_FB_CFB_IMAGEBLIT=y
+CONFIG_FB_SOFT_CURSOR=y
 CONFIG_FB_MODE_HELPERS=y
 # CONFIG_FB_TILEBLITTING is not set
 CONFIG_FB_CIRRUS=m
@@ -1695,6 +1723,7 @@
 CONFIG_VIDEO_SELECT=y
 CONFIG_FB_HGA=m
 # CONFIG_FB_HGA_ACCEL is not set
+# CONFIG_FB_NVIDIA is not set
 CONFIG_FB_RIVA=m
 CONFIG_FB_RIVA_I2C=y
 CONFIG_FB_RIVA_DEBUG=y
@@ -1726,6 +1755,7 @@
 CONFIG_FB_VOODOO1=m
 CONFIG_FB_TRIDENT=m
 # CONFIG_FB_TRIDENT_ACCEL is not set
+# CONFIG_FB_GEODE is not set
 CONFIG_FB_VIRTUAL=m

 #
@@ -2281,6 +2311,7 @@
 CONFIG_MAGIC_SYSRQ=y
 CONFIG_LOG_BUF_SHIFT=14
 CONFIG_DETECT_SOFTLOCKUP=y
+# CONFIG_PRINTK_TIME is not set
 # CONFIG_SCHEDSTATS is not set
 # CONFIG_DEBUG_SLAB is not set
 CONFIG_DEBUG_PREEMPT=y


