Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268378AbUIFRuA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268378AbUIFRuA (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Sep 2004 13:50:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268397AbUIFRt7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Sep 2004 13:49:59 -0400
Received: from mail-relay-4.tiscali.it ([213.205.33.44]:26248 "EHLO
	mail-relay-4.tiscali.it") by vger.kernel.org with ESMTP
	id S268378AbUIFRt4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Sep 2004 13:49:56 -0400
Subject: [patch 2/3] uml-ubd-any-elevator
To: akpm@osdl.org
Cc: jdike@addtoit.com, linux-kernel@vger.kernel.org,
       user-mode-linux-devel@lists.sourceforge.net, blaisorblade_spam@yahoo.it
From: blaisorblade_spam@yahoo.it
Date: Mon, 06 Sep 2004 19:44:49 +0200
Message-Id: <20040906174449.8CAAEBB1A@zion.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Avoid forcing use of the no-op scheduler for UBD; this may uncover some bugs in the
UBD driver, and in fact uml-ubd-no-empty-queue.patch is needed to make this sure.
But as of now, no other bugs have been discovered, so this should be safe.

Signed-off-by: Paolo 'Blaisorblade' Giarrusso <blaisorblade_spam@yahoo.it>
---

 uml-linux-2.6.8.1-paolo/arch/um/drivers/ubd_kern.c |    2 --
 1 files changed, 2 deletions(-)

diff -puN arch/um/drivers/ubd_kern.c~uml-ubd-any-elevator arch/um/drivers/ubd_kern.c
--- uml-linux-2.6.8.1/arch/um/drivers/ubd_kern.c~uml-ubd-any-elevator	2004-08-29 14:40:53.731043416 +0200
+++ uml-linux-2.6.8.1-paolo/arch/um/drivers/ubd_kern.c	2004-08-29 14:40:53.733043112 +0200
@@ -749,8 +749,6 @@ int ubd_init(void)
 		return -1;
 	}
 		
-	elevator_init(ubd_queue, &elevator_noop);
-
 	if (fake_major != MAJOR_NR) {
 		char name[sizeof("ubd_nnn\0")];
 
_
