Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316545AbSGVHMR>; Mon, 22 Jul 2002 03:12:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316548AbSGVHMR>; Mon, 22 Jul 2002 03:12:17 -0400
Received: from mailhost.nmt.edu ([129.138.4.52]:25868 "EHLO mailhost.nmt.edu")
	by vger.kernel.org with ESMTP id <S316545AbSGVHMP>;
	Mon, 22 Jul 2002 03:12:15 -0400
Date: Mon, 22 Jul 2002 01:15:10 -0600
From: Val Henson <val@nmt.edu>
To: Andreas Schuldei <andreas@schuldei.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: using bitkeeper to backport subsystems?
Message-ID: <20020722071510.GG16559@boardwalk>
References: <20020721233410.GA21907@lukas>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020721233410.GA21907@lukas>
User-Agent: Mutt/1.4i
Favorite-Color: Polka dot
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 22, 2002 at 01:34:10AM +0200, Andreas Schuldei wrote:
> I want to use/track the linuxconsole project (especially for its
> Multi-desktop operation), which tracks 2.5 on the stable tree
> 2.4.
> 
> is bitkeeper the easiest way to go? i imagine the patch sets to
> be like transformations, which can be superimposed, so i would
> clone marcellos and linus tree, generate a linuxconsole patchset
> against linus tree and backport it to marcellos tree. (there are
> older backports, which should make my live easier.) 
> 
> I imagine that i had two 'transforms' now: first the linuxconsole
> transform, which changes over time as the project (and the
> kernel) moves on, and the backport transform, which i hope to
> remain more static. Can i superimpose these transforms? Is this
> how it works?
> 
> has anyone done this before? is there a howto or could someone
> outline the bitkeeper steps needed? Any catches?

Sigh.  I hate this question: "How will BitKeeper make it easier to
port something between 2.4 and 2.5?"  Answer: "Bk won't help - at
least not as much as it would help if 2.5 had been cloned from 2.4."

As far as bk is concerned, 2.4 and 2.5 are two completely unrelated
repositories, so you can't push or pull changes between them.  You can
still use bk to export and import patches, and to help you understand
what a change was attempting to do, so it's not completely useless.

If I were you, I would:

1. Grab the linux-2.4, linux-2.5, and linuxconsole trees.
2. Use "bk changes -L <location of vanilla 2.5 tree>" to get a list of
   all the changes in the linuxconsole tree but not in the mainline.
3. Export those changes as a GNU patch, something like:

   for i in `bk changes -L ../linux-2.5 -k | bk key2rev ChangeSet`; do
      bk export -tpatch -r$i >> ../console_patches;
   done

   Note: This won't collapse overlapping patches.  There is probably a
   smarter way to do this.

4. Attempt to apply that patch to the linux-2.4 tree:

   cd ../linux-2.4
   bk import -tpatch ../console_patches

5. Clean up the resulting mess.  I suggest bringing up revtool in the
   linuxconsole tree and reading the comments and generally browsing
   the related changesets for each file in order to figure out what
   rejected bits of patches were supposed to do.

For documentation, try the following:

Jeff Garzik's BK Kernel Hacking HOWTO:

http://www.uwsg.indiana.edu/hypermail/linux/kernel/0202.2/1060.html

[Warning: Blatant personal plug] BitKeeper for Kernel Developers:

http://www.nmt.edu/~val/ols/bk.ps.gz

I also highly recommend the Bitkeeper test drive even for people who
have been using bk for a while:

http://www.bitkeeper.com/Test.html

After using bk for over a year, I still learned something new (and
very useful) when I took the test drive.

-VAL
