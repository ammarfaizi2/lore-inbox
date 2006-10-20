Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751644AbWJTBHe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751644AbWJTBHe (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Oct 2006 21:07:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751646AbWJTBHe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Oct 2006 21:07:34 -0400
Received: from rgminet01.oracle.com ([148.87.113.118]:30702 "EHLO
	rgminet01.oracle.com") by vger.kernel.org with ESMTP
	id S1751644AbWJTBHd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Oct 2006 21:07:33 -0400
Date: Thu, 19 Oct 2006 18:07:15 -0700
From: Mark Fasheh <mark.fasheh@oracle.com>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Pierre Ossman <drzeus-list@drzeus.cx>, Andrew Morton <akpm@osdl.org>,
       LKML <linux-kernel@vger.kernel.org>
Subject: Re: Git training wheels for the pimple faced maintainer
Message-ID: <20061020010715.GF10128@ca-server1.us.oracle.com>
Reply-To: Mark Fasheh <mark.fasheh@oracle.com>
References: <4537EB67.8030208@drzeus.cx> <Pine.LNX.4.64.0610191629250.3962@g5.osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0610191629250.3962@g5.osdl.org>
Organization: Oracle Corporation
User-Agent: Mutt/1.5.11
X-Brightmail-Tracker: AAAAAQAAAAI=
X-Brightmail-Tracker: AAAAAQAAAAI=
X-Whitelist: TRUE
X-Whitelist: TRUE
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 19, 2006 at 04:44:41PM -0700, Linus Torvalds wrote:
> I think people have seen the messages that other people send out (eg at 
> least Greg KH tends to Cc: those messages to linux-kernel, so others can 
> see what's going on too - although not all other maintainers do that).
I noticed also that people started sending out "What's in XX.git" type
messages at the beginning of a merge window to describe what might shortly
get sent upstream.


> Other git maintainers may have other hints about how they work. Anybody?
I think I have a slightly different workflow than what Pierre describes. I
find that it works well for me and it keeps things very organized in
ocfs2.git. It's also probably a little more work than other methods for
managing a git tree that people employ. Hopefully a description of my
process will be useful to someone.

Basically I have two trees, ocfs2.git which is the main ocfs2 repository and
my own personal linux-2.6.git which I actually hack in.

All my hacking happens on topic branches based off of master in my personal
tree. I keep master pristine so that it's always a direct copy of what Linus
has in his tree. If somebody sends me ocfs2 patches, I'll make a topic
branch for the patches in my personal tree and import them, typically via
git-applymbox. Pull requests (which I typically get from Joel for configfs
changes) go directly to ocfs2.git (described below). The point of this is
that I hack elsewhere and keep ocfs2.git for merging stuff that's ready for
people to see.

In ocfs2.git, I will also make topic branches and pull from my linux-2.6.git
(for my work, or patches e-mailed to me), or directly from somebody elses
git tree. I make an ALL branch, based off of master which gets a merge of
everything ocfs2 related that I want to go in -mm (which so far has been
anything I eventually want to go upstream to Linus).

Once I'm ready to send an upstream pull request, I'll update the master
branch of ocfs2.git. I then make a for-linus branch based off of it, and
git-cherry-pick each individual patch into that branch and send my request.

I do the cherry pick because I like that it allows me to do one last review
of each patch, and it helps avoid lots of merge records in my pull. This
also makes it easy for me to tailor which patches I want to go upstream in a
given pull - sometimes I hold things back if I feel they need more testing,
or if they're features that need to wait for the next merge window.

Once Linus pulls, I'll re-make the ALL branch for Andrew by re-pulling all
the patchsets which weren't a part of that pull request.

Btw, I cannot over state how important and useful it is to have patches go
to -mm first.

Hope this helps,
	--Mark

--
Mark Fasheh
Senior Software Developer, Oracle
mark.fasheh@oracle.com
