Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316723AbSGBKuT>; Tue, 2 Jul 2002 06:50:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316728AbSGBKuT>; Tue, 2 Jul 2002 06:50:19 -0400
Received: from samar.sasken.com ([164.164.56.2]:35716 "EHLO samar.sasken.com")
	by vger.kernel.org with ESMTP id <S316723AbSGBKuR>;
	Tue, 2 Jul 2002 06:50:17 -0400
Date: Tue, 2 Jul 2002 16:24:19 +0530 (IST)
From: Madhavi <madhavis@sasken.com>
To: <linux-kernel@vger.kernel.org>
Subject: IPv6 routing table implementation
Message-ID: <Pine.LNX.4.33.0207021615250.2254-100000@pcz-madhavis.sasken.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi

While going through the routing table implementation for linux-ipv6, I
found this piece of code.

struct fib6_node * fib6_lookup(struct fib6_node *root, struct in6_addr
			*daddr, struct in6_addr *saddr)
{
        struct lookup_args args[2];
        struct rt6_info *rt = NULL;
        struct fib6_node *fn;

        args[0].offset = (u8*) &rt->rt6i_dst - (u8*) rt;
			~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
        args[0].addr = daddr;

#ifdef CONFIG_IPV6_SUBTREES
        args[1].offset = (u8*) &rt->rt6i_src - (u8*) rt;
			~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
        args[1].addr = saddr;
#endif

.
.
.
.
}

I found out that this code is called from inet6_route_input() which will
always be called on the receiving end for IPv6 packets (ip6_rcv_finish()).

The underlined lines will be creating a kernel panic ALWAYS.

I am using 2.4.16 kernel. I have checked version 2.4.18 also and no
change in this part. Aren't these versions supposed to include a working
IPv6 implementation? Am I missing something?

regards
Madhavi.

