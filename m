Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277345AbRJJRuA>; Wed, 10 Oct 2001 13:50:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277343AbRJJRts>; Wed, 10 Oct 2001 13:49:48 -0400
Received: from minus.inr.ac.ru ([193.233.7.97]:20753 "HELO ms2.inr.ac.ru")
	by vger.kernel.org with SMTP id <S277344AbRJJRtc>;
	Wed, 10 Oct 2001 13:49:32 -0400
From: kuznet@ms2.inr.ac.ru
Message-Id: <200110101749.VAA04827@ms2.inr.ac.ru>
Subject: Re: RFC : Wireless Netlink events
To: jt@hpl.hp.com
Date: Wed, 10 Oct 2001 21:49:52 +0400 (MSK DST)
Cc: linux-kernel@vger.kernel.org, alan@lxorguk.ukuu.org.uk
In-Reply-To: <20011009184700.B16874@bougret.hpl.hp.com> from "Jean Tourrilhes" at Oct 9, 1 06:47:00 pm
X-Mailer: ELM [version 2.4 PL24]
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

> 	o Is there a way to do a reverse of SIOCGIFINDEX ? If you have
> an interface index, how do you get its name ?

SIOCGIFNAME.

But this does not matter, applications using rtnetlink should
not use these ioctls. They have all the information from rtnetlink.

> 	o Should I put the full interface name in the event ? That
> would make events larger but help query the interface when receiving
> the event.

Never. They are known from context.


> 	o Any other comments ?

I am not sure that it is right and in right place. I would not create one
more message type for such... mmm... special case.
Probably, you could add a new attribute to RTM_*LINK sort of
IFLA_MISC and to send ifinfo messages.

But I see logical flaw: no way to _retrieve_ information about state
on demand. Hence no right application cannot rely only on these messages.
Hence you should go all the way and to allow to dump this and,
probably, to add statistics shown in /proc/net/wireless.

Alexey
