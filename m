Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129051AbRBUSIG>; Wed, 21 Feb 2001 13:08:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129134AbRBUSH5>; Wed, 21 Feb 2001 13:07:57 -0500
Received: from minus.inr.ac.ru ([193.233.7.97]:33805 "HELO ms2.inr.ac.ru")
	by vger.kernel.org with SMTP id <S129051AbRBUSHp>;
	Wed, 21 Feb 2001 13:07:45 -0500
From: kuznet@ms2.inr.ac.ru
Message-Id: <200102211807.VAA16020@ms2.inr.ac.ru>
Subject: Re: 2.4.1 under heavy network load - more info
To: magnus.walldal@b-linc.com (Magnus Walldal)
Date: Wed, 21 Feb 2001 21:07:28 +0300 (MSK)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <HFEDLHHPHHEOBHLNPJOKAEIBCAAA.magnus.walldal@b-linc.com> from "Magnus Walldal" at Feb 21, 1 12:16:16 pm
X-Mailer: ELM [version 2.4 PL24]
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

> OK! I actually expected 2.4 to be somewhat selftuning.

Defaults for these numbers (X,Y,Z) are very conservative.


> Interesting you say that, I looked at the logs and I see over 5000 sockets
> used, does'nt look peaceful to me. But you are absolutely right about the
> orphans. The error about "too many orphans" must be wrong and is triggered
> by some other condition. Look at the output from the debug printk I've
> added:
> 
> Feb 18 15:43:50 mcquack kernel: TCP: too many of orphaned sockets

Well, message is not accurate. It refuses to hold this particular
orphan, because it feels that too much of memory is consumed.
Change number Z and the message will disappear.

Poor orphans are the first victims, because they have nobody
to take care of, but kernel. And kernel is harsh parent. 8)


> I raised the numbers a little bit more. Now with 128MB RAM in the box we can
> handle a maximum of 7000 connections. No more because we start to swap too
> much.

Really? Well, it is unlikely to have something with net.
Your dumps show that at 6000 connections networking eated less
than 10MB of memory. Probably, swapping is mistuned.


> Feb 21 10:43:41 mcquack kernel: KERNEL: assertion (tp->lost_out == 0) failed
> at tcp_input.c(1202):tcp_remove_reno_sacks

This is also debugging. Harmless.


> 2) The error about "too many orphans" is bogus?

Yes. It is sort of desinformation. It means really that
accounting detected excess of limits, which are set.


> 3) I will get a lot of debug crap i syslog

It will disappear as soon as debugging is disabled. I.e. when
kernel will enter distributions, I guess.

If I was responsible for this, I would not kill them.
The more messages is the better. Otherwise you would have
nothing to report and even did not notice that something is wrong. 8)


> This happened once under very heavy load (8000+ connections) and I have been
> unable to reproduce.

Probably this has nothing to do with tcp, but explained by some
vm failure, sort of oom killer.

Alexey
