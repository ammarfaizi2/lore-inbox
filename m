Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269555AbTHBPw3 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 2 Aug 2003 11:52:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269542AbTHBPw2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 2 Aug 2003 11:52:28 -0400
Received: from hueytecuilhuitl.mtu.ru ([195.34.32.123]:11536 "EHLO
	hueymiccailhuitl.mtu.ru") by vger.kernel.org with ESMTP
	id S269555AbTHBPwZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 2 Aug 2003 11:52:25 -0400
From: Andrey Borzenkov <arvidjaar@mail.ru>
To: linux-kernel@vger.kernel.org
Subject: [PATCH][TRIVIAL] 2.6.0-test2 -fix joystick devfs name
Date: Sat, 2 Aug 2003 19:46:58 +0400
User-Agent: KMail/1.5
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_yz9K/YDUnLXRJJX"
Message-Id: <200308021946.58137.arvidjaar@mail.ru>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Boundary-00=_yz9K/YDUnLXRJJX
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

any reason joydev creates devices under /dev and not under /dev/input as all 
other input handlers?

-andrey
--Boundary-00=_yz9K/YDUnLXRJJX
Content-Type: text/x-diff;
  charset="us-ascii";
  name="2.6.0-test2-joydev_devfs_name.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="2.6.0-test2-joydev_devfs_name.patch"

--- linux-2.6.0-test2-smp/drivers/input/joydev.c.devfs_name	2003-06-26 21:39:35.000000000 +0400
+++ linux-2.6.0-test2-smp/drivers/input/joydev.c	2003-08-02 19:40:24.000000000 +0400
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

--Boundary-00=_yz9K/YDUnLXRJJX--

