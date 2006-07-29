Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932188AbWG2Rsy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932188AbWG2Rsy (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 29 Jul 2006 13:48:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932191AbWG2Rsv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 29 Jul 2006 13:48:51 -0400
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:1810 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S932188AbWG2Rsa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 29 Jul 2006 13:48:30 -0400
Date: Sat, 29 Jul 2006 19:48:30 +0200
From: Adrian Bunk <bunk@stusta.de>
To: Andrew Morton <akpm@osdl.org>, Venkat Yekkirala <vyekkirala@TrustedCS.com>
Cc: linux-kernel@vger.kernel.org, davem@davemloft.net, netdev@vger.kernel.org,
       sds@tycho.nsa.gov, jmorris@namei.org
Subject: [-mm patch] security/selinux/hooks.c: make 4 functions static
Message-ID: <20060729174830.GD26963@stusta.de>
References: <20060727015639.9c89db57.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060727015639.9c89db57.akpm@osdl.org>
User-Agent: Mutt/1.5.12-2006-07-14
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 27, 2006 at 01:56:39AM -0700, Andrew Morton wrote:
>...
> Changes since 2.6.18-rc2-mm1:
>...
>  git-net.patch
>...
>  git trees
>...

This patch makes four needlessly global functions static.

Signed-off-by: Adrian Bunk <bunk@stusta.de>

---

 security/selinux/hooks.c |   12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

--- linux-2.6.18-rc2-mm1-full/security/selinux/hooks.c.old	2006-07-27 20:31:37.000000000 +0200
+++ linux-2.6.18-rc2-mm1-full/security/selinux/hooks.c	2006-07-27 20:32:46.000000000 +0200
@@ -3576,7 +3576,7 @@
 	}
 }
 
-void selinux_sock_graft(struct sock* sk, struct socket *parent)
+static void selinux_sock_graft(struct sock* sk, struct socket *parent)
 {
 	struct inode_security_struct *isec = SOCK_INODE(parent)->i_security;
 	struct sk_security_struct *sksec = sk->sk_security;
@@ -3584,8 +3584,8 @@
 	isec->sid = sksec->sid;
 }
 
-int selinux_inet_conn_request(struct sock *sk, struct sk_buff *skb, 
-					   struct request_sock *req)
+static int selinux_inet_conn_request(struct sock *sk, struct sk_buff *skb, 
+				     struct request_sock *req)
 {
 	struct sk_security_struct *sksec = sk->sk_security;
 	int err;
@@ -3603,7 +3603,8 @@
 	return 0;
 }
 
-void selinux_inet_csk_clone(struct sock *newsk, const struct request_sock *req)
+static void selinux_inet_csk_clone(struct sock *newsk,
+				   const struct request_sock *req)
 {
 	struct sk_security_struct *newsksec = newsk->sk_security;
 
@@ -3614,7 +3615,8 @@
 	   time it will have been created and available. */
 }
 
-void selinux_req_classify_flow(const struct request_sock *req, struct flowi *fl)
+static void selinux_req_classify_flow(const struct request_sock *req,
+				      struct flowi *fl)
 {
 	fl->secid = req->secid;
 }

