Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268588AbRGYQhO>; Wed, 25 Jul 2001 12:37:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268589AbRGYQgz>; Wed, 25 Jul 2001 12:36:55 -0400
Received: from minus.inr.ac.ru ([193.233.7.97]:51474 "HELO ms2.inr.ac.ru")
	by vger.kernel.org with SMTP id <S268585AbRGYQgs>;
	Wed, 25 Jul 2001 12:36:48 -0400
Message-Id: <200107242250.CAA00488@mops.inr.ac.ru>
Subject: Re: ifconfig and SIOCSIFADDR
To: Andries.BRouwer@cwi.NL
Date: Wed, 25 Jul 2001 02:50:24 +0400 (MSD)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <200107241447.OAA07015@vlet.cwi.nl> from "Andries.BRouwer@cwi.NL" at Jul 24, 1 07:15:00 pm
From: Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>
X-Mailer: ELM [version 2.4 PL24]
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

Hello!

> and the last ioctl destroys the information set by the previous two.

Exactly.


> I consider this a kernel bug,

No. And even not a feature, but just the only eligible way.
SIOCSIFADDR resets all previously set address information and
changes it to some legal defaults, otherwise you will stay
with illegal netmask/broadcast set for previously
set address on this interface.

BTW, if no address was selected before, setting netmask
and broadcast etc. simply fails.
So that you had some address set on the interface before
you did the operation and that netmask is set for _that_ address_.


> and ifconfig should assume that SIOCSIFADDR may be destructive
> and hence wait with setting netmask and broadcast address
> until after the SIOCSIFADDR.

I think it is even worse idea. ifconfig is low level tool and should
execute ops in the order, which it was asked. Especially, taking into
account that they are not commutative. Leave this logic to config
scripts or to human brains.

Actually, ifconfig does some too "clever" things by hisorical reasons,
sort of automic upping interface, when setting address. This is very
confusing and inconvenint, however, it is impossible to change by the
same (historical) reasons.

Alexey
