Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271073AbTG2J0L (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Jul 2003 05:26:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271343AbTG2J0L
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Jul 2003 05:26:11 -0400
Received: from ppp-217-133-42-200.cust-adsl.tiscali.it ([217.133.42.200]:45197
	"EHLO dualathlon.random") by vger.kernel.org with ESMTP
	id S271073AbTG2J0I (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Jul 2003 05:26:08 -0400
Date: Tue, 29 Jul 2003 11:28:21 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Larry McVoy <lm@bitmover.com>, Mike Fedyk <mfedyk@matchmail.com>,
       linux-kernel@vger.kernel.org
Cc: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: Fwd: Re: Bug Report: 2.4.22-pre5: BUG in page_alloc (fwd)
Message-ID: <20030729092821.GC23835@dualathlon.random>
References: <20030721190226.GA14453@matchmail.com> <20030721194514.GA5803@work.bitmover.com> <20030721212155.GF4677@x30.linuxsymposium.org> <20030721213159.GA7240@work.bitmover.com> <20030721220000.GG4677@x30.linuxsymposium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030721220000.GG4677@x30.linuxsymposium.org>
User-Agent: Mutt/1.4i
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
X-PGP-Key: 1024R/CB4660B9 CC A0 71 81 F4 A0 63 AC  C0 4B 81 1D 8C 15 C8 E5
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Mon, Jul 21, 2003 at 06:00:00PM -0400, Andrea Arcangeli wrote:
> On Mon, Jul 21, 2003 at 02:31:59PM -0700, Larry McVoy wrote:
> > On Mon, Jul 21, 2003 at 05:21:55PM -0400, Andrea Arcangeli wrote:
> > > Hi Larry,
> > > 
> > > On Mon, Jul 21, 2003 at 12:45:14PM -0700, Larry McVoy wrote:
> > > > You don't need the tags, use dates.  You can get the date range you want 
> > > > with an rlog of the ChangeSet file and then use those dates.
> > > 
> > > I realized I could do this, and it can of course be automated with an
> > > additional bkcvs specific hack in cvsps. But the tag in every file would
> > > have kept the functionality generic with the already available -r
> > > option, and since I can't see any downside in the tag in the files, I
> > > prefer that generic way.
> > 
> > The tags means that each file gets modified for each tag and then we have
> > to transfer the whole tree after a tag.  It thrashes the hell out of the
> > disk too, for no good reason.
> > 
> > Also note that there are nowhere near as many tags as there are commits
> > in the CVS tree.  So by using tags you are restricting yourself to coarse
> > granularity in your bug hunts.
> 
> the granularity wasn't the issue, I need this feature anyways out of
> cvsps (cvsps is exactly the thing that generates the changesets out of
> the coarse granularity of the tags). the checkout/rsync being more
> expensive sounds a fair enough argument for implementing the feature in
> cvsps where it will be zero write cost.

while writing the code to do it, I noticed the heuristic was already
there in cvsps ;), and it is generic (not hardwired to the ChangeSet
file). I had bad luck diffing with -r v2_4_22-pre3 (which is missing
from the changeset file too, so I guess the info is missing in bitkeeper
as well, not just bkcvs).  Infact probably it's a long time that you
dropped the tags from all files, and I noticed only now after getting
the error diffing against 22pre3 ;).

> since we're talking about bkcvs, I also would have a feature wish for
> the repository export in rsync.kernel.org: would it be possible to
> export a sequence number increased once before a transfer, and increased
> a second time after the tree is coherent again? When the sequence number
> is even and it didn't change before and after the rsync, we'll know the
> current status is coherent and we don't need to repeat the rsync (after
> some delay). Or is there any other mechanism that guarantees to get a
> coherent repository out of rsync?

Peter, any suggestion on this? Larry said it's all on your side, so I
assume you're running bkcvs yourself, or Larry is already providing you
a locking mechanism that serializes against bkcvs and that allows you
to fetch a coherent of the cvs repository. w/o this last locking bit
that allows to export a coherent copy of the repository, I can't easily
automate the stuff based on a local repository and I've to switch to the
remote one, despite having it local is more flexible (and much faster
for local browsing) and rsync -z is faster.

Many thanks again to both of you and last but not the least to David
Mansfiel (cvsps author).

Andrea
