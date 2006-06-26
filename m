Return-Path: <linux-kernel-owner+willy=40w.ods.org-S933022AbWFZVDR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933022AbWFZVDR (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Jun 2006 17:03:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933026AbWFZVDR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Jun 2006 17:03:17 -0400
Received: from mx2.mail.elte.hu ([157.181.151.9]:29582 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S933022AbWFZVDQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Jun 2006 17:03:16 -0400
Date: Mon, 26 Jun 2006 22:58:24 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Christoph Hellwig <hch@infradead.org>,
       Steven Whitehouse <swhiteho@redhat.com>,
       Linus Torvalds <torvalds@osdl.org>,
       David Teigland <teigland@redhat.com>,
       Patrick Caulfield <pcaulfie@redhat.com>,
       Kevin Anderson <kanderso@redhat.com>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: Re: GFS2 and DLM
Message-ID: <20060626205824.GA16661@elte.hu>
References: <1150805833.3856.1356.camel@quoit.chygwyn.com> <20060623150040.GA1197@infradead.org> <1151080174.3856.1606.camel@quoit.chygwyn.com> <20060623164823.GA12480@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060623164823.GA12480@infradead.org>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: -3.1
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-3.1 required=5.9 tests=ALL_TRUSTED,AWL,BAYES_50 autolearn=no SpamAssassin version=3.0.3
	-3.3 ALL_TRUSTED            Did not pass through any untrusted hosts
	0.0 BAYES_50               BODY: Bayesian spam probability is 40 to 60%
	[score: 0.5000]
	0.2 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Christoph Hellwig <hch@infradead.org> wrote:

> On Fri, Jun 23, 2006 at 05:29:34PM +0100, Steven Whitehouse wrote:
> > Hi,
> > 
> > On Fri, 2006-06-23 at 16:00 +0100, Christoph Hellwig wrote:
> > > On Tue, Jun 20, 2006 at 01:17:13PM +0100, Steven Whitehouse wrote:
> > > > Hi,
> > > > 
> > > > Linus, Andrew suggested to me to send this pull request to you directly.
> > > > Please consider merging the GFS2 filesystem and DLM from (they are both
> > > > in the same tree for ease of testing):
> > > 
> > > A new normal filesystem (aka everything but procfs) shouldn't implement
> > > ->readlink but use generic_readlink instead.
> > > 
> > 
> > The comment above generic_readlink has this to say:
> > 
> > /*
> >  * A helper for ->readlink().  This should be used *ONLY* for symlinks that
> >  * have ->follow_link() touching nd only in nd_set_link().  Using (or not
> >  * using) it for any given inode is up to filesystem.
> >  */
> > 
> > which appears, at least, to contradict what you are saying. I'll put 
> > it on my list to look at again, but a straight substitution of 
> > generic_readlink() does not work, so I'd prefer to leave it as it is 
> > for the moment,
> 
> The above is the common and preffered case.  The only intree 
> filesystem not doing it is procfs.

i think you might be missing that GFS does cross-node locking in 
readlink too. (OCFS2 does not do it because it apparently does not care 
about cross-node atime correctness here it seems.) So GFS simply cannot 
use generic_readlink()!

i'm all for enhancing vfs_readlink()/generic_readlink() so that local 
locking can be extended if needed, but otherwise this does not seem to 
be a merge showstopper to me. GFS simply implements something that 
no-one implemented until now. (i dont know how XFS's non-GPL binary-only 
clustering module does it, but i'd not be surprised if it defined its 
own readlink implementation too.)

	Ingo
