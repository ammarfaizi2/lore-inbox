Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261880AbREMU05>; Sun, 13 May 2001 16:26:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261886AbREMU0h>; Sun, 13 May 2001 16:26:37 -0400
Received: from netcore.fi ([193.94.160.1]:63760 "EHLO netcore.fi")
	by vger.kernel.org with ESMTP id <S261880AbREMU02>;
	Sun, 13 May 2001 16:26:28 -0400
Date: Sun, 13 May 2001 23:26:23 +0300 (EEST)
From: Pekka Savola <pekkas@netcore.fi>
To: <kuznet@ms2.inr.ac.ru>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: IPv6: the same address can be added multiple times
In-Reply-To: <200105131759.VAA27768@ms2.inr.ac.ru>
Message-ID: <Pine.LNX.4.33.0105132319120.3026-100000@netcore.fi>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 13 May 2001 kuznet@ms2.inr.ac.ru wrote:
> Hello!
>
> > It appears you can add _exactly_ same IPv6 address on an interface many
> > times:
>
> Yes. BTW, look here:
>
> kuznet@dust:~ # ip -6 a ls sit0
> 7: sit0@NONE: <NOARP,UP> mtu 1480 qdisc noqueue
>     inet6 ::127.0.0.1/96 scope host
>     inet6 ::193.233.7.100/96 scope global
>     inet6 ::193.233.7.100/96 scope global
>
> I have two equal addresses inherited from one IPv4 address
> on two interfaces. Nothing illegal.

Heh, I doubt there's an RFC that says "you MUST not be able to add the
same address twice to an interface".  I think it's kind of taken for
granted. ;-)

But it still looks dirty.  Also, it's easier to add it many times by
mistake; IPv4 addresses do not allow this.  And as you have to remove them
N times too, this may create even more confusion.

> > It looks like a check or two in kernel is missing, or is there some
> > reasoning to this behaviour?
>
> Well, it is one of well defined approaches (unlike KAME's one).
> Alternative is to implement full set of options NLM_F_* like used
> in IPv4 routing to block undefined cases. In IPv6 flags are hardwired
> to NLM_F_CREATE|NLM_F_APPEND both for addresses and routes.

Well, I can't really formulate an expert opinion as I'm not intimate how
this works on Linux, but I think KAME adds addresses to a structure where
duplicates aren't possible.

Also, what would be the other well defined approaches?  Quickly I can
think of only two, if "only one same address" isn't possible:
 1) never allow any address to be added at all
 2) no significant restrictions (==this)

I don't think the former is what people want either ;-)

Please Cc:.
-- 
Pekka Savola                 "Tell me of difficulties surmounted,
Netcore Oy                   not those you stumble over and fall"
Systems. Networks. Security.  -- Robert Jordan: A Crown of Swords

