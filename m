Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268278AbUJWD2a@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268278AbUJWD2a (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Oct 2004 23:28:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268236AbUJVXRG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Oct 2004 19:17:06 -0400
Received: from mail.kroah.org ([69.55.234.183]:17827 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S269049AbUJVXKQ convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Oct 2004 19:10:16 -0400
X-Donotread: and you are reading this why?
Subject: Re: [PATCH] Driver Core patches for 2.6.10-rc1
In-Reply-To: <10984865712136@kroah.com>
X-Patch: quite boring stuff, it's just source code...
Date: Fri, 22 Oct 2004 16:09:31 -0700
Message-Id: <1098486571899@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Greg KH <greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.2018, 2004/10/22 13:55:29-07:00, shemminger@osdl.org

[PATCH] cdev: protect against buggy drivers

Here is a better fix (thanks Greg) that allows long names for character
device objects.

Signed-off-by: Stephen Hemminger <shemminger@osdl.org>
Signed-off-by: Greg Kroah-Hartman <greg@kroah.com>


 fs/char_dev.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)


diff -Nru a/fs/char_dev.c b/fs/char_dev.c
--- a/fs/char_dev.c	2004-10-22 16:00:27 -07:00
+++ b/fs/char_dev.c	2004-10-22 16:00:27 -07:00
@@ -207,8 +207,8 @@
 
 	cdev->owner = fops->owner;
 	cdev->ops = fops;
-	strcpy(cdev->kobj.name, name);
-	for (s = strchr(cdev->kobj.name, '/'); s; s = strchr(s, '/'))
+	kobject_set_name(&cdev->kobj, "%s", name);
+	for (s = strchr(kobject_name(&cdev->kobj),'/'); s; s = strchr(s, '/'))
 		*s = '!';
 		
 	err = cdev_add(cdev, MKDEV(cd->major, 0), 256);

