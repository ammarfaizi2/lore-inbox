Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267433AbUHXK23@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267433AbUHXK23 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Aug 2004 06:28:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267405AbUHXK23
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Aug 2004 06:28:29 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:779 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S267488AbUHXK1y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Aug 2004 06:27:54 -0400
Date: Tue, 24 Aug 2004 11:27:44 +0100
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Linux Kernel List <linux-kernel@vger.kernel.org>
Cc: netdev@oss.sgi.com
Subject: [PATCH] 2.6.9-rc1 compile fix: ip_conntrack_proto_udp.c / ip_conntrack_proto_icmp.c
Message-ID: <20040824112744.B23041@flint.arm.linux.org.uk>
Mail-Followup-To: Linux Kernel List <linux-kernel@vger.kernel.org>,
	netdev@oss.sgi.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

These seem to suffer from the same problem that ip_conntrack_proto_tcp.c
does (see Felipe Alfaro Solana recent mail on lkml.)

net/ipv4/netfilter/ip_conntrack_proto_udp.c: In function `udp_error':
net/ipv4/netfilter/ip_conntrack_proto_udp.c:120: error: `NF_IP_PRE_ROUTING' undeclared (first use in this function)
net/ipv4/netfilter/ip_conntrack_proto_udp.c:120: error: (Each undeclared identifier is reported only once
net/ipv4/netfilter/ip_conntrack_proto_udp.c:120: error: for each function it appears in.)

and:

net/ipv4/netfilter/ip_conntrack_proto_icmp.c: In function `icmp_error_message':
net/ipv4/netfilter/ip_conntrack_proto_icmp.c:180: error: `NF_IP_LOCAL_OUT' undeclared (first use in this function)
net/ipv4/netfilter/ip_conntrack_proto_icmp.c:180: error: (Each undeclared identifier is reported only once
net/ipv4/netfilter/ip_conntrack_proto_icmp.c:180: error: for each function it appears in.)
net/ipv4/netfilter/ip_conntrack_proto_icmp.c: In function `icmp_error':
net/ipv4/netfilter/ip_conntrack_proto_icmp.c:216: error: `NF_IP_PRE_ROUTING' undeclared (first use in this function)

diff -up -x BitKeeper -x ChangeSet -x SCCS -x _xlk -x *.orig -x *.rej orig/net/ipv4/netfilter/ip_conntrack_proto_udp.c linux/net/ipv4/netfilter/ip_conntrack_proto_udp.c
--- orig/net/ipv4/netfilter/ip_conntrack_proto_udp.c	Tue Aug 24 09:57:21 2004
+++ linux/net/ipv4/netfilter/ip_conntrack_proto_udp.c	Tue Aug 24 11:22:48 2004
@@ -14,6 +14,7 @@
 #include <linux/udp.h>
 #include <net/checksum.h>
 #include <linux/netfilter.h>
+#include <linux/netfilter_ipv4.h>
 #include <linux/netfilter_ipv4/ip_conntrack_protocol.h>
 
 unsigned long ip_ct_udp_timeout = 30*HZ;
diff -up -x BitKeeper -x ChangeSet -x SCCS -x _xlk -x *.orig -x *.rej orig/net/ipv4/netfilter/ip_conntrack_proto_icmp.c linux/net/ipv4/netfilter/ip_conntrack_proto_icmp.c
--- orig/net/ipv4/netfilter/ip_conntrack_proto_icmp.c	Tue Aug 24 09:57:21 2004
+++ linux/net/ipv4/netfilter/ip_conntrack_proto_icmp.c	Tue Aug 24 11:24:27 2004
@@ -15,6 +15,7 @@
 #include <net/ip.h>
 #include <net/checksum.h>
 #include <linux/netfilter.h>
+#include <linux/netfilter_ipv4.h>
 #include <linux/netfilter_ipv4/ip_conntrack.h>
 #include <linux/netfilter_ipv4/ip_conntrack_core.h>
 #include <linux/netfilter_ipv4/ip_conntrack_protocol.h>

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 PCMCIA      - http://pcmcia.arm.linux.org.uk/
                 2.6 Serial core
