Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277263AbRJNSUi>; Sun, 14 Oct 2001 14:20:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277264AbRJNSU2>; Sun, 14 Oct 2001 14:20:28 -0400
Received: from minus.inr.ac.ru ([193.233.7.97]:43527 "HELO ms2.inr.ac.ru")
	by vger.kernel.org with SMTP id <S277263AbRJNSUK>;
	Sun, 14 Oct 2001 14:20:10 -0400
From: kuznet@ms2.inr.ac.ru
Message-Id: <200110141820.WAA06484@ms2.inr.ac.ru>
Subject: Re: TCP acking too fast
To: Mika.Liljeberg@welho.com (Mika Liljeberg)
Date: Sun, 14 Oct 2001 22:20:24 +0400 (MSK DST)
Cc: ak@muc.de, davem@redhat.com, linux-kernel@vger.kernel.org
In-Reply-To: <3BC9D1BB.3177FA39@welho.com> from "Mika Liljeberg" at Oct 14, 1 08:56:11 pm
X-Mailer: ELM [version 2.4 PL24]
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

> The assumption is that the peer is implemented the way you expect and
> that the application doesn't toy with TCP_NODELAY.

Sorry??

It is the most important _exactly_ for TCP_NODELAY, which
generates lots of remnants.


> Not really. You could do one of two things: either ack every second
> segment 

I do not worry about this _at_ _all_. See?
"each other", "each two mss" --- all this is red herring.

I do understand your problem, which is not related to rcv_mss.
When bandwidth in different directions differ more than 20 times,
stretch ACKs are even preferred. Look into tcplw work, using stretch ACKs
is even considered as something normal.

I really commiserate and think that removing "final cut" clause
will help you. But sending ACK on buffer drain at least for short
packets is real demand, which cannot be relaxed.
"final cut" is also better not to remove actually, but the case
when it is required is probabilistically marginal.

Alexey
