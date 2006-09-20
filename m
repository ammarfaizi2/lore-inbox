Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751083AbWITU7V@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751083AbWITU7V (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Sep 2006 16:59:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751055AbWITU7S
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Sep 2006 16:59:18 -0400
Received: from [63.64.152.142] ([63.64.152.142]:58893 "EHLO gitlost.site")
	by vger.kernel.org with ESMTP id S1751070AbWITU7Q (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Sep 2006 16:59:16 -0400
From: Ashwini Kulkarni <ashwini.kulkarni@intel.com>
Subject: [RFC 2/6] Make sock_def_wakeup non-static
Date: Wed, 20 Sep 2006 14:08:13 -0700
To: linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Cc: christopher.leech@intel.com
Message-Id: <20060920210813.17480.34464.stgit@gitlost.site>
In-Reply-To: <20060920210711.17480.92354.stgit@gitlost.site>
References: <20060920210711.17480.92354.stgit@gitlost.site>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


---

 include/net/sock.h |    1 +
 net/core/sock.c    |    3 ++-
 2 files changed, 3 insertions(+), 1 deletions(-)

diff --git a/include/net/sock.h b/include/net/sock.h
index 324b3ea..3a64262 100644
--- a/include/net/sock.h
+++ b/include/net/sock.h
@@ -497,6 +497,7 @@ extern void sk_stream_wait_close(struct 
 extern int sk_stream_error(struct sock *sk, int flags, int err);
 extern void sk_stream_kill_queues(struct sock *sk);
 
+extern void sock_def_wakeup(struct sock *sk);
 extern int sk_wait_data(struct sock *sk, long *timeo);
 
 struct request_sock_ops;
diff --git a/net/core/sock.c b/net/core/sock.c
index 51fcfbc..8496854 100644
--- a/net/core/sock.c
+++ b/net/core/sock.c
@@ -1400,7 +1400,7 @@ ssize_t sock_no_sendpage(struct socket *
  *	Default Socket Callbacks
  */
 
-static void sock_def_wakeup(struct sock *sk)
+void sock_def_wakeup(struct sock *sk)
 {
 	read_lock(&sk->sk_callback_lock);
 	if (sk->sk_sleep && waitqueue_active(sk->sk_sleep))
@@ -1961,6 +1961,7 @@ EXPORT_SYMBOL(sock_no_poll);
 EXPORT_SYMBOL(sock_no_recvmsg);
 EXPORT_SYMBOL(sock_no_sendmsg);
 EXPORT_SYMBOL(sock_no_sendpage);
+EXPORT_SYMBOL(sock_def_wakeup);
 EXPORT_SYMBOL(sock_no_setsockopt);
 EXPORT_SYMBOL(sock_no_shutdown);
 EXPORT_SYMBOL(sock_no_socketpair);

