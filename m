Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289040AbSAIWA6>; Wed, 9 Jan 2002 17:00:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289038AbSAIWAv>; Wed, 9 Jan 2002 17:00:51 -0500
Received: from mail.libertysurf.net ([213.36.80.91]:43813 "EHLO
	mail.libertysurf.net") by vger.kernel.org with ESMTP
	id <S289043AbSAIWAk> convert rfc822-to-8bit; Wed, 9 Jan 2002 17:00:40 -0500
Date: Wed, 9 Jan 2002 22:59:35 +0100 (CET)
From: =?ISO-8859-1?Q?G=E9rard_Roudier?= <groudier@free.fr>
X-X-Sender: <groudier@gerard>
To: Bernard Dautrevaux <Dautrevaux@microprocess.com>
cc: "'dewar@gnat.com'" <dewar@gnat.com>, <bernd@gams.at>, <gcc@gcc.gnu.org>,
        <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] C undefined behavior fix
In-Reply-To: <17B78BDF120BD411B70100500422FC6309E410@IIS000>
Message-ID: <20020109223850.G2914-100000@gerard>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 9 Jan 2002, Bernard Dautrevaux wrote:

> > -----Original Message-----
> > From: dewar@gnat.com [mailto:dewar@gnat.com]
> > Sent: Wednesday, January 09, 2002 11:42 AM
> > To: bernd@gams.at; gcc@gcc.gnu.org; linux-kernel@vger.kernel.org
> > Subject: Re: [PATCH] C undefined behavior fix
> >
> >
> > <<Especially if there are cases were this optimization yields
> > a slower =
> >
> > access (or even worse indirect bugs).
> > E.g. if the referenced "volatile short" is a hardware register and the
> > access is multiplexed over a slow 8 bit bus.  There are
> > embedded systems
> > around where this is the case and the (cross-)compiler has no way to
> > know this (except it can be told by the programmer).
> > >>
> >
> > Well that of course is a situation where the compiler is
> > being deliberately
> > misinformed as to the relative costs of various machine
> > instructions, and
> > that is definitely a problem. One can even imagine hardware
> > (not such a hard
> > feat, one of our customers had such hardware) where a word
> > access works, but
> > a byte access fails due to hardware shortcuts,
>
> Tht's quite often the case with MMIO, and the only portable way to give a
> hint to the compiler that it should refrain from optimizing is "volatile";
> that's why I think the compiler should not do this optimization on volatile
> objects at all.

The C programming language and MMIO are two different things that must not
be mixed.

'volatile' is not enough a portable a concept to deal with MMIO. You also
need to tell about what is atomic and what is not atomic regarding
accesses through the involved BUS, for example. As a result, you may use
'volatile' to avoid assembly for MMIO, but you want to put the code in
architecture dependant code.

The atomicity issue also applies to memory-like access obviously, but the
compiler is expected to know about the architecture capabilities. If this
may differ for a given architecture family, then some compiler options
should be made available.

  Gérard.


