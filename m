Return-Path: <linux-kernel-owner+w=401wt.eu-S964972AbWLOBlx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964972AbWLOBlx (ORCPT <rfc822;w@1wt.eu>);
	Thu, 14 Dec 2006 20:41:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965032AbWLOBlv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Dec 2006 20:41:51 -0500
Received: from 216-99-217-87.dsl.aracnet.com ([216.99.217.87]:46178 "EHLO
	sous-sol.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S964972AbWLOBfU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Dec 2006 20:35:20 -0500
Message-Id: <20061215013557.785334000@sous-sol.org>
References: <20061215013337.823935000@sous-sol.org>
User-Agent: quilt/0.45-1
Date: Thu, 14 Dec 2006 17:33:45 -0800
From: Chris Wright <chrisw@sous-sol.org>
To: linux-kernel@vger.kernel.org, stable@kernel.org
Cc: Justin Forbes <jmforbes@linuxtx.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       "Theodore Ts'o" <tytso@mit.edu>, Randy Dunlap <rdunlap@xenotime.net>,
       Dave Jones <davej@redhat.com>, Chuck Wolber <chuckw@quantumlinux.com>,
       Chris Wedgwood <reviews@ml.cw.f00f.org>,
       Michael Krufky <mkrufky@linuxtv.org>, torvalds@osdl.org, akpm@osdl.org,
       alan@lxorguk.ukuu.org.uk, David Miller <davem@davemloft.net>,
       bunk@stusta.de, Patrick McHardy <kaber@trash.net>
Subject: [patch 08/24] NETFILTER: ip_tables: revision support for compat code
Content-Disposition: inline; filename=netfilter-ip_tables-revision-support-for-compat-code.patch
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

2.6.18-stable review patch.  If anyone has any objections, please let us know.
------------------

From: Patrick McHardy <kaber@trash.net>

---
commit 79030ed07de673e8451a03aecb9ada9f4d75d491
tree 4ba8bd843c8bc95db0ea6877880b73d06da620e5
parent bec71b162747708d4b45b0cd399b484f52f2901a
author Patrick McHardy <kaber@trash.net> Wed, 20 Sep 2006 12:05:08 -0700
committer David S. Miller <davem@sunset.davemloft.net> Fri, 22 Sep 2006 15:20:00 -0700

 net/ipv4/netfilter/ip_tables.c |    5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

--- linux-2.6.18.5.orig/net/ipv4/netfilter/ip_tables.c
+++ linux-2.6.18.5/net/ipv4/netfilter/ip_tables.c
@@ -1989,6 +1989,8 @@ compat_get_entries(struct compat_ipt_get
 	return ret;
 }
 
+static int do_ipt_get_ctl(struct sock *, int, void __user *, int *);
+
 static int
 compat_do_ipt_get_ctl(struct sock *sk, int cmd, void __user *user, int *len)
 {
@@ -2005,8 +2007,7 @@ compat_do_ipt_get_ctl(struct sock *sk, i
 		ret = compat_get_entries(user, len);
 		break;
 	default:
-		duprintf("compat_do_ipt_get_ctl: unknown request %i\n", cmd);
-		ret = -EINVAL;
+		ret = do_ipt_get_ctl(sk, cmd, user, len);
 	}
 	return ret;
 }

--
