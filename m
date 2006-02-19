Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751090AbWBSWg4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751090AbWBSWg4 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 19 Feb 2006 17:36:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751105AbWBSWg4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 19 Feb 2006 17:36:56 -0500
Received: from ogre.sisk.pl ([217.79.144.158]:46987 "EHLO ogre.sisk.pl")
	by vger.kernel.org with ESMTP id S1751090AbWBSWg4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 19 Feb 2006 17:36:56 -0500
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: Andrew Morton <akpm@osdl.org>
Subject: [PATCH -mm] swsusp: warn about filesystems mounted from USB devices
Date: Sun, 19 Feb 2006 23:37:27 +0100
User-Agent: KMail/1.9.1
Cc: Pavel Machek <pavel@suse.cz>, LKML <linux-kernel@vger.kernel.org>,
       Alan Stern <stern@rowland.harvard.edu>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200602192337.27941.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Warn in the documentation that data may be lost if there are some filesystems
mounted from USB devices before suspend.

[Thanks to Alan Stern for providing the answer to the question in the Q:-A: part.]


Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
Acked-by: Pavel Machek <pavel@suse.cz>
---
 Documentation/power/swsusp.txt |   24 ++++++++++++++++++++++++
 1 files changed, 24 insertions(+)

Index: linux-2.6.16-rc3-mm1/Documentation/power/swsusp.txt
===================================================================
--- linux-2.6.16-rc3-mm1.orig/Documentation/power/swsusp.txt
+++ linux-2.6.16-rc3-mm1/Documentation/power/swsusp.txt
@@ -17,6 +17,11 @@ Some warnings, first.
  * but it will probably only crash.
  *
  * (*) suspend/resume support is needed to make it safe.
+ *
+ * If you have any filesystems on USB devices mounted before suspend,
+ * they won't be mounted after resume and you may lose data, as though
+ * you have unplugged the USB devices with mounted filesystems on them
+ * (see the FAQ below for details).
 
 You need to append resume=/dev/your_swap_partition to kernel command
 line. Then you suspend by
@@ -347,3 +352,22 @@ terminal the kernel switches to during s
 kernel console loglevel to at least 5, for example by doing
 
 	echo 5 > /proc/sys/kernel/printk
+
+Q: Is this true that if I have a mounted filesystem on a USB device and
+I suspend to disk, I can lose data unless the filesystem has been mounted
+with "sync"?
+
+A: That's right.  It depends on your hardware, and it could be true even for
+suspend-to-RAM.  In fact, even with "-o sync" you can lose data if your
+programs have information in buffers they haven't written out to disk.
+
+If you're lucky, your hardware will support low-power modes for USB
+controllers while the system is asleep.  Lots of hardware doesn't,
+however.  Shutting off the power to a USB controller is equivalent to 
+unplugging all the attached devices.
+
+Remember that it's always a bad idea to unplug a disk drive containing a
+mounted filesystem.  With USB that's true even when your system is asleep!
+The safest thing is to unmount all USB-based filesystems before suspending 
+and remount them after resuming.
+
