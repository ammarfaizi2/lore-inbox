Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311885AbSEXWOv>; Fri, 24 May 2002 18:14:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311025AbSEXWOu>; Fri, 24 May 2002 18:14:50 -0400
Received: from RAVEL.CODA.CS.CMU.EDU ([128.2.222.215]:53423 "EHLO
	ravel.coda.cs.cmu.edu") by vger.kernel.org with ESMTP
	id <S311885AbSEXWOs>; Fri, 24 May 2002 18:14:48 -0400
Date: Fri, 24 May 2002 18:14:47 -0400
To: Andrea Arcangeli <andrea@suse.de>
Cc: Alexander Viro <viro@math.psu.edu>, linux-kernel@vger.kernel.org
Subject: Re: negative dentries wasting ram
Message-ID: <20020524221447.GA22944@ravel.coda.cs.cmu.edu>
Mail-Followup-To: Andrea Arcangeli <andrea@suse.de>,
	Alexander Viro <viro@math.psu.edu>, linux-kernel@vger.kernel.org
In-Reply-To: <20020524194344.GH15703@dualathlon.random> <Pine.GSO.4.21.0205241549520.9792-100000@weyl.math.psu.edu> <20020524203630.GJ15703@dualathlon.random>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
From: Jan Harkes <jaharkes@cs.cmu.edu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 24, 2002 at 10:36:30PM +0200, Andrea Arcangeli wrote:
> On Fri, May 24, 2002 at 03:55:45PM -0400, Alexander Viro wrote:
> > On Fri, 24 May 2002, Andrea Arcangeli wrote:
> >  
> > > and they provide useful cache, they remebers the i_size and everything
> > > else that you need to read from disk the next time a lookup that ends in
> > > such inode happens. It's not a "this dentry doesn't exist" kind of
> > > info after an unlink, so very very unlikely to be ever needed
> > > information. Furthmore there cannot be an huge grow of those inodes see
> > > below.
> > 
> > That's crap, since there _IS_ such a grow.  Again, they easily sit around
> > for 5-7 minutes without a single attempt to access them, while the system
> > is swapping like hell.
> 
> no-way, that's because your vm is broken then, apply vm-35 and it
> shouldn't really happen, if the system swaps inodes will be pruned

Reading this thread I just got this incredible sense of 'deja vu'.

    http://marc.theaimsgroup.com/?l=linux-kernel&m=98709057613992&w=2
    http://marc.theaimsgroup.com/?l=linux-kernel&m=98840062922352&w=2

Actually these threads are very interesting to read.

Most interesting is the following message with a patch from you, because
the dcache and icache were pruned 'too agressively' when the new VM was
on the verge of being introduced in 2.4.10 :) Considering that what you
are proposing now is even more agressive than that, it is almost amusing.

    http://marc.theaimsgroup.com/?l=linux-kernel&m=100076684905307&w=2

Jan

