Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S275277AbRJNOEa>; Sun, 14 Oct 2001 10:04:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S275278AbRJNOEV>; Sun, 14 Oct 2001 10:04:21 -0400
Received: from colin.muc.de ([193.149.48.1]:45322 "HELO colin.muc.de")
	by vger.kernel.org with SMTP id <S275277AbRJNOEM>;
	Sun, 14 Oct 2001 10:04:12 -0400
Message-ID: <20011014160511.53642@colin.muc.de>
Date: Sun, 14 Oct 2001 16:05:11 +0200
From: Andi Kleen <ak@muc.de>
To: Mika Liljeberg <Mika.Liljeberg@welho.com>
Cc: Andi Kleen <ak@muc.de>, "David S. Miller" <davem@redhat.com>,
        linux-kernel@vger.kernel.org, kuznet@ms2.inr.ac.ru
Subject: Re: TCP acking too fast
In-Reply-To: <3BC94F3A.7F842182@welho.com> <20011014.020326.18308527.davem@redhat.com> <k2zo6uiney.fsf@zero.aec.at> <20011014.023948.95894368.davem@redhat.com> <20011014133004.34133@colin.muc.de> <3BC97BC5.9F341ACE@welho.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.88e
In-Reply-To: <3BC97BC5.9F341ACE@welho.com>; from Mika Liljeberg on Sun, Oct 14, 2001 at 01:49:25PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 14, 2001 at 01:49:25PM +0200, Mika Liljeberg wrote:
> Andi Kleen wrote:
> > The only special case for PSH in RX left I can is in rcv_mss estimation,
> > where is assumes that a packet with PSH set is not full sized.
> 
> A packet without PSH should be full size. Assuming the sender implemets
> SWS avoidance correctly, this should be a safe enough assumption.

It's not guaranteed by any spec; just common behaviour from BSD derived
stacks. SWS avoidance does not say anything about PSH flags.


> 
> > On further
> > look the 2.4 tcp_measure_rcv_mss will never update rcv_mss for packets
> > which do have PSH set and in this case cause random ack behaviour depending
> > on the initial rcv_mss guess.
> > Not very nice; definitely violates the "be conservative what you accept"
> > rule. I'm not sure how to fix it, adding a fallback to every-two-packet-add
> > would pollute the fast path a bit.
> 
> You're right. As far as I can see, it's not necessary to set the
> TCP_ACK_PUSHED flag at all (except maybe for SYN-ACK). I'm just writing
> a patch to clean this up.

Setting it for packets >= rcv_mss looks useful to me to catch mistakes.
Better too many acks than to few.


-Andi
