Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268014AbRGVRwC>; Sun, 22 Jul 2001 13:52:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268013AbRGVRvx>; Sun, 22 Jul 2001 13:51:53 -0400
Received: from Expansa.sns.it ([192.167.206.189]:54789 "EHLO Expansa.sns.it")
	by vger.kernel.org with ESMTP id <S268012AbRGVRvs>;
	Sun, 22 Jul 2001 13:51:48 -0400
Date: Sun, 22 Jul 2001 19:51:43 +0200 (CEST)
From: Luigi Genoni <kernel@Expansa.sns.it>
To: "Alan J. Wylie" <alan.nospam@glaramara.freeserve.co.uk>
cc: <linux-kernel@vger.kernel.org>, Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: ipt_unclean: TCP flags bad: 4
In-Reply-To: <15194.61662.338810.87576@glaramara.freeserve.co.uk>
Message-ID: <Pine.LNX.4.33.0107221947420.739-100000@Expansa.sns.it>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing


There was a bug introduced with kernel 2.4.6, but it was
solved with one of the latest 2.4.7-pre patch, i do not remember which
one.

actually i was happily using tcp_unclean on my production servers, but
with 2.4.6 i was forced to avoid it.
I still have to try 2.4.7 to see if it works properly.

If you use a rule like

iptables -A INPUT -m unlean -j DROP

are you still able to connect in/out of your box?

bests
Luigi


On Sun, 22 Jul 2001, Alan J. Wylie wrote:

>
> I've just upgraded to 2.4.7, and I'm getting lots of errors:
>
> ipt_unclean: TCP flags bad: 4
>
> I only see them when my ppp link is up - pppd version 2.4.0
>
> Looking at ipt_unclean.c it seems that this message will be generated
> when I send a packet with flags set to RST only.
>
> I've run a ppp session with the pppd option "record" turned on, and
> analysed the output with "ethereal". This is indeed what is on the
> wire. I'm no expert on TCP I'm afraid. The complete TCP stream
> follows:
>
> ------------------------------------------------------------------------------
> No. Time        Source                Destination           Protocol Info
>
> 129 12.800000   62.137.113.223        news.svr.pol.co.uk    TCP
>     1148 > nntp [SYN] Seq=3684831495 Ack=0 Win=5840 Len=0
>
> 131 12.900000   news.svr.pol.co.uk    62.137.113.223        TCP
>     nntp > 1148 [SYN, ACK] Seq=2607886663 Ack=3684831496 Win=32736 Len=0
>
> 137 13.300000   62.137.113.223        news.svr.pol.co.uk    TCP
>     1148 > nntp [FIN, ACK] Seq=3684831502 Ack=2607887466 Win=7090 Len=0
>
> 142 13.400000   62.137.113.223        news.svr.pol.co.uk    TCP
>     1148 > nntp [RST] Seq=3684831503 Ack=0 Win=0 Len=0
> ------------------------------------------------------------------------------
>
> --
> Alan J. Wylie                        http://www.glaramara.freeserve.co.uk/
> "Perfection [in design] is achieved not when there is nothing left to add,
> but rather when there is nothing left to take away."
>   Antoine de Saint-Exupery
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>

