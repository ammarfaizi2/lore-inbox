Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264534AbTE1Fev (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 May 2003 01:34:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264537AbTE1Fev
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 May 2003 01:34:51 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:4788 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S264534AbTE1Feu
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 May 2003 01:34:50 -0400
Date: Wed, 28 May 2003 06:48:05 +0100
From: viro@parcelfarce.linux.theplanet.co.uk
To: Shaya Potter <spotter@cs.columbia.edu>
Cc: linux-kernel@vger.kernel.org
Subject: Re: permission() operating on inode instead of dentry?
Message-ID: <20030528054804.GF27916@parcelfarce.linux.theplanet.co.uk>
References: <1054099180.6942.71.camel@zaphod>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1054099180.6942.71.camel@zaphod>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 28, 2003 at 01:19:40AM -0400, Shaya Potter wrote:
> [please cc: responses to me, have 10k message backlog in l-k folder)
> 
> Is there a good reason why the fs permission function operates on the
> inode instead of the dentry? It would seem if the dentry was passed into
> the function instead of the inode, one would have a better structure to
> play with, such as being able to use d_put() to get the real path name. 
> The inode is still readily accessible from the dentry.

man grep.

Then use the resulting knowledge to find the callers of said function in
the tree.

Then think where you would get dentry (and vfsmount, since you want path)
for each of these.  Exclude ones that have them available.  See which
functions contain the rest of calls.

Repeat the entire thing for each of these functions, until the set is
empty.  At that point you have a sequence of changes that need to be
done.  Start moving from the end of list, changing the prototypes and
updating callers.  You will get a sequence of patches ending with
what you want.  Look at their sizes.  If they are tolerably small and
straightforward - start posting them to fsdevel, one by one.  With
summaries.  Start with posting the list of changes (step 1 propagates
..., step 2...,  step n gives what we want).

Get that stuff merged, one by one.  Since it won't go in one release,
repeat the searches to verify that your analysis is still correct and
no new paths had appeared.

That's how it's done - there's nothing more to it.  And yes, this one
will end up in a moderately long chain of patches - it appeared to be
doable the last time I'd looked, but would result in 10-15 steps _if_
nothing tricky would crop up.
