Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267188AbTBDJL1>; Tue, 4 Feb 2003 04:11:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267191AbTBDJL0>; Tue, 4 Feb 2003 04:11:26 -0500
Received: from packet.digeo.com ([12.110.80.53]:38864 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S267188AbTBDJL0>;
	Tue, 4 Feb 2003 04:11:26 -0500
Date: Tue, 4 Feb 2003 01:21:05 -0800
From: Andrew Morton <akpm@digeo.com>
To: Helge Hafting <helgehaf@aitel.hist.no>
Cc: linux-kernel@vger.kernel.org, "David S. Miller" <davem@redhat.com>
Subject: Re: 2.5.59-mm8 compile error in tcp_ipv6.c
Message-Id: <20030204012105.4249b053.akpm@digeo.com>
In-Reply-To: <3E3F857A.5C55A6E3@aitel.hist.no>
References: <20030203233156.39be7770.akpm@digeo.com>
	<3E3F857A.5C55A6E3@aitel.hist.no>
X-Mailer: Sylpheed version 0.8.9 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 04 Feb 2003 09:20:53.0248 (UTC) FILETIME=[B71CE000:01C2CC2E]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Helge Hafting <helgehaf@aitel.hist.no> wrote:
>
> mm8 gave me this error. mm6 didn't have this problem.  _I haven't
> looked at mm7.  
> 
>   gcc -Wp,-MD,net/ipv6/.tcp_ipv6.o.d -D__KERNEL__ -Iinclude -Wall
> -Wstrict-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common
> -pipe -mpreferred-stack-boundary=2 -march=i686
> -Iinclude/asm-i386/mach-default -fomit-frame-pointer -nostdinc
> -iwithprefix include    -DKBUILD_BASENAME=tcp_ipv6 -DKBUILD_MODNAME=ipv6
> -c -o net/ipv6/tcp_ipv6.o net/ipv6/tcp_ipv6.c
> net/ipv6/tcp_ipv6.c:1750: conflicting types for `tcp_v6_xmit'
> net/ipv6/tcp_ipv6.c:63: previous declaration of `tcp_v6_xmit'

Somebody's finger slipped.

diff -puN net/ipv6/tcp_ipv6.c~a net/ipv6/tcp_ipv6.c
--- 25/net/ipv6/tcp_ipv6.c~a	2003-02-04 01:20:17.000000000 -0800
+++ 25-akpm/net/ipv6/tcp_ipv6.c	2003-02-04 01:20:19.000000000 -0800
@@ -60,7 +60,7 @@ static void	tcp_v6_send_check(struct soc
 				  struct sk_buff *skb);
 
 static int	tcp_v6_do_rcv(struct sock *sk, struct sk_buff *skb);
-static int	tcp_v6_xmit(struct sk_buff *skb);
+static int	tcp_v6_xmit(struct sk_buff *skb, int ipfragok)
 
 static struct tcp_func ipv6_mapped;
 static struct tcp_func ipv6_specific;

_

