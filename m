Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161238AbWAHXVv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161238AbWAHXVv (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 8 Jan 2006 18:21:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161237AbWAHXVu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 8 Jan 2006 18:21:50 -0500
Received: from nessie.weebeastie.net ([220.233.7.36]:44303 "EHLO
	bunyip.lochness.weebeastie.net") by vger.kernel.org with ESMTP
	id S1161228AbWAHXVu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 8 Jan 2006 18:21:50 -0500
Date: Mon, 9 Jan 2006 10:22:17 +1100
From: CaT <cat@zip.com.au>
To: linux-kernel@vger.kernel.org
Cc: netdev@vger.kernel.org
Subject: network code assertion failed
Message-ID: <20060108232217.GQ18905@zip.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Organisation: Furball Inc.
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I've been looking through logfiles for strange things that may have
occoured whilst I was away and I spotted this:

UDP: bad checksum. From 68.56.220.203:19520 to x.x.x.x:33435 ulen 8
printk: 22 messages suppressed.
UDP: bad checksum. From 68.56.220.203:19520 to x.x.x.x:33438 ulen 8
KERNEL: assertion (!sk->sk_forward_alloc) failed at net/core/stream.c (279)
KERNEL: assertion (!sk->sk_forward_alloc) failed at net/ipv4/af_inet.c (148)
cdrom: open failed.
cdrom: open failed.
KERNEL: assertion (!sk->sk_forward_alloc) failed at net/core/stream.c (279)
KERNEL: assertion (!sk->sk_forward_alloc) failed at net/ipv4/af_inet.c (148)
TCP: Treason uncloaked! Peer 61.69.94.12:60121/80 shrinks window 146488137:146489597. Repaired.

Can't really give more info on it as the messages were not logged to
syslog and so I can't check out the timing and hence check for
strangeness elsewhere. I am wondering if it would've caused the
webserver to not be able to get a listen socket as it failed during the
break though.

Kernel is 2.6.14.3.

Network part of the .config is:

CONFIG_NET=y
CONFIG_NET_KEY=y
CONFIG_INET=y
CONFIG_INET_DIAG=y
CONFIG_INET_TCP_DIAG=y
CONFIG_NETFILTER=y
CONFIG_NET_CLS_ROUTE=y
CONFIG_NETDEVICES=y
CONFIG_IP_ADVANCED_ROUTER=y
CONFIG_ASK_IP_FIB_HASH=y
CONFIG_IP_FIB_HASH=y
CONFIG_IP_MULTIPLE_TABLES=y
CONFIG_IP_ROUTE_VERBOSE=y
CONFIG_IP_NF_QUEUE=y
CONFIG_IP_NF_IPTABLES=y
CONFIG_IP_NF_MATCH_LIMIT=y
CONFIG_IP_NF_MATCH_IPRANGE=y
CONFIG_IP_NF_MATCH_MAC=y
CONFIG_IP_NF_MATCH_PKTTYPE=y
CONFIG_IP_NF_MATCH_MARK=y
CONFIG_IP_NF_MATCH_MULTIPORT=y
CONFIG_IP_NF_MATCH_TOS=y
CONFIG_IP_NF_MATCH_RECENT=y
CONFIG_IP_NF_MATCH_ECN=y
CONFIG_IP_NF_MATCH_DSCP=y
CONFIG_IP_NF_MATCH_AH_ESP=y
CONFIG_IP_NF_MATCH_LENGTH=y
CONFIG_IP_NF_MATCH_TTL=y
CONFIG_IP_NF_MATCH_TCPMSS=y
CONFIG_IP_NF_MATCH_OWNER=y
CONFIG_IP_NF_MATCH_ADDRTYPE=y
CONFIG_IP_NF_MATCH_REALM=y
CONFIG_IP_NF_MATCH_SCTP=y
CONFIG_IP_NF_MATCH_DCCP=y
CONFIG_IP_NF_MATCH_COMMENT=y
CONFIG_IP_NF_MATCH_HASHLIMIT=y
CONFIG_IP_NF_MATCH_STRING=y
CONFIG_IP_NF_FILTER=y
CONFIG_IP_NF_TARGET_REJECT=y
CONFIG_IP_NF_TARGET_LOG=y
CONFIG_IP_NF_TARGET_ULOG=y
CONFIG_IP_NF_TARGET_TCPMSS=y
CONFIG_IP_NF_TARGET_NFQUEUE=y
CONFIG_IP_NF_MANGLE=y
CONFIG_IP_NF_TARGET_TOS=y
CONFIG_IP_NF_TARGET_ECN=y
CONFIG_IP_NF_TARGET_DSCP=y
CONFIG_IP_NF_TARGET_MARK=y
CONFIG_IP_NF_TARGET_CLASSIFY=y
CONFIG_IP_NF_TARGET_TTL=y
CONFIG_IP_NF_RAW=y
CONFIG_IP_NF_ARPTABLES=y
CONFIG_IP_NF_ARPFILTER=y
CONFIG_IP_NF_ARP_MANGLE=y

There are two routing tables (created with 'ip rule add') for two interfaces
also. Both interfaces are e1000s.

-- 
    "To the extent that we overreact, we proffer the terrorists the
    greatest tribute."
    	- High Court Judge Michael Kirby
