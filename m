Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261232AbUKNBiO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261232AbUKNBiO (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 13 Nov 2004 20:38:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261233AbUKNBiO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 13 Nov 2004 20:38:14 -0500
Received: from hera.cwi.nl ([192.16.191.8]:50660 "EHLO hera.cwi.nl")
	by vger.kernel.org with ESMTP id S261232AbUKNBiK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 13 Nov 2004 20:38:10 -0500
Date: Sun, 14 Nov 2004 02:37:30 +0100
From: Andries Brouwer <Andries.Brouwer@cwi.nl>
To: torvalds@osdl.org, akpm@osdl.org
Cc: linux-kernel@vger.kernel.org, coreteam@netfilter.org
Subject: [PATCH] no __initdata in netfilter?
Message-ID: <20041114013724.GA21219@apps.cwi.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Stuff marked initdata that is referenced in non-init context.

diff -uprN -X /linux/dontdiff a/net/ipv4/netfilter/ip_nat_rule.c b/net/ipv4/netfilter/ip_nat_rule.c
--- a/net/ipv4/netfilter/ip_nat_rule.c	2004-10-30 21:44:11.000000000 +0200
+++ b/net/ipv4/netfilter/ip_nat_rule.c	2004-11-13 22:40:51.000000000 +0100
@@ -59,8 +59,8 @@ static struct
 	struct ipt_replace repl;
 	struct ipt_standard entries[3];
 	struct ipt_error term;
-} nat_initial_table __initdata
-= { { "nat", NAT_VALID_HOOKS, 4,
+} nat_initial_table = {
+    { "nat", NAT_VALID_HOOKS, 4,
       sizeof(struct ipt_standard) * 3 + sizeof(struct ipt_error),
       { [NF_IP_PRE_ROUTING] = 0,
 	[NF_IP_POST_ROUTING] = sizeof(struct ipt_standard),
diff -uprN -X /linux/dontdiff a/net/ipv4/netfilter/iptable_filter.c b/net/ipv4/netfilter/iptable_filter.c
--- a/net/ipv4/netfilter/iptable_filter.c	2004-10-30 21:44:11.000000000 +0200
+++ b/net/ipv4/netfilter/iptable_filter.c	2004-11-13 22:40:51.000000000 +0100
@@ -44,8 +44,8 @@ static struct
 	struct ipt_replace repl;
 	struct ipt_standard entries[3];
 	struct ipt_error term;
-} initial_table __initdata
-= { { "filter", FILTER_VALID_HOOKS, 4,
+} initial_table = {
+    { "filter", FILTER_VALID_HOOKS, 4,
       sizeof(struct ipt_standard) * 3 + sizeof(struct ipt_error),
       { [NF_IP_LOCAL_IN] = 0,
 	[NF_IP_FORWARD] = sizeof(struct ipt_standard),
