Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277361AbRJJSs3>; Wed, 10 Oct 2001 14:48:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277362AbRJJSsR>; Wed, 10 Oct 2001 14:48:17 -0400
Received: from minus.inr.ac.ru ([193.233.7.97]:43025 "HELO ms2.inr.ac.ru")
	by vger.kernel.org with SMTP id <S277361AbRJJSsG>;
	Wed, 10 Oct 2001 14:48:06 -0400
From: kuznet@ms2.inr.ac.ru
Message-Id: <200110101848.WAA05322@ms2.inr.ac.ru>
Subject: Re: RFC : Wireless Netlink events
To: jt@hpl.hp.com
Date: Wed, 10 Oct 2001 22:48:22 +0400 (MSK DST)
Cc: linux-kernel@vger.kernel.org, alan@lxorguk.ukuu.org.uk
In-Reply-To: <20011010111404.D17439@bougret.hpl.hp.com> from "Jean Tourrilhes" at Oct 10, 1 11:14:04 am
X-Mailer: ELM [version 2.4 PL24]
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

> 	That would not be the case of Wireless Events, the event would
> just contain the type of change and the interface index. See reasons
> for that below.

See below. :-)

> > I am not sure that it is right and in right place. I would not create one
> > more message type for such... mmm... special case.
> > Probably, you could add a new attribute to RTM_*LINK sort of
> > IFLA_MISC and to send ifinfo messages.
> 
> 	The problem is that I need to propagate the "command" field
> (the ioctl number leading to the event), and there is no space for
> that in the ifinfo structure. None of the flags in the ifinfo
> structure would change when those ioctls are called.
> 	I don't mind adding a new attribute to struct ifinfo, but that
> will break existing netlink apps (unless I missed something).

You missed.

All the rtnetlink messages contain a minimal fix part, followed
by variable attributes. New attributes can be added any time
not breaking anything.


> 	Hu ? Just query any of the Wireless IOCTLs,

OK. I see.


> 	The whole Wireless configuration is in the order of 624 bytes
> (including /proc/net/wireless, excluding iwspy/aplist and assuming
> only one encryption key). You surely don't want me to push that with
> every event ?

624? Not a big deal.


> 	The idea is like select() + read(). Select gives you the basic
> event, you need to use read to get the data.

Sorry, I am inclined against issuing lots of sequences of ioctls to get
information. This approach is fragile because you never
get a self-consistent state when state is subject to change.

Logic of rtnetlink is a bit different: you get atomic pieces of information,
which are meaningfull itself.


> 	It seems to me that what you are implying is that RTnetlink is
> not the right place for me to propagate events.

Not at all.

But approach which you outlined really contradicts to logic of rtnetlink yet.
It is not a select(), it is real read(). :-)


>						 Any idea of what
> mechanism might be better to propagate those events ? Maybe I should
> create my own event channel.

Probably. There lots of unused channels. Well, choose the best approach.

Alexey
