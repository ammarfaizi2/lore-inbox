Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265713AbTFNUc5 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 14 Jun 2003 16:32:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265731AbTFNUcq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 14 Jun 2003 16:32:46 -0400
Received: from twilight.ucw.cz ([81.30.235.3]:34026 "EHLO twilight.ucw.cz")
	by vger.kernel.org with ESMTP id S265713AbTFNUbY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 14 Jun 2003 16:31:24 -0400
Date: Sat, 14 Jun 2003 22:45:10 +0200
From: Vojtech Pavlik <vojtech@suse.cz>
To: Vojtech Pavlik <vojtech@suse.cz>
Cc: torvalds@transmeta.com, linux-kernel@vger.kernel.org
Subject: [patch] input: Fix hiddev_ioctl()  [11/13]
Message-ID: <20030614224510.J25997@ucw.cz>
References: <20030614223513.A25948@ucw.cz> <20030614223629.A25997@ucw.cz> <20030614223708.B25997@ucw.cz> <20030614223934.C25997@ucw.cz> <20030614224022.D25997@ucw.cz> <20030614224052.E25997@ucw.cz> <20030614224149.F25997@ucw.cz> <20030614224253.G25997@ucw.cz> <20030614224358.H25997@ucw.cz> <20030614224432.I25997@ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20030614224432.I25997@ucw.cz>; from vojtech@suse.cz on Sat, Jun 14, 2003 at 10:44:32PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


You can pull this changeset from:
	bk://kernel.bkbits.net/vojtech/input

===================================================================

ChangeSet@1.1215.104.28, 2003-06-11 16:58:41+02:00, vsu@altlinux.ru
  hid: Add missing 'return 0's in hiddev ioctl handler.


 hiddev.c |   10 ++++++++++
 1 files changed, 10 insertions(+)

===================================================================

diff -Nru a/drivers/usb/input/hiddev.c b/drivers/usb/input/hiddev.c
--- a/drivers/usb/input/hiddev.c	Sat Jun 14 22:24:10 2003
+++ b/drivers/usb/input/hiddev.c	Sat Jun 14 22:24:10 2003
@@ -442,10 +442,14 @@
 		if (copy_to_user((void *) arg, &dinfo, sizeof(dinfo)))
 			return -EFAULT;
 
+		return 0;
+
 	case HIDIOCGFLAG:
 		if (put_user(list->flags, (int *) arg))
 			return -EFAULT;
 
+		return 0;
+
 	case HIDIOCSFLAG:
 		{
 			int newflags;
@@ -533,6 +537,8 @@
 		if (copy_to_user((void *) arg, &rinfo, sizeof(rinfo)))
 			return -EFAULT;
 
+		return 0;
+
 	case HIDIOCGFIELDINFO:
 		if (copy_from_user(&finfo, (void *) arg, sizeof(finfo)))
 			return -EFAULT;
@@ -564,6 +570,8 @@
 		if (copy_to_user((void *) arg, &finfo, sizeof(finfo)))
 			return -EFAULT;
 
+		return 0;
+
 	case HIDIOCGUCODE:
 		if (copy_from_user(&uref, (void *) arg, sizeof(uref)))
 			return -EFAULT;
@@ -584,6 +592,8 @@
 
 		if (copy_to_user((void *) arg, &uref, sizeof(uref)))
 			return -EFAULT;
+
+		return 0;
 
 	case HIDIOCGUSAGE:
 	case HIDIOCSUSAGE:
