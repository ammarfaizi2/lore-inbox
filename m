Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261928AbVEETEy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261928AbVEETEy (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 May 2005 15:04:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262179AbVEETEj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 May 2005 15:04:39 -0400
Received: from c-24-22-18-178.hsd1.or.comcast.net ([24.22.18.178]:46481 "EHLO
	w-gerrit.beaverton.ibm.com") by vger.kernel.org with ESMTP
	id S262184AbVEES3N (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 May 2005 14:29:13 -0400
Message-Id: <20050505180931.717485000@us.ibm.com>
References: <20050505180731.010896000@us.ibm.com>
Date: Thu, 05 May 2005 11:07:41 -0700
To: linux-kernel@vger.kernel.org, ckrm-tech@lists.sourceforge.net
Subject: [patch 10/21] CKRM: Move Callbacks from listenaq to socketclass
From: gh@us.ibm.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--
Content-Disposition: inline; filename=06a-ckrm_net_cb


Signed-Off-By: Chandra Seetharaman <sekharan@us.ibm.com>
Signed-Off-By: Gerrit Huizenga <gh@us.ibm.com>

Callbacks are not called from appropriate places in the socketclass
patch. The patch was wrongly present in the listenaq controller.
Moving from listenaq controller to socketclass patch.

 tcp.c |    5 ++++-
 1 files changed, 4 insertions(+), 1 deletion(-)

Index: linux-2.6.12-rc3-ckrm5/net/ipv4/tcp.c
===================================================================
--- linux-2.6.12-rc3-ckrm5.orig/net/ipv4/tcp.c	2005-05-05 09:33:01.000000000 -0700
+++ linux-2.6.12-rc3-ckrm5/net/ipv4/tcp.c	2005-05-05 09:36:26.000000000 -0700
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

