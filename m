Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751018AbWFAPCD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751018AbWFAPCD (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Jun 2006 11:02:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751054AbWFAPCD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Jun 2006 11:02:03 -0400
Received: from stinky.trash.net ([213.144.137.162]:11249 "EHLO
	stinky.trash.net") by vger.kernel.org with ESMTP id S1751044AbWFAPCC
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Jun 2006 11:02:02 -0400
Message-ID: <447F0156.8020603@trash.net>
Date: Thu, 01 Jun 2006 17:01:42 +0200
From: Patrick McHardy <kaber@trash.net>
User-Agent: Debian Thunderbird 1.0.7 (X11/20051017)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: lepton <ytht.net@gmail.com>
CC: lkm <linux-kernel@vger.kernel.org>,
       Netfilter Development Mailinglist 
	<netfilter-devel@lists.netfilter.org>
Subject: Re: [PATCH] 2.6.16.19 Fix the bug of "return 0 instead of the error
 code in ipt_register_table"
References: <20060601102449.GA8572@gsy2.lepton.home>
In-Reply-To: <20060601102449.GA8572@gsy2.lepton.home>
X-Enigmail-Version: 0.93.0.0
Content-Type: multipart/mixed;
 boundary="------------030705040603010200050504"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------030705040603010200050504
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit

lepton wrote:
> Hi,
> 
> There is a bug in ipt_register_table() in
> net/ipv4/netfilter/ip_tables.c:
> 
> ipt_register_table() will return 0 instead of
> the error code when xt_register_table() fails
> 
> Signed-off-by: Lepton Wu <ytht.net@gmail.com>
> 
> diff -prU 10 linux-2.6.16.19.oirg/net/ipv4/netfilter/ip_tables.c linux-2.6.16.19/net/ipv4/netfilter/ip_tables.c
> --- linux-2.6.16.19.oirg/net/ipv4/netfilter/ip_tables.c	2006-05-31 08:31:44.000000000 +0800
> +++ linux-2.6.16.19/net/ipv4/netfilter/ip_tables.c	2006-06-01 18:11:25.000000000 +0800

Thanks. As usual this bug has been happily copy and pasted around,
so I've added this patch instead.


--------------030705040603010200050504
Content-Type: text/plain;
 name="x"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="x"

[NETFILTER]: x_tables: fix xt_register_table error propagation

When xt_register_table fails the error is not properly propagated back.
Based on patch by Lepton Wu <ytht.net@gmail.com>.

Signed-off-by: Patrick McHardy <kaber@trash.net>

---
commit b010cc3184ce7cb65a9865ae52ec2ce6f3fe4c9d
tree 9744395bcd9c7d976048ebd8afbabfc0a9b542a4
parent 10263005af5814396b8263c1c2a4367d49548e13
author Patrick McHardy <kaber@trash.net> Thu, 01 Jun 2006 16:59:12 +0200
committer Patrick McHardy <kaber@trash.net> Thu, 01 Jun 2006 16:59:12 +0200

 net/ipv4/netfilter/arp_tables.c |    3 ++-
 net/ipv4/netfilter/ip_tables.c  |    3 ++-
 net/ipv6/netfilter/ip6_tables.c |    3 ++-
 3 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/net/ipv4/netfilter/arp_tables.c b/net/ipv4/netfilter/arp_tables.c
index d0d1919..ad39bf6 100644
--- a/net/ipv4/netfilter/arp_tables.c
+++ b/net/ipv4/netfilter/arp_tables.c
@@ -1120,7 +1120,8 @@ int arpt_register_table(struct arpt_tabl
 		return ret;
 	}
 
-	if (xt_register_table(table, &bootstrap, newinfo) != 0) {
+	ret = xt_register_table(table, &bootstrap, newinfo);
+	if (ret != 0) {
 		xt_free_table_info(newinfo);
 		return ret;
 	}
diff --git a/net/ipv4/netfilter/ip_tables.c b/net/ipv4/netfilter/ip_tables.c
index cee3397..101ad98 100644
--- a/net/ipv4/netfilter/ip_tables.c
+++ b/net/ipv4/netfilter/ip_tables.c
@@ -2113,7 +2113,8 @@ int ipt_register_table(struct xt_table *
 		return ret;
 	}
 
-	if (xt_register_table(table, &bootstrap, newinfo) != 0) {
+	ret = xt_register_table(table, &bootstrap, newinfo);
+	if (ret != 0) {
 		xt_free_table_info(newinfo);
 		return ret;
 	}
diff --git a/net/ipv6/netfilter/ip6_tables.c b/net/ipv6/netfilter/ip6_tables.c
index 2e72f89..0b5bd55 100644
--- a/net/ipv6/netfilter/ip6_tables.c
+++ b/net/ipv6/netfilter/ip6_tables.c
@@ -1281,7 +1281,8 @@ int ip6t_register_table(struct xt_table 
 		return ret;
 	}
 
-	if (xt_register_table(table, &bootstrap, newinfo) != 0) {
+	ret = xt_register_table(table, &bootstrap, newinfo);
+	if (ret != 0) {
 		xt_free_table_info(newinfo);
 		return ret;
 	}

--------------030705040603010200050504--
