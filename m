Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313711AbSHKRYO>; Sun, 11 Aug 2002 13:24:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313773AbSHKRYO>; Sun, 11 Aug 2002 13:24:14 -0400
Received: from nycsmtp2fb.rdc-nyc.rr.com ([24.29.99.78]:1285 "EHLO si.rr.com")
	by vger.kernel.org with ESMTP id <S313711AbSHKRYN>;
	Sun, 11 Aug 2002 13:24:13 -0400
Date: Sun, 11 Aug 2002 13:14:06 -0400 (EDT)
From: Frank Davis <fdavis@si.rr.com>
X-X-Sender: fdavis@localhost.localdomain
To: linux-kernel@vger.kernel.org
cc: fdavis@si.rr.com
Subject: [PATCH] 2.5.31 : net/802/p8022.c
Message-ID: <Pine.LNX.4.44.0208111311290.12349-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello all,
  This fixes the save_flags/restore_flags reported earlier for 
net/network.o . Please review.

Regards,
Frank

--- net/802/p8022.c.old	Sun Aug 11 13:06:57 2002
+++ net/802/p8022.c	Sun Aug 11 13:09:26 2002
@@ -107,8 +107,7 @@
 	struct datalink_proto *tmp, **clients = &p8022_list;
 	unsigned long flags;
 
-	save_flags(flags);
-	cli();
+	local_irq_save(flags);
 	while (*clients) {
 		tmp = *clients;
 		if (tmp->type[0] == type) {
@@ -119,7 +118,7 @@
 		}
 		clients = &tmp->next;
 	}
-	restore_flags(flags);
+	local_irq_restore(flags);
 }
 
 EXPORT_SYMBOL(register_8022_client);
 

