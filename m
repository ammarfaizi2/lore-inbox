Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965209AbVKVVLU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965209AbVKVVLU (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Nov 2005 16:11:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965142AbVKVVKv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Nov 2005 16:10:51 -0500
Received: from smtp.osdl.org ([65.172.181.4]:51359 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S965204AbVKVVKQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Nov 2005 16:10:16 -0500
Date: Tue, 22 Nov 2005 13:08:21 -0800
From: Chris Wright <chrisw@osdl.org>
To: linux-kernel@vger.kernel.org, stable@kernel.org
Cc: Justin Forbes <jmforbes@linuxtx.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       "Theodore Ts'o" <tytso@mit.edu>, Randy Dunlap <rdunlap@xenotime.net>,
       Dave Jones <davej@redhat.com>, Chuck Wolber <chuckw@quantumlinux.com>,
       torvalds@osdl.org, akpm@osdl.org, alan@lxorguk.ukuu.org.uk,
       YOSHIFUJI Hideaki <yoshfuji@linux-ipv6.org>
Subject: [patch 16/23] [PATCH] [IPV6]: Fix memory management error during setting up new advapi sockopts.
Message-ID: <20051122210821.GQ28140@shell0.pdx.osdl.net>
References: <20051122205223.099537000@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline; filename="fix-memory-management-error-during.patch"
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-stable review patch.  If anyone has any objections, please let us know.
------------------

---
 net/ipv6/exthdrs.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

--- linux-2.6.14.2.orig/net/ipv6/exthdrs.c
+++ linux-2.6.14.2/net/ipv6/exthdrs.c
@@ -628,6 +628,7 @@ ipv6_renew_options(struct sock *sk, stru
 	if (!tot_len)
 		return NULL;
 
+	tot_len += sizeof(*opt2);
 	opt2 = sock_kmalloc(sk, tot_len, GFP_ATOMIC);
 	if (!opt2)
 		return ERR_PTR(-ENOBUFS);
@@ -668,7 +669,7 @@ ipv6_renew_options(struct sock *sk, stru
 
 	return opt2;
 out:
-	sock_kfree_s(sk, p, tot_len);
+	sock_kfree_s(sk, opt2, opt2->tot_len);
 	return ERR_PTR(err);
 }
 

--
