Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261891AbTCLStt>; Wed, 12 Mar 2003 13:49:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261892AbTCLStt>; Wed, 12 Mar 2003 13:49:49 -0500
Received: from ashi.footprints.net ([204.239.179.1]:42759 "EHLO
	ashi.FootPrints.net") by vger.kernel.org with ESMTP
	id <S261891AbTCLStr>; Wed, 12 Mar 2003 13:49:47 -0500
Date: Wed, 12 Mar 2003 11:00:29 -0800 (PST)
From: Kaz Kylheku <kaz@ashi.footprints.net>
To: linux-kernel@vger.kernel.org
Subject: Re: BitBucket: GPL-ed KitBeeper clone
Message-ID: <Pine.LNX.4.44.0303112047340.27245-100000@ashi.FootPrints.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds wrote:

> Now, it's true that in 90% of all cases (probably closer to 99%) you
> will never see the really nasty cases Larry was talking about. People
> just don't rename files that much, and more importantly: then whey do,
> they very very seldom have anybody else doing the same.

The Meta-CVS software handles conflicting renames quite nicely.
Corner cases such as these are handled smoothly:

- merging parallel moves of the same object to different names 
- merging parellel moves of multiple objects to the same name
- name rotation situations: a renamed to b, b renamed to c,
  c renamed to d, d renamed back to a, all committed as one atomic
  change. You can update to before that change, and a b c d jump
  to their original names in your sandbox; then update past the change
  and they jump to their new names.
- merging deletion and modification of a file
- merging parallel additions of an object to the same name.

> On eof the things I always hated about CVS is how it makes it
> IMPOSSIBLE to "work together" on something between two different random
> people.  Take one person who's been working on something for a while,
> but is chansing that one final bug, and asks another person for help.
> It just DOES NOT WORK in the CVS mentality (or _any_ centralized
> setup).

Meta-CVS has sane snapshot-importing feature: ``mcvs grab''.  If
someone has some hacked version of a program that I released, he can
give me a snapshot, and tell me what release it is based from. I can
shoot a branch from that release baseline, and grab his snapshot to
that branch. It doesn't matter if he added, removed or moved files,
changed around symbolic links, or fiddled with execute permissions; all
is analyzed and represented. The software prepares the import by
converting the snapshot into a sandbox containing local changes that I
can review, then commit.

Just as I can have this branch for tracking his changes in my
repository, he can have a branch for tracking my changes in his.

These are not changesets, in the sense that I don't have a detailed
change history, only a single delta for everything. I have to write my
own commit comment for the snapshot.  On the other hand, the input is a
simple snapshot, not a data structure produced by some specific version
control system that the other guy would have to use.  I don't care if
he uses tarballs for his version control.

