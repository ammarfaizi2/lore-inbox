Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262269AbVFSSQj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262269AbVFSSQj (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 19 Jun 2005 14:16:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262271AbVFSSQj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 19 Jun 2005 14:16:39 -0400
Received: from mail.dif.dk ([193.138.115.101]:27059 "EHLO saerimmer.dif.dk")
	by vger.kernel.org with ESMTP id S262269AbVFSSQR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 19 Jun 2005 14:16:17 -0400
Date: Sun, 19 Jun 2005 20:21:43 +0200 (CEST)
From: Jesper Juhl <juhl-lkml@dif.dk>
To: linux-kernel@vger.kernel.org
Cc: Jeff Dike <jdike@karaya.com>, user-mode-linux-devel@lists.sourceforge.net,
       Lennert Buytenhek <buytenh@gnu.org>, James Leu <jleu@mindspring.net>
Subject: [PATCH] um: kfree() cleanup of daemon_user.c
Message-ID: <Pine.LNX.4.62.0506192015220.2832@dragon.hyggekrogen.localhost>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Here's a small patch to remove a few unnessesary NULL pointer checks 
before kfree() in arch/um/drivers/daemon_user.c

Signed-off-by: Jesper Juhl <juhl-lkml@dif.dk>
---

 arch/um/drivers/daemon_user.c |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

--- linux-2.6.12-orig/arch/um/drivers/daemon_user.c	2005-06-17 21:48:29.000000000 +0200
+++ linux-2.6.12/arch/um/drivers/daemon_user.c	2005-06-19 20:13:34.000000000 +0200
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


