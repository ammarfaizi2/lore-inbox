Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751296AbWCZMYN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751296AbWCZMYN (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 26 Mar 2006 07:24:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751301AbWCZMYN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 26 Mar 2006 07:24:13 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:56324 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1751296AbWCZMYM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 26 Mar 2006 07:24:12 -0500
Date: Sun, 26 Mar 2006 14:24:10 +0200
From: Adrian Bunk <bunk@stusta.de>
To: Andrew Morton <akpm@osdl.org>
Cc: Norbert Kiesel <nkiesel@tbdnetworks.com>, acme@conectiva.com.br,
       linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Subject: [2.6 patch] net: drop duplicate assignment in request_sock
Message-ID: <20060326122410.GG4053@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Norbert Kiesel <nkiesel@tbdnetworks.com>

Just noticed that request_sock.[ch] contain a useless assignment of
rskq_accept_head to itself.  I assume this is a typo and the 2nd one
was supposed to be _tail.  However, setting _tail to NULL is not
needed, so the patch below just drops the 2nd assignment.

Signed-Off-By: Norbert Kiesel <nkiesel@tbdnetworks.com>
Signed-off-by: Adrian Bunk <bunk@stusta.de>

---

This patch was sent by Norbert Kiesel on:
-  5 Mar 2006

diff -ru a/include/net/request_sock.h b/include/net/request_sock.h
--- a/include/net/request_sock.h	2005-10-28 15:44:45.000000000 -0700
+++ b/include/net/request_sock.h	2006-03-05 15:22:33.000000000 -0800
@@ -145,7 +145,7 @@
 {
 	struct request_sock *req = queue->rskq_accept_head;
 
-	queue->rskq_accept_head = queue->rskq_accept_head = NULL;
+	queue->rskq_accept_head = NULL;
 	return req;
 }
 
diff -ru a/net/core/request_sock.c b/net/core/request_sock.c
--- a/net/core/request_sock.c	2006-03-05 14:40:50.000000000 -0800
+++ b/net/core/request_sock.c	2006-03-05 15:23:11.000000000 -0800
@@ -51,7 +51,7 @@
 
 	get_random_bytes(&lopt->hash_rnd, sizeof(lopt->hash_rnd));
 	rwlock_init(&queue->syn_wait_lock);
-	queue->rskq_accept_head = queue->rskq_accept_head = NULL;
+	queue->rskq_accept_head = NULL;
 	lopt->nr_table_entries = nr_table_entries;
 
 	write_lock_bh(&queue->syn_wait_lock);
