Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1758210AbWK2WDJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758210AbWK2WDJ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Nov 2006 17:03:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758246AbWK2WCn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Nov 2006 17:02:43 -0500
Received: from 216-99-217-87.dsl.aracnet.com ([216.99.217.87]:64689 "EHLO
	sous-sol.org") by vger.kernel.org with ESMTP id S1758265AbWK2WCU
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Nov 2006 17:02:20 -0500
Message-Id: <20061129220409.408136000@sous-sol.org>
References: <20061129220111.137430000@sous-sol.org>
User-Agent: quilt/0.45-1
Date: Wed, 29 Nov 2006 14:00:19 -0800
From: Chris Wright <chrisw@sous-sol.org>
To: linux-kernel@vger.kernel.org, stable@kernel.org
Cc: Justin Forbes <jmforbes@linuxtx.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       "Theodore Ts'o" <tytso@mit.edu>, Randy Dunlap <rdunlap@xenotime.net>,
       Dave Jones <davej@redhat.com>, Chuck Wolber <chuckw@quantumlinux.com>,
       Chris Wedgwood <reviews@ml.cw.f00f.org>,
       Michael Krufky <mkrufky@linuxtv.org>, torvalds@osdl.org, akpm@osdl.org,
       alan@lxorguk.ukuu.org.uk, Patrick McHardy <kaber@trash.net>,
       davem@davemloft.net
Subject: [patch 08/23] NETFILTER: Kconfig: fix xt_physdev dependencies
Content-Disposition: inline; filename=netfilter-kconfig-fix-xt_physdev-dependencies.patch
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-stable review patch.  If anyone has any objections, please let us know.
------------------

From: Patrick McHardy <kaber@trash.net>

xt_physdev depends on bridge netfilter, which is a boolean, but can still
be built modular because of special handling in the bridge makefile. Add
a dependency on BRIDGE to prevent XT_MATCH_PHYSDEV=y, BRIDGE=m.

Signed-off-by: Patrick McHardy <kaber@trash.net>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Chris Wright <chrisw@sous-sol.org>

---
commit ca6adddd237afa4910bab5e9e8ba0685f37c2bfe
tree 45c88fae3ec75a90ffac423906e662bdb36e8251
parent cf08e74a590c945d3c0b95886ea3fad8ff73793d
author Patrick McHardy <kaber@trash.net> Fri, 17 Nov 2006 06:25:31 +0100
committer Patrick McHardy <kaber@trash.net> Fri, 17 Nov 2006 06:25:31 +0100

 net/netfilter/Kconfig |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- linux-2.6.18.4.orig/net/netfilter/Kconfig
+++ linux-2.6.18.4/net/netfilter/Kconfig
@@ -342,7 +342,7 @@ config NETFILTER_XT_MATCH_MULTIPORT
 
 config NETFILTER_XT_MATCH_PHYSDEV
 	tristate '"physdev" match support'
-	depends on NETFILTER_XTABLES && BRIDGE_NETFILTER
+	depends on NETFILTER_XTABLES && BRIDGE && BRIDGE_NETFILTER
 	help
 	  Physdev packet matching matches against the physical bridge ports
 	  the IP packet arrived on or will leave by.

--
