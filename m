Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318496AbSGSK7T>; Fri, 19 Jul 2002 06:59:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318500AbSGSK7T>; Fri, 19 Jul 2002 06:59:19 -0400
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.176.19]:1997 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id <S318496AbSGSK7S>; Fri, 19 Jul 2002 06:59:18 -0400
Date: Fri, 19 Jul 2002 13:02:16 +0200 (CEST)
From: Adrian Bunk <bunk@fs.tum.de>
X-X-Sender: bunk@mimas.fachschaften.tu-muenchen.de
To: Robert Love <rml@tech9.net>
cc: linux-kernel@vger.kernel.org, <alan@redhat.com>
Subject: Re: [PATCH] strict VM overcommit
In-Reply-To: <1027031246.1086.158.camel@sinai>
Message-ID: <Pine.NEB.4.44.0207191251390.17300-100000@mimas.fachschaften.tu-muenchen.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 18 Jul 2002, Robert Love wrote:

> > Out of interest:
> >
> > How is assured that it's impossible to OOM when the amount of memory
> > shrinks?
> >
> > IOW:
> > - allocate very much memory
> > - "swapoff -a"
>
> Well, seriously: don't do that.
>
> But `swapoff' will not succeed if there is not enough swap or physical
> memory to move the pages to... if it does succeed, then there is enough
> storage elsewhere.  At that point, you are not OOM but you may now have
> more address space allocated than the strict accounting would typically
> allow - thus no allocations will succeed so you should not be able to
> OOM.

"thus no allocations will succeed" seems to be a synonymous for "the
machine is more or less dead"?

And this might be a real problem:

If you have a xsession with many open programs and leave it with an xlock
over night it's quite usual that all your applications are swapped out the
next morning. A convenient way to get all your applications swapped in
again is a "swapoff -a; swapon -a". You might argue that this is "wrong"
but it's as far as I know the best solution to get all your applications
swapped in again (and I know several people doing it this way).

If "no allocations will succeed" the first command that will fail is the
"swapon -a"...

> 	Robert Love

cu
Adrian

-- 

You only think this is a free country. Like the US the UK spends a lot of
time explaining its a free country because its a police state.
								Alan Cox

