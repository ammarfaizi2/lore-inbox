Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270958AbRH1NaB>; Tue, 28 Aug 2001 09:30:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270973AbRH1N3v>; Tue, 28 Aug 2001 09:29:51 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:8972 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S270958AbRH1N3j>; Tue, 28 Aug 2001 09:29:39 -0400
Date: Tue, 28 Aug 2001 06:27:22 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Roman Zippel <zippel@linux-m68k.org>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: [IDEA+RFC] Possible solution for min()/max() war
In-Reply-To: <3B8B91D1.A4D5C23F@linux-m68k.org>
Message-ID: <Pine.LNX.4.33.0108280617250.8365-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 28 Aug 2001, Roman Zippel wrote:
>
> Linus Torvalds wrote:
>
> > I know people don't understand about the difference between signed and
> > unsigned compares, and people may not even realize that just by doing
> > the patches David ended up fixing a few real bugs that were uncovered
> > simply by virtue of having to think about what kind of comparison it was
> > supposed to be.
>
> What's wrong with "-Wsign-compare"? You just fixed only a minor amount
> of compares.

-Wsign-compare is TOTALLY useless.

The problem with signed compares is not just comparing a signed entity
against a unsigned one. It's quite common to have signed quantities on
both sides, but _intending_ a unsigned comparison or vice versa.

This is simply an area where it's better to make people think about the
types, than to magically try to do the "right" thing.

> What's wrong with this version?

[ Standard stupid min() removed ]

You just fixed the "re-use arguments" bug - which is a bug, but doesn't
address the fact that most of the min/max bugs are due to the programmer
_indending_ a unsigned compare because he didn't even think about the
type.

		Linus

