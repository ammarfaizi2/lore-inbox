Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264954AbTBEWDH>; Wed, 5 Feb 2003 17:03:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264992AbTBEWDE>; Wed, 5 Feb 2003 17:03:04 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:18446 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S264954AbTBEWDC>; Wed, 5 Feb 2003 17:03:02 -0500
To: linux-kernel@vger.kernel.org
From: torvalds@transmeta.com (Linus Torvalds)
Subject: Re: 2.5 changeset 1.952.4.2 corrupt in fs/jfs/inode.c
Date: Wed, 5 Feb 2003 22:09:56 +0000 (UTC)
Organization: Transmeta Corporation
Message-ID: <b1s23k$3je$1@penguin.transmeta.com>
References: <20030205174021.GE19678@dualathlon.random> <20030205201055.GL19678@dualathlon.random> <20030205203445.GA4467@mars.ravnborg.org> <20030205205127.GP19678@dualathlon.random>
X-Trace: palladium.transmeta.com 1044483140 12660 127.0.0.1 (5 Feb 2003 22:12:20 GMT)
X-Complaints-To: news@transmeta.com
NNTP-Posting-Date: 5 Feb 2003 22:12:20 GMT
Cache-Post-Path: palladium.transmeta.com!unknown@penguin.transmeta.com
X-Cache: nntpcache 2.4.0b5 (see http://www.nntpcache.org/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <20030205205127.GP19678@dualathlon.random>,
Andrea Arcangeli  <andrea@suse.de> wrote:
>
>What I care is how can I find the order of the changesets that are
>applied to Linus's tree? That's all I need to know. I thought the order
>shown on the web would just provide this information, but now I'mlost...

You are lost because no such simple order exists.

You're trying to force a partially ordered set (BK changesets) into a
strictly ordered set (CVS-like thing), and you can't do it.

Assuming a static BK tree, you can always find _one_ ordering that will
work. But when the next merge comes around, you'll notice that you may
well have to re-order. You can never get it right.

The fact is, a BK tree is fundamentally more powerful than a linear CVS
tree. If you want to get the BK information into CVS, you have to
either:

 - throw away information (every time I do a merge, you commit all the
   new code as one patch or possibly a set of "linearized" patches at
   the top-of-tree)

 - you use a CVS branch/merge to emulate every non-linear BK event (and
   you'll probably have to rebuild the whole CVS tree every time a merge
   occurs)

>Also note that the fact changesets can be merged in the past, and not
>alwayas in the head

No.  ChangeSets _cannot_ be merged in the past.  ChangeSet's can be
_based_ on past events, and have times in the past, and be merged
through a to the top of tree.

I don't think you can emulate this in CVS easily, since the branch has
to be "pre-created" in the CVS repository (when it was HEAD), I don't
think you can go back and create a branch "in the past" to graft onto. 
Which is why I think you have to recreate the whole CVS tree (and insert
the branch point at the right point) when this happens in order to
really get the full BK information. 

So please realize that BK is different from (and strictly more powerful
than) CVS.  But this difference is the whole _point_ of it, and the
reason for why I use it for the kernel, and refuse to use CVS. 

			Linus
