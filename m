Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262964AbVD2U0c@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262964AbVD2U0c (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Apr 2005 16:26:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262962AbVD2UZo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Apr 2005 16:25:44 -0400
Received: from ppp-217-133-42-200.cust-adsl.tiscali.it ([217.133.42.200]:35683
	"EHLO opteron.random") by vger.kernel.org with ESMTP
	id S262944AbVD2UZT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Apr 2005 16:25:19 -0400
Date: Fri, 29 Apr 2005 22:30:27 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Matt Mackall <mpm@selenic.com>
Cc: Linus Torvalds <torvalds@osdl.org>,
       linux-kernel <linux-kernel@vger.kernel.org>, git@vger.kernel.org
Subject: Re: Mercurial 0.4b vs git patchbomb benchmark
Message-ID: <20050429203027.GK17379@opteron.random>
References: <20050426004111.GI21897@waste.org> <Pine.LNX.4.58.0504251859550.18901@ppc970.osdl.org> <20050429060157.GS21897@waste.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050429060157.GS21897@waste.org>
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 28, 2005 at 11:01:57PM -0700, Matt Mackall wrote:
> change nodes so you've got to potentially traverse all the commits to
> reconstruct a file's history. That's gonna be O(top-level changes)
> seeks. This introduces a number of problems:
> 
> - no way to easily find previous revisions of a file
>   (being able to see when a particular change was introduced is a
>   pretty critical feature)
> - no way to do bandwidth-efficient delta transfer
> - no way to do efficient delta storage
> - no way to do merges based on the file's history[1]

And IMHO also no-way to implement a git-on-the-fly efficient network
protocol if tons of clients connects at the same time, it would be
dosable etc... At the very least such a system would require an huge
amount of ram. So I see the only efficient way to design a network
protocol for git not to use git, but to import the data into mercurial
and to implement the network protocol on top of mercurial.

The one downside is that git is sort of rock solid in the way it stores
data on disk, it makes rsync usage trivial too, the git fsck is reliable
and you can just sign the hash of the root of the tree and you sign
everything including file contents. And of course the checkin is
absolutely trivial and fast too.

With a more efficient diff-based storage like mercurial we'd be losing
those fsck properties etc.. but those reliability properties don't worth
the network and disk space they take IMHO, and the checkin time
shouldn't be substantially different (still running in O(1) when
appending at the head). And we could always store the hash of the
changeset, to give it some basic self-checking.

I give extreme value in a SCM in how efficiently it can represent the
whole tree for both network downloads and backups too. Being able to
store the whole history of 2.5 in < 100M is a very valuable feature
IMHO, much more valuable than to be able to sign the root.

Also don't get me wrong, I'm _very_ happy about git too, but I just
happen to prefer mercurial storage (I would never use git for anything
but the kernel, just like I wasn't using arch for similar reasons).
