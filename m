Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136148AbRD0SOv>; Fri, 27 Apr 2001 14:14:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136152AbRD0SOm>; Fri, 27 Apr 2001 14:14:42 -0400
Received: from mail-2.addcom.de ([62.96.128.36]:22802 "HELO mail-2.addcom.de")
	by vger.kernel.org with SMTP id <S136148AbRD0SOg>;
	Fri, 27 Apr 2001 14:14:36 -0400
Date: Fri, 27 Apr 2001 20:14:55 +0200 (CEST)
From: Kai Germaschewski <kai@tp1.ruhr-uni-bochum.de>
X-X-Sender: <kai@vaio>
To: "David S. Miller" <davem@redhat.com>
cc: Matthias Andree <matthias.andree@gmx.de>,
        Linux-Kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: 2.4.4-pre7 build failure w/ IP NAT and ipchains
Message-ID: <Pine.LNX.4.33.0104272012410.1256-100000@vaio>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Fri, 27 Apr 2001, David S. Miller wrote:

>> net/network.o: In function `ip_nat_setup_info':
>> net/network.o(.text+0x37b3e): undefined reference to `helpers'
>> net/network.o(.text+0x37b54): undefined reference to `helpers'
>
> Your configuration seems impossible, somehow the config system allowed
> you to set CONFIG_IP_NF_COMPAT_IPCHAINS without setting
> CONFIG_IP_NF_CONNTRACK.

Hmmh, actually the Config.in won't allow you to to set
CONFIG_IP_NF_COMPAT_IPCHAINS if CONFIG_IP_NF_CONNTRACK=y, but I don't
really understand that Config.in completely. (CONFIG_IP_NF_NAT_NEEDED is
set, but AFAICS never referenced anywhere).

Anyway, the appended patch fixed the problem for me, vmlinux links okay
now - didn't try if it works, though.

--Kai


Index: net/ipv4/netfilter/ip_conntrack_core.c
===================================================================
RCS file: /scratch/kai/cvsroot/linux_2_4/net/ipv4/netfilter/ip_conntrack_core.c,v
retrieving revision 1.1.1.3
diff -u -r1.1.1.3 ip_conntrack_core.c
--- net/ipv4/netfilter/ip_conntrack_core.c	2001/04/24 00:20:29	1.1.1.3
+++ net/ipv4/netfilter/ip_conntrack_core.c	2001/04/26 20:49:36
@@ -46,7 +46,7 @@
 void (*ip_conntrack_destroyed)(struct ip_conntrack *conntrack) = NULL;
 LIST_HEAD(expect_list);
 LIST_HEAD(protocol_list);
-static LIST_HEAD(helpers);
+LIST_HEAD(helpers);
 unsigned int ip_conntrack_htable_size = 0;
 static int ip_conntrack_max = 0;
 static atomic_t ip_conntrack_count = ATOMIC_INIT(0);




