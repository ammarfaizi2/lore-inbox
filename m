Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129267AbQLOA7S>; Thu, 14 Dec 2000 19:59:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129325AbQLOA66>; Thu, 14 Dec 2000 19:58:58 -0500
Received: from pizda.ninka.net ([216.101.162.242]:39808 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S129267AbQLOA6s>;
	Thu, 14 Dec 2000 19:58:48 -0500
Date: Thu, 14 Dec 2000 16:11:10 -0800
Message-Id: <200012150011.QAA12767@pizda.ninka.net>
From: "David S. Miller" <davem@redhat.com>
To: laforge@gnumonks.org
CC: ionut@cs.columbia.edu, mhaque@haque.net, linux-kernel@vger.kernel.org
In-Reply-To: <20001215012000.B6775@coruscant.gnumonks.org> (message from
	Harald Welte on Fri, 15 Dec 2000 01:20:00 +0100)
Subject: Re: Netfilter is broken (was Re: ip_defrag is broken (was: Re: test12 lockups -- need feedback))
In-Reply-To: <Pine.LNX.4.30.0012141204210.27848-100000@age.cs.columbia.edu> <200012141955.LAA08814@pizda.ninka.net> <20001215012000.B6775@coruscant.gnumonks.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   Date: Fri, 15 Dec 2000 01:20:00 +0100
   From: Harald Welte <laforge@gnumonks.org>

   Or is there something wrong with:

   - packet arrives in net/ipv4/ip_input.c:ip_rcv()
   - netfilter hook NF_IP_PRE_ROUTING is called
   - net/ipv4/netfilter/ip_conntrack_core.c:ip_conntrack_in() is called
   - net/ipv4/netfilter/ip_conntrack_core.c:ip_ct_gather_frags() is called
   - net/ipv4/ip_input.c:ip_defrag() is called

   Isn't the skb->dev member supposed to still point to the receiving 
   device?

No, once you submit the packet to the defrag layer, that SKB
instance is owned by the defrag layer.

One way to do what netfilter wants to do, but legally, is to
simply skb_clone() the SKB before passing it into the
defragmentation code.

I'm still deciding whether this is the best fix.

Later,
David S. Miller
davem@redhat.com

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
