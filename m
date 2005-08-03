Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262125AbVHCG7f@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262125AbVHCG7f (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Aug 2005 02:59:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262141AbVHCG5q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Aug 2005 02:57:46 -0400
Received: from smtp.osdl.org ([65.172.181.4]:15069 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262125AbVHCG4V (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Aug 2005 02:56:21 -0400
Date: Tue, 2 Aug 2005 23:55:56 -0700
From: Chris Wright <chrisw@osdl.org>
To: linux-kernel@vger.kernel.org, stable@kernel.org
Cc: Justin Forbes <jmforbes@linuxtx.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       "Theodore Ts'o" <tytso@mit.edu>, Randy Dunlap <rdunlap@xenotime.net>,
       Chuck Wolber <chuckw@quantumlinux.com>, torvalds@osdl.org,
       akpm@osdl.org, alan@lxorguk.ukuu.org.uk,
       Patrick McHardy <kaber@trash.net>,
       "David S. Miller" <davem@davemloft.net>
Subject: [06/13] [NETFILTER]: Fix deadlock in ip6_queue
Message-ID: <20050803065556.GU7762@shell0.pdx.osdl.net>
References: <20050803064439.GO7762@shell0.pdx.osdl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050803064439.GO7762@shell0.pdx.osdl.net>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-stable review patch.  If anyone has any objections, please let us know.

------------------

[NETFILTER]: Fix deadlock in ip6_queue

Already fixed in ip_queue, ip6_queue was missed.

Signed-off-by: Patrick McHardy <kaber@trash.net>
Signed-off-by: Chris Wright <chrisw@osdl.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>
---
 net/ipv6/netfilter/ip6_queue.c |    2 ++
 1 files changed, 2 insertions(+)

--- linux-2.6.12.3.orig/net/ipv6/netfilter/ip6_queue.c	2005-07-28 11:17:01.000000000 -0700
+++ linux-2.6.12.3/net/ipv6/netfilter/ip6_queue.c	2005-07-28 11:17:13.000000000 -0700
@@ -76,7 +76,9 @@
 static void
 ipq_issue_verdict(struct ipq_queue_entry *entry, int verdict)
 {
+	local_bh_disable();
 	nf_reinject(entry->skb, entry->info, verdict);
+	local_bh_enable();
 	kfree(entry);
 }
 
