Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263861AbTG1Lte (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Jul 2003 07:49:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263875AbTG1Lte
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Jul 2003 07:49:34 -0400
Received: from vtens.prov-liege.be ([193.190.122.60]:49755 "EHLO
	mesepl.epl.prov-liege.be") by vger.kernel.org with ESMTP
	id S263861AbTG1Ltd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Jul 2003 07:49:33 -0400
To: <akpm@osdl.org>
Subject: [PATCH]2.6 test1 mm2 user.c race (?)
From: <ffrederick@prov-liege.be>
Cc: <linux-kernel@vger.kernel.org>
Date: Mon, 28 Jul 2003 14:31:23 CEST
Reply-To: <ffrederick@prov-liege.be>
X-Priority: 3 (Normal)
X-Originating-Ip: [10.10.0.30]
X-Mailer: NOCC v0.9.5
Content-Type: text/plain;
	charset="ISO-8859-1"
Content-Transfer-Encoding: 8bit
Message-Id: <S263861AbTG1Ltd/20030728114933Z+399@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew,

        Trivial patch against possible smp race (?) in user.c
or do we have bkl above ?

Regards,
Fabian

diff -Naur orig/kernel/user.c edited/kernel/user.c
--- orig/kernel/user.c	2003-07-14 05:32:42.000000000 +0200
+++ edited/kernel/user.c	2003-07-28 13:44:55.000000000 +0200
@@ -146,8 +146,11 @@
 	for(n = 0; n < UIDHASH_SZ; ++n)
 		INIT_LIST_HEAD(uidhash_table + n);
 
-	/* Insert the root user immediately - init already runs with this */
+	/* Insert the root user immediately (init already runs as root) */
+	spin_lock(&uidhash_lock);
 	uid_hash_insert(&root_user, uidhashentry(0));
+	spin_unlock(&uidhash_lock);	
+
 	return 0;
 }
 


___________________________________



