Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292314AbSBBQWX>; Sat, 2 Feb 2002 11:22:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292319AbSBBQWO>; Sat, 2 Feb 2002 11:22:14 -0500
Received: from CS.BU.EDU ([128.197.10.2]:23193 "EHLO cs.bu.edu")
	by vger.kernel.org with ESMTP id <S292314AbSBBQWB>;
	Sat, 2 Feb 2002 11:22:01 -0500
Date: Sat, 2 Feb 2002 11:21:56 -0500 (EST)
From: "Guo, Liang" <guol@cs.bu.edu>
To: linux-kernel@vger.kernel.org
Subject: Re: TCP in TIME_WAIT response to dup FIN 
In-Reply-To: <Pine.SOL.4.20.0202012107260.1020-100000@csb.bu.edu>
Message-ID: <Pine.SOL.4.20.0202021116020.1020-100000@csb.bu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> I'm performing a benchmark test to a local linux website. When
> I monitor packet sequences at the website with tcpdump, I found
> that when tcp socket is in TIME_WAIT state, the default response to a
> retransmitted FIN packets is to silently drop them. Is this the correct
> way of implementing TIME_WAIT? The website was runing on
> 2.2.19 kernel, and when I change it to 2.4.9, tcp becomes more
> active and start sending back FIN-ACKs.
> 
> I saw different explainations on the purpose of TIME_WAIT state,
> some of them (including Stevens' book) say that it can deal with
> losses of the last FIN or FIN-ACK packet in addition to
> preventing reuse of same address-port pair immediately.
> 
> I also glimpsed through TCP implementations in both kernels.
> Although both claim to be conformant to RFC 1122, the code
> themselves are quite different. And I couldn't find 
> anywhere in the 2.2.19 kernel implementation that tells
> TCP to respond to duplicate FINs except in tcp_timewait_state_process:
> 
>         /* Ack old packets if necessary */ 
>         if (!after(TCP_SKB_CB(skb)->end_seq, tw->rcv_nxt) &&
>             (len > (th->doff * 4) || th->fin))
>                 return TCP_TW_ACK; 
>         return 0; 
> 
> Which I suspect contains some bug.
> I've searched the archive and found a related message was posted
> almost 3 years ago:
> http://marc.theaimsgroup.com/?l=linux-kernel&m=93293686728605&w=2
> Seems that the "|| th->fin" condition was the ad-hoc patch for
> the problem. And if it is, shouldn't the "&&" be "||" in the
> if condition?
> 
> Again, my question is whether 2.2.19 is doing correct things, 
> and if not, can I replace tcp implementation in 2.2.19 by
> that in 2.4.9 and how? Or some alternative milder changes?
> 
> Thank you very much.
> 
> 
> Guo, Liang 
> 
> guol@cs.bu.edu                     Dept. of Comp. Sci., Boston Univ.,
> (617)353-5222 (O)                  111 Cummington St., MCS-217,
> (617)375-9206 (H)                  Boston, MA 02215
> 
> 

