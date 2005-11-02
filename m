Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965201AbVKBTuu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965201AbVKBTuu (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Nov 2005 14:50:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965202AbVKBTuu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Nov 2005 14:50:50 -0500
Received: from de01egw02.freescale.net ([192.88.165.103]:3985 "EHLO
	de01egw02.freescale.net") by vger.kernel.org with ESMTP
	id S965201AbVKBTut (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Nov 2005 14:50:49 -0500
From: Steve Snyder <R00020C@freescale.com>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Can I reduce CPU use of conntrack/masq?
Date: Wed, 2 Nov 2005 14:50:47 -0500
User-Agent: KMail/1.8.2
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200511021450.47657.R00020C@freescale.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello.

I am working on what amounts to a Ethernet to Ultra-Wide Band (UWB) 
converter box.  Packets are simply routed from 1 interface to 
another.

This box is based on an ARM7TDMI CPU, running Linux 2.4.26, and the 
network throughput of the box is CPU-limited.  How limited?  The 
100Mbps/FD Ethernet can do no better than 35Mbps.

I've discovered that I can improve Ethernet throughput by about %20 by 
removing the the conntrack/masq support from the kernel.  The removal 
is good only as a test, though, since I need this functionality to 
move the packets between interfaces.  

This is the relevant config:

CONFIG_IP_NF_CONNTRACK=y
CONFIG_IP_NF_IPTABLES=y
CONFIG_IP_NF_NAT=y
CONFIG_IP_NF_NAT_NEEDED=y
CONFIG_IP_NF_TARGET_MASQUERADE=y

Enabled at boot time like this:

/sbin/iptables -t nat -A POSTROUTING -o uwb0 -j MASQUERADE
echo "1" > /proc/sys/net/ipv4/ip_forward

I wonder if I can improve conntrack/masq performance at the expense of 
flexibility.  This will be a closed system, with simple and static 
routing.  Are there any trade-offs I can make to sacrifice unneeded 
flexibility in routing for reduced CPU utilization in conntrack/masq?

Thanks.
