Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132508AbRDUGWG>; Sat, 21 Apr 2001 02:22:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132511AbRDUGV4>; Sat, 21 Apr 2001 02:21:56 -0400
Received: from leibniz.math.psu.edu ([146.186.130.2]:63112 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S132508AbRDUGVr>;
	Sat, 21 Apr 2001 02:21:47 -0400
Date: Sat, 21 Apr 2001 02:21:38 -0400 (EDT)
From: Alexander Viro <viro@math.psu.edu>
To: Linus Torvalds <torvalds@transmeta.com>
cc: Jeremy Fitzhardinge <jeremy@goop.org>,
        Linux Kernel <linux-kernel@vger.kernel.org>, autofs@linux.kernel.org
Subject: Re: Fix for SMP deadlock in autofs4
In-Reply-To: <Pine.LNX.4.31.0104202253010.15553-100000@penguin.transmeta.com>
Message-ID: <Pine.GSO.4.21.0104210217000.23618-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 20 Apr 2001, Linus Torvalds wrote:

> 
> 
> On Fri, 20 Apr 2001, Jeremy Fitzhardinge wrote:
> >
> > I kept the dget/put out caution and ignorance, but they're clearly
> > problematic.  I'm happy to drop them if holding dcache_lock is enough
> > to keep the tree stable while I traverse it.
> 
> How does this patch look to you people?
> 
> It's untested, but looks fairly obvious. It removes the increment, and
> changes autofs4_expire() to properly bump the count of the returned dentry
> (and callers will dput() it when done). This may be unnecessarily careful,
> but it's the RightThing(tm) to do.

Looks sane for me. However, I would add check for dentry being hashed and
would skip the unhashed ones. Otherwise you can get a directory that
had been removed but is still busy - doesn't look like a right thing to
do. Jeremy?
								Al

