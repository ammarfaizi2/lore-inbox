Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262250AbRENQRJ>; Mon, 14 May 2001 12:17:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262245AbRENQQ7>; Mon, 14 May 2001 12:16:59 -0400
Received: from minus.inr.ac.ru ([193.233.7.97]:56326 "HELO ms2.inr.ac.ru")
	by vger.kernel.org with SMTP id <S262248AbRENQQr>;
	Mon, 14 May 2001 12:16:47 -0400
From: kuznet@ms2.inr.ac.ru
Message-Id: <200105141616.UAA14586@ms2.inr.ac.ru>
Subject: Re: skb->truesize > sk->rcvbuf == Dropped packets
To: davem@redhat.com (David S. Miller)
Date: Mon, 14 May 2001 20:16:08 +0400 (MSK DST)
Cc: mike_phillips@urscorp.com, linux-kernel@vger.kernel.org
In-Reply-To: <15103.20768.588746.495042@pizda.ninka.net> from "David S. Miller" at May 13, 1 08:29:36 pm
X-Mailer: ELM [version 2.4 PL24]
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

> Hmmm... I don't see how not touching buffer values can solve his
> problem at all.  His MTU is really HUGE, and in this case 300 byte
> packet eats 10k or so space in receive buffer.

Default rcvbuf is ~64K, it is enough to receive up to mtu of a bit less 64K.
When application says rcvbuf=2K it appearently does not expect to hold
more then one packet.



> I doubt our buffer size tuning algorithms can cope with this.

At least TCP will tune itself nicely under the most extremal conditions.
What's about this case, no chances to tune. rcvbuf just should be large.


> Really, copy threshold in driver just must be choosen carefully.

rx copybreak has no chances to work in the case of large mtus...
F.e. it does not with gigabit cards, which use 9K mtu, but need
to talk to 1.5K world. Blind copybreak at 1.5K is a non-sense,
meaning "copy all". Though acenic with its three rx rings is
a lucky exception. 8)

Alexey
