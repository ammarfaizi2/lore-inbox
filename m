Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261665AbUL3PiM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261665AbUL3PiM (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Dec 2004 10:38:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261663AbUL3PiL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Dec 2004 10:38:11 -0500
Received: from ztxmail03.ztx.compaq.com ([161.114.1.207]:18956 "EHLO
	ztxmail03.ztx.compaq.com") by vger.kernel.org with ESMTP
	id S261660AbUL3PhY convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Dec 2004 10:37:24 -0500
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Subject: RE: [PATCH] cciss: Documentation update
Date: Thu, 30 Dec 2004 09:37:18 -0600
Message-ID: <D4CFB69C345C394284E4B78B876C1CF107DC0160@cceexc23.americas.cpqcorp.net>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH] cciss: Documentation update
Thread-Index: AcTrTVfic6VNGy02TtiiqviENBH9iQDN/ULg
From: "Miller, Mike (OS Dev)" <mike.miller@hp.com>
To: "James Nelson" <james4765@verizon.net>, <linux-kernel@vger.kernel.org>,
       "ISS StorageDev" <iss_storagedev@hp.com>
Cc: <akpm@osdl.org>
X-OriginalArrivalTime: 30 Dec 2004 15:37:18.0777 (UTC) FILETIME=[723B5A90:01C4EE85]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Mike Miller <mike.miller@hp.com>

Patch still applies to 2.6.10.

Updates to cciss documentation.

mkdev.cciss is no longer needed, since it is handled by the MAKEDEV program.

diffstat output:

 00-INDEX    |    2 --
 cciss.txt   |   27 +++++++++++++--------------
 mkdev.cciss |   40 ----------------------------------------
 3 files changed, 13 insertions(+), 56 deletions(-)

Signed-off-by: James Nelson <james4765@gmail.com>

diff -urN --exclude='*~' linux-2.6.10-original/Documentation/00-INDEX linux-2.6.10/Documentation/00-INDEX
--- linux-2.6.10-original/Documentation/00-INDEX	2004-12-24 16:34:26.000000000 -0500
+++ linux-2.6.10/Documentation/00-INDEX	2004-12-26 08:12:16.241315851 -0500
@@ -174,8 +174,6 @@
 	- info on typical Linux memory problems.
 mips/
 	- directory with info about Linux on MIPS architecture.
-mkdev.cciss
-	- script to make /dev entries for SMART controllers (see cciss.txt).
 mono.txt
 	- how to execute Mono-based .NET binaries with the help of BINFMT_MISC.
 moxa-smartio
diff -urN --exclude='*~' linux-2.6.10-original/Documentation/cciss.txt linux-2.6.10/Documentation/cciss.txt
--- linux-2.6.10-original/Documentation/cciss.txt	2004-12-24 16:34:00.000000000 -0500
+++ linux-2.6.10/Documentation/cciss.txt	2004-12-26 08:12:16.241315851 -0500
@@ -17,25 +17,27 @@
 	* SA 6422
 	* SA V100
 
-If nodes are not already created in the /dev/cciss directory
+If nodes are not already created in the /dev/cciss directory, run as root:
 
-# mkdev.cciss [ctlrs]
-
-Where ctlrs is the number of controllers you have (defaults to 1 if not
-specified).
+# cd /dev
+# ./MAKEDEV cciss
 
 Device Naming:
 --------------
 
-You need some entries in /dev for the cciss device.  The mkdev.cciss script
+You need some entries in /dev for the cciss device.  The MAKEDEV script
 can make device nodes for you automatically.  Currently the device setup
 is as follows:
 
 Major numbers:
 	104	cciss0	
 	105	cciss1	
-	106	cciss2 
-	etc...
+	106	cciss2
+	105	cciss3
+	108	cciss4
+	109	cciss5
+	110	cciss6
+	111	cciss7
 
 Minor numbers:
         b7 b6 b5 b4 b3 b2 b1 b0
@@ -45,7 +47,7 @@
              |
              +-------------------- Logical Volume number
 
-The suggested device naming scheme is:
+The device naming scheme is:
 /dev/cciss/c0d0			Controller 0, disk 0, whole device
 /dev/cciss/c0d0p1		Controller 0, disk 0, partition 1
 /dev/cciss/c0d0p2		Controller 0, disk 0, partition 2
@@ -117,16 +119,13 @@
 
 Note that the naming convention of the /proc filesystem entries 
 contains a number in addition to the driver name.  (E.g. "cciss0" 
-instead of just "cciss" which you might expect.)   This is because 
-of changes to the 2.4 kernel PCI interface related to PCI hot plug
-that imply the driver must register with the SCSI mid layer once per
-adapter instance rather than once per driver.
+instead of just "cciss" which you might expect.)
 
 Note: ONLY sequential access devices and medium changers are presented 
 as SCSI devices to the SCSI mid layer by the cciss driver.  Specifically, 
 physical SCSI disk drives are NOT presented to the SCSI mid layer.  The 
 physical SCSI disk drives are controlled directly by the array controller 
-hardware and it is important to prevent the OS from attempting to directly 
+hardware and it is important to prevent the kernel from attempting to directly 
 access these devices too, as if the array controller were merely a SCSI 
 controller in the same way that we are allowing it to access SCSI tape drives.
 
diff -urN --exclude='*~' linux-2.6.10-original/Documentation/mkdev.cciss linux-2.6.10/Documentation/mkdev.cciss
--- linux-2.6.10-original/Documentation/mkdev.cciss	2004-12-24 16:33:52.000000000 -0500
+++ linux-2.6.10/Documentation/mkdev.cciss	1969-12-31 19:00:00.000000000 -0500
@@ -1,40 +0,0 @@
-#!/bin/sh
-# Script to create device nodes for SMART array controllers
-# Usage:
-#	mkdev.cciss [num controllers] [num log volumes] [num partitions]
-#
-# With no arguments, the script assumes 1 controller, 16 logical volumes,
-# and 16 partitions/volume, which is adequate for most configurations.
-#
-# If you had 5 controllers and were planning on no more than 4 logical volumes
-# each, using a maximum of 8 partitions per volume, you could say:
-#
-# mkdev.cciss 5 4 8
-#
-# Of course, this has no real benefit over "mkdev.cciss 5" except that it
-# doesn't create so many device nodes in /dev/cciss.
-
-NR_CTLR=${1-1}
-NR_VOL=${2-16}
-NR_PART=${3-16}
-
-if [ ! -d /dev/cciss ]; then
-	mkdir -p /dev/cciss
-fi
-
-C=0; while [ $C -lt $NR_CTLR ]; do
-	MAJ=`expr $C + 104`
-	D=0; while [ $D -lt $NR_VOL ]; do
-		P=0; while [ $P -lt $NR_PART ]; do
-			MIN=`expr $D \* 16 + $P`
-			if [ $P -eq 0 ]; then
-				mknod /dev/cciss/c${C}d${D} b $MAJ $MIN
-			else
-				mknod /dev/cciss/c${C}d${D}p${P} b $MAJ $MIN
-			fi
-			P=`expr $P + 1`
-		done
-		D=`expr $D + 1`
-	done
-	C=`expr $C + 1`
-done
