Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161121AbVLWWyx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161121AbVLWWyx (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Dec 2005 17:54:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161102AbVLWWyN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Dec 2005 17:54:13 -0500
Received: from mail.kroah.org ([69.55.234.183]:47055 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S1161100AbVLWWtY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Dec 2005 17:49:24 -0500
Date: Fri, 23 Dec 2005 14:47:46 -0800
From: Greg Kroah-Hartman <gregkh@suse.de>
To: linux-kernel@vger.kernel.org, stable@kernel.org
Cc: Justin Forbes <jmforbes@linuxtx.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       "Theodore Ts'o" <tytso@mit.edu>, Randy Dunlap <rdunlap@xenotime.net>,
       Dave Jones <davej@redhat.com>, Chuck Wolber <chuckw@quantumlinux.com>,
       torvalds@osdl.org, akpm@osdl.org, alan@lxorguk.ukuu.org.uk,
       Harald Welte <laforge@netfilter.org>,
       Netfilter Development Mailinglist 
	<netfilter-devel@lists.netfilter.org>,
       Pablo Neira Ayuso <pablo@eurodev.net>, kaber@trash.net, ole@ans.pl
Subject: [patch 03/19] [NETFILTER]: Fix CTA_PROTO_NUM attribute size in ctnetlink
Message-ID: <20051223224746.GC19057@kroah.com>
References: <20051223221200.342826000@press.kroah.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline; filename="fix-cta_proto_num-attribute-size-in-ctnetlink.patch"
In-Reply-To: <20051223224712.GA18975@kroah.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-stable review patch.  If anyone has any objections, please let us know.

------------------
From: Krzysztof Oledzki <olenf@ans.pl>

CTA_PROTO_NUM is a u_int8_t.

Based on oryginal patch by Patrick McHardy <kaber@trash.net>

Signed-off-by: Krzysztof Piotr Oledzki <ole@ans.pl>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

---
 net/ipv4/netfilter/ip_conntrack_netlink.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- linux-2.6.14.4.orig/net/ipv4/netfilter/ip_conntrack_netlink.c
+++ linux-2.6.14.4/net/ipv4/netfilter/ip_conntrack_netlink.c
@@ -506,7 +506,7 @@ nfattr_failure:
 }
 
 static const int cta_min_proto[CTA_PROTO_MAX] = {
-	[CTA_PROTO_NUM-1]	= sizeof(u_int16_t),
+	[CTA_PROTO_NUM-1]	= sizeof(u_int8_t),
 	[CTA_PROTO_SRC_PORT-1]	= sizeof(u_int16_t),
 	[CTA_PROTO_DST_PORT-1]	= sizeof(u_int16_t),
 	[CTA_PROTO_ICMP_TYPE-1]	= sizeof(u_int8_t),
@@ -532,7 +532,7 @@ ctnetlink_parse_tuple_proto(struct nfatt
 
 	if (!tb[CTA_PROTO_NUM-1])
 		return -EINVAL;
-	tuple->dst.protonum = *(u_int16_t *)NFA_DATA(tb[CTA_PROTO_NUM-1]);
+	tuple->dst.protonum = *(u_int8_t *)NFA_DATA(tb[CTA_PROTO_NUM-1]);
 
 	proto = ip_conntrack_proto_find_get(tuple->dst.protonum);
 

--
