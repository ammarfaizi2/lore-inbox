Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932262AbWGXVwN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932262AbWGXVwN (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Jul 2006 17:52:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932263AbWGXVwN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Jul 2006 17:52:13 -0400
Received: from inti.inf.utfsm.cl ([200.1.21.155]:6785 "EHLO inti.inf.utfsm.cl")
	by vger.kernel.org with ESMTP id S932262AbWGXVwL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Jul 2006 17:52:11 -0400
Message-Id: <200607242151.k6OLpDZu009297@laptop13.inf.utfsm.cl>
To: Mike Benoit <ipso@snappymail.ca>
cc: "Horst H. von Brand" <vonbrand@inf.utfsm.cl>,
       Matthias Andree <matthias.andree@gmx.de>,
       Hans Reiser <reiser@namesys.com>, lkml@lpbproductions.com,
       Jeff Garzik <jeff@garzik.org>, Theodore Tso <tytso@mit.edu>,
       LKML <linux-kernel@vger.kernel.org>,
       ReiserFS List <reiserfs-list@namesys.com>
Subject: Re: the " 'official' point of view" expressed by kernelnewbies.org regarding reiser4 inclusion 
In-Reply-To: Message from Mike Benoit <ipso@snappymail.ca> 
   of "Mon, 24 Jul 2006 13:37:13 MST." <1153773433.5735.85.camel@ipso.snappymail.ca> 
X-Mailer: MH-E 7.4.2; nmh 1.1; XEmacs 21.4 (patch 19)
Date: Mon, 24 Jul 2006 17:51:13 -0400
From: "Horst H. von Brand" <vonbrand@inf.utfsm.cl>
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-2.0.2 (inti.inf.utfsm.cl [200.1.21.155]); Mon, 24 Jul 2006 17:51:15 -0400 (CLT)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mike Benoit <ipso@snappymail.ca> wrote:
> On Mon, 2006-07-24 at 14:06 -0400, Horst H. von Brand wrote:
> > > And EXT3 imposes practical limits that ReiserFS doesn't as well. The big
> > > one being a fixed number of inodes that can't be adjusted on the fly,

> > Right. Plan ahead.

> That is great in theory. But back to reality, when your working for a
> company that is growing by leaps and bounds that isn't always possible.
> Why would I want to intentionally limit myself to a set number of inodes
> when I can get a performance increase and not have to worry about it by
> simply using ReiserFS? 

Place your filesystems on LVN, when they grow the number of inodes grows to
match. Or did you run out of inodes and not of diskspace? Only ever
happened to me on (static) /dev, or (wrong configured) newsspools...

> It all boils down to using the right tool for the job, ReiserFS was the
> right tool for this job. 

/One/ tool that did the job. Not "the" right one, perhaps not even the best
one.

> > > I've been bitten by running out of inodes on several occasions,

> > Me too. It was rather painful each time, but fixable (and in hindsight,
> > dumb user (setup) error).

> > >                                                                 and by
> > > switching to ReiserFS it saved one company I worked for over $250,000
> > > because they didn't need to buy a totally new piece of software.

> > How can a filesystem (which by basic requirements and design is almost
> > transparent to applications) make such a difference?!

> Very easily, the backup software the company had spent ~$75,000 on
> before I started working there used tiny little files as its "database".

If you know that, you configure your filesystem like a newsspool or some
such.

> Once the inodes ran out the entire system pretty much came to a
> screeching halt.

Get a clue by for, apply to the vendor (for the design, or at the very
least for not warning unsuspecting users)?

>                  We basically had two options, use ReiserFS, or find
> another piece of software that didn't use tiny little files as its
> database.

Or reconfigure the filesystem with more inodes (you were willing to rebuild
the filesystem in any case, so...)

>           If I recall correctly the database went from about 2million
> files to over 40 million in the span of just a few months. No one could
> have predicted that. I believe this database was on an 18GB SCSI drive,
> so even using 1K blocks wouldn't have worked. According to the mke2fs
> man page:

> "-i bytes-per-inode
> This value generally shouldn't be smaller than the blocksize  of
> the filesystem,  since  then  too many inodes will be made."

18GiB = 18 million KiB, you do have a point there. But 40 million files on
that, with some space to spare, just doesn't add up.

> The only other option at that time was to purchase Veritas backup

... or a larger disk...

>                                                                   and
> its not cheap. We ended up switching to ReiserFS, it increased our
> backup/restore time immensely and also bought us about 1year before the
> system finally outgrew itself for good. By that time the company could
> afford to drop $250,000 on high end backup software so we could grow
> past 10TB.
