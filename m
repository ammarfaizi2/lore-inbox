Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264649AbSLIIl3>; Mon, 9 Dec 2002 03:41:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264672AbSLIIl3>; Mon, 9 Dec 2002 03:41:29 -0500
Received: from smtp01.uc3m.es ([163.117.136.121]:48133 "HELO smtp.uc3m.es")
	by vger.kernel.org with SMTP id <S264649AbSLIIl2>;
	Mon, 9 Dec 2002 03:41:28 -0500
Date: Mon, 9 Dec 2002 09:49:02 +0100
Message-Id: <200212090849.gB98n2319698@oboe.it.uc3m.es>
From: "Peter T. Breuer" <ptb@it.uc3m.es>
To: ahtraps@yahoo.com (Andy Trap)
Subject: Re: Difference between dummy and loopback interfaces
X-Newsgroups: comp.os.linux.networking
In-Reply-To: <e414a6f2.0212082318.71702ff9@posting.google.com>
Cc: linux-kernel@vger.kernel.org
User-Agent: tin/1.4.4-20000803 ("Vet for the Insane") (UNIX) (Linux/2.2.15 (i686))
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <e414a6f2.0212082318.71702ff9@posting.google.com> you wrote:
> I have read this. But the description leaves the following questions
> unanswered:

> 1. How this is any different than configuring the IP address of vlite
>    (72.16.1.65) on the loopback interface.

It's very different. RH's parctice of configuring the loopback device
as something other than (in addition to) localhost (no domain!) is just
plain broken, as umpteen administrators will tell you. localhost is
in the root domain, and nowhere else, netwise.

> 2. The implementation of dummy_xmit() unconditionally drops every packet
>    sent to it which suggests that intra-node communication can never
>    occur over a dummy interface. The loopback interface on the other
>    hand queues packets sent to it on the receive queue (allowing intra-
>    node communication even when the dialup line is down)

> I can't think of a condition where a dummy device is useful (other than
> for simulating a blackhole device which sucks every packet sent to it).

The dummy device is conventionally used to provide a separate interface
that can be used to bind the hostname to when there is no real nic in
the box to bind it to (binding it to loopback being a no no). One
ususally does if-down ppp0, for example, with a few lines in that
brings up the hostname on dummy0. When ppp comes up, the hostname may
be bound to the ppp0 connection, but personally I prefer t leave it
stable.

"a stable binding point" for the hostname is another use for dummy0,
when the configuration is dynamic, such as in a failover cluster.

Peter
