Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265575AbUABTp1 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Jan 2004 14:45:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265619AbUABTp1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Jan 2004 14:45:27 -0500
Received: from hueytecuilhuitl.mtu.ru ([195.34.32.123]:32516 "EHLO
	hueymiccailhuitl.mtu.ru") by vger.kernel.org with ESMTP
	id S265575AbUABTpV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Jan 2004 14:45:21 -0500
From: Andrey Borzenkov <arvidjaar@mail.ru>
To: Andrew Morton <akpm@osdl.org>, vojtech@suse.cz
Subject: [PATCH] fix devfs names for joystick (resubmitted)
Date: Fri, 2 Jan 2004 22:25:57 +0300
User-Agent: KMail/1.5.3
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_FXc9/fDOE00P11m"
Message-Id: <200401022225.57534.arvidjaar@mail.ru>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Boundary-00=_FXc9/fDOE00P11m
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

I believed it was included; at least judging by changelog. All other input 
devices are under /dev/input; any reason joystick is the exception?

-andrey

--Boundary-00=_FXc9/fDOE00P11m
Content-Type: text/x-diff;
  charset="us-ascii";
  name="2.6.0-test11-joydev_devfs.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="2.6.0-test11-joydev_devfs.patch"

--- ../tmp/linux-2.6.0-test11/drivers/input/joydev.c	2003-09-09 23:45:40.000000000 +0400
+++ linux-2.6.0-test11/drivers/input/joydev.c	2003-09-09 21:19:31.000000000 +0400
@@ -143,7 +143,7 @@ static int joydev_fasync(int fd, struct 
 
 static void joydev_free(struct joydev *joydev)
 {
-	devfs_remove("js%d", joydev->minor);
+	devfs_remove("input/js%d", joydev->minor);
 	joydev_table[joydev->minor] = NULL;
 	kfree(joydev);
 }
@@ -447,7 +447,7 @@ static struct input_handle *joydev_conne
 	joydev_table[minor] = joydev;
 	
 	devfs_mk_cdev(MKDEV(INPUT_MAJOR, JOYDEV_MINOR_BASE + minor),
-			S_IFCHR|S_IRUGO|S_IWUSR, "js%d", minor);
+			S_IFCHR|S_IRUGO|S_IWUSR, "input/js%d", minor);
 
 	return &joydev->handle;
 }

--Boundary-00=_FXc9/fDOE00P11m--

