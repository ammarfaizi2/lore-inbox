Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932086AbWH3Vea@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932086AbWH3Vea (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Aug 2006 17:34:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932087AbWH3Vea
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Aug 2006 17:34:30 -0400
Received: from ogre.sisk.pl ([217.79.144.158]:11720 "EHLO ogre.sisk.pl")
	by vger.kernel.org with ESMTP id S932086AbWH3Ve3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Aug 2006 17:34:29 -0400
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: Greg KH <greg@kroah.com>
Subject: [RFC][PATCH -mm] PM: add /sys/power documentation to Documentation/ABI
Date: Wed, 30 Aug 2006 23:38:06 +0200
User-Agent: KMail/1.9.3
Cc: Andrew Morton <akpm@osdl.org>, Pavel Machek <pavel@ucw.cz>,
       LKML <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200608302338.06882.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The file sysfs-power that documents the interface in the /sys/power/ directory
is added to Documentation/ABI/testing.

Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
---
 Documentation/ABI/testing/sysfs-power |   88 ++++++++++++++++++++++++++++++++++
 1 file changed, 88 insertions(+)

Index: linux-2.6.18-rc4-mm3/Documentation/ABI/testing/sysfs-power
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ linux-2.6.18-rc4-mm3/Documentation/ABI/testing/sysfs-power	2006-08-30 23:29:17.000000000 +0200
@@ -0,0 +1,88 @@
+What:		/sys/power/
+Date:		August 2006
+Contact:	Rafael J. Wysocki <rjw@sisk.pl>
+Description:
+		The /sys/power directory will contain files that will
+		provide a unified interface to the power management
+		subsystem.
+
+What:		/sys/power/state
+Date:		August 2006
+Contact:	Rafael J. Wysocki <rjw@sisk.pl>
+Description:
+		The /sys/power/state file controls the system power state.
+		Reading from this file returns what states are supported,
+		which is hard-coded to 'standby' (Power-On Suspend), 'mem'
+		(Suspend-to-RAM), and 'disk' (Suspend-to-Disk).
+
+		Writing to this file one of these strings causes the system to
+		transition into that state. Please see the file
+		Documentation/power/states.txt for a description of each of
+		these states.
+
+What:		/sys/power/disk
+Date:		August 2006
+Contact:	Rafael J. Wysocki <rjw@sisk.pl>
+Description:
+		The /sys/power/disk file controls the operating mode of the
+		suspend-to-disk mechanism.  Reading from this file returns
+		the name of the method by which the system will be put to
+		sleep on the next suspend.  There are four methods supported:
+		'firmware' - means that the memory image will be saved to disk
+		by some firmware, in which case we also assume that the
+		firmware will handle the system suspend.
+		'platform' - the memory image will be saved by the kernel and
+		the system will be put to sleep by the platform driver (e.g.
+		ACPI or other PM registers).
+		'shutdown' - the memory image will be saved by the kernel and
+		the system will be powered off.
+		'reboot' - the memory image will be saved by the kernel and
+		the system will be rebooted.
+
+		The suspend-to-disk method may be chosen by writing to this
+		file one of the accepted strings:
+
+		'firmware'
+		'platform'
+		'shutdown'
+		'reboot'
+
+		It will only change to 'firmware' or 'platform' if the system
+		supports that.
+
+What:		/sys/power/image_size
+Date:		August 2006
+Contact:	Rafael J. Wysocki <rjw@sisk.pl>
+Description:
+		The /sys/power/image_size file controls the size of the image
+		created by the suspend-to-disk mechanism.  It can be written a
+		string representing a non-negative integer that will be used
+		as an upper limit of the image size, in bytes.  The kernel's
+		suspend-to-disk code will do its best to ensure the image size
+		will not exceed this number.  However, if it turns out to be
+		impossible, the kernel will try to suspend anyway using the
+		smallest image possible.  In particular, if "0" is written to
+		this file, the suspend image will be as small as possible.
+
+		Reading from this file will display the current image size
+		limit, which is set to 500 MB by default.
+
+What:		/sys/power/pm_trace
+Date:		August 2006
+Contact:	Rafael J. Wysocki <rjw@sisk.pl>
+Description:
+		The /sys/power/pm_trace file controls the code which saves the
+		last PM event point in the RTC across reboots, so that you can
+		debug a machine that just hangs during suspend (or more
+		commonly, during resume).  Namely, the RTC is only used to save
+		the last PM event point if this file contains '1'.  Initially
+		it contains '0' which may be changed to '1' by writing a
+		string representing a nonzero integer into it.
+
+		To use this debugging feature you should attempt to suspend
+		the machine, then reboot it and run
+
+		dmesg -s 1000000 | grep 'hash matches'
+
+		CAUTION: Using it will cause your machine's real-time (CMOS)
+		clock to be set to a random invalid time after a resume.
