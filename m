Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262562AbUJ1A7I@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262562AbUJ1A7I (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Oct 2004 20:59:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262528AbUJ1A7H
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Oct 2004 20:59:07 -0400
Received: from ipcop.bitmover.com ([192.132.92.15]:11197 "EHLO
	work.bitmover.com") by vger.kernel.org with ESMTP id S262609AbUJ1Aya
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Oct 2004 20:54:30 -0400
Date: Wed, 27 Oct 2004 17:54:12 -0700
From: Larry McVoy <lm@bitmover.com>
To: Roman Zippel <zippel@linux-m68k.org>
Cc: Larry McVoy <lm@bitmover.com>, Linus Torvalds <torvalds@osdl.org>,
       Andrea Arcangeli <andrea@novell.com>, Joe Perches <joe@perches.com>,
       Paolo Ciarrocchi <paolo.ciarrocchi@gmail.com>,
       Jeff Garzik <jgarzik@pobox.com>,
       Linux Kernel <linux-kernel@vger.kernel.org>, akpm@osdl.org
Subject: Re: BK kernel workflow
Message-ID: <20041028005412.GA8065@work.bitmover.com>
Mail-Followup-To: Larry McVoy <lm@work.bitmover.com>,
	Roman Zippel <zippel@linux-m68k.org>, Larry McVoy <lm@bitmover.com>,
	Linus Torvalds <torvalds@osdl.org>,
	Andrea Arcangeli <andrea@novell.com>, Joe Perches <joe@perches.com>,
	Paolo Ciarrocchi <paolo.ciarrocchi@gmail.com>,
	Jeff Garzik <jgarzik@pobox.com>,
	Linux Kernel <linux-kernel@vger.kernel.org>, akpm@osdl.org
References: <1098707342.7355.44.camel@localhost.localdomain> <20041025133951.GW14325@dualathlon.random> <20041025162022.GA27979@work.bitmover.com> <20041025164732.GE14325@dualathlon.random> <Pine.LNX.4.58.0410251017010.27766@ppc970.osdl.org> <Pine.LNX.4.61.0410252350240.17266@scrub.home> <20041026010141.GA15919@work.bitmover.com> <Pine.LNX.4.61.0410270338310.877@scrub.home> <20041027035412.GA8493@work.bitmover.com> <Pine.LNX.4.61.0410272214580.877@scrub.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.61.0410272214580.877@scrub.home>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 27, 2004 at 10:58:03PM +0200, Roman Zippel wrote:
> Allow me to translate that what this means, so everyone clearly knows 
> what's going on here:
> The complete development history of the Linux kernel is now effectly 
> locked into the bk format, you can get a summary of it, but that's it.

That's not even close to being the case.

100% of the information is available on bkbits.net, diffs, comments, 
everything, all of which you can get at with a wget in a form that
is perfect for import into another system.

100% of the data, diffs, comments, everything, is available in a BK2CVS
exported CVS tree.  The comparison of the metadata is as follows:

    System          File deltas		Commits
    BK              203,999		53,274        (1)
    CVS             195,689		23,429        (2)

In other words, the files which contain the data have 96% of the same
information as the BK files, at the same boundaries, the same patches can
be generated, etc.  In 4% of the cases you are looking at a patch which
was two commits in BK but one commit in CVS.  In 4% of the cases only.
96% of the time you'd get the same patch from each system.

Every commit in CVS matches up to a commit in BK, so every commit in CVS
represents a point in the BK history where you get identical output from
BK and CVS.

That's pretty darned good IMO.  You could pick up with those CVS files
and move forward and you've lost no data, no history, and only a tiny
amount of patch boundary history.

What you have lost is some metadata which doesn't translate into CVS and
doesn't translate into Arch, so that's pointless.  And as Andrea said,
Arch can't handle more than 5,000 changesets, and the history exported
is almost 5 times that.

Maybe you weren't aware that that is the situation so you were complaining
about something that wasn't true.  Now that you are aware that you are
getting all of the data, all of the comments, in a form which is 96%
of the way to being identical to BK you will no longer have a complaint.

Regardless of what you believe, Roman, I think that anyone can see that
the statement that the development history of Linux kernel is locked 
into the BK format is not true.  I can't believe anyone could look at 
the data and come to your conclusion.

--lm

(1) To reproduce these numbers, get a BK 2.5 tree and do this:

	CSETS=`bk prs -hnd:I: ChangeSet | wc -l`
	BOTH=`bk -r prs -hnd:I: | wc -l`
	DELTAS=`expr $BOTH - $CSETS`

(2) To reproduce these numbers, get a BK2CVS 2.5 tree and do this:

	DELTAS=`find . -name '*,v' | grep -v ChangeSet,v | xargs egrep '^head[[:space:]]+1\.[0-9]+;|^next[[:space:]]+1\.[0-9]+;' | wc -l`

	Similarly for the ChangeSet,v file to get csets.
