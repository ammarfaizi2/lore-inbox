Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262067AbVBJJhK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262067AbVBJJhK (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Feb 2005 04:37:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262081AbVBJJhK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Feb 2005 04:37:10 -0500
Received: from mx1.redhat.com ([66.187.233.31]:38297 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S262067AbVBJJgz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Feb 2005 04:36:55 -0500
To: lm@bitmover.com (Larry McVoy)
Cc: Stelian Pop <stelian@popies.net>, Francois Romieu <romieu@fr.zoreil.com>,
       linux-kernel@vger.kernel.org
Subject: Re: [RFC] Linux Kernel Subversion Howto
References: <20050204183922.GC27707@bitmover.com>
	<20050204200507.GE5028@deep-space-9.dsnet>
	<20050204201157.GN27707@bitmover.com>
	<20050204214015.GF5028@deep-space-9.dsnet>
	<20050204233153.GA28731@electric-eye.fr.zoreil.com>
	<20050205193848.GH5028@deep-space-9.dsnet>
	<20050205233841.GA20875@bitmover.com>
	<20050208154343.GH3537@crusoe.alcove-fr>
	<20050208155845.GB14505@bitmover.com>
	<ord5vatdph.fsf@livre.redhat.lsd.ic.unicamp.br>
	<20050209155113.GA10659@bitmover.com>
From: Alexandre Oliva <aoliva@redhat.com>
Organization: Red Hat Global Engineering Services Compiler Team
Date: 10 Feb 2005 07:36:15 -0200
In-Reply-To: <20050209155113.GA10659@bitmover.com>
Message-ID: <or7jlgpxio.fsf@livre.redhat.lsd.ic.unicamp.br>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Feb  9, 2005, lm@bitmover.com (Larry McVoy) wrote:

> On Wed, Feb 09, 2005 at 05:06:02AM -0200, Alexandre Oliva wrote:
>> So you've somehow managed to trick most kernel developers into
>> granting you power over not only the BK history

> It's exactly the same as a file system.  If you put some files into a
> file system does the file system creator owe you the knowledge of how
> those files are maintained in the file system?

No, the `how' is not the missing bit.  The missing bit is `what'.

Taking your file system analogy, consider this:

- you only have a filesystem that supports 8.3 file names, all-caps.

- I offer you a new filesystem layer that can supports file names with
  arbitrary lengths, lower-case letters, blanks, etc.  This is
  actually implemented using an 8.3 filesystem structure, adding to it
  some special filename mapping files that a filesystem upper layer will
  interpret to present users with arbitrary filenames.  The actual 8.3
  filenames used under the hood are chosen with a well-defined
  algorithm, that I even offer as part of the filesystem documentation.

- the catch: copy operations from this filesystem to any other are not
  allowed to carry over the filename map that my filesystem happens to
  maintain from 8.3, so the result of the copy to any other filesystem
  will have 8.3 names, even in a copy to a filesystem that does
  support arbitrary file names.


When you claim the Linux community got a very good tool from you, and
that those who use your tool are far better off, and those who don't
are worse off, you fail to realize that there is one thing that all of
us lost in the process: a compelling reason to help develop a Free VCS
tool that could play the role that BK currently does.  Sure, if Linus
hadn't adopted BK, nobody would have any of the metadata that Roman is
requesting.  However, I suspect many would be working towards creating
a tool that would provide everyone with such a tool.

Also, by offering them a tool that will let them get access to the
metadata, but not export it in a form that other tools that supported
changesets and multi-branch patch tracking, you set the people who
chose to adopt BK up for a difficult situation for as soon as a Free
Software tool would be able to offer a similar amount of convenience
as BK does: should they ever decide to switch, they'd have to give up
all of the metadata that was part of the reason for the switch in the
first place, and start over from scratch in the new VCS.  So they
might be further compelled to stick with this proprietary piece of
software, just because the fact that a Free Software equivalent exists
may not be enough for them to offset the penalty of giving up the
metadata.

This was the clever trick I alluded to.  Well done!  Too bad for us.

> Since when is that part of the deal?  Does that mean that I can
> insist you provide me with a detailed specification, without an
> attached GPL, of how GCC works so I can clone the technology into my
> commercial compiler?

Why, sure, and you do get that.  The source code can serve as a pretty
good specification and, as long as you don't copy it directly, you're
free to use it in your proprietary compiler, commercial or not.

> It's the same with any software package.  I know Red Hat uses Oracle,
> why aren't you telling Oracle to disclose how Oracle works inside?

Because that's not the point.  Should Oracle keep part of the data
stored in the database for itself, I would.  But they don't.  It's our
data in there.

What BK is doing to us is equivalent to using a database with a
predetermined set of queries, that operate on the current state of the
database, plus an additional operation to dump all of the transactions
(not the state, the transactions) that have ever been performed on
this database, in a randomized order.  The transactions are all in
diff format, so one could theoretically serialize them and figure out
the complete state of the database at a certain point, but not
necessarily intermediate states, which, in the presence of concurrent
transactions without an intervening serialization event, may not even
exist.  And then one could import the state into another database and
perform queries.

So, you see, having the list of patches/transactions/changesets
without information of what goes atop of what doesn't stop people from
figuring out the current state of the database, but it sure requires
them to do a lot of work to get to it, except for the predetermined
queries.

> What's going on here is no different than Red Hat deciding they don't
> want to pay for Oracle so they are reverse engineering Oracle and
> transferring the technology into MySQL.  

Guess what: we would be able to take all of our data and move it into
a different database.

> We're the only vendor I've ever heard of who provides a mirror of
> the data in a competing free product.

It's not a complete mirror.  If it was, we wouldn't be having this
discussion.  The mirror intentionally excludes information that
actually differentiate BK from CVS and SVN, but not from other
changeset tracking VCS tools.

> Does Oracle do that for you?

I do believe it's possible to have replicated databases with one of
the replicas running Oracle and another replicate running other
database server, yes.

> But somehow we are the bad guys locking you in?

Well, you are locking us in, I don't think there's no debate over
that.  I didn't say you were bad guys for that, I even applauded the
nice trick you played on Linus and other BK adopters.  Personally, I
dislike proprietary software, and will stay away from it as much as
I can.

In this sense, you and Oracle are on the same boat: both have made
some contributions to the Free Software community, but only in so far
as it helps them promote their bottom line, a proprietary software
product.

> OK, if your position is that we are locking you in then you'd have
> no problem if we dropped the CVS gateway, that's of no value to you,
> right?

Of course not.  It would make the lock-in even stronger.  It might be
a good step towards getting people to move away from BK.  I believe
you offer the CVS gateway because you know you have to in order to
keep Linux hosted on BK.  If you didn't, people would be compelled to
find a way out as quickly as possible.

It just so happens that the CVS gateway is enough for most, but not
all, uses, and there are only a few people who care enough about the
missing info to make a fuss about it, so you keep the balance towards
you and BK.  Good for you.

-- 
Alexandre Oliva             http://www.ic.unicamp.br/~oliva/
Red Hat Compiler Engineer   aoliva@{redhat.com, gcc.gnu.org}
Free Software Evangelist  oliva@{lsd.ic.unicamp.br, gnu.org}
