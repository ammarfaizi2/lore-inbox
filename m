Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161650AbWAMDTt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161650AbWAMDTt (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Jan 2006 22:19:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161655AbWAMDTs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Jan 2006 22:19:48 -0500
Received: from 216-99-217-87.dsl.aracnet.com ([216.99.217.87]:12416 "EHLO
	sorel.sous-sol.org") by vger.kernel.org with ESMTP id S1161653AbWAMDTY
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Jan 2006 22:19:24 -0500
Message-Id: <20060113032244.507823000@sorel.sous-sol.org>
References: <20060113032102.154909000@sorel.sous-sol.org>
Date: Thu, 12 Jan 2006 18:37:47 -0800
From: Chris Wright <chrisw@sous-sol.org>
To: linux-kernel@vger.kernel.org, stable@kernel.org
Cc: Justin Forbes <jmforbes@linuxtx.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       "Theodore Ts'o" <tytso@mit.edu>, Randy Dunlap <rdunlap@xenotime.net>,
       Dave Jones <davej@redhat.com>, Chuck Wolber <chuckw@quantumlinux.com>,
       torvalds@osdl.org, akpm@osdl.org, alan@lxorguk.ukuu.org.uk,
       Patrick McHardy <kaber@trash.net>
Subject: [PATCH 09/17] [NETFILTER]: Fix crash in ip_nat_pptp
Content-Disposition: inline; filename=netfilter-fix-crash-in-ip_nat_pptp.patch
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-stable review patch.  If anyone has any objections, please let us know.
------------------

When an inbound PPTP_IN_CALL_REQUEST packet is received the
PPTP NAT helper uses a NULL pointer in pointer arithmentic to
calculate the offset in the packet which needs to be mangled
and corrupts random memory or crashes.

Signed-off-by: Patrick McHardy <kaber@trash.net>
Signed-off-by: Chris Wright <chrisw@sous-sol.org>
---
 net/ipv4/netfilter/ip_nat_helper_pptp.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- linux-2.6.15.y.orig/net/ipv4/netfilter/ip_nat_helper_pptp.c
+++ linux-2.6.15.y/net/ipv4/netfilter/ip_nat_helper_pptp.c
@@ -315,7 +315,7 @@ pptp_inbound_pkt(struct sk_buff **pskb,
 		break;
 	case PPTP_IN_CALL_REQUEST:
 		/* only need to nat in case PAC is behind NAT box */
-		break;
+		return NF_ACCEPT;
 	case PPTP_WAN_ERROR_NOTIFY:
 		pcid = &pptpReq->wanerr.peersCallID;
 		break;

--
