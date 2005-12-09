Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964875AbVLITzO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964875AbVLITzO (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Dec 2005 14:55:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964874AbVLITzO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Dec 2005 14:55:14 -0500
Received: from fmr22.intel.com ([143.183.121.14]:59105 "EHLO
	scsfmr002.sc.intel.com") by vger.kernel.org with ESMTP
	id S932423AbVLITzM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Dec 2005 14:55:12 -0500
From: Jesse Barnes <jesse.barnes@intel.com>
To: gregkh@suse.de, linux-kernel@vger.kernel.org,
       Ian Romanick <idr@us.ibm.com>
Subject: [PATCH] document sysfs rom file interface
Date: Fri, 9 Dec 2005 11:55:03 -0800
User-Agent: KMail/1.9
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_XEemDuJjIGAKH0r"
Message-Id: <200512091155.03552.jesse.barnes@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--Boundary-00=_XEemDuJjIGAKH0r
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

idr gently pointed out today that not only is the sysfs rom file 
interface somewhat unintuitive (despite my efforts and initial 
implementation), but it's also undocumented!  This patch to 
Documentation/filesystems/sysfs-pci.txt corrects the latter problem; the 
former is a userland ABI now though, so we're stuck with it for awhile 
at least.

Signed-off-by: Jesse Barnes <jbarnes@virtuousgeek.org>


--Boundary-00=_XEemDuJjIGAKH0r
Content-Type: text/x-diff;
  charset="us-ascii";
  name="sysfs-rom-file-documentation.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="sysfs-rom-file-documentation.patch"

diff --git a/Documentation/filesystems/sysfs-pci.txt b/Documentation/filesystems/sysfs-pci.txt
index 988a62f..7ba2baa 100644
--- a/Documentation/filesystems/sysfs-pci.txt
+++ b/Documentation/filesystems/sysfs-pci.txt
@@ -1,4 +1,5 @@
 Accessing PCI device resources through sysfs
+--------------------------------------------
 
 sysfs, usually mounted at /sys, provides access to PCI resources on platforms
 that support it.  For example, a given bus might look like this:
@@ -47,14 +48,21 @@ files, each with their own function.
   binary - file contains binary data
   cpumask - file contains a cpumask type
 
-The read only files are informational, writes to them will be ignored.
-Writable files can be used to perform actions on the device (e.g. changing
-config space, detaching a device).  mmapable files are available via an
-mmap of the file at offset 0 and can be used to do actual device programming
-from userspace.  Note that some platforms don't support mmapping of certain
-resources, so be sure to check the return value from any attempted mmap.
+The read only files are informational, writes to them will be ignored, with
+the exception of the 'rom' file.  Writable files can be used to perform
+actions on the device (e.g. changing config space, detaching a device).
+mmapable files are available via an mmap of the file at offset 0 and can be
+used to do actual device programming from userspace.  Note that some platforms
+don't support mmapping of certain resources, so be sure to check the return
+value from any attempted mmap.
+
+The 'rom' file is special in that it provides read-only access to the device's
+ROM file, if available.  It's disabled by default, however, so applications
+should write the string "1" to the file to enable it before attempting a read
+call, and disable it following the access by writing "0" to the file.
 
 Accessing legacy resources through sysfs
+----------------------------------------
 
 Legacy I/O port and ISA memory resources are also provided in sysfs if the
 underlying platform supports them.  They're located in the PCI class heirarchy,
@@ -75,6 +83,7 @@ simply dereference the returned pointer 
 to access legacy memory space.
 
 Supporting PCI access on new platforms
+--------------------------------------
 
 In order to support PCI resource mapping as described above, Linux platform
 code must define HAVE_PCI_MMAP and provide a pci_mmap_page_range function.

--Boundary-00=_XEemDuJjIGAKH0r--
