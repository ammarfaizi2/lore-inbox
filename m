Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317701AbSGVPWx>; Mon, 22 Jul 2002 11:22:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317704AbSGVPWx>; Mon, 22 Jul 2002 11:22:53 -0400
Received: from bitmover.com ([192.132.92.2]:51370 "EHLO bitmover.com")
	by vger.kernel.org with ESMTP id <S317701AbSGVPWx>;
	Mon, 22 Jul 2002 11:22:53 -0400
Date: Mon, 22 Jul 2002 08:25:52 -0700
From: Larry McVoy <lm@bitmover.com>
To: Christoph Hellwig <hch@lst.de>, Andreas Schuldei <andreas@schuldei.org>,
       linux-kernel@vger.kernel.org
Subject: Re: using bitkeeper to backport subsystems?
Message-ID: <20020722082552.A15391@work.bitmover.com>
Mail-Followup-To: Larry McVoy <lm@work.bitmover.com>,
	Christoph Hellwig <hch@lst.de>,
	Andreas Schuldei <andreas@schuldei.org>,
	linux-kernel@vger.kernel.org
References: <20020721233410.GA21907@lukas> <20020722071510.GG16559@boardwalk> <20020722102930.A14802@lst.de> <20020722102705.GB21907@lukas> <20020722122905.A16423@lst.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20020722122905.A16423@lst.de>; from hch@lst.de on Mon, Jul 22, 2002 at 12:29:05PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 22, 2002 at 12:29:05PM +0200, Christoph Hellwig wrote:
> On Mon, Jul 22, 2002 at 12:27:05PM +0200, Andreas Schuldei wrote:
> > * Christoph Hellwig (hch@lst.de) [020722 10:29]:
> > > On Mon, Jul 22, 2002 at 01:15:10AM -0600, Val Henson wrote:
> > > > Sigh.  I hate this question: "How will BitKeeper make it easier to
> > > > port something between 2.4 and 2.5?"  Answer: "Bk won't help - at
> > > > least not as much as it would help if 2.5 had been cloned from 2.4."
> > > 
> > > 2.5 _is_ cloned from 2.4..
> > 
> > can one make use of that somehow?
> 
> /me ain't no bk guru.
> 
> but I'd be interested in that, too.

I'll try and write up how to do the backport thing later today (after
I have some coffee) but I wanted to answer this one.

In theory, the fact that the 2.4 and 2.5 trees are clones of each other
means that you could just do a bk pull of the 2.5 tree into the 2.4 tree
and you'd be all set.  In practice, it's not going to work very well;
the problem is that that a lot of files, the same files, were added to
both the 2.4 and the 2.5 tree.  As far as BK is concerned, these are
different files, they have different "inode numbers".  Today, when you
do the pull, you'll be forced to move one of the files out of the way,
typically deleting it and using the other one.  That's not what you want,
you really want the two "inodes" to be merged into one in such a way that
synchronizing with either a 2.4 or a 2.5 tree would take any updates to
either inode and apply them to the merged inode.

Unless BK is taught to handle that case, I think a 2.4 / 2.5 merge 
using BK is hopeless, I tried it about a month after the trees 
split and there were piles of file conflicts.
-- 
---
Larry McVoy            	 lm at bitmover.com           http://www.bitmover.com/lm 
