Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314085AbSHKRb4>; Sun, 11 Aug 2002 13:31:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315529AbSHKRbz>; Sun, 11 Aug 2002 13:31:55 -0400
Received: from nycsmtp3fa.rdc-nyc.rr.com ([24.29.99.79]:31242 "EHLO si.rr.com")
	by vger.kernel.org with ESMTP id <S314085AbSHKRby>;
	Sun, 11 Aug 2002 13:31:54 -0400
Date: Sun, 11 Aug 2002 13:16:07 -0400 (EDT)
From: Frank Davis <fdavis@si.rr.com>
X-X-Sender: fdavis@localhost.localdomain
To: linux-kernel@vger.kernel.org
cc: fdavis@si.rr.com
Subject: [PATCH] 2.5.31 : net/802/psnap.c
Message-ID: <Pine.LNX.4.44.0208111314090.12349-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello all,
  This fixes the net/network.o save_flags/restore_flags error. Please 
review.

Regards,
Frank

--- net/802/psnap.c.old	Sun Aug 11 13:06:19 2002
+++ net/802/psnap.c	Sun Aug 11 13:09:46 2002
@@ -127,8 +127,7 @@
 	struct datalink_proto *tmp;
 	unsigned long flags;
 
-	save_flags(flags);
-	cli();
+	local_irq_save(flags);
 
 	while ((tmp = *clients) != NULL) {
 		if (!memcmp(tmp->type, desc, 5)) {
@@ -139,7 +138,7 @@
 			clients = &tmp->next;
 	}
 
-	restore_flags(flags);
+	local_irq_restore(flags);
 }
 
 MODULE_LICENSE("GPL");

