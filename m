Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262556AbVAJWAy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262556AbVAJWAy (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Jan 2005 17:00:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262703AbVAJV7u
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Jan 2005 16:59:50 -0500
Received: from mail.dif.dk ([193.138.115.101]:51400 "EHLO mail.dif.dk")
	by vger.kernel.org with ESMTP id S262556AbVAJVsE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Jan 2005 16:48:04 -0500
Date: Mon, 10 Jan 2005 22:50:34 +0100 (CET)
From: Jesper Juhl <juhl-lkml@dif.dk>
To: linux-kernel <linux-kernel@vger.kernel.org>
Cc: linux-net <linux-net@vger.kernel.org>, netdev <netdev@oss.sgi.com>,
       Olaf Kirch <okir@monad.swb.de>
Subject: [PATCH] remove unused variables in net/sunrpc/auth.c
Message-ID: <Pine.LNX.4.61.0501102239000.2987@dragon.hygekrogen.localhost>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


We have a few unused variables in net/sunrpc/auth.c:320:

net/sunrpc/auth.c:320: warning: unused variable `auth'
net/sunrpc/auth.c:333: warning: unused variable `auth'
net/sunrpc/auth.c:345: warning: unused variable `auth'
net/sunrpc/auth.c:385: warning: unused variable `auth'

As far as I can see, the patch that caused them to become unused is this 
one (which btw is ~36 months old) :
http://linux.bkbits.net:8080/linux-2.6/diffs/net/sunrpc/auth.c@1.4?nav=index.html|src/|src/net|src/net/sunrpc|hist/net/sunrpc/auth.c

Here is a patch to get rid of them (compile tested only).


Signed-off-by: Jesper Juhl <juhl-lkml@dif.dk>

diff -up linux-2.6.10-bk13-orig/net/sunrpc/auth.c linux-2.6.10-bk13/net/sunrpc/auth.c
--- linux-2.6.10-bk13-orig/net/sunrpc/auth.c	2005-01-10 22:09:22.000000000 +0100
+++ linux-2.6.10-bk13/net/sunrpc/auth.c	2005-01-10 22:37:55.000000000 +0100
@@ -317,7 +317,6 @@ put_rpccred(struct rpc_cred *cred)
 void
 rpcauth_unbindcred(struct rpc_task *task)
 {
-	struct rpc_auth	*auth = task->tk_auth;
 	struct rpc_cred	*cred = task->tk_msg.rpc_cred;
 
 	dprintk("RPC: %4d releasing %s cred %p\n",
@@ -330,7 +329,6 @@ rpcauth_unbindcred(struct rpc_task *task
 u32 *
 rpcauth_marshcred(struct rpc_task *task, u32 *p)
 {
-	struct rpc_auth	*auth = task->tk_auth;
 	struct rpc_cred	*cred = task->tk_msg.rpc_cred;
 
 	dprintk("RPC: %4d marshaling %s cred %p\n",
@@ -342,7 +340,6 @@ rpcauth_marshcred(struct rpc_task *task,
 u32 *
 rpcauth_checkverf(struct rpc_task *task, u32 *p)
 {
-	struct rpc_auth	*auth = task->tk_auth;
 	struct rpc_cred	*cred = task->tk_msg.rpc_cred;
 
 	dprintk("RPC: %4d validating %s cred %p\n",
@@ -382,7 +379,6 @@ rpcauth_unwrap_resp(struct rpc_task *tas
 int
 rpcauth_refreshcred(struct rpc_task *task)
 {
-	struct rpc_auth	*auth = task->tk_auth;
 	struct rpc_cred	*cred = task->tk_msg.rpc_cred;
 
 	dprintk("RPC: %4d refreshing %s cred %p\n",




PS. please keep me on CC 



