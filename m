Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267940AbUIWB3w@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267940AbUIWB3w (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Sep 2004 21:29:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268127AbUIWBXH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Sep 2004 21:23:07 -0400
Received: from [12.177.129.25] ([12.177.129.25]:4292 "EHLO
	ccure.user-mode-linux.org") by vger.kernel.org with ESMTP
	id S267935AbUIWBTa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Sep 2004 21:19:30 -0400
Message-Id: <200409230224.i8N2OhiF004290@ccure.user-mode-linux.org>
X-Mailer: exmh version 2.4 06/23/2000 with nmh-1.1-RC1
To: akpm@osdl.org
cc: linux-kernel@vger.kernel.org, blaisorblade_spam@yahoo.it
Subject: [PATCH] UML - Fix fencepost errors in printks
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Wed, 22 Sep 2004 22:24:42 -0400
From: Jeff Dike <jdike@addtoit.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Simple corrections to some error messages, which list wrong limits for UBD
devices and such.

Signed-off-by: Paolo 'Blaisorblade' Giarrusso <blaisorblade_spam@yahoo.it>
Signed-off-by: Jeff Dike <jdike@addtoit.com>

Index: linux-2.6.9-rc2-mm1-orig/arch/um/drivers/line.c
===================================================================
--- linux-2.6.9-rc2-mm1-orig.orig/arch/um/drivers/line.c	2004-09-22 19:51:02.000000000 -0400
+++ linux-2.6.9-rc2-mm1-orig/arch/um/drivers/line.c	2004-09-22 20:39:58.000000000 -0400
@@ -332,7 +332,7 @@
 	init++;
 	if((n >= 0) && (n >= num)){
 		printk("line_setup - %d out of range ((0 ... %d) allowed)\n",
-		       n, num);
+		       n, num - 1);
 		return(0);
 	}
 	else if(n >= 0){
Index: linux-2.6.9-rc2-mm1-orig/arch/um/drivers/ubd_kern.c
===================================================================
--- linux-2.6.9-rc2-mm1-orig.orig/arch/um/drivers/ubd_kern.c	2004-09-22 19:51:02.000000000 -0400
+++ linux-2.6.9-rc2-mm1-orig/arch/um/drivers/ubd_kern.c	2004-09-22 20:39:58.000000000 -0400
@@ -299,7 +299,7 @@
 	}
 	if(n >= MAX_DEV){
 		printk(KERN_ERR "ubd_setup : index %d out of range "
-		       "(%d devices)\n", n, MAX_DEV);
+		       "(%d devices, from 0 to %d)\n", n, MAX_DEV, MAX_DEV - 1);
 		return(1);
 	}
 
More recent patches modify files in message-off-by-one.

