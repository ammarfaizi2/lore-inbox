Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264566AbUAAUmL (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Jan 2004 15:42:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265435AbUAAUjE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Jan 2004 15:39:04 -0500
Received: from iron-c-1.tiscali.it ([212.123.84.81]:19796 "EHLO
	mailr-1.tiscali.it") by vger.kernel.org with ESMTP id S264566AbUAAUhr
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Jan 2004 15:37:47 -0500
X-BrightmailFiltered: true
Date: Thu, 1 Jan 2004 21:37:43 +0100
From: Kronos <kronos@kronoz.cjb.net>
To: linux-net@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Subject: [2.6.0] ip_local_deliver: bad loopback skb: PRE_ROUTING LOCAL_IN
Message-ID: <20040101203743.GA8934@dreamland.darkstar.lan>
Reply-To: kronos@kronoz.cjb.net
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
I saw the following messages in my logs:

ip_local_deliver: bad loopback skb: PRE_ROUTING LOCAL_IN
skb: pf=2 (unowned) dev=lo len=16436
PROTO=6 10.0.0.1:3128 10.0.0.1:36227 L=16436 S=0x00 I=20054 F=0x4000 T=64
ip_local_deliver: bad loopback skb: PRE_ROUTING LOCAL_IN
skb: pf=2 (unowned) dev=lo len=4148
PROTO=6 10.0.0.1:3128 10.0.0.1:36227 L=4148 S=0x00 I=20055 F=0x4000 T=64
ip_local_deliver: bad loopback skb: PRE_ROUTING LOCAL_IN
skb: pf=2 (unowned) dev=lo len=16436
PROTO=6 10.0.0.1:3128 10.0.0.1:36234 L=16436 S=0x00 I=30461 F=0x4000 T=64
ip_local_deliver: bad loopback skb: PRE_ROUTING LOCAL_IN
skb: pf=2 (unowned) dev=lo len=4148
PROTO=6 10.0.0.1:3128 10.0.0.1:36234 L=4148 S=0x00 I=30462 F=0x4000 T=64
ip_local_deliver: bad loopback skb: PRE_ROUTING LOCAL_IN
skb: pf=2 (unowned) dev=lo len=16436
PROTO=6 10.0.0.1:3128 10.0.0.1:36228 L=16436 S=0x00 I=28891 F=0x4000 T=64
ip_local_deliver: bad loopback skb: PRE_ROUTING LOCAL_IN
skb: pf=2 (unowned) dev=lo len=4148
PROTO=6 10.0.0.1:3128 10.0.0.1:36228 L=4148 S=0x00 I=28892 F=0x4000 T=64
ip_local_deliver: bad loopback skb: PRE_ROUTING LOCAL_IN
skb: pf=2 (unowned) dev=lo len=16436
PROTO=6 10.0.0.1:3128 10.0.0.1:36228 L=16436 S=0x00 I=28896 F=0x4000 T=64
ip_local_deliver: bad loopback skb: PRE_ROUTING LOCAL_IN
skb: pf=2 (unowned) dev=lo len=5502
PROTO=6 10.0.0.1:3128 10.0.0.1:36228 L=5502 S=0x00 I=28897 F=0x4000 T=64

10.0.0.1 is my eth0 card, connected to my hub. It's an Intel 82557 card with
e100 driver. On port 3128 there is squid. Kernel is 2.6.0.

The messages come from netfilter.c, but netfilter is build as module and
wasn't loaded. Any idea of what went wrong?

This is the relevant part .config:

#
# Networking support
#
CONFIG_NET=y

#
# Networking options
#
CONFIG_PACKET=y
CONFIG_PACKET_MMAP=y
CONFIG_NETLINK_DEV=m
CONFIG_UNIX=y
CONFIG_NET_KEY=m
CONFIG_INET=y
CONFIG_IP_MULTICAST=y
CONFIG_IP_ADVANCED_ROUTER=y
CONFIG_IP_MULTIPLE_TABLES=y
# CONFIG_IP_ROUTE_FWMARK is not set
CONFIG_IP_ROUTE_NAT=y
CONFIG_IP_ROUTE_MULTIPATH=y
# CONFIG_IP_ROUTE_TOS is not set
# CONFIG_IP_ROUTE_VERBOSE is not set
# CONFIG_IP_PNP is not set
CONFIG_NET_IPIP=m
CONFIG_NET_IPGRE=m
# CONFIG_NET_IPGRE_BROADCAST is not set
# CONFIG_IP_MROUTE is not set
# CONFIG_ARPD is not set
CONFIG_INET_ECN=y
CONFIG_SYN_COOKIES=y
# CONFIG_INET_AH is not set
# CONFIG_INET_ESP is not set
# CONFIG_INET_IPCOMP is not set

#
# IP: Virtual Server Configuration
#
# CONFIG_IP_VS is not set
CONFIG_IPV6=m
# CONFIG_IPV6_PRIVACY is not set
# CONFIG_INET6_AH is not set
# CONFIG_INET6_ESP is not set
CONFIG_INET6_IPCOMP=m
# CONFIG_IPV6_TUNNEL is not set
# CONFIG_DECNET is not set
# CONFIG_BRIDGE is not set
CONFIG_NETFILTER=y
CONFIG_NETFILTER_DEBUG=y

#
# IP: Netfilter Configuration
#
CONFIG_IP_NF_CONNTRACK=m
CONFIG_IP_NF_FTP=m
CONFIG_IP_NF_IRC=m
CONFIG_IP_NF_TFTP=m
CONFIG_IP_NF_AMANDA=m
CONFIG_IP_NF_QUEUE=m
CONFIG_IP_NF_IPTABLES=m
CONFIG_IP_NF_MATCH_LIMIT=m
CONFIG_IP_NF_MATCH_IPRANGE=m
CONFIG_IP_NF_MATCH_MAC=m
CONFIG_IP_NF_MATCH_PKTTYPE=m
CONFIG_IP_NF_MATCH_MARK=m
CONFIG_IP_NF_MATCH_MULTIPORT=m
CONFIG_IP_NF_MATCH_TOS=m
CONFIG_IP_NF_MATCH_RECENT=m
CONFIG_IP_NF_MATCH_ECN=m
CONFIG_IP_NF_MATCH_DSCP=m
CONFIG_IP_NF_MATCH_AH_ESP=m
CONFIG_IP_NF_MATCH_LENGTH=m
CONFIG_IP_NF_MATCH_TTL=m
CONFIG_IP_NF_MATCH_TCPMSS=m
CONFIG_IP_NF_MATCH_HELPER=m
CONFIG_IP_NF_MATCH_STATE=m
CONFIG_IP_NF_MATCH_CONNTRACK=m
CONFIG_IP_NF_MATCH_OWNER=m
CONFIG_IP_NF_FILTER=m
CONFIG_IP_NF_TARGET_REJECT=m
CONFIG_IP_NF_NAT=m
CONFIG_IP_NF_NAT_NEEDED=y
CONFIG_IP_NF_TARGET_MASQUERADE=m
CONFIG_IP_NF_TARGET_REDIRECT=m
CONFIG_IP_NF_TARGET_NETMAP=m
CONFIG_IP_NF_TARGET_SAME=m
CONFIG_IP_NF_NAT_LOCAL=y
CONFIG_IP_NF_NAT_SNMP_BASIC=m
CONFIG_IP_NF_NAT_IRC=m
CONFIG_IP_NF_NAT_FTP=m
CONFIG_IP_NF_NAT_TFTP=m
CONFIG_IP_NF_NAT_AMANDA=m
CONFIG_IP_NF_MANGLE=m
CONFIG_IP_NF_TARGET_TOS=m
CONFIG_IP_NF_TARGET_ECN=m
CONFIG_IP_NF_TARGET_DSCP=m
CONFIG_IP_NF_TARGET_MARK=m
CONFIG_IP_NF_TARGET_CLASSIFY=m
CONFIG_IP_NF_TARGET_LOG=m
CONFIG_IP_NF_TARGET_ULOG=m
CONFIG_IP_NF_TARGET_TCPMSS=m
CONFIG_IP_NF_ARPTABLES=m
CONFIG_IP_NF_ARPFILTER=m
CONFIG_IP_NF_ARP_MANGLE=m
# CONFIG_IP_NF_COMPAT_IPCHAINS is not set
# CONFIG_IP_NF_COMPAT_IPFWADM is not set

Luca
-- 
Reply-To: kronos@kronoz.cjb.net
Home: http://kronoz.cjb.net
#include <stdio.h> 
int main(void) {printf("\t\t\b\b\b\b\b\b");
printf("\t\t\b\b\b\b\b\b");return 0;}
