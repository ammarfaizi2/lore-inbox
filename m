Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261257AbUKNH4m@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261257AbUKNH4m (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 14 Nov 2004 02:56:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261258AbUKNH4m
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 14 Nov 2004 02:56:42 -0500
Received: from [62.206.217.67] ([62.206.217.67]:56222 "EHLO kaber.coreworks.de")
	by vger.kernel.org with ESMTP id S261257AbUKNH4k (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 14 Nov 2004 02:56:40 -0500
Message-ID: <41970FAD.6010501@trash.net>
Date: Sun, 14 Nov 2004 08:56:29 +0100
From: Patrick McHardy <kaber@trash.net>
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.7.3) Gecko/20041008 Debian/1.7.3-5
X-Accept-Language: en
MIME-Version: 1.0
To: Andries Brouwer <Andries.Brouwer@cwi.nl>
CC: torvalds@osdl.org, akpm@osdl.org, coreteam@netfilter.org,
       linux-kernel@vger.kernel.org
Subject: Re: [netfilter-core] [PATCH] no __initdata in netfilter?
References: <20041114013724.GA21219@apps.cwi.nl>
In-Reply-To: <20041114013724.GA21219@apps.cwi.nl>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andries Brouwer wrote:

>Stuff marked initdata that is referenced in non-init context.
>
Where ? The initial tables are replaced by ipt_register_table.

Regards
Patrick

>diff -uprN -X /linux/dontdiff a/net/ipv4/netfilter/ip_nat_rule.c b/net/ipv4/netfilter/ip_nat_rule.c
>--- a/net/ipv4/netfilter/ip_nat_rule.c	2004-10-30 21:44:11.000000000 +0200
>+++ b/net/ipv4/netfilter/ip_nat_rule.c	2004-11-13 22:40:51.000000000 +0100
>@@ -59,8 +59,8 @@ static struct
> 	struct ipt_replace repl;
> 	struct ipt_standard entries[3];
> 	struct ipt_error term;
>-} nat_initial_table __initdata
>-= { { "nat", NAT_VALID_HOOKS, 4,
>+} nat_initial_table = {
>+    { "nat", NAT_VALID_HOOKS, 4,
>       sizeof(struct ipt_standard) * 3 + sizeof(struct ipt_error),
>       { [NF_IP_PRE_ROUTING] = 0,
> 	[NF_IP_POST_ROUTING] = sizeof(struct ipt_standard),
>diff -uprN -X /linux/dontdiff a/net/ipv4/netfilter/iptable_filter.c b/net/ipv4/netfilter/iptable_filter.c
>--- a/net/ipv4/netfilter/iptable_filter.c	2004-10-30 21:44:11.000000000 +0200
>+++ b/net/ipv4/netfilter/iptable_filter.c	2004-11-13 22:40:51.000000000 +0100
>@@ -44,8 +44,8 @@ static struct
> 	struct ipt_replace repl;
> 	struct ipt_standard entries[3];
> 	struct ipt_error term;
>-} initial_table __initdata
>-= { { "filter", FILTER_VALID_HOOKS, 4,
>+} initial_table = {
>+    { "filter", FILTER_VALID_HOOKS, 4,
>       sizeof(struct ipt_standard) * 3 + sizeof(struct ipt_error),
>       { [NF_IP_LOCAL_IN] = 0,
> 	[NF_IP_FORWARD] = sizeof(struct ipt_standard),
>
>  
>

