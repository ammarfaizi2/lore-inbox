Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264688AbTBEUUO>; Wed, 5 Feb 2003 15:20:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264836AbTBEUUO>; Wed, 5 Feb 2003 15:20:14 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:262 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S264688AbTBEUUL>; Wed, 5 Feb 2003 15:20:11 -0500
Date: Wed, 5 Feb 2003 12:25:10 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: Matt Reppert <arashi@yomerashi.yi.org>
cc: Andrew Morton <akpm@digeo.com>, <andrea@suse.de>, <lm@bitmover.com>,
       <linux-kernel@vger.kernel.org>
Subject: Re: 2.5 changeset 1.952.4.2 corrupt in fs/jfs/inode.c
In-Reply-To: <20030205141104.6ae9e439.arashi@yomerashi.yi.org>
Message-ID: <Pine.LNX.4.44.0302051211070.2999-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 5 Feb 2003, Matt Reppert wrote:
>
> (CC'ing Linus because I have a question for him in here ... )
> On Wed, 5 Feb 2003 11:43:53 -0800
> Andrew Morton <akpm@digeo.com> wrote:
> >
> > http://linux.bkbits.net:8080/linux-2.5/cset@1.879.43.1?nav=index.html|ChangeSet@-8w
> > 
> > And revtool shows that change on Jan 09 this year.
> > 
> > But it does not appear in Linus's 2.5.59 tarball, and there appears to be no
> > record in bitkeeper of where this change fell out of the tree.

There is a record in BK, you just have to find the merge.

> > In fact the above URL shows two instances of the same patch, with different
> > human-written summaries, on the same day.

Which if true would easily happen if the patches was independently
committed to two trees and then those trees were later merged.

However, in this case I don't think there is any real duplication, and
what you're looking at is the "all diffs"  part (whole changeset) and the
"per-file diffs" part. And the changeset comment is slightly different for
the per-file comment. (Look at some more extensive changeset that modifies
multiple files to see this more clearly).

The way it then came into my tree is through:

	ChangeSet@1.974, 2003-02-03 14:58:24-08:00, torvalds@penguin.transmeta.com
	  Merge http://jfs.bkbits.net/linux-2.5
	  into penguin.transmeta.com:/home/penguin/torvalds/repositories/kernel/linux

(you can use "bk changes -e" to also get merge changes, or you can try to 
follow the merges in the graphical tree shown by "bk revtool").

So it was merged into _my_ tree yesterday, but it's been in shaggy's tree 
since Jan 9th.

> I sit on the web interface a lot to see what's being merged. If you ask for
> it, it will give you a list of csets ordered by date, newest first. I've
> noticed sometimes that recently merged csets will appear to be older than
> the date they were merged, perhaps because they actually were that old in
> the parent repository. Is cset age preserved across repositories? It seems
> to be.

Absolutely. There are two totally independent events: the event of 
committing a patch to a tree (which was done by shaggy some time ago) and 
the event of merging the trees into my tree (which was done by me 
yesterday). 

Use "bk revtool" to get a mental picture of this. I don't find "bk 
revtool" that useful for some other reasons (bad cut-and-paste behaviour, 
sometimes horribly hard to find things), but it's a good way to mentally 
visualize the "topology" of the changes.

("bk revtool" probably works a lot better on simpler projects, with the 
kernel it just gets too complicated too fast to be horribly useful).

		Linus

