Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262740AbUJ1DLj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262740AbUJ1DLj (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Oct 2004 23:11:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262731AbUJ1DKO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Oct 2004 23:10:14 -0400
Received: from ipcop.bitmover.com ([192.132.92.15]:12481 "EHLO
	work.bitmover.com") by vger.kernel.org with ESMTP id S262728AbUJ1DJ6
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Oct 2004 23:09:58 -0400
Date: Wed, 27 Oct 2004 20:09:39 -0700
From: Larry McVoy <lm@bitmover.com>
To: Roman Zippel <zippel@linux-m68k.org>
Cc: Larry McVoy <lm@bitmover.com>, Linus Torvalds <torvalds@osdl.org>,
       Andrea Arcangeli <andrea@novell.com>, Joe Perches <joe@perches.com>,
       Paolo Ciarrocchi <paolo.ciarrocchi@gmail.com>,
       Jeff Garzik <jgarzik@pobox.com>,
       Linux Kernel <linux-kernel@vger.kernel.org>, akpm@osdl.org
Subject: Re: BK kernel workflow
Message-ID: <20041028030939.GA11308@work.bitmover.com>
Mail-Followup-To: Larry McVoy <lm@work.bitmover.com>,
	Roman Zippel <zippel@linux-m68k.org>, Larry McVoy <lm@bitmover.com>,
	Linus Torvalds <torvalds@osdl.org>,
	Andrea Arcangeli <andrea@novell.com>, Joe Perches <joe@perches.com>,
	Paolo Ciarrocchi <paolo.ciarrocchi@gmail.com>,
	Jeff Garzik <jgarzik@pobox.com>,
	Linux Kernel <linux-kernel@vger.kernel.org>, akpm@osdl.org
References: <20041025162022.GA27979@work.bitmover.com> <20041025164732.GE14325@dualathlon.random> <Pine.LNX.4.58.0410251017010.27766@ppc970.osdl.org> <Pine.LNX.4.61.0410252350240.17266@scrub.home> <20041026010141.GA15919@work.bitmover.com> <Pine.LNX.4.61.0410270338310.877@scrub.home> <20041027035412.GA8493@work.bitmover.com> <Pine.LNX.4.61.0410272214580.877@scrub.home> <20041028005412.GA8065@work.bitmover.com> <Pine.LNX.4.61.0410280314490.877@scrub.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.61.0410280314490.877@scrub.home>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Warning: long message.  Reason you should read it: because I show you
how you can independently verify, without a BK license, that Roman is
spreading FUD.  So read this, check it out, you'll see that this is
all Roman's nonsense.  If you already believe that, you can skip this
but there is a lot of useful BK2CVS data in this message.  

If any of you doubt our good faith this is the message for you to read,
you can see for yourself.  It would be nice if one of you went off and did
what I suggest and reported back the results.  Who knows, maybe there's
a bug.  If you find that to be the case, we'll fix it and re-export the
whole tree to match what it is I'm saying below but I doubt (famous last
words) that you'll find a bug.  If you do, let me know.

> You're only telling half of the story and I'm afraid you'll get away with 
> it, because most people don't really know the topic that well and I can't 
> blame them.

Any of the BK users can go verify my numbers, I even included the commands
I used to generate those numbers.

It's all well and good to say I'm only telling half of the story but
that's not supported by the data.  You have a perfectly legitimate point
if the BK users were getting a lot more information than you are, i.e.,
if you were stuck on tarball/patches and everyone else had BK.  But that's
not the case, you have 96% as much information as any BK user has.  In 
a form which most BK users wish they had, it's more compact, higher
signal to noise.

As for the comment that people don't know the topic that well, you are
exactly right.  One thing that we gave you in the BK2CVS exporter is
changesets.  We didn't have to do that, in fact, in order to do that we
change things very slightly in the RCS history we output.  We arranged
the date/timestamps so that each delta in each file in the same changeset
has the same time and we arranged so that the date in the ChangeSet file
we export matches those.

That was so it would be trivial for people like you to import the data
into an alternative system which has real changesets and preserve the
changeset boundaries.

We had to DO EXTRA WORK to make that happen.  If we had exported the
data exactly as it appears in BK you couldn't recreate the changeset
boundaries.  You could guess but sometimes you'd guess wrong.  We removed
the guesswork.

To most people this is just noise, they don't understand, but what
they should take away from this is that while you are accusing of us of
making it hard for you, we actually made it easy for you.  Anyone can
go verify this, here is how.  In the BK2CVS tree we created a file
called ChangeSet, it has all the changeset comments you see in BK with
bk changes.  Plus one extra datum which looks like this:

BKrev: 417edb4fCTYTu66uKlGNZJVk9pbDDg

That string corresponds to a changeset rev in bk, if you get a bk tree
and do

	bk changes -vr417edb4fCTYTu66uKlGNZJVk9pbDDg

you will see the changeset comments and the file checkin comments for
that changeset.  You will also see the timestamps, which may vary from
file to file.

In the BK2CVS tree, if you were to do an rlog with the exact date string
associated with that rev over all the files, you'll get the same set of
files as you see in that BK changeset, but all the files will have an
identical date.

It's an invariant in the BK2CVS tree that dates are monotonically
increasing, each changeset has a different date, and each file
participating in the changeset has the same date as the changeset.
None of that is necessarily true in the BK tree.  That's something we
did to make it absolutely TRIVIAL to import this history properly into
some other SCM system like arch or whatever.

I want to underscore that.  We gave you the bk exported tree but we
modified it to make it easier for you to recreate a more exact copy of
what is in BK.  We didn't have to do that, it was extra work, noone could
have faulted us for doing a perfectly exact export, but we tweaked it to
make it easy for you.  I can easily believe that this is the first time
that you realized this.  Whatever, it's true, anyone can go verify it.
It demonstrates a tremendous goodfaith effort on our part to make sure
that you could track a BK tree accurately.

If we were trying to screw you over, as you take every opportunity to
suggest we are, then how do you explain this extra effort we went to?
You yourself can verify this, you don't need a BK license, those strings
work in bkweb.  You go to

http://linux.bkbits.net:8080/linux-2.5/gnupatch@417edb4fCTYTu66uKlGNZJVk9pbDDg

i.e.,

http://linux.bkbits.net:8080/linux-2.5/gnupatch@$BKREV

for any value of Bkrev in the BK2CVS export tree, you'll see the list of
files, you'll see the dates.  Now go look at the same list of files in the
BK2CVS tree and you'll notice that the dates are just slightly different,
usually by a few seconds, but regardless of the amount they are different,
they are always the same value in all files in the same changeset.

Just so you, my loyal enemy, can have an easier time to import this data
correctly into your favorite competing system.

Go verify that, see that I'm telling the truth, see that the BK data is
slightly less consistent, and explain to me what possible reason we could
have had for doing that other than to help you.  Then explain to me how
you can claim that we're trying to screw you somehow in that history.

I know _you_ won't, you are prejudiced against us so anything which might
show us in a positive light isn't something you will do.  But any other
reader of this thread can do it, some will do it, and I hope they report
back here that things are exactly as I say they are and that the only
conclusion anyone can draw is that you are fanatical guy who doesn't
want realize or admit we actually tried to help you in good faith.
I don't really care if you ever realize that but I'd like it if other
people went off and checked and figured out "hey, those BitMover guys
may have a wacky license but they really are trying to help, they even
try and help the non-BK users".  That would be nice.
-- 
---
Larry McVoy                lm at bitmover.com           http://www.bitkeeper.com
