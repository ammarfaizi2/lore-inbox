Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261324AbVBGBpk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261324AbVBGBpk (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 6 Feb 2005 20:45:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261334AbVBGBpk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 6 Feb 2005 20:45:40 -0500
Received: from scrub.xs4all.nl ([194.109.195.176]:49121 "EHLO scrub.xs4all.nl")
	by vger.kernel.org with ESMTP id S261324AbVBGBpZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 6 Feb 2005 20:45:25 -0500
Date: Mon, 7 Feb 2005 02:45:22 +0100 (CET)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@scrub.home
To: Larry McVoy <lm@bitmover.com>
cc: Stelian Pop <stelian@popies.net>, linux-kernel@vger.kernel.org
Subject: Re: [RFC] Linux Kernel Subversion Howto
In-Reply-To: <20050206173910.GB24160@bitmover.com>
Message-ID: <Pine.LNX.4.61.0502061859000.30794@scrub.home>
References: <20050202155403.GE3117@crusoe.alcove-fr>
 <200502030028.j130SNU9004640@terminus.zytor.com> <20050203033459.GA29409@bitmover.com>
 <20050203193220.GB29712@sd291.sivit.org> <20050203202049.GC20389@bitmover.com>
 <20050203220059.GD5028@deep-space-9.dsnet> <20050203222854.GC20914@bitmover.com>
 <20050204130127.GA3467@crusoe.alcove-fr> <20050204160631.GB26748@bitmover.com>
 <Pine.LNX.4.61.0502060025020.6118@scrub.home> <20050206173910.GB24160@bitmover.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Sun, 6 Feb 2005, Larry McVoy wrote:

> > $ find -name \*,v -a ! -path ./BitKeeper\* -a ! -name ChangeSet,v | xargs rlog | egrep '\(Logical change 1.[0-9]+\)' | wc -l
> > 187576
> 
> Bzzt.  You forgot all the intial deltas which are not marked with the
> logical change comment.  And just to double check my logic I tried it
> with rlog (much slower but whatever):
> 
> $ /tmp/linux-2.5-cvs find linux-2.5/ -name '*,v' |
> xargs rlog | grep 'total revisions' |
> awk 'BEGIN { n = 0 }; { n = n + $NF };  END { print n }'
> 237338
> $ /tmp/linux-2.5-cvs perl REVS
> files=22966 revs=237338
> 
> Imagine that, the numbers match perfectly.

Bzzt. Larry, I will make this one very easy, so that even you can follow 
it. Let's take a simple file:

$ rlog REPORTING-BUGS,v | grep 'total revisions'
total revisions: 3;	selected revisions: 3
$ rlog REPORTING-BUGS,v | egrep '\(Logical change 1.[0-9]+\)'
(Logical change 1.31)
(Logical change 1.3)

Now please check http://linux.bkbits.net:8080/linux-2.6/hist/REPORTING-BUGS
and tell me which number is correct.

> It's always possible I've made a mistake but you really ought to check
> your work a little bit before making false claims.  It's trivial to do
> what I did which is run the script over a single file and hand verify
> that it is correct.  

Ditto.

> > [Questionable complaints that he isn't getting enough information]

I challenge you to quote a single complaint I did in this mail.
All I did was adding the missing facts, which you like to forget to 
mention and giving anyone the necessary information to verify them.

> First, you can get all the granularity that you want from bkbits.net.
> Find the file you want, find the revision, and go backwards to the
> changeset.  It takes you a few clicks to do that.  

Once again our dear Larry tells only half the story. It's true that single 
file changes (which are in bkcvs are only available to 85%) are completely 
available via bkweb to 100%. The problem is again how all these changes 
relate to each other (the 44% number for bkcvs).
To give everyone an idea what this means, let's take a bit more 
complicated file like http://linux.bkbits.net:8080/linux-2.6/hist/MAINTAINERS
Now try to figure out what all the revisions saying "Auto merged" actually 
merge. It's actually possible, but one has to use heuristics which can 
fail, so while one can restore most of the history of a single file, it's 
not reliable anymore as soon as the branching becomes more complex.
The real trouble starts if one wants to know how all these files relate to 
each other. Right now the bk tree contains over 59000 snapshots of how the 
kernel looked at a specific point. To restore these snapshots again one 
must apply the changesets in the correct order (this is equally true for 
the commit mails), IOW one must know the parent revisions of a changeset 
to really restore the history and to not just look at a part of it, but 
bkweb unfortunately doesn't provide this information in full. Within a 
branch the patch order is of course obvious, but one must also know where 
a branch starts and ends, which is unfortunately not as obvious as one 
might think. E.g. SCCS files are limited to a single branch level and bk 
inherited this, so a branch of 1.2.3.4 is not 1.2.3.4.1.1 but something 
like 1.2.4.1.
Larry, so far I have only stated facts, which are easily verifiable, how 
about you come up with some facts of your own to prove me wrong? If I'm 
just "complaining" and all the information is out there, it should be easy 
for you to do...

> Fourth, it is your choice to not use BitKeeper because you want to compete
> with the people who are helping you.  It's not that unreasonable that
> you find yourself at something of a disadvantage because of that choice.
> And the disadvantage is very slight as has been shown.  You can argue
> all you want about the amount of disadvantage but it is your choice that
> has placed you in that position.

Well, I'm not the one who claimed "We don't do lockins.  Period."
I'm just trying to figure out what that means...

bye, Roman
