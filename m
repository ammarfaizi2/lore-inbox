Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130413AbRBTUPV>; Tue, 20 Feb 2001 15:15:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130404AbRBTUPL>; Tue, 20 Feb 2001 15:15:11 -0500
Received: from minus.inr.ac.ru ([193.233.7.97]:3588 "HELO ms2.inr.ac.ru")
	by vger.kernel.org with SMTP id <S130540AbRBTUOe>;
	Tue, 20 Feb 2001 15:14:34 -0500
From: kuznet@ms2.inr.ac.ru
Message-Id: <200102202014.XAA00920@ms2.inr.ac.ru>
Subject: Re: 2.4.1 under heavy network load - more info
To: magnus.walldal@b-linc.COM (Magnus Walldal)
Date: Tue, 20 Feb 2001 23:14:06 +0300 (MSK)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <HFEDLHHPHHEOBHLNPJOKIEHNCAAA.magnus.walldal@b-linc.com> from "Magnus Walldal" at Feb 19, 1 06:15:01 pm
X-Mailer: ELM [version 2.4 PL24]
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

> of errors a bit but I'm not sure I fully understand the implications of
> doing so.

Until these numbers do not exceed total amount of RAM, this is exactly
the action required in this case.

Dumps, which you sent to me, show nothing pathological. Actually,
they are made in some period of full peace: only 47 orphans and
only about 10MB of accounted memory.


> echo 30 > /proc/sys/net/ipv4/tcp_fin_timeout

This is not essential with 2.4. In 2.4 this state does not grab any essential
resources.

> echo 0 > /proc/sys/net/ipv4/tcp_timestamps
> echo 0 > /proc/sys/net/ipv4/tcp_sack

Why?


> echo "3072 3584 6144" > /proc/sys/net/ipv4/tcp_mem

If you still have problems with orphans, you should raise these
numbers. Extremal settings are sort of:

Z=<total amount of ram in pages>
Y=<something < Z>
Z=<something < Y>
echo "$X $Y $Z" > /proc/sys/net/ipv4/tcp_mem

Set them to maximum and if the messages will not disappear completely,
decrease them to more tough limits.


> Feb 18 15:05:44 mcquack kernel: sending pkt_too_big to self

Normal. Debugging.


> Feb 18 15:24:07 mcquack kernel: TCP: peer xx.xx.xx.xx:1084/7000 shrinks
> window 2106777705:1072:2106779313. Bad, what else can I say?

Debugging too.

> Feb 18 15:42:06 mcquack kernel: TCP: dbg sk->wmem_queued 5664
> tcp_orphan_count 99 tcp_memory_allocated 6145

Number Z is exceeded, newly _closed_ sockets will be aborted and
stack entered state of moderation of its appetite.

Dump, which you have sent to me and further messages in logs,
show that it succeded and converged to normal state.


> Please let me know if I can provide more debug info or test something!

Actually, the only dubious place in your original report was something
about behaviour of ssh. ssh surely cannot be affected by this effect.
Could you elaborate this? What kind of problem exactly? Maybe, some
tcpdump is the problem is reproducable.

Alexey
