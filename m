Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271687AbRIJVLe>; Mon, 10 Sep 2001 17:11:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271718AbRIJVLY>; Mon, 10 Sep 2001 17:11:24 -0400
Received: from humbolt.nl.linux.org ([131.211.28.48]:2821 "EHLO
	humbolt.nl.linux.org") by vger.kernel.org with ESMTP
	id <S271687AbRIJVLP>; Mon, 10 Sep 2001 17:11:15 -0400
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@bonn-fries.net>
To: Linus Torvalds <torvalds@transmeta.com>
Subject: Re: linux-2.4.10-pre5
Date: Mon, 10 Sep 2001 23:18:44 +0200
X-Mailer: KMail [version 1.3.1]
Cc: Andreas Dilger <adilger@turbolabs.com>, Andrea Arcangeli <andrea@suse.de>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.33.0109091615570.22033-100000@penguin.transmeta.com>
In-Reply-To: <Pine.LNX.4.33.0109091615570.22033-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <20010910211135Z16537-26183+875@humbolt.nl.linux.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On September 10, 2001 01:24 am, Linus Torvalds wrote:
> On Sun, 9 Sep 2001, Daniel Phillips wrote:
> >						  A spin-off benefit
> > is, the same mechanism could be used to implement a physical readahead
> > cache which can do things that logical readahead can't.
> 
> Considering that 99.9% of all disks do this on a lower hardware layer
> anyway, I very much doubt it has any good properties to make software more
> complex by having that kind of readahead in sw.

Here's some anectdotal evidence to the contrary.

This machine requires about 1.5 seconds to diff two kernel trees if both 
trees are in cache.  If neither tree is in cache it takes 90 seconds.  It's a 
total of about 300M of source - reading that into memory should take about 10 
seconds at 30M/sec, taking one pass across the disk and assuming no extensive 
fragmentation.

We lost 78.5 seconds somewhere.  From the sound of the disk drives, I'd say 
we lost it to seeking, which physical readahead with a large cache would be 
able to largely eliminate in this case.

--
Daniel
