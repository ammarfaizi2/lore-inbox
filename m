Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266182AbUGQQxN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266182AbUGQQxN (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 17 Jul 2004 12:53:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266546AbUGQQxN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 17 Jul 2004 12:53:13 -0400
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:63681 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id S266182AbUGQQxK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 17 Jul 2004 12:53:10 -0400
Date: Sat, 17 Jul 2004 18:53:04 +0200
From: Adrian Bunk <bunk@fs.tum.de>
To: coreteam@netfilter.org
Cc: linux-kernel@vger.kernel.org, netfilter-devel@lists.netfilter.org
Subject: [2.6 patch] ipv4/netfilter/Kconfig: simplify dependencies
Message-ID: <20040717165303.GE4759@fs.tum.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

It seems that originating from the automatic Kconfig transition, some 
dependencies in ipv4/netfilter/Kconfig are correct, but too complicated.

The patch below makes them a bit more simple.

--- linux-2.6.8-rc1-mm1-full/net/ipv4/netfilter/Kconfig.old	2004-07-17 17:43:55.000000000 +0200
+++ linux-2.6.8-rc1-mm1-full/net/ipv4/netfilter/Kconfig	2004-07-17 18:12:43.000000000 +0200
@@ -307,7 +307,7 @@
 
 config IP_NF_NAT_NEEDED
 	bool
-	depends on IP_NF_CONNTRACK!=y && IP_NF_IPTABLES!=y && (IP_NF_COMPAT_IPCHAINS!=y && IP_NF_COMPAT_IPFWADM || IP_NF_COMPAT_IPCHAINS) || IP_NF_IPTABLES && IP_NF_CONNTRACK && IP_NF_NAT
+	depends on IP_NF_COMPAT_IPFWADM || IP_NF_COMPAT_IPCHAINS || IP_NF_NAT
 	default y
 
 config IP_NF_TARGET_MASQUERADE
@@ -392,19 +392,19 @@
 # or $CONFIG_IP_NF_FTP (m or y), whichever is weaker.  Argh.
 config IP_NF_NAT_FTP
 	tristate
-	depends on IP_NF_IPTABLES!=n && IP_NF_CONNTRACK!=n && IP_NF_NAT!=n
+	depends on IP_NF_NAT!=n
 	default IP_NF_NAT if IP_NF_FTP=y
 	default m if IP_NF_FTP=m
 
 config IP_NF_NAT_TFTP
 	tristate
-	depends on IP_NF_IPTABLES!=n && IP_NF_CONNTRACK!=n && IP_NF_NAT!=n
+	depends on IP_NF_NAT!=n
 	default IP_NF_NAT if IP_NF_TFTP=y
 	default m if IP_NF_TFTP=m
 
 config IP_NF_NAT_AMANDA
 	tristate
-	depends on IP_NF_IPTABLES!=n && IP_NF_CONNTRACK!=n && IP_NF_NAT!=n
+	depends on IP_NF_NAT!=n
 	default IP_NF_NAT if IP_NF_AMANDA=y
 	default m if IP_NF_AMANDA=m
 

