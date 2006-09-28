Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161184AbWI1WTW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161184AbWI1WTW (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Sep 2006 18:19:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030391AbWI1WTG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Sep 2006 18:19:06 -0400
Received: from ogre.sisk.pl ([217.79.144.158]:37260 "EHLO ogre.sisk.pl")
	by vger.kernel.org with ESMTP id S1030389AbWI1WSl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Sep 2006 18:18:41 -0400
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: Andrew Morton <akpm@osdl.org>
Subject: [PATCH -mm 3/3] swsusp: Document testing code
Date: Fri, 29 Sep 2006 00:19:51 +0200
User-Agent: KMail/1.9.1
Cc: Pavel Machek <pavel@ucw.cz>, LKML <linux-kernel@vger.kernel.org>
References: <200609290005.17616.rjw@sisk.pl>
In-Reply-To: <200609290005.17616.rjw@sisk.pl>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200609290019.51531.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Update the swsusp documentation to cover the recently introduced testing
code.

Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
---
 Documentation/ABI/testing/sysfs-power |   17 ++++++++++++++++-
 Documentation/power/interface.txt     |   13 +++++++++++++
 2 files changed, 29 insertions(+), 1 deletion(-)

Index: linux-2.6.18-mm2/Documentation/ABI/testing/sysfs-power
===================================================================
--- linux-2.6.18-mm2.orig/Documentation/ABI/testing/sysfs-power	2006-09-28 21:53:01.000000000 +0200
+++ linux-2.6.18-mm2/Documentation/ABI/testing/sysfs-power	2006-09-28 23:37:50.000000000 +0200
@@ -21,7 +21,7 @@ Description:
 		these states.
 
 What:		/sys/power/disk
-Date:		August 2006
+Date:		September 2006
 Contact:	Rafael J. Wysocki <rjw@sisk.pl>
 Description:
 		The /sys/power/disk file controls the operating mode of the
@@ -39,6 +39,19 @@ Description:
 		'reboot' - the memory image will be saved by the kernel and
 		the system will be rebooted.
 
+		Additionally, /sys/power/disk can be used to turn on one of the
+		two testing modes of the suspend-to-disk mechanism: 'testproc'
+		or 'test'.  If the suspend-to-disk mechanism is in the
+		'testproc' mode, writing 'disk' to /sys/power/state will cause
+		the kernel to disable nonboot CPUs and freeze tasks, wait for 5
+		seconds, unfreeze tasks and enable nonboot CPUs.  If it is in
+		the 'test' mode, writing 'disk' to /sys/power/state will cause
+		the kernel to disable nonboot CPUs and freeze tasks, shrink
+		memory, suspend devices, wait for 5 seconds, resume devices,
+		unfreeze tasks and enable nonboot CPUs.  Then, we are able to
+		look in the log messages and work out, for example, which code
+		is being slow and which device drivers are misbehaving.
+
 		The suspend-to-disk method may be chosen by writing to this
 		file one of the accepted strings:
 
@@ -46,6 +59,8 @@ Description:
 		'platform'
 		'shutdown'
 		'reboot'
+		'testproc'
+		'test'
 
 		It will only change to 'firmware' or 'platform' if the system
 		supports that.
Index: linux-2.6.18-mm2/Documentation/power/interface.txt
===================================================================
--- linux-2.6.18-mm2.orig/Documentation/power/interface.txt	2006-09-28 21:53:01.000000000 +0200
+++ linux-2.6.18-mm2/Documentation/power/interface.txt	2006-09-28 23:34:39.000000000 +0200
@@ -30,6 +30,17 @@ testing). The system will support either
 that is known a priori. But, the user may choose 'shutdown' or
 'reboot' as alternatives. 
 
+Additionally, /sys/power/disk can be used to turn on one of the two testing
+modes of the suspend-to-disk mechanism: 'testproc' or 'test'.  If the
+suspend-to-disk mechanism is in the 'testproc' mode, writing 'disk' to
+/sys/power/state will cause the kernel to disable nonboot CPUs and freeze
+tasks, wait for 5 seconds, unfreeze tasks and enable nonboot CPUs.  If it is
+in the 'test' mode, writing 'disk' to /sys/power/state will cause the kernel
+to disable nonboot CPUs and freeze tasks, shrink memory, suspend devices, wait
+for 5 seconds, resume devices, unfreeze tasks and enable nonboot CPUs.  Then,
+we are able to look in the log messages and work out, for example, which code
+is being slow and which device drivers are misbehaving.
+
 Reading from this file will display what the mode is currently set
 to. Writing to this file will accept one of
 
@@ -37,6 +48,8 @@ to. Writing to this file will accept one
        'platform'
        'shutdown'
        'reboot'
+       'testproc'
+       'test'
 
 It will only change to 'firmware' or 'platform' if the system supports
 it. 
