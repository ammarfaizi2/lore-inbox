Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751132AbWIZFti@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751132AbWIZFti (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Sep 2006 01:49:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751383AbWIZFtI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Sep 2006 01:49:08 -0400
Received: from cantor.suse.de ([195.135.220.2]:58081 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1751339AbWIZFjR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Sep 2006 01:39:17 -0400
From: Greg KH <greg@kroah.com>
To: linux-kernel@vger.kernel.org
Cc: Andrew Morton <akpm@osdl.org>, Greg Kroah-Hartman <gregkh@suse.de>
Subject: [PATCH 23/47] PM: add /sys/power documentation to Documentation/ABI
Date: Mon, 25 Sep 2006 22:37:43 -0700
Message-Id: <11592491581007-git-send-email-greg@kroah.com>
X-Mailer: git-send-email 1.4.2.1
In-Reply-To: <11592491551919-git-send-email-greg@kroah.com>
References: <20060926053728.GA8970@kroah.com> <1159249087369-git-send-email-greg@kroah.com> <11592490903867-git-send-email-greg@kroah.com> <11592490933346-git-send-email-greg@kroah.com> <1159249096460-git-send-email-greg@kroah.com> <11592490993970-git-send-email-greg@kroah.com> <11592491023995-git-send-email-greg@kroah.com> <1159249104512-git-send-email-greg@kroah.com> <11592491082990-git-send-email-greg@kroah.com> <1159249111668-git-send-email-greg@kroah.com> <11592491152668-git-send-email-greg@kroah.com> <115924911859-git-send-email-greg@kroah.com> <11592491211162-git-send-email-greg@kroah.com> <1159249124371-git-send-email-greg@kroah.com> <11592491274168-git-send-email-greg@kroah.com> <11592491303012-git-send-email-greg@kroah.com> <11592491342421-git-send-email-greg@kroah.com> <11592491371254-git-send-email-greg@kroah.com> <1159249140339-git-send-email-greg@kroah.com> <11592491451786-git-send-email-greg@kroah.com> <11592491482560-git-send-email-greg@kroah.com> <11592491512
 235-git-send-email-greg@kroah.com> <11592491551919-git-send-email-greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Rafael J. Wysocki <rjw@sisk.pl>

The file sysfs-power that documents the interface in the /sys/power/ directory
is added to Documentation/ABI/testing.

Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
Acked-by: Pavel Machek <pavel@ucw.cz>
Signed-off-by: Andrew Morton <akpm@osdl.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>
---
 Documentation/ABI/testing/sysfs-power |   88 +++++++++++++++++++++++++++++++++
 1 files changed, 88 insertions(+), 0 deletions(-)

diff --git a/Documentation/ABI/testing/sysfs-power b/Documentation/ABI/testing/sysfs-power
new file mode 100644
index 0000000..d882f80
--- /dev/null
+++ b/Documentation/ABI/testing/sysfs-power
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
-- 
1.4.2.1

