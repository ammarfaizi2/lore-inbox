Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268178AbRGWKma>; Mon, 23 Jul 2001 06:42:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268179AbRGWKmT>; Mon, 23 Jul 2001 06:42:19 -0400
Received: from juicer35.bigpond.com ([139.134.6.87]:3782 "EHLO
	mailin10.bigpond.com") by vger.kernel.org with ESMTP
	id <S268178AbRGWKmO>; Mon, 23 Jul 2001 06:42:14 -0400
Message-Id: <m15ObJH-000CD5C@localhost>
From: Rusty Russell <rusty@rustcorp.com.au>
To: "Alan J. Wylie" <alan.nospam@glaramara.freeserve.co.uk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: ipt_unclean: TCP flags bad: 4 
In-Reply-To: Your message of "Sun, 22 Jul 2001 16:27:26 +0100."
             <15194.61662.338810.87576@glaramara.freeserve.co.uk> 
Date: Mon, 23 Jul 2001 18:43:26 +1000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

In message <15194.61662.338810.87576@glaramara.freeserve.co.uk> you write:
> 
> I've just upgraded to 2.4.7, and I'm getting lots of errors:
> 
> ipt_unclean: TCP flags bad: 4

Please try this patch...

Note that this should be a warning to people not to reject packets
based on ipt_unclean, or we'll end up with another situation like the
ECN blackholes when the next Funky New Thing comes along...

Thanks,
Rusty.
--
Premature optmztion is rt of all evl. --DK

diff -urN -I \$.*\$ -X /home/rusty/devel/kernel/kernel-patches/dontdiff --minimal linux-2.4.7-official/net/ipv4/netfilter/ipt_unclean.c working-2.4.7-unclean/net/ipv4/netfilter/ipt_unclean.c
--- linux-2.4.7-official/net/ipv4/netfilter/ipt_unclean.c	Sun Jul 22 13:13:27 2001
+++ working-2.4.7-unclean/net/ipv4/netfilter/ipt_unclean.c	Mon Jul 23 18:29:11 2001
@@ -331,6 +331,7 @@
 	tcpflags = ((u_int8_t *)tcph)[13];
 	if (tcpflags != TH_SYN
 	    && tcpflags != (TH_SYN|TH_ACK)
+	    && tcpflags != TH_RST
 	    && tcpflags != (TH_RST|TH_ACK)
 	    && tcpflags != (TH_RST|TH_ACK|TH_PUSH)
 	    && tcpflags != (TH_FIN|TH_ACK)
