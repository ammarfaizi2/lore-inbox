Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S275381AbSIUGHR>; Sat, 21 Sep 2002 02:07:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S275554AbSIUGHR>; Sat, 21 Sep 2002 02:07:17 -0400
Received: from out001pub.verizon.net ([206.46.170.140]:11179 "EHLO
	out001.verizon.net") by vger.kernel.org with ESMTP
	id <S275381AbSIUGHP>; Sat, 21 Sep 2002 02:07:15 -0400
Message-ID: <3D8C0DA4.D801C523@verizon.net>
Date: Fri, 20 Sep 2002 23:11:48 -0700
From: "Randy.Dunlap" <randy.dunlap@verizon.net>
X-Mailer: Mozilla 4.78 [en] (X11; U; Linux 2.4.18 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: [patch-2.4.19] add/cleanup kernel-parameters.txt
Content-Type: multipart/mixed;
 boundary="------------7A081D19CFFC174A30A3230E"
X-Authentication-Info: Submitted using SMTP AUTH PLAIN at out001.verizon.net from [4.64.197.173] at Sat, 21 Sep 2002 01:12:16 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------7A081D19CFFC174A30A3230E
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit


Hi-

I began by wanting to see "mem=exactmap" listed in
Documentation/kernel-parameters.txt, and then it just
grew from there.

Change summary:
 kernel-parameters.txt |   32 ++++++++++++++++++++++++--------
 1 files changed, 24 insertions(+), 8 deletions(-)

. add IP_PNP kernel parameter category (was just "PNP")

. change occurrences of "ix86" to "IA-32" (not that I care,
  but the file says that IA-32 is for i386 family stuff)

. [ARM only] change "keep_initrd" to "keepinitrd" as used in
  source code

. add some missing kernel parameters

. add "mem=exactmap"

Patch is against 2.4.19, but 2.4.20-pre7 and same-ac don't
contain any changes to Documentation/kernel-parameters.txt.

Comments or corrections before I ask Marcelo to apply it?

Thanks,
~Randy
--------------7A081D19CFFC174A30A3230E
Content-Type: text/plain; charset=us-ascii;
 name="kparam-doc-2419.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="kparam-doc-2419.patch"

--- linux-2419/Documentation/kernel-parameters.txt.xmap	Fri Aug  2 17:39:42 2002
+++ linux-2419/Documentation/kernel-parameters.txt	Fri Sep 20 22:50:22 2002
@@ -23,6 +23,7 @@
 	HW	Appropriate hardware is enabled.
 	IA-32	IA-32 aka i386 architecture is enabled.
 	IA-64	IA-64 architecture is enabled.
+	IP_PNP	IP DCHP, BOOTP, or RARP is enabled.
 	ISAPNP  ISA PnP code is enabled.
 	ISDN	Appropriate ISDN support is enabled.
 	JOY 	Appropriate joystick support is enabled.
@@ -251,7 +252,7 @@
 
 	initrd=		[BOOT] Specify the location of the initial ramdisk. 
 
-	ip=		[PNP]
+	ip=		[IP_PNP]
 
 	isapnp=		[ISAPNP] Specify RDP, reset, pci_scan and verbosity.
 
@@ -273,10 +274,14 @@
  
 	kbd-reset	[VT]
 
-	keep_initrd	[HW, ARM]
+	keepinitrd	[HW, ARM]
 
 	load_ramdisk=	[RAM] List of ramdisks to load from floppy.
 
+	lockd.udpport=	[NFS]
+
+	lockd.tcpport=	[NFS]
+
 	logi_busmouse=	[HW, MOUSE]
 
 	lp=0		[LP]	Specify parallel ports to use, e.g,
@@ -313,7 +318,7 @@
 
 	max_scsi_luns=	[SCSI]
 
-	mca-pentium	[BUGS=ix86]
+	mca-pentium	[BUGS=IA-32]
 
 	mcd=		[HW,CD]
 
@@ -327,6 +332,11 @@
 
 	megaraid=	[HW,SCSI]
  
+	mem=exactmap	[KNL,BOOT,IA-32] enable setting of an exact
+			e820 memory map, as specified by the user.
+			Such mem=exactmap lines can be constructed
+			based on BIOS output or other requirements.
+
 	mem=nn[KMG]	[KNL,BOOT] force use of a specific amount of
 			memory; to be used when the kernel is not able
 			to see the whole system memory or for test.
@@ -359,9 +369,9 @@
 
 	nfsroot=	[NFS] nfs root filesystem for disk-less boxes.
 
-	nmi_watchdog=	[KNL,BUGS=ix86] debugging features for SMP kernels.
+	nmi_watchdog=	[KNL,BUGS=IA-32] debugging features for SMP kernels.
 
-	no387		[BUGS=ix86] Tells the kernel to use the 387 maths
+	no387		[BUGS=IA-32] Tells the kernel to use the 387 maths
 			emulation library even if a 387 maths coprocessor
 			is present.
 
@@ -379,7 +389,9 @@
 
 	nohlt		[BUGS=ARM]
  
-	no-hlt		[BUGS=ix86]
+	no-hlt		[BUGS=IA-32] Tells the kernel that the hlt
+			instruction doesn't work correctly and not to
+			use it.
 
 	noht		[SMP,IA-32] Disables P4 Xeon(tm) HyperThreading.
 
@@ -396,7 +408,7 @@
 
 	nosync		[HW, M68K] Disables sync negotiation for all devices.
 
-	notsc           [BUGS=ix86] Disable Time Stamp Counter
+	notsc           [BUGS=IA-32] Disable Time Stamp Counter
 
 	nowb		[ARM]
  
@@ -504,7 +516,7 @@
 	ramdisk_start=	[RAM] Starting block of RAM disk image (so you can
 			place it after the kernel image on a boot floppy).
 
-	reboot=		[BUGS=ix86]
+	reboot=		[BUGS=IA-32]
 
 	reserve=	[KNL,BUGS] force the kernel to ignore some iomem area.
 
@@ -513,6 +525,10 @@
 	ro		[KNL] Mount root device read-only on boot.
 
 	root=		[KNL] root filesystem.
+
+	rootflags=	[KNL] set root filesystem mount option string
+
+	rootfstype=	[KNL] set root filesystem type
 
 	rw		[KNL] Mount root device read-write on boot.
 

--------------7A081D19CFFC174A30A3230E--

