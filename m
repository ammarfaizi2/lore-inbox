Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312138AbSCQXzY>; Sun, 17 Mar 2002 18:55:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312140AbSCQXzG>; Sun, 17 Mar 2002 18:55:06 -0500
Received: from proj2501.aiss.uic.edu ([131.193.164.90]:56844 "EHLO
	proj2501.aiss.uic.edu") by vger.kernel.org with ESMTP
	id <S312138AbSCQXyy>; Sun, 17 Mar 2002 18:54:54 -0500
Date: Sun, 17 Mar 2002 18:02:18 -0600 (CST)
From: "Barton, Christopher" <cpbarton@uiuc.edu>
X-X-Sender: cpbarton@proj2501.aiss.uic.edu
To: Miles Lane <miles@megapathdsl.net>
cc: LKML <linux-kernel@vger.kernel.org>, <davem@ninka.net>,
        <laforge@gnumonks.org>
Subject: Re: 2.5.7-pre2 -- ip_conntrack_standalone.c:41: In function
 `kill_proto': structure has no member named `dst'
In-Reply-To: <1016262729.6501.305.camel@turbulence.megapathdsl.net>
Message-ID: <Pine.LNX.4.44.0203171733170.31233-100000@proj2501.aiss.uic.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This seems to have been broken here:

http://linux.bkbits.net:8080/linux-2.5/diffs/net/ipv4/netfilter/ip_conntrack_standalone.c@1.6?nav=index.html|src/|src/net|src/net/ipv4|src/net/ipv4/netfilter|related/net/ipv4/netfilter/ip_conntrack_standalone.c|cset@1.384.4.14

You might try this patch:

diff -ur linux/net/ipv4/netfilter/ip_conntrack_standalone.c linux-2.5.7-pre2/net/ipv4/netfilter/ip_conntrack_standalone.c
--- linux/net/ipv4/netfilter/ip_conntrack_standalone.c	Sun Mar 17 17:30:09 2002
+++ linux-2.5.7-pre2/net/ipv4/netfilter/ip_conntrack_standalone.c	Sun Mar 17 17:24:03 2002
@@ -38,7 +38,7 @@
 
 static int kill_proto(const struct ip_conntrack *i, void *data)
 {
-	return (i->tuplehash[IP_CT_DIR_ORIGINAL].dst.protonum == 
+	return (i->tuplehash[IP_CT_DIR_ORIGINAL].tuple.dst.protonum == 
 			*((u_int8_t *) data));
 }
 

On 15 Mar 2002, Miles Lane wrote:

> ip_conntrack_standalone.c: In function `kill_proto':
> ip_conntrack_standalone.c:41: structure has no member named `dst'
> ip_conntrack_standalone.c:43: warning: control reaches end of non-void
> function
> make[3]: *** [ip_conntrack_standalone.o] Error 1
> make[3]: Leaving directory `/usr/src/linux/net/ipv4/netfilter'
> 
> CONFIG_PACKET=y
> CONFIG_NETLINK_DEV=y
> CONFIG_NETFILTER=y
> CONFIG_NETFILTER_DEBUG=y
> CONFIG_FILTER=y
> CONFIG_UNIX=y
> CONFIG_INET=y
> CONFIG_IP_MULTICAST=y
> CONFIG_IP_ADVANCED_ROUTER=y
> CONFIG_IP_ROUTE_VERBOSE=y
> CONFIG_NET_IPIP=y
> CONFIG_NET_IPGRE=y
> CONFIG_NET_IPGRE_BROADCAST=y
> CONFIG_IP_MROUTE=y
> CONFIG_IP_PIMSM_V1=y
> CONFIG_IP_PIMSM_V2=y
> CONFIG_SYN_COOKIES=y
> 
> #
> #   IP: Netfilter Configuration
> #
> CONFIG_IP_NF_CONNTRACK=y
> CONFIG_IP_NF_FTP=y
> CONFIG_IP_NF_IRC=y
> CONFIG_IP_NF_QUEUE=y
> CONFIG_IP_NF_IPTABLES=y
> CONFIG_IP_NF_MATCH_LIMIT=y
> CONFIG_IP_NF_FILTER=y
> CONFIG_IP_NF_TARGET_REJECT=y
> CONFIG_IP_NF_TARGET_MIRROR=y
> CONFIG_IP_NF_ARPTABLES=y
> CONFIG_IP_NF_ARPFILTER=y
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 




