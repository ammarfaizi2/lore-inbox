Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267543AbTAGSCi>; Tue, 7 Jan 2003 13:02:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267544AbTAGSCi>; Tue, 7 Jan 2003 13:02:38 -0500
Received: from sb0-cf9a4971.dsl.impulse.net ([207.154.73.113]:22538 "EHLO
	madrabbit.org") by vger.kernel.org with ESMTP id <S267543AbTAGSCg>;
	Tue, 7 Jan 2003 13:02:36 -0500
Subject: [PATCH] Re: unix_getname buglet - > 2.5.4(?)
From: Ray Lee <ray-lk@madrabbit.org>
To: Michael Meeks <michael@ximian.com>, torvalds@transmeta.com
Cc: Linux Kernel <linux-kernel@vger.kernel.org>,
       evolution <evolution-hackers@ximian.com>, orbit <orbit-list@gnome.org>
In-Reply-To: <1041941192.25619.293.camel@michael.home>
References: <1041941192.25619.293.camel@michael.home>
Content-Type: text/plain
Organization: 
Message-Id: <1041963072.855.13.camel@orca.madrabbit.org>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.1 
Date: 07 Jan 2003 10:11:12 -0800
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2003-01-07 at 04:06, Michael Meeks wrote:
> 	Evolution is non-functioning on recent 2.5.X kernels, due to
> mal-performance in getpeername => net/unix/af_unix.c (unix_getname),
> where it seems we switch 'sk' on 'peer', but not the (previously)
> typecast pointer to it; this fixes it.

<snip> Your patch was MailerMangled(tm). Below is what I'm running on
2.5.54, using Evolution. The patch is obviously correct (once you look
at the full code, anyway).

Linus, please apply.

Ray

diff -Nurx /home/ray/work/dontdiff linux-2.5.54/net/unix/af_unix.c linux-2.5.54-af_unix.c-fix/net/unix/af_unix.c
--- linux-2.5.54/net/unix/af_unix.c	2003-01-07 09:22:29.000000000 -0800
+++ linux-2.5.54-af_unix.c-fix/net/unix/af_unix.c	2003-01-07 09:55:19.000000000 -0800
@@ -1109,7 +1109,7 @@
 static int unix_getname(struct socket *sock, struct sockaddr *uaddr, int *uaddr_len, int peer)
 {
 	struct sock *sk = sock->sk;
-	struct unix_sock *u = unix_sk(sk);
+	struct unix_sock *u;
 	struct sockaddr_un *sunaddr=(struct sockaddr_un *)uaddr;
 	int err = 0;
 
@@ -1124,6 +1124,7 @@
 		sock_hold(sk);
 	}
 
+	u = unix_sk(sk);
 	unix_state_rlock(sk);
 	if (!u->addr) {
 		sunaddr->sun_family = AF_UNIX;


