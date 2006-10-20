Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1946304AbWJTE2o@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946304AbWJTE2o (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Oct 2006 00:28:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1946317AbWJTE2o
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Oct 2006 00:28:44 -0400
Received: from smtpout.mac.com ([17.250.248.177]:21744 "EHLO smtpout.mac.com")
	by vger.kernel.org with ESMTP id S1946316AbWJTE2m (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Oct 2006 00:28:42 -0400
In-Reply-To: <Pine.LNX.4.64.0610191629250.3962@g5.osdl.org>
References: <4537EB67.8030208@drzeus.cx> <Pine.LNX.4.64.0610191629250.3962@g5.osdl.org>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <64E321FD-FD09-4962-9BF3-86104B92A74A@mac.com>
Cc: Pierre Ossman <drzeus-list@drzeus.cx>, Andrew Morton <akpm@osdl.org>,
       LKML <linux-kernel@vger.kernel.org>
Content-Transfer-Encoding: 7bit
From: Kyle Moffett <mrmacman_g4@mac.com>
Subject: Re: Git training wheels for the pimple faced maintainer
Date: Fri, 20 Oct 2006 00:28:20 -0400
To: Linus Torvalds <torvalds@osdl.org>
X-Mailer: Apple Mail (2.752.2)
X-Brightmail-Tracker: AAAAAA==
X-Brightmail-scanned: yes
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Oct 19, 2006, at 19:44:41, Linus Torvalds wrote:
>  - If you actually want your development tree to "track" my tree,  
> I'd suggest you have your "for-linus" branch that you put the work  
> you want to track into, and then a plain "linus" branch which  
> tracks _my_ tree. Then you can just fetch my tree (to keep your  
> "linus" branch up-to-date), and if you want your development branch  
> to track those changes, you can just do a "git rebase linus" in  
> your "for-linus" branch.

I'm no official maintainer, but I have several random local GIT trees  
I use for local development and patches which don't make a lot of  
sense outside my personal systems.  Because of this it's important  
for me to be able to migrate my changes over to newer versions  
easily, but I don't care all that much about maintaining old history,  
I just want my separate patches to work on latest Linus.

It also matters a lot to me to be able to wipe out a devel tree with  
a quick rm and create it from scratch.

As a result, I have an "upstream" tree with various "linus", "libata- 
dev", etc upstream branches that I pull from for various reasons.  I  
then have a "linux-template" tree which has no objects of its own but  
references the "upstream" tree's object directory and "pulls" from  
some branch in the upstream tree.  To create a new devel tree I just  
copy the "upsteram" tree which is the size of a single checkout, and  
start patching.  To update all my patchsets to latest linus:

### This gets the upstream tree to the latest state
$ cd ~/git/linux/upstream
$ cg-fetch linus
$ cg-fetch libata-dev
$ cg-fetch $OTHER_UPSTREAM_SRC

## Optionally repack the single copy of the upstream objects for  
better speed
$ git-repack -a -d -l -f

### Now fast-forward the patches in $MY_TREE to be based on the  
latest version of the random upstream tree
$ cd ~/git/linux/$MY_TREE
$ cg-fetch upstream
$ git-rebase upstream
### Now I resolve rebase-conflicts

When I want to export a GIT tree for somebody else to look at I just  
pull into the HTTP-accessible GIT directories from my various  
development trees, optionally merging if necessary.

This isn't "The Best Solution(TM)" for everyone, but it works really  
well for me and has the advantage of only storing one easily-repacked  
copy of the upstream sources; the rest of my dev trees have only the  
overhead of my local changesets and a single copy of the kernel  
sources.  In the event I have to wipe out a dev tree it's a very fast  
"rm -rf $OLD_TREE", and creating one is also a fast "cp -a linux- 
template $NEW_TREE"

Cheers,
Kyle Moffett

