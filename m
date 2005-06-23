Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262282AbVFWHtF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262282AbVFWHtF (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Jun 2005 03:49:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262350AbVFWHr1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Jun 2005 03:47:27 -0400
Received: from [24.22.56.4] ([24.22.56.4]:30182 "EHLO
	w-gerrit.beaverton.ibm.com") by vger.kernel.org with ESMTP
	id S262336AbVFWGTF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Jun 2005 02:19:05 -0400
Message-Id: <20050623061756.120377000@w-gerrit.beaverton.ibm.com>
References: <20050623061552.833852000@w-gerrit.beaverton.ibm.com>
Date: Wed, 22 Jun 2005 23:16:02 -0700
From: Gerrit Huizenga <gh@us.ibm.com>
To: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Cc: ckrm-tech@lists.sourceforge.net, Chandra Seetharaman <sekharan@us.ibm.com>,
       Gerrit Huizenga <gh@us.ibm.com>
Subject: [patch 10/38] CKRM e18: Move Callbacks from listenaq to socketclass
Content-Disposition: inline; filename=06a-ckrm_net_cb
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-Off-By: Chandra Seetharaman <sekharan@us.ibm.com>
Signed-Off-By: Gerrit Huizenga <gh@us.ibm.com>

Callbacks are not called from appropriate places in the socketclass
patch. The patch was wrongly present in the listenaq controller.
Moving from listenaq controller to socketclass patch.

 tcp.c |    5 ++++-
 1 files changed, 4 insertions(+), 1 deletion(-)

Index: linux-2.6.12-ckrm1/net/ipv4/tcp.c
===================================================================
--- linux-2.6.12-ckrm1.orig/net/ipv4/tcp.c	2005-06-17 12:48:29.000000000 -0700
+++ linux-2.6.12-ckrm1/net/ipv4/tcp.c	2005-06-20 13:08:37.000000000 -0700
@@ -263,6 +263,7 @@
 #include <net/xfrm.h>
 #include <net/ip.h>
 
+#include <linux/ckrm_events.h>
 
 #include <asm/uaccess.h>
 #include <asm/ioctls.h>
@@ -496,7 +497,7 @@ int tcp_listen_start(struct sock *sk)
 
 		sk_dst_reset(sk);
 		sk->sk_prot->hash(sk);
-
+		ckrm_cb_listen_start(sk);
 		return 0;
 	}
 
@@ -529,6 +530,8 @@ static void tcp_listen_stop (struct sock
 	write_unlock_bh(&tp->syn_wait_lock);
 	tp->accept_queue = tp->accept_queue_tail = NULL;
 
+	ckrm_cb_listen_stop(sk);
+
 	if (lopt->qlen) {
 		for (i = 0; i < TCP_SYNQ_HSIZE; i++) {
 			while ((req = lopt->syn_table[i]) != NULL) {

--
