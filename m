Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264596AbUE0Ovv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264596AbUE0Ovv (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 May 2004 10:51:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264655AbUE0Ovv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 May 2004 10:51:51 -0400
Received: from ipcop.bitmover.com ([192.132.92.15]:37806 "EHLO
	work.bitmover.com") by vger.kernel.org with ESMTP id S264596AbUE0Ovb
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 May 2004 10:51:31 -0400
Date: Thu, 27 May 2004 07:51:27 -0700
From: Larry McVoy <lm@bitmover.com>
To: Andrew Morton <akpm@osdl.org>
Cc: Larry McVoy <lm@bitmover.com>, linux-kernel@vger.kernel.org
Subject: Re: [RFD] Explicitly documenting patch submission
Message-ID: <20040527145127.GB3375@work.bitmover.com>
Mail-Followup-To: Larry McVoy <lm@work.bitmover.com>,
	Andrew Morton <akpm@osdl.org>, Larry McVoy <lm@bitmover.com>,
	linux-kernel@vger.kernel.org
References: <20040527062002.GA20872@work.bitmover.com> <20040527010409.66e76397.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040527010409.66e76397.akpm@osdl.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 27, 2004 at 01:04:09AM -0700, Andrew Morton wrote:
> Larry McVoy <lm@bitmover.com> wrote:
> >
> > I just read the whole thread and I can't help but wonder if you aren't
> > trying to solve the 5% problem while avoiding the 95% problem.  Right now,
> > because of how patches are fanned in through maintainers, lots and lots
> > of patches are going into the SCM system (BK and/or CVS since that is
> > derived from BK) as authored by a handful of people.  Just go look at
> > the stats: http://linux.bkbits.net:8080/linux-2.5/stats?nav=index.html
> > As productive as Andrew is I find it difficult to believe he has
> > personally authored more than 5000 patches.  He hasn't, he doesn't
> > pretend to have done so but we are not getting the authorship right.
> 
> Numerous people have asked Linus to make that small change to his scripts
> but he prefers it the way it is, because the current practice better
> represents how the patch got into the tree.  The authors names are in the
> changelog and the submitter's name is in the SCM metadata.

That means that all the SCM tools, BK, CVS, whatever, get the wrong attribution
when you are trying to track down a bug.  Which is more important when you are
debugging: knowing who created the change or who pushed the change to Linus?

The high order bit, in my not humble opinion, is the author.  If Linus wants
to keep the info about the submitter then do that in the check in comments.

> A purist would say "that should have been a separate changeset" but I
> disagree - I'd prefer that the patch which hits the tree is a single,
> complete, logical whole.  Because the quality and integrity of the
> changeset is more important than precisely tracking the little fixes which
> got added on the way through.

I think we can have our cake and eat it too, at least in BK (and there
is no reason other systems couldn't do this as well):  BK does not have
the concept of a 1:1 binding between a change to a file and a changeset.
A changeset is a container which may have one or more deltas to one or
more files, i.e., it is many:1.

If you took to sending your patches as the original patch plus another
patch, bundling them together (I can work out a format and GPLed tools for
this) then what we could do is have the BK import tools record the first
one as a set of deltas, the next one as another set of deltas, and so on.
We can handle an arbitrary number of patches to patches to patches.
Then when the import finishes we bundle up all the deltas in one logical
changeset.  99% of the time people won't care about the details, when
they are looking through the code the interfaces will all work as they
do today, the BK/Web interface would export this as a patch just like
you are used to, but when people do care the full information is there.

I suspect that with a little practice this could be quite useful.  
I could build tools which record the secondary patches as diffs to
the patches (I think) and if you have ever read a diff of a diff 
it is suprisingly useful.  I tend to save diffs of my work in 
progress and then later I'll generate diffs again and diff them to 
get my context back.
-- 
---
Larry McVoy                lm at bitmover.com           http://www.bitkeeper.com
