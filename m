Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261973AbVDKWuO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261973AbVDKWuO (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Apr 2005 18:50:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261981AbVDKWuN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Apr 2005 18:50:13 -0400
Received: from iabervon.org ([66.92.72.58]:25349 "EHLO iabervon.org")
	by vger.kernel.org with ESMTP id S261973AbVDKWuD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Apr 2005 18:50:03 -0400
Date: Mon, 11 Apr 2005 18:50:24 -0400 (EDT)
From: Daniel Barkalow <barkalow@iabervon.org>
To: Linus Torvalds <torvalds@osdl.org>
cc: Jeff Garzik <jgarzik@pobox.com>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Linux Kernel list <linux-kernel@vger.kernel.org>,
       James Bottomley <James.Bottomley@SteelEye.com>,
       David Woodhouse <dwmw2@infradead.org>
Subject: Re: New SCM and commit list
In-Reply-To: <Pine.LNX.4.58.0504102304050.1267@ppc970.osdl.org>
Message-ID: <Pine.LNX.4.21.0504111801450.30848-100000@iabervon.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 10 Apr 2005, Linus Torvalds wrote:

> On Mon, 11 Apr 2005, Jeff Garzik wrote:
> > 
> > > But I hope that I can get non-conflicting merges done fairly soon, and 
> > > maybe I can con James or Jeff or somebody to try out GIT then...
> > 
> > I don't mind being a guinea pig as long as someone else does the hard 
> > work of finding a new way to merge :)
> 
> So I can tell you what merges are going to be like, just to prepare you.
> 
> First, the good news: I think we can make the workflow look like bk, ie
> pretty much like "git pull" and "git push".  And for well-behaved stuff
> (ie minimal changes to the same files on both sides) it will even be fast.  
> I think.
> 
> Then the bad news: the merge algorithm is going to suck. It's going to be
> just plain 3-way merge, the same RCS/CVS thing you've seen before. With no
> understanding of renames etc. I'll try to find the best parent to base the
> merge off of, although early testers may have to tell the piece of crud
> what the most recent common parent was.
>
> So anything that got modified in just one tree obviously merges to that 
> version. Any file that got modified in two trees will end up just being 
> passed to the "merge" program. See "man merge" and "man diff3". The merger 
> gets to fix up any conflicts by hand.

If merge took trees instead of single files, and had some way of detecting
renames (or it got additional information about the differences between
files), would that give BK-quality performance? Or does BK also support
cases like:

orig ---> first ---> first-merge -
 |                /               \
 |------> second -                 -> final
 |                \               /
 |------> third ---> third-merge -

where the final merge requires, for complete cleanliness, a comparison of
more than 3 states (since some changes will have orig as the common
ancestor and some will have second).

Does this happen in real life? It seems like sane development processes
wouldn't have multiple mainline-candidate patch sets including the same
patches, if for no other reason than that, should the merge fail, nobody
with any clue about the original patches would be anywhere nearby. It
seems better to throw something back to someone to rebase their diffs.

Otherwise, the problem seems to boil down to finding the common ancestor
well, getting trees instead of files to merge, and improving merge until
it handles all of the tractible cases.

	-Daniel
*This .sig left intentionally blank*

