Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263212AbREMR75>; Sun, 13 May 2001 13:59:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263214AbREMR7h>; Sun, 13 May 2001 13:59:37 -0400
Received: from minus.inr.ac.ru ([193.233.7.97]:57605 "HELO ms2.inr.ac.ru")
	by vger.kernel.org with SMTP id <S263212AbREMR7a>;
	Sun, 13 May 2001 13:59:30 -0400
From: kuznet@ms2.inr.ac.ru
Message-Id: <200105131759.VAA27768@ms2.inr.ac.ru>
Subject: Re: IPv6: the same address can be added multiple times
To: pekkas@netcore.FI (Pekka Savola)
Date: Sun, 13 May 2001 21:59:07 +0400 (MSK DST)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.33.0105031202080.13012-100000@netcore.fi> from "Pekka Savola" at May 3, 1 01:15:01 pm
X-Mailer: ELM [version 2.4 PL24]
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

> It appears you can add _exactly_ same IPv6 address on an interface many
> times:

Yes. BTW, look here:

kuznet@dust:~ # ip -6 a ls sit0
7: sit0@NONE: <NOARP,UP> mtu 1480 qdisc noqueue
    inet6 ::127.0.0.1/96 scope host
    inet6 ::193.233.7.100/96 scope global
    inet6 ::193.233.7.100/96 scope global

I have two equal addresses inherited from one IPv4 address
on two interfaces. Nothing illegal.



> FWIW, KAME stack adds the address only once(, but BSD ifconfig(8)
> doesn't show errors when you try to do it again; just doesn't add the
> second one).

8)

> It looks like a check or two in kernel is missing, or is there some
> reasoning to this behaviour?

Well, it is one of well defined approaches (unlike KAME's one).
Alternative is to implement full set of options NLM_F_* like used
in IPv4 routing to block undefined cases. In IPv6 flags are hardwired
to NLM_F_CREATE|NLM_F_APPEND both for addresses and routes.

Alexey
