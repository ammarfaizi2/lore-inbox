Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1758239AbWK2WCF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758239AbWK2WCF (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Nov 2006 17:02:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758270AbWK2WCE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Nov 2006 17:02:04 -0500
Received: from 216-99-217-87.dsl.aracnet.com ([216.99.217.87]:54705 "EHLO
	sous-sol.org") by vger.kernel.org with ESMTP id S1758239AbWK2WB5
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Nov 2006 17:01:57 -0500
Message-Id: <20061129220347.063712000@sous-sol.org>
References: <20061129220111.137430000@sous-sol.org>
User-Agent: quilt/0.45-1
Date: Wed, 29 Nov 2006 14:00:17 -0800
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
Subject: [patch 06/23] NETFILTER: arp_tables: missing unregistration on module unload
Content-Disposition: inline; filename=netfilter-arp_tables-missing-unregistration-on-module-unload.patch
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-stable review patch.  If anyone has any objections, please let us know.
------------------

From: Patrick McHardy <kaber@trash.net>

---
commit 6b22b99ecd431b63aece1fa5b1faa01b75a8302e
tree 7969fd96d4daad6eaf8a10a0659702ca3e404439
parent 0ef4760e162ea44c847cca7393b36e5bcac5414e
author Patrick McHardy <kaber@trash.net> Fri, 17 Nov 2006 06:24:43 +0100
committer Patrick McHardy <kaber@trash.net> Fri, 17 Nov 2006 06:24:43 +0100

 net/ipv4/netfilter/arp_tables.c |    2 ++
 1 file changed, 2 insertions(+)

--- linux-2.6.18.4.orig/net/ipv4/netfilter/arp_tables.c
+++ linux-2.6.18.4/net/ipv4/netfilter/arp_tables.c
@@ -1211,6 +1211,8 @@ err1:
 static void __exit arp_tables_fini(void)
 {
 	nf_unregister_sockopt(&arpt_sockopts);
+	xt_unregister_target(&arpt_error_target);
+	xt_unregister_target(&arpt_standard_target);
 	xt_proto_fini(NF_ARP);
 }
 

--
