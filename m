Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261849AbULaLRb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261849AbULaLRb (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 31 Dec 2004 06:17:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261852AbULaLRb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 31 Dec 2004 06:17:31 -0500
Received: from livid.absolutedigital.net ([66.92.46.173]:47751 "EHLO
	mx2.absolutedigital.net") by vger.kernel.org with ESMTP
	id S261849AbULaLR0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 31 Dec 2004 06:17:26 -0500
Date: Fri, 31 Dec 2004 06:17:26 -0500 (EST)
From: Cal Peake <cp@absolutedigital.net>
To: Ikke <ikke.lkml@gmail.com>
cc: Michael Berger <mikeb1@t-online.de>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Compile error in kernel 2.6.10-bk3 in file slhc.c
In-Reply-To: <297f4e0104123102571bb1759f@mail.gmail.com>
Message-ID: <Pine.LNX.4.61.0412310614320.6599@lancer.cnet.absolutedigital.net>
References: <3hbOM-43L-21@gated-at.bofh.it> <41D5009E.4090100@t-online.de>
 <297f4e0104123102571bb1759f@mail.gmail.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 31 Dec 2004, Ikke wrote:

> Could you point me to the patch please?

at:

http://linux.bkbits.net:8080/linux-2.5/cset@1.2082?nav=index.html|ChangeSet@-1d

and below.

-- Cal

# This is a BitKeeper generated diff -Nru style patch.
#
# ChangeSet
#   2004/12/30 15:21:16-08:00 acme@conectiva.com.br 
#   [PATCH] Fix net/core/sock.o build failure
#   
#   This fixes a build failure that happens when you don't select IPV6.
#   
#   Signed-off-by: Linus Torvalds <torvalds@osdl.org>
# 
# include/linux/ipv6.h
#   2004/12/29 14:22:45-08:00 acme@conectiva.com.br +1 -1
#   Fix net/core/sock.o build failure
# 
diff -Nru a/include/linux/ipv6.h b/include/linux/ipv6.h
--- a/include/linux/ipv6.h	2004-12-31 03:15:16 -08:00
+++ b/include/linux/ipv6.h	2004-12-31 03:15:16 -08:00
@@ -273,6 +273,7 @@
 	struct ipv6_pinfo inet6;
 };
 
+#if defined(CONFIG_IPV6) || defined(CONFIG_IPV6_MODULE)
 static inline struct ipv6_pinfo * inet6_sk(const struct sock *__sk)
 {
 	return inet_sk(__sk)->pinet6;
@@ -283,7 +284,6 @@
 	return &((struct raw6_sock *)__sk)->raw6;
 }
 
-#if defined(CONFIG_IPV6) || defined(CONFIG_IPV6_MODULE)
 #define __ipv6_only_sock(sk)	(inet6_sk(sk)->ipv6only)
 #define ipv6_only_sock(sk)	((sk)->sk_family == PF_INET6 && __ipv6_only_sock(sk))
 #else
