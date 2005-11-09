Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030448AbVKIARD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030448AbVKIARD (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Nov 2005 19:17:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030447AbVKIARD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Nov 2005 19:17:03 -0500
Received: from lemon.ken.nicta.com.au ([203.143.174.44]:48836 "EHLO
	lemon.gelato.unsw.edu.au") by vger.kernel.org with ESMTP
	id S1030445AbVKIARA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Nov 2005 19:17:00 -0500
From: Peter Chubb <peterc@gelato.unsw.edu.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17265.16378.77270.7493@berry.gelato.unsw.EDU.AU>
Date: Wed, 9 Nov 2005 11:16:58 +1100
To: netdev@vger.kernel.org, linux-kernel@vger.kernel.org
X-Mailer: VM 7.19 under 21.4 (patch 17) "Jumbo Shrimp" XEmacs Lucid
Comments: Hyperbole mail buttons accepted, v04.18.
X-Face: GgFg(Z>fx((4\32hvXq<)|jndSniCH~~$D)Ka:P@e@JR1P%Vr}EwUdfwf-4j\rUs#JR{'h#
 !]])6%Jh~b$VA|ALhnpPiHu[-x~@<"@Iv&|%R)Fq[[,(&Z'O)Q)xCqe1\M[F8#9l8~}#u$S$Rm`S9%
 \'T@`:&8>Sb*c5d'=eDYI&GF`+t[LfDH="MP5rwOO]w>ALi7'=QJHz&y&C&TE_3j!
X-SA-Exim-Connect-IP: 203.143.160.117
X-SA-Exim-Mail-From: peterc@gelato.unsw.edu.au
Subject: [PATCH] Fix fallout from CONFIG_IPV6_PRIVACY
X-SA-Exim-Version: 4.2 (built Thu, 03 Mar 2005 10:39:27 +0000)
X-SA-Exim-Scanned: Yes (on lemon.gelato.unsw.edu.au)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Trying to build today's 2.6.14+git snapshot gives undefined references
to use_tempaddr

Looks like an ifdef got left out.

Signed-off-by: Peter Chubb <peterc@gelato.unsw.edu.au>

 net/ipv6/addrconf.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

Index: linux-2.6-import/net/ipv6/addrconf.c
===================================================================
--- linux-2.6-import.orig/net/ipv6/addrconf.c	2005-11-09 11:11:42.137993239 +1100
+++ linux-2.6-import/net/ipv6/addrconf.c	2005-11-09 11:12:39.857561898 +1100
@@ -1022,6 +1022,7 @@ int ipv6_dev_get_saddr(struct net_device
 					continue;
 			}
 
+#ifdef CONFIG_IPV6_PRIVACY
 			/* Rule 7: Prefer public address
 			 * Note: prefer temprary address if use_tempaddr >= 2
 			 */
@@ -1043,7 +1044,7 @@ int ipv6_dev_get_saddr(struct net_device
 				if (hiscore.attrs & IPV6_SADDR_SCORE_PRIVACY)
 					continue;
 			}
-
+#endif
 			/* Rule 8: Use longest matching prefix */
 			if (hiscore.rule < 8)
 				hiscore.matchlen = ipv6_addr_diff(&ifa_result->addr, daddr);
