Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129098AbRBULPc>; Wed, 21 Feb 2001 06:15:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129516AbRBULPX>; Wed, 21 Feb 2001 06:15:23 -0500
Received: from cthulhu.lls.se ([193.15.114.2]:50936 "HELO cthulhu.lls.se")
	by vger.kernel.org with SMTP id <S129098AbRBULPQ>;
	Wed, 21 Feb 2001 06:15:16 -0500
From: "Magnus Walldal" <magnus.walldal@b-linc.com>
To: <kuznet@ms2.inr.ac.ru>
Cc: <linux-kernel@vger.kernel.org>
Subject: RE: 2.4.1 under heavy network load - more info
Date: Wed, 21 Feb 2001 12:16:16 +0100
Message-ID: <HFEDLHHPHHEOBHLNPJOKAEIBCAAA.magnus.walldal@b-linc.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.2416 (9.0.2910.0)
In-Reply-To: <200102202014.XAA00920@ms2.inr.ac.ru>
Importance: Normal
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4133.2400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> Hello!
>
> > of errors a bit but I'm not sure I fully understand the implications of
> > doing so.
>
> Until these numbers do not exceed total amount of RAM, this is exactly
> the action required in this case.

OK! I actually expected 2.4 to be somewhat selftuning. But if I exceed the
amount of physical RAM because I use a lot of sockets, I can understand that
Linux refuse.

> Dumps, which you sent to me, show nothing pathological. Actually,
> they are made in some period of full peace: only 47 orphans and
> only about 10MB of accounted memory.

Interesting you say that, I looked at the logs and I see over 5000 sockets
used, does'nt look peaceful to me. But you are absolutely right about the
orphans. The error about "too many orphans" must be wrong and is triggered
by some other condition. Look at the output from the debug printk I've
added:

Feb 18 15:43:50 mcquack kernel: TCP: too many of orphaned sockets
Feb 18 15:43:50 mcquack kernel: TCP: debug sk->wmem_queued 5364
tcp_orphan_count 124 tcp_memory_allocated 6146

Not many orphans but still an error, OK!

> > echo 30 > /proc/sys/net/ipv4/tcp_fin_timeout
>
> This is not essential with 2.4. In 2.4 this state does not grab
> any essential
> resources.
>
> > echo 0 > /proc/sys/net/ipv4/tcp_timestamps
> > echo 0 > /proc/sys/net/ipv4/tcp_sack
>
> Why?

Removed, makes not visible difference. OK!

> > echo "3072 3584 6144" > /proc/sys/net/ipv4/tcp_mem
>
> If you still have problems with orphans, you should raise these
> numbers. Extremal settings are sort of:
> Dump, which you have sent to me and further messages in logs,
> show that it succeded and converged to normal state.

I raised the numbers a little bit more. Now with 128MB RAM in the box we can
handle a maximum of 7000 connections. No more because we start to swap too
much.

Feb 21 10:43:41 mcquack kernel: KERNEL: assertion (tp->lost_out == 0) failed
at tcp_input.c(1202):tcp_remove_reno_sacks

One about every 10 minutes.

I want to add a few conclusions and observasions to all this. Previously the
owner of this machine handled about 10k connections with FreeBSD, same
amount of RAM, same app and no tuning.

To run with very many sockets open I have to
1) Tune Linux heavily
and
2) The error about "too many orphans" is bogus?
3) I will get a lot of debug crap i syslog
4) FreeBSD with the same hardware and software handles more connections

Found this article, "The Linux 20k" socket challenge. Pretty interesting!
http://old.jabber.org/article/34.html


> Actually, the only dubious place in your original report was something
> about behaviour of ssh. ssh surely cannot be affected by this effect.
> Could you elaborate this? What kind of problem exactly? Maybe, some
> tcpdump is the problem is reproducable.
>
> Alexey

This happened once under very heavy load (8000+ connections) and I have been
unable to reproduce.

We have decided to upgrade the system and try to handle 20-30k connections,
will let you know how it goes!

Regards,
Magnus Walldal

