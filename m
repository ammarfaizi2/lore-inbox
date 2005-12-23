Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161099AbVLWWzz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161099AbVLWWzz (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Dec 2005 17:55:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161103AbVLWWyH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Dec 2005 17:54:07 -0500
Received: from mail.kroah.org ([69.55.234.183]:51151 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S1161101AbVLWWt0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Dec 2005 17:49:26 -0500
Date: Fri, 23 Dec 2005 14:48:11 -0800
From: Greg Kroah-Hartman <gregkh@suse.de>
To: linux-kernel@vger.kernel.org, stable@kernel.org
Cc: Justin Forbes <jmforbes@linuxtx.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       "Theodore Ts'o" <tytso@mit.edu>, Randy Dunlap <rdunlap@xenotime.net>,
       Dave Jones <davej@redhat.com>, Chuck Wolber <chuckw@quantumlinux.com>,
       torvalds@osdl.org, akpm@osdl.org, alan@lxorguk.ukuu.org.uk,
       davem@davemloft.net, kaber@trash.net
Subject: [patch 09/19] [NETFILTER]: Fix NAT init order
Message-ID: <20051223224811.GI19057@kroah.com>
References: <20051223221200.342826000@press.kroah.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline; filename="fix-nat-init-order.patch"
In-Reply-To: <20051223224712.GA18975@kroah.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-stable review patch.  If anyone has any objections, please let us know.

------------------
From: Patrick McHardy <kaber@trash.net>

As noticed by Phil Oester, the GRE NAT protocol helper is initialized
before the NAT core, which makes registration fail.

Change the linking order to make NAT be initialized first.

Signed-off-by: Patrick McHardy <kaber@trash.net>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Chris Wright <chrisw@redhat.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>
---
 net/ipv4/netfilter/Makefile |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

--- linux-2.6.14.4.orig/net/ipv4/netfilter/Makefile
+++ linux-2.6.14.4/net/ipv4/netfilter/Makefile
@@ -12,6 +12,7 @@ ip_nat_pptp-objs	:= ip_nat_helper_pptp.o
 
 # connection tracking
 obj-$(CONFIG_IP_NF_CONNTRACK) += ip_conntrack.o
+obj-$(CONFIG_IP_NF_NAT) += ip_nat.o
 
 # conntrack netlink interface
 obj-$(CONFIG_IP_NF_CONNTRACK_NETLINK) += ip_conntrack_netlink.o
@@ -41,7 +42,7 @@ obj-$(CONFIG_IP_NF_IPTABLES) += ip_table
 # the three instances of ip_tables
 obj-$(CONFIG_IP_NF_FILTER) += iptable_filter.o
 obj-$(CONFIG_IP_NF_MANGLE) += iptable_mangle.o
-obj-$(CONFIG_IP_NF_NAT) += iptable_nat.o ip_nat.o
+obj-$(CONFIG_IP_NF_NAT) += iptable_nat.o
 obj-$(CONFIG_IP_NF_RAW) += iptable_raw.o
 
 # matches

--
