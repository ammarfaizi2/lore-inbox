Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271759AbRICRPQ>; Mon, 3 Sep 2001 13:15:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271757AbRICRPH>; Mon, 3 Sep 2001 13:15:07 -0400
Received: from minus.inr.ac.ru ([193.233.7.97]:57358 "HELO ms2.inr.ac.ru")
	by vger.kernel.org with SMTP id <S271761AbRICROw>;
	Mon, 3 Sep 2001 13:14:52 -0400
From: kuznet@ms2.inr.ac.ru
Message-Id: <200109031714.VAA24484@ms2.inr.ac.ru>
Subject: Re: Excessive TCP retransmits over lossless, high latency link
To: lk@tantalophile.demon.co.uk (Jamie Lokier)
Date: Mon, 3 Sep 2001 21:14:47 +0400 (MSK DST)
Cc: davem@redhat.com, ak@muc.de, linux-kernel@vger.kernel.org
In-Reply-To: <20010901210212.A3361@thefinal.cern.ch> from "Jamie Lokier" at Sep 1, 1 09:02:12 pm
X-Mailer: ELM [version 2.4 PL24]
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

> I hate rebooting :-)

Relax. Really, this will not change anything. After more careful look
into the first tcpdump, I did not find any signs of false fast retransmits.

All the problem is due to wrong rtt estimator at sender.


> > Yes, on such links fast retransmit is not useful in any case.
> 
> Should I turn of /proc/sys/net/ipv4/tcp_fack then?

No. Defaults are defaults, because they are the best defaults. :-)


> Yes, definitely.  Btw, I saw a ping round trip time of 162s just now.

I do not understand, do you share this link with someone or
ping over tcp connection?

If the last is true, reduce window to 4K, maximum 8K. Default 64K, combined
with misconfigured queues and/or with broken error correction is disaster.

Actually, you dump shows that window is not open.


> I saw very few retransmits in a single message download.  SACK appears
> occasionally.  I don't really understand the local reaction to SACK, or
> why a SACK option appears in one ACK sent locally and not the following
> ACK, even though the SACK mentions data that does not arrive between the
> two locally sent ACKs.

But I do not see _any_ sacks in your tcpdumps.


> The throughput difference was obvious: POP3 negotiation + 30k message +
> headers took:
> 
>         5 min 31 sec       downloading unknown OS   ->  Linux 2.4.7
>         2 min 15 sec       downloading Linux 2.4.2  ->  Linux 2.4.7

It is dominated by rtt, one rtt per segment. It is very strange
that cwnd does not want to open. Maybe, it is worth to tcpdump at proxy.

Alexey
