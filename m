Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750741AbWANSNH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750741AbWANSNH (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 14 Jan 2006 13:13:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750747AbWANSNH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 14 Jan 2006 13:13:07 -0500
Received: from pilet.ens-lyon.fr ([140.77.167.16]:18347 "EHLO
	pilet.ens-lyon.fr") by vger.kernel.org with ESMTP id S1750741AbWANSNG
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 14 Jan 2006 13:13:06 -0500
Date: Sat, 14 Jan 2006 19:09:17 +0100
From: Benoit Boissinot <benoit.boissinot@ens-lyon.org>
To: Andrew Morton <akpm@osdl.org>
Cc: Harald Welte <laforge@netfilter.org>, linux-kernel@vger.kernel.org
Subject: [patch 2.6.15-mm4] fix warning in ip{,6}t_policy.c
Message-ID: <20060114180917.GA26443@ens-lyon.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

the following warnings appeared in -mm4
net/ipv4/netfilter/ipt_policy.c:154: warning: initialization from incompatible pointer type
net/ipv4/netfilter/ipt_policy.c:155: warning: initialization from incompatible pointer type
net/ipv6/netfilter/ip6t_policy.c:160: warning: initialization from incompatible pointer type

It looks like they were missed in the x_tables conversion.

Signed-off-by: Benoit Boissinot <benoit.boissinot@ens-lyon.org>

--- a/net/ipv4/netfilter/ipt_policy.c	2006-01-14 16:11:52.000000000 +0100
+++ b/net/ipv4/netfilter/ipt_policy.c	2006-01-14 18:55:26.000000000 +0100
@@ -95,7 +95,10 @@
 static int match(const struct sk_buff *skb,
                  const struct net_device *in,
                  const struct net_device *out,
-                 const void *matchinfo, int offset, int *hotdrop)
+                 const void *matchinfo,
+                 int offset,
+                 unsigned int protoff,
+                 int *hotdrop)
 {
 	const struct ipt_policy_info *info = matchinfo;
 	int ret;
@@ -113,7 +116,7 @@
 	return ret;
 }
 
-static int checkentry(const char *tablename, const struct ipt_ip *ip,
+static int checkentry(const char *tablename, const void *ip_void,
                       void *matchinfo, unsigned int matchsize,
                       unsigned int hook_mask)
 {
--- a/net/ipv6/netfilter/ip6t_policy.c	2006-01-14 16:11:52.000000000 +0100
+++ b/net/ipv6/netfilter/ip6t_policy.c	2006-01-14 18:52:58.000000000 +0100
@@ -118,7 +118,7 @@
 	return ret;
 }
 
-static int checkentry(const char *tablename, const struct ip6t_ip6 *ip,
+static int checkentry(const char *tablename, const void *ip_void,
                       void *matchinfo, unsigned int matchsize,
                       unsigned int hook_mask)
 {
