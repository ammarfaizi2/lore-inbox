Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264525AbRFTSHz>; Wed, 20 Jun 2001 14:07:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264529AbRFTSHo>; Wed, 20 Jun 2001 14:07:44 -0400
Received: from minus.inr.ac.ru ([193.233.7.97]:54281 "HELO ms2.inr.ac.ru")
	by vger.kernel.org with SMTP id <S264525AbRFTSH3>;
	Wed, 20 Jun 2001 14:07:29 -0400
From: kuznet@ms2.inr.ac.ru
Message-Id: <200106201806.WAA19422@ms2.inr.ac.ru>
Subject: Re: softirq in pre3 and all linux ports
To: andrea@suse.de (Andrea Arcangeli)
Date: Wed, 20 Jun 2001 22:06:13 +0400 (MSK DST)
Cc: davem@redhat.com, paulus@samba.org, torvalds@transmeta.com,
        alan@lxorguk.ukuu.org.uk, mingo@elte.hu, linux-kernel@vger.kernel.org
In-Reply-To: <20010620060753.B849@athlon.random> from "Andrea Arcangeli" at Jun 20, 1 06:07:53 am
X-Mailer: ELM [version 2.4 PL24]
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

> > Andrea Arcangeli writes:
> >  > I don't have gigabit ethernet so I cannot flood my boxes to death.
> >  > But I think it's real, and a softirq marking itself runnable again is
> >  > another case to handle without live lockups or starvation.

Andrea, you do not need gigabit interfaces to check this. 100Mbit ones
are enough and even better, because they do not mitigate as rule
and consume more resources. 8) Actually, you may laugh, but one 10Mbit(!)
interface is enough in some curcumstances, namely when stack does more work
than usually: sniffing, connection tracking in presence of fragments,
syn flooding etc.

Actually, now I do not understand why TUX still works with Ingo's patch.
As soon as bulk work is made in thread context, it should die pretty
fastly doing no progress. :-)


> > I think (still) that you're just moving the problem around and
> > not actually changing anything.

Well, ksoftirqd is not sort of placebo yet. :-)

OK. Let's forget about infinite thread latency and live lock problems
introduced by Ingo's patch. Eventually, BSD does exactly the same
thing for ages and nobody but security paranoics cried about this
too much. We are just fully bsd compliant now. 8)


Let's look at different angle: f.e. with Ingo's patch, as soon as
one cpu processes some global BH, all the rest of cpus will spin
waiting for global bh release. Is this good? I am afraid this is not
quite good.

Alexey

