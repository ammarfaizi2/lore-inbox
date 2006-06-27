Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161275AbWF0URp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161275AbWF0URp (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Jun 2006 16:17:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161278AbWF0URp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Jun 2006 16:17:45 -0400
Received: from 216-99-217-87.dsl.aracnet.com ([216.99.217.87]:54144 "EHLO
	sous-sol.org") by vger.kernel.org with ESMTP id S1161277AbWF0URb
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Jun 2006 16:17:31 -0400
Message-Id: <20060627201514.317801000@sous-sol.org>
References: <20060627200745.771284000@sous-sol.org>
User-Agent: quilt/0.45-1
Date: Tue, 27 Jun 2006 00:00:17 -0700
From: Chris Wright <chrisw@sous-sol.org>
To: linux-kernel@vger.kernel.org, stable@kernel.org
Cc: Justin Forbes <jmforbes@linuxtx.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       "Theodore Ts'o" <tytso@mit.edu>, Randy Dunlap <rdunlap@xenotime.net>,
       Dave Jones <davej@redhat.com>, Chuck Wolber <chuckw@quantumlinux.com>,
       Chris Wedgwood <reviews@ml.cw.f00f.org>, torvalds@osdl.org,
       akpm@osdl.org, alan@lxorguk.ukuu.org.uk,
       David Miller <davem@davemloft.net>,
       YOSHIFUJI Hideaki <yoshfuji@linux-ipv6.org>
Subject: [PATCH 17/25] IPV6 ADDRCONF: Fix default source address selection without CONFIG_IPV6_PRIVACY
Content-Disposition: inline; filename=ipv6-addrconf-fix-default-source-address-selection-without-config_ipv6_privacy.patch
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-stable review patch.  If anyone has any objections, please let us know.
------------------

From: YOSHIFUJI Hideaki <yoshfuji@linux-ipv6.org>

We need to update hiscore.rule even if we don't enable CONFIG_IPV6_PRIVACY,
because we have more less significant rule; longest match.

Signed-off-by: YOSHIFUJI Hideaki <yoshfuji@linux-ipv6.org>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Chris Wright <chrisw@sous-sol.org>
---
 net/ipv6/addrconf.c |    3 +++
 1 file changed, 3 insertions(+)

--- linux-2.6.17.1.orig/net/ipv6/addrconf.c
+++ linux-2.6.17.1/net/ipv6/addrconf.c
@@ -1075,6 +1075,9 @@ int ipv6_dev_get_saddr(struct net_device
 				if (hiscore.attrs & IPV6_SADDR_SCORE_PRIVACY)
 					continue;
 			}
+#else
+			if (hiscore.rule < 7)
+				hiscore.rule++;
 #endif
 			/* Rule 8: Use longest matching prefix */
 			if (hiscore.rule < 8) {

--
