Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130766AbRBPRip>; Fri, 16 Feb 2001 12:38:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130768AbRBPRiZ>; Fri, 16 Feb 2001 12:38:25 -0500
Received: from neon-gw.transmeta.com ([209.10.217.66]:28942 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S130766AbRBPRiU>; Fri, 16 Feb 2001 12:38:20 -0500
Date: Fri, 16 Feb 2001 09:38:08 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: Ben LaHaise <bcrl@redhat.com>
cc: Jamie Lokier <lk@tantalophile.demon.co.uk>,
        Manfred Spraul <manfred@colorfullife.com>,
        linux-kernel@vger.kernel.org
Subject: Re: x86 ptep_get_and_clear question
In-Reply-To: <Pine.LNX.4.30.0102161229090.17251-100000@today.toronto.redhat.com>
Message-ID: <Pine.LNX.4.10.10102160936210.14020-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 16 Feb 2001, Ben LaHaise wrote:

> On Fri, 16 Feb 2001, Jamie Lokier wrote:
> 
> > It should be fast on known CPUs, correct on unknown ones, and much
> > simpler than "gather" code which may be completely unnecessary and
> > rather difficult to test.
> >
> > If anyone reports the message, _then_ we think about the problem some more.
> >
> > Ben, fancy writing a boot-time test?
> 
> Sure, I'll whip one up this afternoon.

How do you expect to ever see this in practice? Sounds basically
impossible to test for this hardware race. The obvious "try to dirty as
fast as possible on one CPU while doing an atomic get-and-clear on the
other" thing is not valid - it's in fact quite likely to get into
lock-step because of page table cache movement synchronization. And as
such it could hide any race.

		Linus

