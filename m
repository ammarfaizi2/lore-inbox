Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317230AbSFKXi5>; Tue, 11 Jun 2002 19:38:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317251AbSFKXi4>; Tue, 11 Jun 2002 19:38:56 -0400
Received: from mailout09.sul.t-online.com ([194.25.134.84]:17794 "EHLO
	mailout09.sul.t-online.com") by vger.kernel.org with ESMTP
	id <S317230AbSFKXiz>; Tue, 11 Jun 2002 19:38:55 -0400
To: "Philippe Veillette (LMC)" <Philippe.Veillette@ericsson.ca>
Cc: linux-kernel@vger.kernel.org
Subject: Re: sk->socket is invalid in tcp stack
In-Reply-To: <7B2A7784F4B7F0409947481F3F3FEF8303A070D4@eammlnt051.lmc.ericsson.se>
From: Andi Kleen <ak@muc.de>
Date: 12 Jun 2002 01:38:51 +0200
Message-ID: <m3it4p5qt0.fsf@averell.firstfloor.org>
User-Agent: Gnus/5.070095 (Pterodactyl Gnus v0.95) Emacs/20.7
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Philippe Veillette (LMC)" <Philippe.Veillette@ericsson.ca> writes:

> I've found what could be a problem in the tcp stack with linux-2.4.17 &
> 2.4.18.  When i run lmbench-2.0-patch2 and that i add the following line of
> code in tcp_v4_rcv, it<s get added between the if (!ipsec_sk_policy(sk,skb))
> ... and if (sk->state == TCP_TIME_WAIT)
> 
> if (sk->socket) {	
> 	if (sk->socket->inode) {
> 		printk("Boum\n");
> 	}
> }
> 
> I get a crash, i can give the dump later but for now, I am just wondering if
> the sk->socket could be invalid when we are receiving a tcp packet.  Since

It likely did receive to a time-wait socket. time-wait buckets are 
"inherited" by hand from struct sock and live in similar hash tables, 
but only some fields at the beginning are valid. Yes, it's rather ugly, but ...

-Andi
