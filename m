Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263669AbTCUSHi>; Fri, 21 Mar 2003 13:07:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263656AbTCUSG7>; Fri, 21 Mar 2003 13:06:59 -0500
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:33667
	"EHLO hraefn.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S262595AbTCUSGd>; Fri, 21 Mar 2003 13:06:33 -0500
Date: Fri, 21 Mar 2003 19:21:48 GMT
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Message-Id: <200303211921.h2LJLm1M025711@hraefn.swansea.linux.org.uk>
To: linux-kernel@vger.kernel.org, torvalds@transmeta.com
Subject: PATCH: Move ipmi to new struct stuff
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

diff -u --new-file --recursive --exclude-from /usr/src/exclude linux-2.5.65/drivers/char/ipmi/ipmi_devintf.c linux-2.5.65-ac2/drivers/char/ipmi/ipmi_devintf.c
--- linux-2.5.65/drivers/char/ipmi/ipmi_devintf.c	2003-02-10 18:38:51.000000000 +0000
+++ linux-2.5.65-ac2/drivers/char/ipmi/ipmi_devintf.c	2003-03-06 23:14:51.000000000 +0000
@@ -105,7 +105,7 @@
 
 static struct ipmi_user_hndl ipmi_hndlrs =
 {
-	ipmi_recv_hndl : file_receive_handler
+	.ipmi_recv_hndl	= file_receive_handler,
 };
 
 static int ipmi_open(struct inode *inode, struct file *file)
@@ -424,12 +424,12 @@
 
 
 static struct file_operations ipmi_fops = {
-	owner:   THIS_MODULE,
-	ioctl:   ipmi_ioctl,
-	open:    ipmi_open,
-	release: ipmi_release,
-	fasync:  ipmi_fasync,
-	poll:    ipmi_poll
+	.owner		= THIS_MODULE,
+	.ioctl		= ipmi_ioctl,
+	.open		= ipmi_open,
+	.release	= ipmi_release,
+	.fasync		= ipmi_fasync,
+	.poll		= ipmi_poll,
 };
 
 #define DEVICE_NAME     "ipmidev"
@@ -468,8 +468,8 @@
 
 static struct ipmi_smi_watcher smi_watcher =
 {
-	new_smi  : ipmi_new_smi,
-	smi_gone : ipmi_smi_gone
+	.new_smi	= ipmi_new_smi,
+	.smi_gone	= ipmi_smi_gone,
 };
 
 static __init int init_ipmi_devintf(void)
