Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932239AbWCEXpy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932239AbWCEXpy (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 5 Mar 2006 18:45:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932226AbWCEXpy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 5 Mar 2006 18:45:54 -0500
Received: from mail.tbdnetworks.com ([204.13.84.99]:20745 "EHLO
	mail.tbdnetworks.com") by vger.kernel.org with ESMTP
	id S932193AbWCEXpx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 5 Mar 2006 18:45:53 -0500
Date: Sun, 5 Mar 2006 15:45:43 -0800
To: acme@conectiva.com.br
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Subject: [PATCH] net: drop duplicate assignment in request_sock
Message-ID: <20060305234543.GA22550@defiant.tbdnetworks.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11+cvs20060126
From: nkiesel@tbdnetworks.com (Norbert Kiesel)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Norbert Kiesel <nkiesel@tbdnetworks.com>

Hi,

just noticed that request_sock.[ch] contain a useless assignment of
rskq_accept_head to itself.  I assume this is a typo and the 2nd one
was supposed to be _tail.  However, setting _tail to NULL is not
needed, so the patch below just drops the 2nd assignment.

Best,
  Norbert

Signed-Off-By: Norbert Kiesel <nkiesel@tbdnetworks.com>

---

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
