Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276262AbRI1TjT>; Fri, 28 Sep 2001 15:39:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276261AbRI1TjJ>; Fri, 28 Sep 2001 15:39:09 -0400
Received: from minus.inr.ac.ru ([193.233.7.97]:35595 "HELO ms2.inr.ac.ru")
	by vger.kernel.org with SMTP id <S276258AbRI1Tix>;
	Fri, 28 Sep 2001 15:38:53 -0400
From: kuznet@ms2.inr.ac.ru
Message-Id: <200109281939.XAA05297@ms2.inr.ac.ru>
Subject: Re: [patch] softirq performance fixes, cleanups, 2.4.10.
To: mingo@elte.hu
Date: Fri, 28 Sep 2001 23:39:08 +0400 (MSK DST)
Cc: torvalds@transmeta.com, linux-kernel@vger.kernel.org,
        alan@lxorguk.ukuu.org.uk, bcrl@redhat.com, andrea@suse.de
In-Reply-To: <Pine.LNX.4.33.0109281956200.9978-100000@localhost.localdomain> from "Ingo Molnar" at Sep 28, 1 08:28:59 pm
X-Mailer: ELM [version 2.4 PL24]
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

> unless you have strong arguments against this approach, i will start
> coding this. It's a pretty intrusive change, because all current softirq
> users will have to agree on a generic event format + callback that can be
> queued. This has to be embedded into skbs and bh-handling structs. What do
> you think?

Why skbs?

Anyway, scheme sort of:

do_softirq()
{
	start = jiffies;

	while (dequeue()) {
		if (jiffies - start > 1)
			goto wakeup_ksoftirq
		process();
	}
}

and raise_softirq() enqueuing event to tail, if it is still not queued
is nice, not intrusive and very easy.

Only "skbs" scares me. :-)

Alexey
