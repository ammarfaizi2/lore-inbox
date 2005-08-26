Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030207AbVHZTWv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030207AbVHZTWv (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 Aug 2005 15:22:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030212AbVHZTWv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 Aug 2005 15:22:51 -0400
Received: from smtp.osdl.org ([65.172.181.4]:45526 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1030207AbVHZTWu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 Aug 2005 15:22:50 -0400
Message-Id: <20050826191814.861164000@localhost.localdomain>
References: <20050826191755.052951000@localhost.localdomain>
Date: Fri, 26 Aug 2005 12:17:56 -0700
From: Chris Wright <chrisw@osdl.org>
To: linux-kernel@vger.kernel.org, stable@kernel.org
Cc: Justin Forbes <jmforbes@linuxtx.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       "Theodore Ts'o" <tytso@mit.edu>, Randy Dunlap <rdunlap@xenotime.net>,
       Chuck Wolber <chuckw@quantumlinux.com>, torvalds@osdl.org,
       akpm@osdl.org, alan@lxorguk.ukuu.org.uk,
       Herbert Xu <herbert@gondor.apana.org.au>,
       "David S. Miller" <davem@davemloft.net>, Chris Wright <chrisw@osdl.org>
Subject: [PATCH 1/7] [IPSEC] Restrict socket policy loading to CAP_NET_ADMIN - CAN-2005-2555
Content-Disposition: inline; filename=ipsec-socket-policy-use-cap.patch
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-stable review patch.  If anyone has any  objections, please let us know.
------------------

The interface needs much redesigning if we wish to allow
normal users to do this in some way.

Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>
Signed-off-by: "David S. Miller" <davem@davemloft.net>
Signed-off-by: Chris Wright <chrisw@osdl.org>
---
 net/ipv4/ip_sockglue.c   |    3 +++
 net/ipv6/ipv6_sockglue.c |    3 +++
 2 files changed, 6 insertions(+)

Index: linux-2.6.12.y/net/ipv4/ip_sockglue.c
===================================================================
--- linux-2.6.12.y.orig/net/ipv4/ip_sockglue.c
+++ linux-2.6.12.y/net/ipv4/ip_sockglue.c
@@ -848,6 +848,9 @@ mc_msf_out:
  
 		case IP_IPSEC_POLICY:
 		case IP_XFRM_POLICY:
+			err = -EPERM;
+			if (!capable(CAP_NET_ADMIN))
+				break;
 			err = xfrm_user_policy(sk, optname, optval, optlen);
 			break;
 
Index: linux-2.6.12.y/net/ipv6/ipv6_sockglue.c
===================================================================
--- linux-2.6.12.y.orig/net/ipv6/ipv6_sockglue.c
+++ linux-2.6.12.y/net/ipv6/ipv6_sockglue.c
@@ -503,6 +503,9 @@ done:
 		break;
 	case IPV6_IPSEC_POLICY:
 	case IPV6_XFRM_POLICY:
+		retv = -EPERM;
+		if (!capable(CAP_NET_ADMIN))
+			break;
 		retv = xfrm_user_policy(sk, optname, optval, optlen);
 		break;
 

--
