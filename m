Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276209AbRI1R4e>; Fri, 28 Sep 2001 13:56:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276211AbRI1R4Y>; Fri, 28 Sep 2001 13:56:24 -0400
Received: from minus.inr.ac.ru ([193.233.7.97]:19722 "HELO ms2.inr.ac.ru")
	by vger.kernel.org with SMTP id <S276208AbRI1R4I>;
	Fri, 28 Sep 2001 13:56:08 -0400
From: kuznet@ms2.inr.ac.ru
Message-Id: <200109281756.VAA04730@ms2.inr.ac.ru>
Subject: Re: [patch] softirq performance fixes, cleanups, 2.4.10.
To: mingo@elte.hu
Date: Fri, 28 Sep 2001 21:56:24 +0400 (MSK DST)
Cc: torvalds@transmeta.com, linux-kernel@vger.kernel.org,
        alan@lxorguk.ukuu.org.uk, bcrl@redhat.com, andrea@suse.de
In-Reply-To: <Pine.LNX.4.33.0109281904200.8840-100000@localhost.localdomain> from "Ingo Molnar" at Sep 28, 1 07:31:27 pm
X-Mailer: ELM [version 2.4 PL24]
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

> what are you trying to argue, that it's incorrect to re-process softirqs
> if they got activated during the previous pass? I told a number of
> fundamental reasons

I did not find them in your mails.


> (Lets assume that a loop of 10 still ensures basic safety in situations
> where external load overloads the system.

It does not, evidently. And 1 does not. But 10 is 10 times worse.


> Is your point to make the softirq loop to be sysctl-tunable?

No. My point is to make it correctly eventually.

If you will repeat such attempts to "improve" it each third 2.4.x,
it will remain broken forever.


> show you slow enough systems which can be overloaded via hardirqs alone.)

This problem has been solved ages ago. The only remaining question
is how to make this more nicely.


> I think the technically most reasonable approach is to process softirqs
> *as soon as possible*,
...
> please point out flaws in this thinking.

They are processed as soon as possible.

Ingo, I told net_rx_action() is small do_softirq() restarting not 10,
but not less than 300 times in row.

If this logic is wrong, you should explain why it is wrong.
Looping dozen of times may look like cure, but for me it still
looks rather like steroids.

Alexey
