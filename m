Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262327AbTJOQGw (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Oct 2003 12:06:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262354AbTJOQGw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Oct 2003 12:06:52 -0400
Received: from mx1.redhat.com ([66.187.233.31]:64009 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S262327AbTJOQGt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Oct 2003 12:06:49 -0400
Date: Wed, 15 Oct 2003 17:06:21 +0100
From: Dave Jones <davej@redhat.com>
To: Thomas Schlichter <schlicht@uni-mannheim.de>
Cc: William Lee Irwin III <wli@holomorphy.com>, Pavel Machek <pavel@ucw.cz>,
       Larry Sendlosky <lsendlosky@katana-technology.com>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: mem=16MB laptop testing
Message-ID: <20031015160621.GA6181@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Thomas Schlichter <schlicht@uni-mannheim.de>,
	William Lee Irwin III <wli@holomorphy.com>,
	Pavel Machek <pavel@ucw.cz>,
	Larry Sendlosky <lsendlosky@katana-technology.com>,
	Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
References: <20031014105514.GH765@holomorphy.com> <20031015132824.GS16158@holomorphy.com> <3F8D52CD.2000909@katana-technology.com> <200310151738.55113.schlicht@uni-mannheim.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200310151738.55113.schlicht@uni-mannheim.de>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 15, 2003 at 05:38:45PM +0200, Thomas Schlichter wrote:
 > Well, as davej submitted his patch he seems to just have missed a Changeset 
 > applied to the 2.4 tree...:
 > 
 > ChangeSet@1.404.2.2  2002-05-06 21:30:10-03:00  hch@infradead.org

Around June last year was when I didn't have enough spare time to
continue doing the 2.4 -> 2.5 pushes as frequently as I had.
As a result, lots of bits fell through the cracks, and no-one else
really bothered to step up and take over this much needed role.

 > So obviously this should be fixed in the 2.6 tree too!

Looks that way.

 > P.S.: How can be assured that fixes for the 2.4 tree get into the 2.6 tree 
 > when they are needed there, too?

There's a number of possible approaches.

The "realtime" method.
 As a cset gets merged in 2.4, push it to 2.6 if needed.
This is what I was doing in early 2.5.x in the -dj branch.
It does however require you watch the trees constantly, which is a time sink,
but if you're like me, and you do that anyway...
This method can easily be a full time job depending on the rate of
change happening in both trees. It is however a good way to learn about
many different parts of the tree, and get a good "global" view of whats
going on in the trees.
This method falls apart if you have to take time off for any reason.
Coming back after a month with around a gig of Changesets to sift
through (and more constantly coming in whilst you're sifting) is a
real energy drain.  I was probably one of the few people who was glad
when Linus/Marcelo went on vacation, as it was good 'catch up' time.

The "painful" method.
 Finding someone to go through every changeset committed since ~2.4.18/.19
 which was when I stopped doing the sync and making sure that they got into
 2.6 too.

The "less effort" approach.
 Do it on an as-needed basis, when issues crop up like this one, check out
 the same code in 2.4, see what changed, see if theres anything that got
 missed.

The "distributed" method.
 Many monkeys make light work. Pick a random driver.
 diff -u linux-2.4/drivers/$foo linux-2.6/drivers/$foo
 review diff. Make patches if needed.


There are also other problems not covered above.
- Some csets don't make sense to forward port even though they
  may look like "obvious fixes".
- Linus has been known to reject patches that made it into 2.4
  This is a *real pain* when the cset isn't a 1-2 liner.
- Nothing remains still very long.
  Fixes that went into 2.4 may need considerable rewriting and
  bending to fit in 2.6. This was incredibly painful for some parts
  of the kernel, but again.. is a good learning process.
- Some kernel hacker prima donna's really hate you touching "their" code
  despite the fact you're submitting the same patch they pushed in 2.4
  Be prepared to deal with assholes, and have to retransmit patches
  dozens of times before they make it in via them, (or be prepared to
  put up with the abuse when you shortcut them and send to Linus).

It is a very time consuming, laborious, largely thankless process with few
rewards other than satisfaction that you've "done something worthwhile",
and the good learning experience.

 > I'd wonder if this missed CS is the only one...

I wish..

		Dave

-- 
 Dave Jones     http://www.codemonkey.org.uk
