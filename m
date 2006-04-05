Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751009AbWDEAFp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751009AbWDEAFp (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Apr 2006 20:05:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750990AbWDEABp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Apr 2006 20:01:45 -0400
Received: from dsl093-040-174.pdx1.dsl.speakeasy.net ([66.93.40.174]:31170
	"EHLO aria.kroah.org") by vger.kernel.org with ESMTP
	id S1750972AbWDEAB1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Apr 2006 20:01:27 -0400
Date: Tue, 4 Apr 2006 17:00:41 -0700
From: gregkh@suse.de
To: linux-kernel@vger.kernel.org, stable@kernel.org
Cc: Justin Forbes <jmforbes@linuxtx.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       "Theodore Ts'o" <tytso@mit.edu>, Randy Dunlap <rdunlap@xenotime.net>,
       Dave Jones <davej@redhat.com>, Chuck Wolber <chuckw@quantumlinux.com>,
       torvalds@osdl.org, akpm@osdl.org, alan@lxorguk.ukuu.org.uk,
       Martin Josefsson <gandalf@wlug.westbo.se>,
       Patrick McHardy <kaber@trash.net>, David Miller <davem@davemloft.net>,
       Greg Kroah-Hartman <gregkh@suse.de>
Subject: [patch 14/26] {ip, nf}_conntrack_netlink: fix expectation notifier unregistration
Message-ID: <20060405000041.GO27049@kroah.com>
References: <20060404235634.696852000@quad.kroah.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline; filename="ip.patch"
In-Reply-To: <20060404235927.GA27049@kroah.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


From: Martin Josefsson <gandalf@wlug.westbo.se>

[NETFILTER]: {ip,nf}_conntrack_netlink: fix expectation notifier unregistration

This patch fixes expectation notifier unregistration on module unload to
use ip_conntrack_expect_unregister_notifier(). This bug causes a soft
lockup at the first expectation created after a rmmod ; insmod of this
module.

Should go into -stable as well.

Signed-off-by: Martin Josefsson <gandalf@wlug.westbo.se>
Signed-off-by: Patrick McHardy <kaber@trash.net>
Signed-off-by: David Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

---
 net/ipv4/netfilter/ip_conntrack_netlink.c |    2 +-
 net/netfilter/nf_conntrack_netlink.c      |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

--- linux-2.6.16.1.orig/net/ipv4/netfilter/ip_conntrack_netlink.c
+++ linux-2.6.16.1/net/ipv4/netfilter/ip_conntrack_netlink.c
@@ -1619,7 +1619,7 @@ static void __exit ctnetlink_exit(void)
 	printk("ctnetlink: unregistering from nfnetlink.\n");
 
 #ifdef CONFIG_IP_NF_CONNTRACK_EVENTS
-	ip_conntrack_unregister_notifier(&ctnl_notifier_exp);
+	ip_conntrack_expect_unregister_notifier(&ctnl_notifier_exp);
 	ip_conntrack_unregister_notifier(&ctnl_notifier);
 #endif
 
--- linux-2.6.16.1.orig/net/netfilter/nf_conntrack_netlink.c
+++ linux-2.6.16.1/net/netfilter/nf_conntrack_netlink.c
@@ -1641,7 +1641,7 @@ static void __exit ctnetlink_exit(void)
 	printk("ctnetlink: unregistering from nfnetlink.\n");
 
 #ifdef CONFIG_NF_CONNTRACK_EVENTS
-	nf_conntrack_unregister_notifier(&ctnl_notifier_exp);
+	nf_conntrack_expect_unregister_notifier(&ctnl_notifier_exp);
 	nf_conntrack_unregister_notifier(&ctnl_notifier);
 #endif
 

--
