Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271545AbSISQSj>; Thu, 19 Sep 2002 12:18:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271547AbSISQSj>; Thu, 19 Sep 2002 12:18:39 -0400
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:31207 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id <S271545AbSISQSi>; Thu, 19 Sep 2002 12:18:38 -0400
Date: Thu, 19 Sep 2002 18:23:33 +0200 (CEST)
From: Adrian Bunk <bunk@fs.tum.de>
X-X-Sender: bunk@mimas.fachschaften.tu-muenchen.de
To: Kent Hunt <kenthunt@yahoo.com>, "David S. Miller" <davem@redhat.com>
cc: lk <linux-kernel@vger.kernel.org>
Subject: Re: Compile error 2.4.20-pre7 in ip_conntrackt_ftp
In-Reply-To: <20020919154545.17347.qmail@web14510.mail.yahoo.com>
Message-ID: <Pine.NEB.4.44.0209191818260.10170-100000@mimas.fachschaften.tu-muenchen.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 19 Sep 2002, Kent Hunt wrote:

> FYI
>
> ip_conntrack_ftp.c:440: parse error before
> `this_object_must_be_defined_as_export_objs_in_the_Makefile'
> ip_conntrack_ftp.c:440: warning: type defaults to
> `int' in declaration of
> `this_object_must_be_defined_as_export_objs_in_the_Makefile'
> ip_conntrack_ftp.c:440: warning: data definition has
> no type or storage class

Hi Kent,

thanks for this report. Dave's patch

  [NETFILTER]: Backport newnat infrastructure to 2.4.x

removed ip_conntrack_ftp.o from export-objs in net/ipv4/netfilter/Makefile
although there's still an EXPORT_SYMBOL in ip_conntrack_ftp.c
#ifdef CONFIG_IP_NF_NAT_NEEDED. The following (untested) patch should fix
it:


--- net/ipv4/netfilter/Makefile.old	2002-09-19 18:17:31.000000000 +0200
+++ net/ipv4/netfilter/Makefile	2002-09-19 18:17:56.000000000 +0200
@@ -9,7 +9,7 @@

 O_TARGET := netfilter.o

-export-objs = ip_conntrack_standalone.o ip_fw_compat.o ip_nat_standalone.o ip_tables.o arp_tables.o
+export-objs = ip_conntrack_standalone.o ip_conntrack_ftp.o ip_fw_compat.o ip_nat_standalone.o ip_tables.o arp_tables.o

 # Multipart objects.
 list-multi		:= ip_conntrack.o iptable_nat.o ipfwadm.o ipchains.o

> Please CC.
>
> Kent

cu
Adrian

-- 

You only think this is a free country. Like the US the UK spends a lot of
time explaining its a free country because its a police state.
								Alan Cox

