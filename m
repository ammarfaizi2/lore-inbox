Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132398AbRD0Wyr>; Fri, 27 Apr 2001 18:54:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132471AbRD0Wyh>; Fri, 27 Apr 2001 18:54:37 -0400
Received: from pizda.ninka.net ([216.101.162.242]:29094 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S132398AbRD0Wy2>;
	Fri, 27 Apr 2001 18:54:28 -0400
From: "David S. Miller" <davem@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15081.63650.574602.341411@pizda.ninka.net>
Date: Fri, 27 Apr 2001 15:54:26 -0700 (PDT)
To: Kai Germaschewski <kai@tp1.ruhr-uni-bochum.de>,
        Matthias Andree <matthias.andree@gmx.de>,
        Linux-Kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: 2.4.4-pre7 build failure w/ IP NAT and ipchains
In-Reply-To: <15081.58646.799622.9357@pizda.ninka.net>
In-Reply-To: <Pine.LNX.4.33.0104272012410.1256-100000@vaio>
	<15081.58646.799622.9357@pizda.ninka.net>
X-Mailer: VM 6.75 under 21.1 (patch 13) "Crater Lake" XEmacs Lucid
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Kai, can you try this patch out?  I think it does the right
thing.  What I'm mostly interested in is if your ipchains
setup works for the resulting kernel, I've already checked
that it links properly. :-)

--- net/ipv4/netfilter/Makefile.~1~	Thu Apr 26 23:30:39 2001
+++ net/ipv4/netfilter/Makefile	Fri Apr 27 15:49:54 2001
@@ -16,11 +16,11 @@
 
 # objects for the conntrack and NAT core (used by standalone and backw. compat)
 ip_nf_conntrack-objs	:= ip_conntrack_core.o ip_conntrack_proto_generic.o ip_conntrack_proto_tcp.o ip_conntrack_proto_udp.o ip_conntrack_proto_icmp.o
-ip_nf_nat-objs		:= ip_nat_core.o ip_nat_proto_unknown.o ip_nat_proto_tcp.o ip_nat_proto_udp.o ip_nat_proto_icmp.o
+ip_nf_nat-objs		:= ip_nat_core.o ip_nat_helper.o ip_nat_proto_unknown.o ip_nat_proto_tcp.o ip_nat_proto_udp.o ip_nat_proto_icmp.o
 
 # objects for the standalone - connection tracking / NAT
 ip_conntrack-objs	:= ip_conntrack_standalone.o $(ip_nf_conntrack-objs)
-iptable_nat-objs	:= ip_nat_standalone.o ip_nat_rule.o ip_nat_helper.o $(ip_nf_nat-objs)
+iptable_nat-objs	:= ip_nat_standalone.o ip_nat_rule.o $(ip_nf_nat-objs)
 
 # objects for backwards compatibility mode
 ip_nf_compat-objs	:= ip_fw_compat.o ip_fw_compat_redir.o ip_fw_compat_masq.o $(ip_nf_conntrack-objs) $(ip_nf_nat-objs)
