Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268357AbUIFRt5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268357AbUIFRt5 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Sep 2004 13:49:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268381AbUIFRt4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Sep 2004 13:49:56 -0400
Received: from mail-relay-3.tiscali.it ([213.205.33.43]:47524 "EHLO
	mail-relay-3.tiscali.it") by vger.kernel.org with ESMTP
	id S268357AbUIFRtz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Sep 2004 13:49:55 -0400
Subject: [patch 3/3] uml-ubd-thread-start-fail-well
To: akpm@osdl.org
Cc: jdike@addtoit.com, linux-kernel@vger.kernel.org,
       user-mode-linux-devel@lists.sourceforge.net, blaisorblade_spam@yahoo.it
From: blaisorblade_spam@yahoo.it
Date: Mon, 06 Sep 2004 19:44:51 +0200
Message-Id: <20040906174451.DCBD5BB21@zion.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Correct the failure path in start_io_thread(), to return the correct error code.

Signed-off-by: Paolo 'Blaisorblade' Giarrusso <blaisorblade_spam@yahoo.it>
---

 uml-linux-2.6.8.1-paolo/arch/um/drivers/ubd_user.c |    1 +
 1 files changed, 1 insertion(+)

diff -puN arch/um/drivers/ubd_user.c~uml-ubd-thread-start-fail-well arch/um/drivers/ubd_user.c
--- uml-linux-2.6.8.1/arch/um/drivers/ubd_user.c~uml-ubd-thread-start-fail-well	2004-08-29 14:40:54.494927288 +0200
+++ uml-linux-2.6.8.1-paolo/arch/um/drivers/ubd_user.c	2004-08-29 14:40:54.496926984 +0200
@@ -353,6 +353,7 @@ int start_io_thread(unsigned long sp, in
 		    NULL);
 	if(pid < 0){
 		printk("start_io_thread - clone failed : errno = %d\n", errno);
+		err = -errno;
 		goto out_close;
 	}
 
_
