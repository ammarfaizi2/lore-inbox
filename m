Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263723AbTDNSbe (for <rfc822;willy@w.ods.org>); Mon, 14 Apr 2003 14:31:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263665AbTDNS22 (for <rfc822;linux-kernel-outgoing>);
	Mon, 14 Apr 2003 14:28:28 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:15889 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id S263725AbTDNS2O (for <rfc822;linux-kernel@vger.kernel.org>); Mon, 14 Apr 2003 14:28:14 -0400
Date: Mon, 14 Apr 2003 11:40:12 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Roman Zippel <zippel@linux-m68k.org>
cc: Andries.Brouwer@cwi.nl, Andrew Morton <akpm@digeo.com>,
       <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] kdevt-diff
In-Reply-To: <Pine.LNX.4.44.0304142022370.5042-100000@serv>
Message-ID: <Pine.LNX.4.44.0304141133390.19302-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, 14 Apr 2003, Roman Zippel wrote:
> > I think the single block-device major is a totally separate issue, and has 
> > nothing to do with allowing big device_t representations. I do not see why 
> > Andries patch would be anything else than infrastructure for future 
> > expansion.
> 
> Expansion into what?

That's the point - Andries patch is a pure extension of the number space 
into user space. 

If you think that clashes with anything else, than that "anything else" is 
_broken_. 

> The knowledge about dev_t is already reduced to a minimum in a lot of 
> block device drivers. register_blkdev() is already pretty much a dummy and 
> not a requirement anymore.

So why do you think Andries patch clashes?

Also, I don't think your patch is proper. The point about having a single
disk number space means that IDE and SCSI disks would show up there too -
users simply shouldn't need to care about the differences (which is not
just major numbers, but also the silly difference in how the partitioning
splits minor numbers).

But at the same time, for backwards compatibility clearly they have to
show up in the _old_ places too. Which really implies that there needs to
be a mapping function for the old numbers into the proper block device
queues etc, so that people can still use the old /dev nodes when they
upgrade their kernel.

		Linus



