Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265936AbTBFKhP>; Thu, 6 Feb 2003 05:37:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266473AbTBFKhP>; Thu, 6 Feb 2003 05:37:15 -0500
Received: from smtpzilla5.xs4all.nl ([194.109.127.141]:35853 "EHLO
	smtpzilla5.xs4all.nl") by vger.kernel.org with ESMTP
	id <S265936AbTBFKhO>; Thu, 6 Feb 2003 05:37:14 -0500
Date: Thu, 6 Feb 2003 11:46:42 +0100 (CET)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@serv
To: Linus Torvalds <torvalds@transmeta.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: 2.5 changeset 1.952.4.2 corrupt in fs/jfs/inode.c
In-Reply-To: <b1s23k$3je$1@penguin.transmeta.com>
Message-ID: <Pine.LNX.4.44.0302061040150.32518-100000@serv>
References: <20030205174021.GE19678@dualathlon.random>
 <20030205201055.GL19678@dualathlon.random> <20030205203445.GA4467@mars.ravnborg.org>
 <20030205205127.GP19678@dualathlon.random> <b1s23k$3je$1@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wed, 5 Feb 2003, Linus Torvalds wrote:

> I don't think you can emulate this in CVS easily, since the branch has
> to be "pre-created" in the CVS repository (when it was HEAD), I don't
> think you can go back and create a branch "in the past" to graft onto. 
> Which is why I think you have to recreate the whole CVS tree (and insert
> the branch point at the right point) when this happens in order to
> really get the full BK information. 

If I understand this correctly, it's possible, but just really painful, 
because you have to work with lots of branches and do a lot manually.
You can create branches "in the past" without problems, you just can't 
insert a patch between two revisions.
(DISCLAIMER: the following might be absolute garbage, as all this is 
only derived from second hand sources. I have no license to run bk, so I 
can't verify this information.)
So in CVS terms cloning a tree would mean to get a read only version of 
your repository and locally I can only a create branch:

cvs tag -D now branch1-point
cvs tag -b -r branch1-point branch1
cvs up -r branch1

and now I can work on that branch. If I want to merge now with you, I had 
first had to get all the new changes, which would be applied to the head. 
After this I had to create a new branch:

cvs tag -D now branch2-point
cvs tag -b -r branch2-point branch2

Now I can merge my changes into the new branch:

cvs up -j branch1-point -j branch1 -r branch2
(fix conflicts)
cvs commit

If you wanted to merge my changes, it would be enough to merge the last 
branch:

cvs up -j branch2-point -j branch2
(fix conflicts)
cvs commit 

Past branches had only to be recreated to also get the history 
information.
AFAICT bk now handles all this transparently and mangles it to into a 
single repository. The price is that you can have only a single branch 
per repository and for every new development (branch) you have to clone a 
new repository.

bye, Roman

