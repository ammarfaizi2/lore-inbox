Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277203AbRJNR4N>; Sun, 14 Oct 2001 13:56:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277196AbRJNR4E>; Sun, 14 Oct 2001 13:56:04 -0400
Received: from cs181088.pp.htv.fi ([213.243.181.88]:24448 "EHLO
	cs181088.pp.htv.fi") by vger.kernel.org with ESMTP
	id <S277203AbRJNRzy>; Sun, 14 Oct 2001 13:55:54 -0400
Message-ID: <3BC9D1BB.3177FA39@welho.com>
Date: Sun, 14 Oct 2001 20:56:11 +0300
From: Mika Liljeberg <Mika.Liljeberg@welho.com>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.10-ac10 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: kuznet@ms2.inr.ac.ru
CC: ak@muc.de, davem@redhat.com, linux-kernel@vger.kernel.org
Subject: Re: TCP acking too fast
In-Reply-To: <200110141735.VAA06277@ms2.inr.ac.ru>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

kuznet@ms2.inr.ac.ru wrote:
> 
> Hello!
> 
> > Well, you should read the preceding messages to understand how we got
> > here.
> 
> I am reading now and until now I did not find why problem of calculating
> rcv_mss raised at all. :-)

I think Andi brought it up. I was actually saying that it probably works
most of the time.

> You nicely understood the reason of the problem and
> it is surely not related to rcv_mss in any way.  :-)
> 
> > When you say "reliably", you should recognize the underlying assumptions
> > as well.
> 
> The assumptions are so conservative, that it is not worth to tell about them.

The assumption is that the peer is implemented the way you expect and
that the application doesn't toy with TCP_NODELAY.

> Heuristics does not predict fall of rcv_mss below 536 when sender
> sets PSH on each frame. And it is pretty evident that such prediction
> is impossible theoretically in this sad case. All that we can do is
> to cry and to hold rcv_mss at 536 and to ack each 4th segment on
> with mtu of 256.

Not really. You could do one of two things: either ack every second
segment and leave rcv estimation only for window calculations, or use an
algorithm like the one I outlined. Either approach would work, I think,
and not produce strech acks.

Regards,

	MikaL
