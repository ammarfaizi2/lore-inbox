Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262736AbTCRWYh>; Tue, 18 Mar 2003 17:24:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262761AbTCRWYh>; Tue, 18 Mar 2003 17:24:37 -0500
Received: from sex.inr.ac.ru ([193.233.7.165]:13983 "HELO sex.inr.ac.ru")
	by vger.kernel.org with SMTP id <S262736AbTCRWYe>;
	Tue, 18 Mar 2003 17:24:34 -0500
From: kuznet@ms2.inr.ac.ru
Message-Id: <200303182235.BAA05440@sex.inr.ac.ru>
Subject: Re: 2.4 delayed acks don't work, fixed
To: andrea@suse.de (Andrea Arcangeli)
Date: Wed, 19 Mar 2003 01:35:23 +0300 (MSK)
Cc: linux-kernel@vger.kernel.org, davem@redhat.com, ak@suse.de
In-Reply-To: <20030318221906.GA30541@dualathlon.random> from "Andrea Arcangeli" at Mar 18, 3 11:19:06 pm
X-Mailer: ELM [version 2.4 PL24]
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

> sure, delacks must be disabled until the ofo queue is empty again.

We do the best efforts to disable them until sender completes slow start
i.e. half of advertised window.

Again, this does not matter in your case, you have window of one (rarely, two)
packets though all the tcpdump. And this bothers me a lot, much more than
ack frequency.


> I see seldom delack timeouts during streming because the streamer simply
> waits, the bandwidth of the link is higher than the streamer one

I do not understand this, to be honest. What does clock this sender?
Some internal clock of sender?

If it is clocked not by acks, and its clock is slower than ack clock,
then I daresay we do absolutely right thing (modulo funny window).



> there must be something that forbids it because I get immediate acks
> instead.

Adding to:

> > I am confused. Please, check.

... it is the thing to understand. I still do not.


> so is the ack sent elsewhere if this was the third packet and there's a
> window advance?

It is sent when cleanup_rbuf() is called, this happens when the function
returns and no more skbs are _already_ queued in backlog. Until that time
it does not make sense to send ACKs. On tcpdump you would see it as burst
of ACKs, spaced by microsecond intervals.

Alexey
