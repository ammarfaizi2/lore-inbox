Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314735AbSDVUhM>; Mon, 22 Apr 2002 16:37:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314736AbSDVUhL>; Mon, 22 Apr 2002 16:37:11 -0400
Received: from quechua.inka.de ([212.227.14.2]:13380 "EHLO mail.inka.de")
	by vger.kernel.org with ESMTP id <S314735AbSDVUhJ>;
	Mon, 22 Apr 2002 16:37:09 -0400
To: linux-kernel@vger.kernel.org
Subject: Re: novice coding in /linux/net/ipv4/util.c From: DJ Barrow <dj.barrow@asitatech.com>
In-Reply-To: <20020422151025Z314220-22651+13849@vger.kernel.org> <Pine.LNX.3.95.1020422113750.11343A-100000@chaos.analogic.com>
Organization: private Linux site, southern Germany
Date: Mon, 22 Apr 2002 22:32:52 +0200
From: Olaf Titz <olaf@bigred.inka.de>
Message-Id: <E16zkUW-0003iI-00@bigred.inka.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I love it! Last guy wins! I wonder how you fix it without having to
> pass it a pointer to something the caller owns?  This is, truly,
> non-trivial. Also, this is in ../linux/net, not something specific

This very discussion came up over CIPE several years ago. I wrote a
function which is even less beautiful but at least can be used
the natural way, i.e. like this:

        dprintk(DEB_OUT, (KERN_INFO
                          "%s: sending %d from %s:%d to %s:%d\n",
                          dev->name, skb->len,
                          cipe_ntoa(iph->saddr), ntohs(udph->source),
                          cipe_ntoa(iph->daddr), ntohs(udph->dest)));

It uses a circular chain of internal buffers (statically allocated
because I decided that more effort Just Isn't Worth It [tm]).

I proposed something like this on l-k back then and most people
disagreed on the grounds that we could use NIPQUAD instead. This may
be efficient but it is problematic on two counts IMHO:
1. it is Wrong[tm] because an IP address is _one_ argument to printk,
   not four
2. there is no easy way to make this IPv6 compatible. Printing IPv6
   addresses seems to me still an unsolved problem in the kernel (the
   stuff in icmpv6_rcv() can't be the last word on it, and ip6t_LOG.c
   neither, I mean really...)

> to Intel, and there is no macro to handle the network-order. It
> just 'comes-out-right' with Intel machines.

no, it comes out right because the argument is in network order, or
else it would come out _wrong_ on Intel boxen. (I'm glad I have a
little endian box if only because of catching such errors early :-)

Olaf

