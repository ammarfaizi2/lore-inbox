Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291475AbSBMKJl>; Wed, 13 Feb 2002 05:09:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291473AbSBMKJb>; Wed, 13 Feb 2002 05:09:31 -0500
Received: from mx2.elte.hu ([157.181.151.9]:54152 "HELO mx2.elte.hu")
	by vger.kernel.org with SMTP id <S291492AbSBMKJW>;
	Wed, 13 Feb 2002 05:09:22 -0500
Date: Wed, 13 Feb 2002 13:07:11 +0100 (CET)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: <mingo@elte.hu>
To: Andreas Dilger <adilger@turbolabs.com>
Cc: Rik van Riel <riel@conectiva.com.br>, Larry McVoy <lm@bitmover.com>,
        Tom Rini <trini@kernel.crashing.org>,
        Linus Torvalds <torvalds@transmeta.com>,
        Daniel Phillips <phillips@bonn-fries.net>,
        Alexander Viro <viro@math.psu.edu>,
        Rob Landley <landley@trommello.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: A modest proposal -- We need a patch penguin
In-Reply-To: <20020212190834.W9826@lynx.turbolabs.com>
Message-ID: <Pine.LNX.4.33.0202131300500.16151-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 12 Feb 2002, Andreas Dilger wrote:

> Is this using "bk clone -l" or just "bk clone"?  I would _imagine_
> that since the rmap changes are fairly localized that you would only
> get multiple copies of a limited number of files, and it wouldn't
> increase the size of each repository very much.

the problem is, i'd like to see all these changes in a single tree, and
i'd like to be able to specify whether two changesets have semantic
dependencies on each other or not. BK would still enforce 'hard
orthogonality' - ie. two changesets that change the same line of code
cannot be defined as nondependent on each other, BK should refuse the
checking in of such a changeset. The default dependency should be
something like 'this changeset is dependent on all previous changesets
committed to this repository' - but if the developer wants it then it
should be possible to un-depend two changesets.

it's also true in the other direction: two changesets that have no hard
conflicts could still have semantic dependencies, it's the responsibility
of the developer.

(detail: it might even be possible to define two changesets as orthogonal
even if there are hard conflicts between them. For this to work the
developer has to provide the correct merge in both directions. If that is
done then BK should allow to make the two changesets independent.)

	Ingo

