Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268183AbUJORP3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268183AbUJORP3 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 15 Oct 2004 13:15:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268206AbUJORP2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Oct 2004 13:15:28 -0400
Received: from adsl-67-120-171-161.dsl.lsan03.pacbell.net ([67.120.171.161]:39552
	"HELO home.linuxace.com") by vger.kernel.org with SMTP
	id S268183AbUJORM6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Oct 2004 13:12:58 -0400
Date: Fri, 15 Oct 2004 10:12:57 -0700
From: Phil Oester <kernel@linuxace.com>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] scsihosts parameter no longer exists
Message-ID: <20041015171257.GA12844@linuxace.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="3MwIy2ne0vdjdPXF"
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--3MwIy2ne0vdjdPXF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

The scsihosts boot parameter was removed in 2.5.73, but references
to it still exist in docs.  Cleanup below.

Phil




--3MwIy2ne0vdjdPXF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=patch-scsihosts

diff -ru linux-orig/Documentation/filesystems/devfs/README linux-new/Documentation/filesystems/devfs/README
--- linux-orig/Documentation/filesystems/devfs/README	2004-08-14 06:55:19.000000000 -0400
+++ linux-new/Documentation/filesystems/devfs/README	2004-10-15 13:07:49.420190504 -0400
@@ -1349,47 +1349,6 @@
 point to the kernel-supplied names.
 
 
-SCSI Host Probing Issues
-
-Devfs allows you to identify SCSI discs based in part on SCSI host
-numbers. If you have only one SCSI host (card) in your computer, then
-clearly it will be given host number 0. Life is not always that easy
-is you have multiple SCSI hosts. Unfortunately, it can sometimes be
-difficult to guess what the probing order of SCSI hosts is. You need
-to know the probe order before you can use device names. To make this
-easy, there is a kernel boot parameter called "scsihosts". This allows
-you to specify the probe order for different types of SCSI hosts. The
-syntax of this parameter is:
-
-scsihosts=<name_1>:<name_2>:<name_3>:...:<name_n>
-
-where <name_1>,<name_2>,...,<name_n> are the names
-of drivers used in the /proc filesystem. For example:
-
-    scsihosts=aha1542:ppa:aha1542::ncr53c7xx
-
-
-means that devices connected to
-
-- first aha1542 controller   - will be /dev/scsi/host0/bus#/target#/lun#
-- first parallel port ZIP    - will be /dev/scsi/host1/bus#/target#/lun#
-- second aha1542 controller  - will be /dev/scsi/host2/bus#/target#/lun#
-- first NCR53C7xx controller - will be /dev/scsi/host4/bus#/target#/lun#
-- any extra controller       - will be /dev/scsi/host5/bus#/target#/lun#,
-                                       /dev/scsi/host6/bus#/target#/lun#, etc
-- if any of above controllers will not be found - the reserved names will
-  not be used by any other device.
-- /dev/scsi/host3/bus#/target#/lun# names will never be used
-
-
-You can use ',' instead of ':' as the separator character if you
-wish. I have used the devfsd naming scheme
-here.
-
-Note that this scheme does not address the SCSI host order if you have
-multiple cards of the same type (such as NCR53c8xx). In this case you
-need to use the driver-specific boot parameters to control this.
-
 -----------------------------------------------------------------------------
 
 
@@ -1952,12 +1911,6 @@
 
 Douglas Gilbert has written another useful document at
 
-http://www.torque.net/scsi/scsihosts.html which
-discusses the scsihosts= boot option
-
-
-Douglas Gilbert has written yet another useful document at
-
 http://www.torque.net/scsi/SCSI-2.4-HOWTO/ which
 discusses the Linux SCSI subsystem in 2.4.
 
diff -ru linux-orig/Documentation/kernel-parameters.txt linux-new/Documentation/kernel-parameters.txt
--- linux-orig/Documentation/kernel-parameters.txt	2004-10-14 18:27:03.000000000 -0400
+++ linux-new/Documentation/kernel-parameters.txt	2004-10-15 13:03:36.115698640 -0400
@@ -1060,8 +1060,6 @@
 
 	scsi_logging=	[SCSI]
 
-	scsihosts=	[SCSI]
-
 	serialnumber	[BUGS=IA-32]
 
 	sf16fm=		[HW] SF16FMI radio driver for Linux
diff -ru linux-orig/Documentation/scsi/scsi_mid_low_api.txt linux-new/Documentation/scsi/scsi_mid_low_api.txt
--- linux-orig/Documentation/scsi/scsi_mid_low_api.txt	2004-10-14 18:27:03.000000000 -0400
+++ linux-new/Documentation/scsi/scsi_mid_low_api.txt	2004-10-15 13:04:58.591160464 -0400
@@ -1323,9 +1323,7 @@
 initialized from the driver's struct scsi_host_template instance. Members
 of interest:
     host_no      - system wide unique number that is used for identifying
-                   this host. Issued in ascending order from 0 (and the
-                   positioning can be influenced by the scsihosts
-                   kernel boot (or module) parameter)
+                   this host. Issued in ascending order from 0.
     can_queue    - must be greater than 0; do not send more than can_queue
                    commands to the adapter.
     this_id      - scsi id of host (scsi initiator) or -1 if not known

--3MwIy2ne0vdjdPXF--
