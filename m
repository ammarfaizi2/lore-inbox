Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262356AbTEIILX (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 May 2003 04:11:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262359AbTEIILX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 May 2003 04:11:23 -0400
Received: from mailout01.sul.t-online.com ([194.25.134.80]:38120 "EHLO
	mailout01.sul.t-online.com") by vger.kernel.org with ESMTP
	id S262356AbTEIILV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 May 2003 04:11:21 -0400
Date: Fri, 9 May 2003 10:24:01 +0200
From: norbert_wolff@t-online.de (Norbert Wolff)
To: lkml <linux-kernel@vger.kernel.org>
Subject: Bogus Warning in ppp_generic.c
Message-Id: <20030509102401.3534d179.norbert_wolff@t-online.de>
X-Mailer: Sylpheed version 0.8.11
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi !

If devfs is not configured, devfs_mk_cdev returns 0.
The ppp_generic-Driver reports a bogus Warning in this case.
Fix below.

Regards,

	Norbert	


--- ppp_generic.c.orig	2003-05-09 09:16:56.%N +0200
+++ ppp_generic.c	2003-05-09 10:09:19.%N +0200
@@ -784,10 +784,13 @@ int __init ppp_init(void)
 
 	printk(KERN_INFO "PPP generic driver version " PPP_VERSION "\n");
 	err = register_chrdev(PPP_MAJOR, "ppp", &ppp_device_fops);
+
+#ifdef CONFIG_DEVFS_FS
 	if (!err) {
 		err = devfs_mk_cdev(MKDEV(PPP_MAJOR, 0),
 				S_IFCHR|S_IRUSR|S_IWUSR, "ppp");
 	}
+#endif
 
 	if (!err)
 		printk(KERN_ERR "failed to register PPP device (%d)\n", err);


--
 Norbert Wolff
 OpenPGP-Key:
   http://pgp.mit.edu:11371/pks/lookup?op=get&search=0xF13BD6F6
