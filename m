Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267935AbUIWB0R@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267935AbUIWB0R (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Sep 2004 21:26:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268130AbUIWBX0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Sep 2004 21:23:26 -0400
Received: from [12.177.129.25] ([12.177.129.25]:5060 "EHLO
	ccure.user-mode-linux.org") by vger.kernel.org with ESMTP
	id S267963AbUIWBUK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Sep 2004 21:20:10 -0400
Message-Id: <200409230225.i8N2PQiF004297@ccure.user-mode-linux.org>
X-Mailer: exmh version 2.4 06/23/2000 with nmh-1.1-RC1
To: akpm@osdl.org
cc: linux-kernel@vger.kernel.org, blaisorblade_spam@yahoo.it
Subject: [PATCH] UML - print errno before resetting it
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Wed, 22 Sep 2004 22:25:26 -0400
From: Jeff Dike <jdike@addtoit.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Make sure we print ERRNO and not always -1.

Signed-off-by: Paolo 'Blaisorblade' Giarrusso <blaisorblade_spam@yahoo.it>
Signed-off-by: Jeff Dike <jdike@addtoit.com>

Index: linux-2.6.9-rc2-mm1-orig/arch/um/drivers/ubd_kern.c
===================================================================
--- linux-2.6.9-rc2-mm1-orig.orig/arch/um/drivers/ubd_kern.c	2004-09-22 20:39:58.000000000 -0400
+++ linux-2.6.9-rc2-mm1-orig/arch/um/drivers/ubd_kern.c	2004-09-22 20:45:40.000000000 -0400
@@ -776,10 +776,10 @@
 	io_pid = start_io_thread(stack + PAGE_SIZE - sizeof(void *), 
 				 &thread_fd);
 	if(io_pid < 0){
-		io_pid = -1;
 		printk(KERN_ERR 
 		       "ubd : Failed to start I/O thread (errno = %d) - "
 		       "falling back to synchronous I/O\n", -io_pid);
+		io_pid = -1;
 		return(0);
 	}
 	err = um_request_irq(UBD_IRQ, thread_fd, IRQ_READ, ubd_intr, 

