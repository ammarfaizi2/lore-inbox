Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422794AbWA1CTL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422794AbWA1CTL (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Jan 2006 21:19:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422799AbWA1CTL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Jan 2006 21:19:11 -0500
Received: from mail.kroah.org ([69.55.234.183]:61112 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S1422794AbWA1CTJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Jan 2006 21:19:09 -0500
Date: Fri, 27 Jan 2006 18:18:17 -0800
From: Greg KH <gregkh@suse.de>
To: linux-kernel@vger.kernel.org, stable@kernel.org
Cc: Justin Forbes <jmforbes@linuxtx.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       "Theodore Ts'o" <tytso@mit.edu>, Randy Dunlap <rdunlap@xenotime.net>,
       Dave Jones <davej@redhat.com>, Chuck Wolber <chuckw@quantumlinux.com>,
       torvalds@osdl.org, akpm@osdl.org, alan@lxorguk.ukuu.org.uk,
       davem@davemloft.net, bdschuym@pandora.be
Subject: [patch 2/6] [EBTABLES] Don't match tcp/udp source/destination port for IP fragments
Message-ID: <20060128021817.GC10362@kroah.com>
References: <20060128015840.722214000@press.kroah.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline; filename="fix-bridge-netfilter-matching-ip-fragments.patch"
In-Reply-To: <20060128021749.GA10362@kroah.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-stable review patch.  If anyone has any objections, please let us know.

------------------
From: Bart De Schuymer <bdschuym@pandora.be>

Signed-off-by: Bart De Schuymer <bdschuym@pandora.be>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Chris Wright <chrisw@sous-sol.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>
---
 net/bridge/netfilter/ebt_ip.c |    3 +++
 1 file changed, 3 insertions(+)

--- linux-2.6.14.6.orig/net/bridge/netfilter/ebt_ip.c
+++ linux-2.6.14.6/net/bridge/netfilter/ebt_ip.c
@@ -15,6 +15,7 @@
 #include <linux/netfilter_bridge/ebtables.h>
 #include <linux/netfilter_bridge/ebt_ip.h>
 #include <linux/ip.h>
+#include <net/ip.h>
 #include <linux/in.h>
 #include <linux/module.h>
 
@@ -51,6 +52,8 @@ static int ebt_filter_ip(const struct sk
 		if (!(info->bitmask & EBT_IP_DPORT) &&
 		    !(info->bitmask & EBT_IP_SPORT))
 			return EBT_MATCH;
+		if (ntohs(ih->frag_off) & IP_OFFSET)
+			return EBT_NOMATCH;
 		pptr = skb_header_pointer(skb, ih->ihl*4,
 					  sizeof(_ports), &_ports);
 		if (pptr == NULL)

--
