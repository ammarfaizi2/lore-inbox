Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264361AbUATBzp (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Jan 2004 20:55:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265168AbUATBNv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Jan 2004 20:13:51 -0500
Received: from mail.kroah.org ([65.200.24.183]:34761 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S265351AbUATBMw convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Jan 2004 20:12:52 -0500
Subject: Re: [PATCH] Driver Core update and fixes for 2.6.1
In-Reply-To: <10745611602245@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Mon, 19 Jan 2004 17:12:40 -0800
Message-Id: <1074561160498@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Greg KH <greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.1501, 2004/01/19 16:40:57-08:00, greg@kroah.com

[PATCH] MEM: add sysfs class support for mem devices

This adds class/mem/ for all memory devices (random, raw, null, etc.)


 drivers/char/mem.c |    7 +++++++
 1 files changed, 7 insertions(+)


diff -Nru a/drivers/char/mem.c b/drivers/char/mem.c
--- a/drivers/char/mem.c	Mon Jan 19 17:04:57 2004
+++ b/drivers/char/mem.c	Mon Jan 19 17:04:57 2004
@@ -24,6 +24,7 @@
 #include <linux/smp_lock.h>
 #include <linux/devfs_fs_kernel.h>
 #include <linux/ptrace.h>
+#include <linux/device.h>
 
 #include <asm/uaccess.h>
 #include <asm/io.h>
@@ -676,6 +677,8 @@
 	{11,"kmsg",    S_IRUGO | S_IWUSR,           &kmsg_fops},
 };
 
+static struct class_simple *mem_class;
+
 static int __init chr_dev_init(void)
 {
 	int i;
@@ -683,7 +686,11 @@
 	if (register_chrdev(MEM_MAJOR,"mem",&memory_fops))
 		printk("unable to get major %d for memory devs\n", MEM_MAJOR);
 
+	mem_class = class_simple_create(THIS_MODULE, "mem");
 	for (i = 0; i < ARRAY_SIZE(devlist); i++) {
+		class_simple_device_add(mem_class,
+					MKDEV(MEM_MAJOR, devlist[i].minor),
+					NULL, devlist[i].name);
 		devfs_mk_cdev(MKDEV(MEM_MAJOR, devlist[i].minor),
 				S_IFCHR | devlist[i].mode, devlist[i].name);
 	}

