Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262690AbTIEO5K (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Sep 2003 10:57:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262634AbTIEO5K
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Sep 2003 10:57:10 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:21845 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S262690AbTIEO5G (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Sep 2003 10:57:06 -0400
To: Pavel Machek <pavel@ucw.cz>
Cc: Mike Fedyk <mfedyk@matchmail.com>, Ed Sweetman <ed.sweetman@wmich.edu>,
       Alex Tomas <bzzz@tmi.comex.ru>, linux-kernel@vger.kernel.org,
       ext2-devel@lists.sourceforge.net
Subject: Re: [Ext2-devel] Re: [RFC] extents support for EXT3
References: <m3r834phqi.fsf@bzzz.home.net> <3F4F7D56.9040107@wmich.edu>
	<m3isogpgna.fsf@bzzz.home.net> <3F4F923F.9070207@wmich.edu>
	<m3ad9snxo6.fsf@bzzz.home.net> <3F4FAFA2.4080202@wmich.edu>
	<20030829213940.GC3846@matchmail.com> <3F4FD2BE.1020505@wmich.edu>
	<20030829231726.GE3846@matchmail.com>
	<m18yp9r2uq.fsf@ebiederm.dsl.xmission.com>
	<20030905100607.GA220@elf.ucw.cz>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: 05 Sep 2003 08:55:17 -0600
In-Reply-To: <20030905100607.GA220@elf.ucw.cz>
Message-ID: <m165k7p9nu.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pavel Machek <pavel@ucw.cz> writes:

> Hi!
> 
> > > > you get no real slowdown as far as rough benchmarks are concerned, 
> > > > perhaps with a microbenchmark you would see one and also, doesn't it 
> > > > take up more space to save the extent info and such? Either way, all of 
> > > > it's real benefits occur on large files.
> > > 
> > > IIRC, if your blocks are contiguous, you can save as soon as soon as the
> > > file size goes above one block (witout extents, the first 12 blocks are
> > > pointed to by what?  I forget... :-/ )
> > 
> > They are pointed to directly from the inode.
> > 
> > In light of other concerns how reasonable is a switch to e2fsck that
> > will remove extents so people can downgrade filesystems?
> 
> It is going to be non-trivial: downgrading filesystem will likely need
> free space. And now: what happens when there's no free space?

Having a full filesystem is generally a rare event.  And the actual size
difference between an extent tree based solution and a block tree solution
is usually quite small.  

And if it fails, well filesystems checkers are not required to succeed.
Safety wise it should be possible to allocate and probably even write
the entire block tree before the extent tree is removed so no data
should be lost.

Maybe downgrading is just silly but it is a nice option to have while
everything is still in development.  For the most part people seem to
be completely capable of making a back up and totally recreating a
filesystem as people have shown.  But if you are going to require that
what is the point of staying with the ext2 file format.


Eric
