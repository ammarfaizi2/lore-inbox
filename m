Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1758280AbWK2WCm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758280AbWK2WCm (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Nov 2006 17:02:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758270AbWK2WCk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Nov 2006 17:02:40 -0500
Received: from 216-99-217-87.dsl.aracnet.com ([216.99.217.87]:2482 "EHLO
	sous-sol.org") by vger.kernel.org with ESMTP id S1758246AbWK2WC2
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Nov 2006 17:02:28 -0500
Message-Id: <20061129220419.865448000@sous-sol.org>
References: <20061129220111.137430000@sous-sol.org>
User-Agent: quilt/0.45-1
Date: Wed, 29 Nov 2006 14:00:20 -0800
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
Subject: [patch 09/23] NETFILTER: xt_CONNSECMARK: fix Kconfig dependencies
Content-Disposition: inline; filename=netfilter-xt_connsecmark-fix-kconfig-dependencies.patch
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-stable review patch.  If anyone has any objections, please let us know.
------------------

From: Patrick McHardy <kaber@trash.net>

CONNSECMARK needs conntrack, add missing dependency to fix linking error
with CONNSECMARK=y and CONNTRACK=m.

Reported by Toralf Förster <toralf.foerster@gmx.de>.

Signed-off-by: Patrick McHardy <kaber@trash.net>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Chris Wright <chrisw@sous-sol.org>

---
commit 7f013c33ba2b02614c856d715b65d858bc1ec47f
tree 7ba757cfe1e953e47726bdcf956c16d07d94aa6e
parent ca6adddd237afa4910bab5e9e8ba0685f37c2bfe
author Patrick McHardy <kaber@trash.net> Fri, 17 Nov 2006 06:25:54 +0100
committer Patrick McHardy <kaber@trash.net> Fri, 17 Nov 2006 06:25:54 +0100

 net/netfilter/Kconfig |    4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

--- linux-2.6.18.4.orig/net/netfilter/Kconfig
+++ linux-2.6.18.4/net/netfilter/Kconfig
@@ -197,7 +197,9 @@ config NETFILTER_XT_TARGET_SECMARK
 
 config NETFILTER_XT_TARGET_CONNSECMARK
 	tristate '"CONNSECMARK" target support'
-	depends on NETFILTER_XTABLES && (NF_CONNTRACK_SECMARK || IP_NF_CONNTRACK_SECMARK)
+	depends on NETFILTER_XTABLES && \
+		   ((NF_CONNTRACK && NF_CONNTRACK_SECMARK) || \
+		    (IP_NF_CONNTRACK && IP_NF_CONNTRACK_SECMARK))
 	help
 	  The CONNSECMARK target copies security markings from packets
 	  to connections, and restores security markings from connections

--
