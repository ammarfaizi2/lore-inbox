Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261195AbTIXKcY (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 Sep 2003 06:32:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261196AbTIXKcY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 Sep 2003 06:32:24 -0400
Received: from bilbo.math.uni-mannheim.de ([134.155.88.153]:49340 "EHLO
	bilbo.math.uni-mannheim.de") by vger.kernel.org with ESMTP
	id S261195AbTIXKcV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 Sep 2003 06:32:21 -0400
From: Rolf Eike Beer <eike-kernel@sf-tec.de>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] if(foo) BUG() -> BUG_ON(foo) for include/net/
Date: Wed, 24 Sep 2003 12:34:58 +0200
User-Agent: KMail/1.5.3
Cc: Linus Torvalds <torvalds@osdl.org>
References: <200309241233.09877@bilbo.math.uni-mannheim.de>
In-Reply-To: <200309241233.09877@bilbo.math.uni-mannheim.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200309241234.58125@bilbo.math.uni-mannheim.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

diff -aur linux-2.6.0-test5-bk6/include/net/sctp/sm.h linux-2.6.0-test5-bk6-caliban/include/net/sctp/sm.h
--- linux-2.6.0-test5-bk6/include/net/sctp/sm.h	2003-09-11 10:17:55.000000000 +0200
+++ linux-2.6.0-test5-bk6-caliban/include/net/sctp/sm.h	2003-09-11 10:26:39.000000000 +0200
@@ -428,8 +428,7 @@
 /* Run sctp_add_cmd() generating a BUG() if there is a failure.  */
 static inline void sctp_add_cmd_sf(sctp_cmd_seq_t *seq, sctp_verb_t verb, sctp_arg_t obj)
 {
-	if (unlikely(!sctp_add_cmd(seq, verb, obj)))
-		BUG();
+	BUG_ON(!sctp_add_cmd(seq, verb, obj));
 }
 
 /* Check VTAG of the packet matches the sender's own tag OR its peer's
diff -aur linux-2.6.0-test5-bk6/include/net/sock.h linux-2.6.0-test5-bk6-caliban/include/net/sock.h
--- linux-2.6.0-test5-bk6/include/net/sock.h	2003-09-11 10:17:55.000000000 +0200
+++ linux-2.6.0-test5-bk6-caliban/include/net/sock.h	2003-09-11 10:30:16.000000000 +0200
@@ -455,8 +455,8 @@
 	 * change the ownership of this struct sock, with one not needed
 	 * transient sk_set_owner call.
 	 */
-	if (unlikely(sk->sk_owner != NULL))
-		BUG();
+	BUG_ON(sk->sk_owner != NULL);
+
 	sk->sk_owner = owner;
 	__module_get(owner);
 }
diff -aur linux-2.6.0-test5-bk6/include/net/tcp.h linux-2.6.0-test5-bk6-caliban/include/net/tcp.h
--- linux-2.6.0-test5-bk6/include/net/tcp.h	2003-09-11 10:17:55.000000000 +0200
+++ linux-2.6.0-test5-bk6-caliban/include/net/tcp.h	2003-09-11 10:26:39.000000000 +0200
@@ -1424,7 +1424,7 @@
 		if (tp->ucopy.memory > sk->sk_rcvbuf) {
 			struct sk_buff *skb1;
 
-			if (sock_owned_by_user(sk)) BUG();
+			BUG_ON(sock_owned_by_user(sk));
 
 			while ((skb1 = __skb_dequeue(&tp->ucopy.prequeue)) != NULL) {
 				sk->sk_backlog_rcv(sk, skb1);
