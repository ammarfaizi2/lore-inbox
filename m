Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263333AbTECPJW (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 3 May 2003 11:09:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263335AbTECPJW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 3 May 2003 11:09:22 -0400
Received: from [203.145.184.221] ([203.145.184.221]:26898 "EHLO naturesoft.net")
	by vger.kernel.org with ESMTP id S263333AbTECPJV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 3 May 2003 11:09:21 -0400
Subject: [PATCH 2.5.68] mod_timer fix for floppy98.c
From: Vinay K Nallamothu <vinay-rc@naturesoft.net>
To: LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 03 May 2003 20:56:39 +0530
Message-Id: <1051975599.2018.206.camel@lima.royalchallenge.com>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

floppy98.c: Trivial {del,add}_timer to mod_timer conversion.

--- linux-2.5.68/drivers/block/floppy98.c	2003-04-21 10:14:23.000000000 +0530
+++ linux-2.5.68-nvk/drivers/block/floppy98.c	2003-05-03 15:33:59.000000000 +0530
@@ -706,15 +706,17 @@
 
 static void reschedule_timeout(int drive, const char *message, int marg)
 {
+	long delay;
+
 	if (drive == current_reqD)
 		drive = current_drive;
 	del_timer(&fd_timeout);
 	if (drive < 0 || drive > N_DRIVE) {
-		fd_timeout.expires = jiffies + 20UL*HZ;
+		delay = jiffies + 20UL*HZ;
 		drive=0;
 	} else
-		fd_timeout.expires = jiffies + UDP->timeout;
-	add_timer(&fd_timeout);
+		delay = jiffies + UDP->timeout;
+	mod_timer(&fd_timeout, delay);
 	if (UDP->flags & FD_DEBUG){
 		DPRINT("reschedule timeout ");
 		printk(message, marg);



