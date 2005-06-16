Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261540AbVFPLB6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261540AbVFPLB6 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Jun 2005 07:01:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261562AbVFPLB6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Jun 2005 07:01:58 -0400
Received: from bonifac.e98.hu ([195.70.36.120]:11748 "HELO bonifac.e98.hu")
	by vger.kernel.org with SMTP id S261540AbVFPLB4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Jun 2005 07:01:56 -0400
Date: Thu, 16 Jun 2005 13:01:55 +0200
From: "SZALONTAI, Zoltan" <szazol@e98.hu>
To: Juergen Kreileder <jk@blackdown.de>
Cc: Andrew Morton <akpm@osdl.org>, Stephen Frost <sfrost@snowman.net>,
       netfilter-devel@lists.netfilter.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ipt_recent fixes
Message-ID: <20050616110155.GA9669@bonifac.e98.hu>
Mail-Followup-To: "SZALONTAI, Zoltan" <szazol>,
	Juergen Kreileder <jk@blackdown.de>, Andrew Morton <akpm@osdl.org>,
	Stephen Frost <sfrost@snowman.net>,
	netfilter-devel@lists.netfilter.org, linux-kernel@vger.kernel.org
References: <87ll6o1pbi.fsf@blackdown.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87ll6o1pbi.fsf@blackdown.de>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 09, 2005 at 03:50:09PM +0200, Juergen Kreileder wrote:
> 
> This patch fixes the problem by using get_seconds() instead of
> jiffies.  It also fixes some 64-bit issues.

I dont know this is correct, please review.

 Zoli


time_temp is used to store and reassign time_info.time which is unsigned long.

diff -u net/ipv4/netfilter/ipt_recent.c.orig net/ipv4/netfilter/ipt_recent.c
--- net/ipv4/netfilter/ipt_recent.c.orig	2005-06-12 22:18:41.000000000 +0200
+++ net/ipv4/netfilter/ipt_recent.c	2005-06-16 10:08:25.000000000 +0200
@@ -361,9 +361,9 @@
       int *hotdrop)
 {
 	int pkt_count, hits_found, ans;
-	unsigned long now;
+	unsigned long now, time_temp;
 	const struct ipt_recent_info *info = matchinfo;
-	u_int32_t addr = 0, time_temp;
+	u_int32_t addr = 0;
 	u_int8_t ttl = skb->nh.iph->ttl;
 	int *hash_table;
 	int orig_hash_result, hash_result, temp, location = 0, time_loc, end_collision_chain = -1;
