Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264456AbRFIKft>; Sat, 9 Jun 2001 06:35:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264458AbRFIKfk>; Sat, 9 Jun 2001 06:35:40 -0400
Received: from oxmail1.ox.ac.uk ([129.67.1.1]:35802 "EHLO oxmail.ox.ac.uk")
	by vger.kernel.org with ESMTP id <S264456AbRFIKf1>;
	Sat, 9 Jun 2001 06:35:27 -0400
Date: Sat, 9 Jun 2001 11:35:21 +0100
From: Ian Lynagh <igloo@earth.li>
To: linux-kernel@vger.kernel.org
Subject: 2.2.19 rpc_execute panic (OK with 2.2.17)
Message-ID: <20010609113521.A30318@stu163.keble.ox.ac.uk>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="tThc/1wpZn/ma/RB"
Content-Disposition: inline
User-Agent: Mutt/1.3.15i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--tThc/1wpZn/ma/RB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline


Hi all

We have a sun ultra 1 with /proc/cpuinfo as follows:

cpu             : TI UltraSparc I   (SpitFire)
fpu             : UltraSparc I integrated FPU
promlib         : Version 3 Revision 1
prom            : 3.1.1
type            : sun4u
ncpus probed    : 1
ncpus active    : 1
BogoMips        : 333.41
MMU Type        : Spitfire

When trying to mount something over NFS with a 2.2.19 kernel we get:

Unsupported unaligned load/store trap for kernel at <00000000004d260c>
Kernel panic: Wheee. Kernel does fpu/atomic unaligned load/store.

Which appears to be in rpc_execute according to System.map:

00000000004d1dc0 T rpc_unlock_task
00000000004d21e0 T rpc_delay
00000000004d2220 t rpc_atrun
00000000004d2240 t __rpc_execute
00000000004d25a0 T rpc_execute
00000000004d2640 t __rpc_schedule
00000000004d27c0 T rpc_allocate
00000000004d28e0 T rpc_free

I have also compiled a 2.2.17 kernel in the same way and that works
fine. We are using the RedHat sparc mount-2.10r-0.6.x RPM. I said no to
the NFS 3 questions when making oldconfig from a 2.2.17 (working)
config. I've attached a diff of the 2 configs.

I've searched the archives but didn't seem to find anything relating to
this. Can anyone suggest a fix? If you need more information to diagnose
the problem please just ask.


I would appreciate it if you were to CC me responses as I am not on the
list.


Thanks in advance
Ian


--tThc/1wpZn/ma/RB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="config.diff"

--- linux-2.2.19-spiffy-simple/.config	Fri Jun  8 22:22:54 2001
+++ linux-2.2.17-spiffy-simple/.config	Fri Jun  8 23:00:34 2001
@@ -20,18 +20,6 @@
 CONFIG_VT=y
 CONFIG_VT_CONSOLE=y
 # CONFIG_SMP is not set
-CONFIG_SPARC64=y
-CONFIG_SBUS=y
-CONFIG_SBUSCHAR=y
-CONFIG_SUN_MOUSE=y
-CONFIG_SERIAL=y
-CONFIG_SUN_SERIAL=y
-CONFIG_SERIAL_CONSOLE=y
-CONFIG_SUN_KEYBOARD=y
-CONFIG_SUN_CONSOLE=y
-CONFIG_SUN_AUXIO=y
-CONFIG_SUN_IO=y
-# CONFIG_PCI is not set
 
 #
 # Console drivers
@@ -50,6 +38,17 @@
 CONFIG_FBCON_FONTWIDTH8_ONLY=y
 CONFIG_FONT_SUN8x16=y
 # CONFIG_FBCON_FONTS is not set
+CONFIG_SBUS=y
+CONFIG_SBUSCHAR=y
+CONFIG_SUN_MOUSE=y
+CONFIG_SERIAL=y
+CONFIG_SUN_SERIAL=y
+CONFIG_SERIAL_CONSOLE=y
+CONFIG_SUN_KEYBOARD=y
+CONFIG_SUN_CONSOLE=y
+CONFIG_SUN_AUXIO=y
+CONFIG_SUN_IO=y
+# CONFIG_PCI is not set
 
 #
 # Misc Linux/SPARC drivers
@@ -65,7 +64,9 @@
 # Linux/SPARC audio subsystem (EXPERIMENTAL)
 #
 # CONFIG_SPARCAUDIO is not set
+# CONFIG_SPARCAUDIO_AMD7930 is not set
 # CONFIG_SPARCAUDIO_CS4231 is not set
+# CONFIG_SPARCAUDIO_DBRI is not set
 # CONFIG_SPARCAUDIO_DUMMY is not set
 CONFIG_SUN_OPENPROMFS=m
 CONFIG_NET=y
@@ -130,7 +131,6 @@
 # CONFIG_X25 is not set
 # CONFIG_LAPB is not set
 # CONFIG_BRIDGE is not set
-# CONFIG_NET_DIVERT is not set
 # CONFIG_LLC is not set
 # CONFIG_ECONET is not set
 # CONFIG_WAN_ROUTER is not set
@@ -200,7 +200,6 @@
 CONFIG_SUNBMAC=m
 # CONFIG_SUNQE is not set
 # CONFIG_MYRI_SBUS is not set
-# CONFIG_FDDI is not set
 
 #
 # Unix 98 PTY support
@@ -214,12 +213,6 @@
 # CONFIG_VIDEO_DEV is not set
 
 #
-# XFree86 DRI support
-#
-# CONFIG_DRM is not set
-# CONFIG_DRM_FFB is not set
-
-#
 # Filesystems
 #
 # CONFIG_QUOTA is not set
@@ -251,14 +244,11 @@
 #
 # CONFIG_CODA_FS is not set
 CONFIG_NFS_FS=y
-# CONFIG_NFS_V3 is not set
 CONFIG_NFSD=m
-# CONFIG_NFSD_V3 is not set
-# CONFIG_NFSD_TCP is not set
+# CONFIG_NFSD_SUN is not set
 CONFIG_SUNRPC=y
 CONFIG_LOCKD=y
 CONFIG_SMB_FS=m
-# CONFIG_SMB_NLS_DEFAULT is not set
 # CONFIG_NCP_FS is not set
 
 #
@@ -266,7 +256,6 @@
 #
 CONFIG_BSD_DISKLABEL=y
 # CONFIG_MAC_PARTITION is not set
-# CONFIG_MINIX_SUBPARTITION is not set
 CONFIG_SMD_DISKLABEL=y
 CONFIG_SOLARIS_X86_PARTITION=y
 # CONFIG_UNIXWARE_DISKLABEL is not set
@@ -308,7 +297,6 @@
 # CONFIG_NLS_ISO8859_14 is not set
 CONFIG_NLS_ISO8859_15=m
 # CONFIG_NLS_KOI8_R is not set
-# CONFIG_NLS_KOI8_RU is not set
 
 #
 # Watchdog

--tThc/1wpZn/ma/RB--
