Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030315AbWAROJ3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030315AbWAROJ3 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Jan 2006 09:09:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030318AbWAROJ3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Jan 2006 09:09:29 -0500
Received: from aun.it.uu.se ([130.238.12.36]:37594 "EHLO aun.it.uu.se")
	by vger.kernel.org with ESMTP id S1030315AbWAROJ2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Jan 2006 09:09:28 -0500
From: Mikael Pettersson <mikpe@user.it.uu.se>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17358.19458.555996.684819@alkaid.it.uu.se>
Date: Wed, 18 Jan 2006 15:09:06 +0100
To: linuxppc-dev@ozlabs.org, netfilter-devel@lists.netfilter.org,
       linux-kernel@vger.kernel.org
Subject: 2.6.16-rc1: iptables broken on ppc32?
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

When trying out kernel 2.6.16-rc1 on a ppc32 box (G4 eMac),
the kernel refused to load my /etc/sysconfig/iptables. strace
on /sbin/iptables-restore shows that the kernel returns EINVAL
instead of accepting the configuration:

setsockopt(3, SOL_IP, 0x40 /* IP_??? */, "filter\0\214\0p\0\230\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0"..., 1664) = -1 EINVAL (Invalid argument)

The exact same configuration is accepted and works on an x86 box
also running 2.6.16-rc1, and of course the configuration worked
in all kernels up to and including 2.6.15 on the ppc32 box.

A much simplified /etc/sysconfig/iptables that fails on ppc32 but
works on x86 is the following:

*filter
:INPUT ACCEPT [0:0]
:FORWARD ACCEPT [0:0]
:OUTPUT ACCEPT [0:0]
:RH-Firewall-1-INPUT - [0:0]
-A INPUT -j RH-Firewall-1-INPUT
-A FORWARD -j RH-Firewall-1-INPUT
-A RH-Firewall-1-INPUT -i lo -j ACCEPT
-A RH-Firewall-1-INPUT -i eth0 -j ACCEPT
COMMIT

My 2.6.16-rc1 kernel configuration includes
CONFIG_NETFILTER_XTABLES=m
CONFIG_NETFILTER_XT_MATCH_STATE=m
CONFIG_IP_NF_CONNTRACK=m
CONFIG_IP_NF_IPTABLES=m
CONFIG_IP_NF_FILTER=m
CONFIG_IP_NF_TARGET_REJECT=m

and the iptable_filter, ip_tables, and x_tables modules were all loaded,
just like they were on the working x86 box.

User-space on the ppc32 box is YDL 4.0 with iptables-1.2.9-2.3.1.

/Mikael
