Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261168AbTIXKaf (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 Sep 2003 06:30:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261178AbTIXKaf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 Sep 2003 06:30:35 -0400
Received: from bilbo.math.uni-mannheim.de ([134.155.88.153]:48828 "EHLO
	bilbo.math.uni-mannheim.de") by vger.kernel.org with ESMTP
	id S261168AbTIXKac (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 Sep 2003 06:30:32 -0400
From: Rolf Eike Beer <eike-kernel@sf-tec.de>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] if(foo) BUG() -> BUG_ON(foo) for include/rxrpc/
Date: Wed, 24 Sep 2003 12:33:09 +0200
User-Agent: KMail/1.5.3
Cc: Linus Torvalds <torvalds@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200309241233.09877@bilbo.math.uni-mannheim.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi again,

some cosmetic changes. Some more will follow as replies to this one.

Eike

diff -aur linux-2.6.0-test5-bk6/include/rxrpc/call.h linux-2.6.0-test5-bk6-caliban/include/rxrpc/call.h
--- linux-2.6.0-test5-bk6/include/rxrpc/call.h	2003-09-11 10:18:33.000000000 +0200
+++ linux-2.6.0-test5-bk6-caliban/include/rxrpc/call.h	2003-09-11 10:26:39.000000000 +0200
@@ -187,8 +187,7 @@
 
 static inline void rxrpc_get_call(struct rxrpc_call *call)
 {
-	if (atomic_read(&call->usage)<=0)
-		BUG();
+	BUG_ON(atomic_read(&call->usage)<=0);
 	atomic_inc(&call->usage);
 	/*printk("rxrpc_get_call(%p{u=%d})\n",(C),atomic_read(&(C)->usage));*/
 }
diff -aur linux-2.6.0-test5-bk6/include/rxrpc/connection.h linux-2.6.0-test5-bk6-caliban/include/rxrpc/connection.h
--- linux-2.6.0-test5-bk6/include/rxrpc/connection.h	2003-09-11 10:18:33.000000000 +0200
+++ linux-2.6.0-test5-bk6-caliban/include/rxrpc/connection.h	2003-09-11 10:26:39.000000000 +0200
@@ -67,8 +67,7 @@
 
 static inline void rxrpc_get_connection(struct rxrpc_connection *conn)
 {
-	if (atomic_read(&conn->usage)<0)
-		BUG();
+	BUG_ON(atomic_read(&conn->usage)<0);
 	atomic_inc(&conn->usage);
 	//printk("rxrpc_get_conn(%p{u=%d})\n",conn,atomic_read(&conn->usage));
 }
diff -aur linux-2.6.0-test5-bk6/include/rxrpc/message.h linux-2.6.0-test5-bk6-caliban/include/rxrpc/message.h
--- linux-2.6.0-test5-bk6/include/rxrpc/message.h	2003-09-11 10:18:33.000000000 +0200
+++ linux-2.6.0-test5-bk6-caliban/include/rxrpc/message.h	2003-09-11 10:26:39.000000000 +0200
@@ -53,8 +53,7 @@
 extern void __rxrpc_put_message(struct rxrpc_message *msg);
 static inline void rxrpc_put_message(struct rxrpc_message *msg)
 {
-	if (atomic_read(&msg->usage)<=0)
-		BUG();
+	BUG_ON(atomic_read(&msg->usage)<=0);
 	if (atomic_dec_and_test(&msg->usage))
 		__rxrpc_put_message(msg);
 }
diff -aur linux-2.6.0-test5-bk6/include/rxrpc/peer.h linux-2.6.0-test5-bk6-caliban/include/rxrpc/peer.h
--- linux-2.6.0-test5-bk6/include/rxrpc/peer.h	2003-09-11 10:18:33.000000000 +0200
+++ linux-2.6.0-test5-bk6-caliban/include/rxrpc/peer.h	2003-09-11 10:26:39.000000000 +0200
@@ -72,8 +72,7 @@
 
 static inline void rxrpc_get_peer(struct rxrpc_peer *peer)
 {
-	if (atomic_read(&peer->usage)<0)
-		BUG();
+	BUG_ON(atomic_read(&peer->usage)<0);
 	atomic_inc(&peer->usage);
 	//printk("rxrpc_get_peer(%p{u=%d})\n",peer,atomic_read(&peer->usage));
 }
diff -aur linux-2.6.0-test5-bk6/include/rxrpc/transport.h linux-2.6.0-test5-bk6-caliban/include/rxrpc/transport.h
--- linux-2.6.0-test5-bk6/include/rxrpc/transport.h	2003-09-11 10:18:33.000000000 +0200
+++ linux-2.6.0-test5-bk6-caliban/include/rxrpc/transport.h	2003-09-11 10:27:28.000000000 +0200
@@ -85,8 +85,7 @@
 
 static inline void rxrpc_get_transport(struct rxrpc_transport *trans)
 {
-	if (atomic_read(&trans->usage) <= 0)
-		BUG();
+	BUG_ON(atomic_read(&trans->usage) <= 0);
 	atomic_inc(&trans->usage);
 	//printk("rxrpc_get_transport(%p{u=%d})\n",
 	//       trans, atomic_read(&trans->usage));
