Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268511AbRGXXIb>; Tue, 24 Jul 2001 19:08:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268509AbRGXXIV>; Tue, 24 Jul 2001 19:08:21 -0400
Received: from humbolt.nl.linux.org ([131.211.28.48]:65287 "EHLO
	humbolt.nl.linux.org") by vger.kernel.org with ESMTP
	id <S268508AbRGXXIR>; Tue, 24 Jul 2001 19:08:17 -0400
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@bonn-fries.net>
To: Marcelo Tosatti <marcelo@conectiva.com.br>
Subject: Re: [RFC] Optimization for use-once pages
Date: Wed, 25 Jul 2001 00:22:53 +0200
X-Mailer: KMail [version 1.2]
Cc: linux-kernel@vger.kernel.org, Rik van Riel <riel@conectiva.com.br>,
        Ben LaHaise <bcrl@redhat.com>, Mike Galbraith <mikeg@wen-online.de>
In-Reply-To: <Pine.LNX.4.21.0107241722310.2263-100000@freak.distro.conectiva>
In-Reply-To: <Pine.LNX.4.21.0107241722310.2263-100000@freak.distro.conectiva>
MIME-Version: 1.0
Message-Id: <01072500225304.00520@starship>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

On Tuesday 24 July 2001 22:27, Marcelo Tosatti wrote:
> On Tue, 24 Jul 2001, Daniel Phillips wrote:
> > Today's patch tackles the use-once problem, that is, the problem of
> > how to identify and discard pages containing data likely to be used
> > only once in a long time, while retaining pages that are used more
> > often.
> >
> > I'll try to explain not only what I did, but the process I went
> > through to arrive at this particular approach.  This requires some
> > background.
>
> Well, as I see the patch should remove the problem where
> drop_behind() deactivates pages of a readahead window even if some of
> those pages are not "used-once" pages, right ?

Yes, that was a specific goal.

> I just want to make sure the performance improvements you're seeing
> caused by the fix of this _particular_ problem.

Of course I chose the test load to show the benefit clearly, but I
also tried to avoid disturbing any of the existing cases that are
working well.  I did the verification and audit in a hurry, so I
wouldn't be surprised at all if I missed something, but I feel
equally that picking these up is more a matter of adjustment than
change in viewpoint.

> If we knew the amount of non-used-once pages which drop_behind() is
> deactivating under _your_ tests, we could make absolute sure about
> the problem.

Yes, for sure, it's time to use the statistics weapon.  I guess we
need to add in a couple more sensor points.  An obvious place is in
check_used_once.

--
Daniel
