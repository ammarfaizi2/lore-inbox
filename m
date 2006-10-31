Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1423727AbWJaSNj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423727AbWJaSNj (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 Oct 2006 13:13:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423744AbWJaSNj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 Oct 2006 13:13:39 -0500
Received: from nic.NetDirect.CA ([216.16.235.2]:53444 "EHLO
	rubicon.netdirect.ca") by vger.kernel.org with ESMTP
	id S1423727AbWJaSNi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 Oct 2006 13:13:38 -0500
X-Originating-Ip: 72.57.81.197
Date: Tue, 31 Oct 2006 13:11:06 -0500 (EST)
From: "Robert P. J. Day" <rpjday@mindspring.com>
X-X-Sender: rpjday@localhost.localdomain
To: Borislav Petkov <petkov@math.uni-muenster.de>
cc: David Rientjes <rientjes@cs.washington.edu>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] sched.c : correct comment for this_rq_lock() routine
In-Reply-To: <20061031153021.GA14505@gollum.tnic>
Message-ID: <Pine.LNX.4.64.0610311250500.22528@localhost.localdomain>
References: <Pine.LNX.4.64.0610301600550.12811@localhost.localdomain>
 <Pine.LNX.4.64N.0610301308290.17544@attu2.cs.washington.edu>
 <Pine.LNX.4.64.0610301623360.13169@localhost.localdomain>
 <20061031153021.GA14505@gollum.tnic>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Net-Direct-Inc-MailScanner-Information: Please contact the ISP for more information
X-Net-Direct-Inc-MailScanner: Found to be clean
X-Net-Direct-Inc-MailScanner-SpamCheck: not spam, SpamAssassin (not cached,
	score=-1.985, required 5, autolearn=not spam, ALL_TRUSTED -1.80,
	BAYES_40 -0.18)
X-Net-Direct-Inc-MailScanner-From: rpjday@mindspring.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 31 Oct 2006, Borislav Petkov wrote:

> In case you're still doubtful about volunteering:
>
> http://lkml.org/lkml/2004/12/20/255

at the risk of being somewhat long-winded, let me explain what i think
is a fundamental conflict involving patch submission, particularly WRT
what are called "trivial" patches.

unlike non-trivial patches such as obvious bug fixes, trivial patches
obviously don't get quite the attention and, because of that, they
have a tendency to collect until someone decides to, say, apply all of
them at once.  most of the time, that's not a problem -- if they're
simply typo fixes or adding comments, then there's no rush.  but
that's not always the case.

in some cases, waiting for the application of one trivial patch might
hold up the submission of another dependent (trivial) patch.  as an
example, i was just poking around the source for the various
"atomic.h" files and noticed a couple possible cleanups:

  1) make sure *everyone* uses "volatile" in the typedef struct (which
	i actually submitted recently)

  2) standardize on "inline", rather than the current messy mixture of
	both "inline" and "__inline__" (which i'm guessing exists for
	backward compatibility)

for the sake of argument, let's assume those were two perfectly
acceptable cleanups and that no one had any objection.  (i'm just
hypothesizing here, so nobody get their underoos in a bunch. :-)

personally, i'd prefer to submit them as separate patches, since i
like my patches to each represent a single logical issue.  so to start
things off, i submit a patch to fix the "volatile" issue.  that
*seems* like a trivial patch, so i submit it as such.  and because
it's marked as trivial, there's no rush to get to it.

if that first trivial patch now changes line numbers sufficiently in
the affected files, then i really have to wait for it to be applied
before i submit the following trivial patch to make sure that second
patch applies cleanly against the updated source.  so i might sit
there, waiting for that first application before i can go ahead with
the second submission.  and i wait, and i wait, and i wait ...

in general, while some patches might very well look "trivial," they
could very well be some preliminary/aesthetic cleanup that has to be
done to set the stage for more involved work that has a real effect.
but that more involved work is just going to have to sit and wait.  if
the trivial stuff got applied more quickly, it would seem that that
would speed up the process of getting to the good stuff.

also, it's never clear whether a patch is going to be appropriate.
someone might spend time creating a patch, only to have it rejected
for reasons they never considered.  it might be more useful to be able
to ask, "hey, i have an idea for a patch, what do you think?", and at
least get some feedback right away.

instead, it seems that, whenever one makes a suggestion along those
lines, the standard reply is just, "submit a patch."  so one creates a
patch and submits it, and it gets rejected after all.  that gets a
little discouraging after a while.

if anyone has a suggestion as to how to make this process more
enjoyable and productive, i'm all ears.

rday
