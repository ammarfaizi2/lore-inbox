Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292352AbSBBTFm>; Sat, 2 Feb 2002 14:05:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292353AbSBBTFc>; Sat, 2 Feb 2002 14:05:32 -0500
Received: from minus.inr.ac.ru ([193.233.7.97]:12808 "HELO ms2.inr.ac.ru")
	by vger.kernel.org with SMTP id <S292352AbSBBTFX>;
	Sat, 2 Feb 2002 14:05:23 -0500
From: kuznet@ms2.inr.ac.ru
Message-Id: <200202021905.WAA19338@ms2.inr.ac.ru>
Subject: Re: TCP in TIME_WAIT response to dup FIN
To: guol@cs.bu.EDU (Guo Liang)
Date: Sat, 2 Feb 2002 22:05:07 +0300 (MSK)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <Pine.SOL.4.20.0202021116020.1020-100000@csb.bu.edu> from "Guo, Liang" at Feb 2, 2 07:45:01 pm
X-Mailer: ELM [version 2.4 PL24]
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

> > that when tcp socket is in TIME_WAIT state, the default response to a
> > retransmitted FIN packets is to silently drop them. Is this the correct
> > way of implementing TIME_WAIT?

No. Linux 2.2 is not expected to have this bug.


> > active and start sending back FIN-ACKs.

No. time-wait never send FINs, just bare ACK.



> >         /* Ack old packets if necessary */ 
> >         if (!after(TCP_SKB_CB(skb)->end_seq, tw->rcv_nxt) &&
> >             (len > (th->doff * 4) || th->fin))
> >                 return TCP_TW_ACK; 
> >         return 0; 
> > 
> > Which I suspect contains some bug.

It should responce right. end_seq == rcv_nxt in the case of retransmitted
FIN, len == th->doff*4 but th->fin == 1. So, it returns TCP_TW_ACK.

So, it looks right, I have no idea what happens in your case.
Apparently, you diagnosed problem wrongly. It would be better
if you sent tcpdump of bad session instead.


> > Again, my question is whether 2.2.19 is doing correct things, 

Supposed to do. If it does not, alas.


> > that in 2.4.9 and how? Or some alternative milder changes?

Milder change is just to install 2.4. :-)

Alexey
