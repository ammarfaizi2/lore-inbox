Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261421AbUJXNsM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261421AbUJXNsM (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 24 Oct 2004 09:48:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261487AbUJXNq2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 24 Oct 2004 09:46:28 -0400
Received: from verein.lst.de ([213.95.11.210]:56742 "EHLO mail.lst.de")
	by vger.kernel.org with ESMTP id S261369AbUJXNnM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 24 Oct 2004 09:43:12 -0400
Date: Sun, 24 Oct 2004 15:43:09 +0200
From: Christoph Hellwig <hch@lst.de>
To: davem@redhat.com
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] remove dead tcp exports
Message-ID: <20041024134309.GB20267@lst.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
X-Spam-Score: -4.901 () BAYES_00
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--- 1.96/include/net/tcp.h	2004-10-21 06:58:39 +02:00
+++ edited/include/net/tcp.h	2004-10-23 13:54:49 +02:00
@@ -159,7 +159,6 @@
 extern void tcp_bucket_destroy(struct tcp_bind_bucket *tb);
 extern void tcp_bucket_unlock(struct sock *sk);
 extern int tcp_port_rover;
-extern struct sock *tcp_v4_lookup_listener(u32 addr, unsigned short hnum, int dif);
 
 /* These are AF independent. */
 static __inline__ int tcp_bhashfn(__u16 lport)
--- 1.77/net/ipv4/af_inet.c	2004-09-23 07:26:42 +02:00
+++ edited/net/ipv4/af_inet.c	2004-10-23 13:53:38 +02:00
@@ -1165,8 +1165,6 @@
 EXPORT_SYMBOL(inet_stream_ops);
 EXPORT_SYMBOL(inet_unregister_protosw);
 EXPORT_SYMBOL(net_statistics);
-EXPORT_SYMBOL(tcp_protocol);
-EXPORT_SYMBOL(udp_protocol);
 
 #ifdef INET_REFCNT_DEBUG
 EXPORT_SYMBOL(inet_sock_nr);
--- 1.81/net/ipv4/tcp.c	2004-10-03 23:26:12 +02:00
+++ edited/net/ipv4/tcp.c	2004-10-23 13:50:23 +02:00
@@ -2307,7 +2307,6 @@
 
 EXPORT_SYMBOL(tcp_accept);
 EXPORT_SYMBOL(tcp_close);
-EXPORT_SYMBOL(tcp_close_state);
 EXPORT_SYMBOL(tcp_destroy_sock);
 EXPORT_SYMBOL(tcp_disconnect);
 EXPORT_SYMBOL(tcp_getsockopt);
--- 1.81/net/ipv4/tcp_input.c	2004-10-03 23:31:39 +02:00
+++ edited/net/ipv4/tcp_input.c	2004-10-23 13:52:46 +02:00
@@ -4963,7 +4963,6 @@
 
 EXPORT_SYMBOL(sysctl_tcp_ecn);
 EXPORT_SYMBOL(sysctl_tcp_reordering);
-EXPORT_SYMBOL(tcp_cwnd_application_limited);
 EXPORT_SYMBOL(tcp_parse_options);
 EXPORT_SYMBOL(tcp_rcv_established);
 EXPORT_SYMBOL(tcp_rcv_state_process);
--- 1.101/net/ipv4/tcp_ipv4.c	2004-10-20 06:50:24 +02:00
+++ edited/net/ipv4/tcp_ipv4.c	2004-10-23 13:55:16 +02:00
@@ -448,8 +448,8 @@
 }
 
 /* Optimize the common listener case. */
-inline struct sock *tcp_v4_lookup_listener(u32 daddr, unsigned short hnum,
-					   int dif)
+static inline struct sock *tcp_v4_lookup_listener(u32 daddr,
+		unsigned short hnum, int dif)
 {
 	struct sock *sk = NULL;
 	struct hlist_head *head;
@@ -2653,7 +2653,6 @@
 EXPORT_SYMBOL(tcp_v4_conn_request);
 EXPORT_SYMBOL(tcp_v4_connect);
 EXPORT_SYMBOL(tcp_v4_do_rcv);
-EXPORT_SYMBOL(tcp_v4_lookup_listener);
 EXPORT_SYMBOL(tcp_v4_rebuild_header);
 EXPORT_SYMBOL(tcp_v4_remember_stamp);
 EXPORT_SYMBOL(tcp_v4_send_check);
--- 1.70/net/ipv4/tcp_output.c	2004-10-22 07:37:25 +02:00
+++ edited/net/ipv4/tcp_output.c	2004-10-23 13:57:15 +02:00
@@ -1719,12 +1719,7 @@
 	}
 }
 
-EXPORT_SYMBOL(tcp_acceptable_seq);
 EXPORT_SYMBOL(tcp_connect);
-EXPORT_SYMBOL(tcp_connect_init);
 EXPORT_SYMBOL(tcp_make_synack);
-EXPORT_SYMBOL(tcp_send_synack);
 EXPORT_SYMBOL(tcp_simple_retransmit);
 EXPORT_SYMBOL(tcp_sync_mss);
-EXPORT_SYMBOL(tcp_write_wakeup);
-EXPORT_SYMBOL(tcp_write_xmit);
