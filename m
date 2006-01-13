Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161654AbWAMDUc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161654AbWAMDUc (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Jan 2006 22:20:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161667AbWAMDU0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Jan 2006 22:20:26 -0500
Received: from 216-99-217-87.dsl.aracnet.com ([216.99.217.87]:3457 "EHLO
	sorel.sous-sol.org") by vger.kernel.org with ESMTP id S1161654AbWAMDTv
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Jan 2006 22:19:51 -0500
Message-Id: <20060113032245.823423000@sorel.sous-sol.org>
References: <20060113032102.154909000@sorel.sous-sol.org>
Date: Thu, 12 Jan 2006 18:37:49 -0800
From: Chris Wright <chrisw@sous-sol.org>
To: linux-kernel@vger.kernel.org, stable@kernel.org
Cc: Justin Forbes <jmforbes@linuxtx.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       "Theodore Ts'o" <tytso@mit.edu>, Randy Dunlap <rdunlap@xenotime.net>,
       Dave Jones <davej@redhat.com>, Chuck Wolber <chuckw@quantumlinux.com>,
       torvalds@osdl.org, akpm@osdl.org, alan@lxorguk.ukuu.org.uk,
       "David S. Miller" <davem@davemloft.net>,
       Bart De Schuymer <bdschuym@pandora.be>
Subject: [PATCH 11/17] [EBTABLES] Dont match tcp/udp source/destination port for IP fragments
Content-Disposition: inline; filename=fix-bridge-netfilter-matching-ip-fragments.patch
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-stable review patch.  If anyone has any objections, please let us know.
------------------

---
 net/bridge/netfilter/ebt_ip.c |    3 +++
 1 file changed, 3 insertions(+)

--- linux-2.6.15.y.orig/net/bridge/netfilter/ebt_ip.c
+++ linux-2.6.15.y/net/bridge/netfilter/ebt_ip.c
@@ -15,6 +15,7 @@
 #include <linux/netfilter_bridge/ebtables.h>
 #include <linux/netfilter_bridge/ebt_ip.h>
 #include <linux/ip.h>
+#include <net/ip.h>
 #include <linux/in.h>
 #include <linux/module.h>
 
@@ -51,6 +52,8 @@ static int ebt_filter_ip(const struct sk
 		if (!(info->bitmask & EBT_IP_DPORT) &&
 		    !(info->bitmask & EBT_IP_SPORT))
 			return EBT_MATCH;
+		if (ntohs(ih->frag_off) & IP_OFFSET)
+			return EBT_NOMATCH;
 		pptr = skb_header_pointer(skb, ih->ihl*4,
 					  sizeof(_ports), &_ports);
 		if (pptr == NULL)

--
