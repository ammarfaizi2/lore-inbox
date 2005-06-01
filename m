Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261537AbVFASWM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261537AbVFASWM (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Jun 2005 14:22:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261531AbVFASLV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Jun 2005 14:11:21 -0400
Received: from mtagate4.de.ibm.com ([195.212.29.153]:56451 "EHLO
	mtagate4.de.ibm.com") by vger.kernel.org with ESMTP id S261507AbVFASC0
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Jun 2005 14:02:26 -0400
Date: Wed, 1 Jun 2005 20:02:26 +0200
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
To: akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: [patch 2/11] s390: cio documentation.
Message-ID: <20050601180226.GB6418@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[patch 2/11] s390: cio documentation.

From: Cornelia Huck <cohuck@de.ibm.com>

Some clarifications in the cio documentation.

Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>

diffstat:
 Documentation/s390/CommonIO |   16 +++++++++-------
 1 files changed, 9 insertions(+), 7 deletions(-)

diff -urpN linux-2.6/Documentation/s390/CommonIO linux-2.6-patched/Documentation/s390/CommonIO
--- linux-2.6/Documentation/s390/CommonIO	2005-03-02 08:38:26.000000000 +0100
+++ linux-2.6-patched/Documentation/s390/CommonIO	2005-06-01 19:43:15.000000000 +0200
@@ -30,7 +30,7 @@ Command line parameters
   device numbers (0xabcd or abcd, for 2.4 backward compatibility).
   You can use the 'all' keyword to ignore all devices.
   The '!' operator will cause the I/O-layer to _not_ ignore a device.
-  The order on the command line is not important.
+  The command line is parsed from left to right.
 
   For example, 
 	cio_ignore=0.0.0023-0.0.0042,0.0.4711
@@ -72,13 +72,14 @@ Command line parameters
   /proc/cio_ignore; "add <device range>, <device range>, ..." will ignore the
   specified devices.
 
-  Note: Already known devices cannot be ignored.
+  Note: While already known devices can be added to the list of devices to be
+        ignored, there will be no effect on then. However, if such a device
+        disappears and then reappeares, it will then be ignored.
 
-  For example, if device 0.0.abcd is already known and all other devices
-  0.0.a000-0.0.afff are not known,
+  For example,
 	"echo add 0.0.a000-0.0.accc, 0.0.af00-0.0.afff > /proc/cio_ignore"
-  will add 0.0.a000-0.0.abcc, 0.0.abce-0.0.accc and 0.0.af00-0.0.afff to the
-  list of ignored devices and skip 0.0.abcd.
+  will add 0.0.a000-0.0.accc and 0.0.af00-0.0.afff to the list of ignored
+  devices.
 
   The devices can be specified either by bus id (0.0.abcd) or, for 2.4 backward
   compatibilty, by the device number in hexadecimal (0xabcd or abcd).
@@ -98,7 +99,8 @@ Command line parameters
 
   - /proc/s390dbf/cio_trace/hex_ascii
     Logs the calling of functions in the common I/O-layer and, if applicable, 
-    which subchannel they were called for.
+    which subchannel they were called for, as well as dumps of some data
+    structures (like irb in an error case).
 
   The level of logging can be changed to be more or less verbose by piping to 
   /proc/s390dbf/cio_*/level a number between 0 and 6; see the documentation on
