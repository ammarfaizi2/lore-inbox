Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261467AbVFTTBM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261467AbVFTTBM (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Jun 2005 15:01:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261498AbVFTS7w
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Jun 2005 14:59:52 -0400
Received: from lakshmi.addtoit.com ([198.99.130.6]:30986 "EHLO
	lakshmi.solana.com") by vger.kernel.org with ESMTP id S261467AbVFTS5h
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Jun 2005 14:57:37 -0400
Message-Id: <200506201851.j5KIpDav008478@ccure.user-mode-linux.org>
X-Mailer: exmh version 2.7.2 01/07/2005 with nmh-1.0.4
To: akpm@osdl.org, torvalds@osdl.org
cc: linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net,
       juhl-lkml@dif.dk
Subject: [PATCH 2/8] UML - kfree cleanup
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Mon, 20 Jun 2005 14:51:13 -0400
From: Jeff Dike <jdike@addtoit.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Here's a small patch to remove a few unnessesary NULL pointer checks
before kfree() in arch/um/drivers/daemon_user.c

Signed-off-by: Jesper Juhl <juhl-lkml@dif.dk>
Signed-off-by: Jeff Dike <jdike@addtoit.com>

Index: linux-2.6.12/arch/um/drivers/daemon_user.c
===================================================================
--- linux-2.6.12.orig/arch/um/drivers/daemon_user.c	2005-06-19 21:11:24.000000000 -0400
+++ linux-2.6.12/arch/um/drivers/daemon_user.c	2005-06-19 21:35:38.000000000 -0400
@@ -157,9 +157,9 @@ static void daemon_remove(void *data)
 
 	os_close_file(pri->fd);
 	os_close_file(pri->control);
-	if(pri->data_addr != NULL) kfree(pri->data_addr);
-	if(pri->ctl_addr != NULL) kfree(pri->ctl_addr);
-	if(pri->local_addr != NULL) kfree(pri->local_addr);
+	kfree(pri->data_addr);
+	kfree(pri->ctl_addr);
+	kfree(pri->local_addr);
 }
 
 int daemon_user_write(int fd, void *buf, int len, struct daemon_data *pri)

