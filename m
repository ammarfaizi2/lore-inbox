Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319329AbSIKU1C>; Wed, 11 Sep 2002 16:27:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319331AbSIKU1C>; Wed, 11 Sep 2002 16:27:02 -0400
Received: from mailout07.sul.t-online.com ([194.25.134.83]:53698 "EHLO
	mailout07.sul.t-online.com") by vger.kernel.org with ESMTP
	id <S319329AbSIKU1B> convert rfc822-to-8bit; Wed, 11 Sep 2002 16:27:01 -0400
Content-Type: text/plain; charset=US-ASCII
From: Oliver Neukum <oliver@neukum.name>
To: Daniel Phillips <phillips@arcor.de>, Roman Zippel <zippel@linux-m68k.org>
Subject: Re: [RFC] Raceless module interface
Date: Wed, 11 Sep 2002 22:29:11 +0200
User-Agent: KMail/1.4.1
Cc: Jamie Lokier <lk@tantalophile.demon.co.uk>,
       Alexander Viro <viro@math.psu.edu>,
       Rusty Russell <rusty@rustcorp.com.au>, <linux-kernel@vger.kernel.org>
References: <Pine.LNX.4.44.0209101201280.8911-100000@serv> <200209112053.52426.oliver@neukum.name> <E17pD2j-0007TM-00@starship>
In-Reply-To: <E17pD2j-0007TM-00@starship>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200209112229.11975.oliver@neukum.name>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> > > magic_wait_for_quiescence to complete.  So the try_count approach is
> > > preferable, where it works.
> >
> > But the try_count approach hurts every user of the defined interfaces,
> > even if modules are not used.
>
> Well, it works great for filesystems, which is my point.  And I'll
> bet beer that somebody out there will find another application
> where it works well.  It's all about choice, and the thing about

How would the other version work less well for filesystems ?
How long unloading takes doesn't matter, as long as it's safe.
The overhead while running is the issue, nothing else.

> the proposed interface is, it gives you the flexibility to make
> that choice.  The fact that it's also the simplest interface is
> just nice.

That makes no difference if you have to support two interfaces.

> > Is the impact on the scheduler limited
> > to the time magic_wait_for_quiescence is running.
> > If so, the approach looks superior.
>
> It definitely is not superior for filesystem modules.  However,
> "damm good" would be a nice level of functionality to aim for.
> The more we come to rely on virtual filesystem, the more we care
> that the load/unload procedure should be reliable and fast.

What? Unloading is a rare event in any case.

> Don't forget that point about not being able to put an upper
> bound on the time required to complete the magic wait.
>
> Are you hinting that we only need, and only ever will need, one
> mechanism here, so the module doesn't need to return a result
> from cleanup_module?  If so then I should add that we don't just

Returning the error value is good.

> have varying requirements for cleanup style between modules, but
> other problems, such as single modules that support multiple
> services, which are common in the pcmcia world.

	Regards
		Oliver

