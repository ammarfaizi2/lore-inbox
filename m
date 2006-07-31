Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932458AbWGaVWL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932458AbWGaVWL (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 31 Jul 2006 17:22:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932529AbWGaVWL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 31 Jul 2006 17:22:11 -0400
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:7853 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP id S932458AbWGaVWK
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 31 Jul 2006 17:22:10 -0400
Subject: Re: the " 'official' point of view" expressed by kernelnewbies.org
	regarding reiser4 inclusion
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Gregory Maxwell <gmaxwell@gmail.com>
Cc: Clay Barnes <clay.barnes@gmail.com>, Rudy Zijlstra <rudy@edsons.demon.nl>,
       Adrian Ulrich <reiser4@blinkenlights.ch>, vonbrand@inf.utfsm.cl,
       ipso@snappymail.ca, reiser@namesys.com, lkml@lpbproductions.com,
       jeff@garzik.org, tytso@mit.edu, linux-kernel@vger.kernel.org,
       reiserfs-list@namesys.com
In-Reply-To: <e692861c0607311400x412d2e6bv71f474ea959c9e00@mail.gmail.com>
References: <1153760245.5735.47.camel@ipso.snappymail.ca>
	 <20060731144736.GA1389@merlin.emma.line.org>
	 <20060731175958.1626513b.reiser4@blinkenlights.ch>
	 <20060731162224.GJ31121@lug-owl.de>
	 <Pine.LNX.4.64.0607311842120.13492@nedra.edsons.demon.nl>
	 <20060731173239.GO31121@lug-owl.de>
	 <20060731181120.GA9667@merlin.emma.line.org>
	 <20060731184314.GQ31121@lug-owl.de>
	 <20060731191712.GE17206@HAL_5000D.tc.ph.cox.net>
	 <1154374923.7230.99.camel@localhost.localdomain>
	 <e692861c0607311400x412d2e6bv71f474ea959c9e00@mail.gmail.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Mon, 31 Jul 2006 22:40:26 +0100
Message-Id: <1154382026.7230.110.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 (2.6.2-1.fc5.5) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ar Llu, 2006-07-31 am 17:00 -0400, ysgrifennodd Gregory Maxwell:
> On 7/31/06, Alan Cox <alan@lxorguk.ukuu.org.uk> wrote:
> > Its well accepted that reiserfs3 has some robustness problems in the
> > face of physical media errors. The structure of the file system and the
> > tree basis make it very hard to avoid such problems. XFS appears to have
> > managed to achieve both robustness and better data structures.
> >
> > How reiser4 compares I've no idea.
> 
> Citation?

Two sources, the cases I've looked at myself when IDE maintainer and
also comments Hans made when we met at UKUUG a few years ago. Generally
speaking on an IDE failure that lost chunks of disk the ext2/ext3 users
got most of their data back. The reiserfs ones sometimes got it back and
sometimes got catastrophic failure.

The ext3 fsck is extremely effective in the face of serious errors. Some
of that is clever code that knows about things like rewriting inode
blocks to force reallocation of failed metadata by the drive but the
majority of it is simply because you *know* where inode X is on the disk
rather than having to deal with data structures and walk them.

That's a tradeoff with the reiser performance with small files and until
recently the reiser large directory performance. Which is right is
another question altogether. Its also something I think XFS demonstrates
can be done better so doesn't invalidate the theory behind reiserfs just
the rev 3 implementation.

> Are you sure that you aren't commenting on cases where Reiser3 alerts
> the user to a critical data condition (via a panic) which leads to a
> trouble report while ext3 ignores the problem which suppresses the
> trouble report from the user?

man mount

Ext3 is configurable, and has been for years via the errors= option.

Alan

