Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269102AbRHBT4I>; Thu, 2 Aug 2001 15:56:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269082AbRHBTzw>; Thu, 2 Aug 2001 15:55:52 -0400
Received: from humbolt.nl.linux.org ([131.211.28.48]:62224 "EHLO
	humbolt.nl.linux.org") by vger.kernel.org with ESMTP
	id <S269099AbRHBTzf>; Thu, 2 Aug 2001 15:55:35 -0400
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@bonn-fries.net>
To: Alexander Viro <viro@math.psu.edu>
Subject: Re: ext3-2.4-0.9.4
Date: Thu, 2 Aug 2001 22:01:01 +0200
X-Mailer: KMail [version 1.2]
Cc: Matthias Andree <matthias.andree@stud.uni-dortmund.de>,
        "Stephen C. Tweedie" <sct@redhat.com>, linux-kernel@vger.kernel.org
In-Reply-To: <Pine.GSO.4.21.0108021347300.29563-100000@weyl.math.psu.edu>
In-Reply-To: <Pine.GSO.4.21.0108021347300.29563-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Message-Id: <01080222010104.00440@starship>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 02 August 2001 19:54, Alexander Viro wrote:
> On Thu, 2 Aug 2001, Daniel Phillips wrote:
> > I don't know why it is hard or inefficient to implement this at the
> > VFS level, though I'm sure there is a reason or this thread
> > wouldn't exist.  Stephen, perhaps you could explain for the record
> > why sys_fsync can't just walk the chain of dentry parent links
> > doing fdatasync?  Does this create VFS or Ext3 locking problems? 
> > Or maybe it repeats work that Ext3 is already supposed to have
> > done?
>
> Parent directory can be renamed. Which grandparent should we sync?
> New one? Old one? Both?

Either one, or both, it doesn't matter since the application has not 
forced any serialization on this and can't assume any.

> BTW, how about file itself getting renamed during fsync()?

It doesn't matter.  If the application wants to race that way, let it.  
We're talking about ensuring access to the fsynced fd's inode.

> See the problem? And no, blocking all renames while fsync() happens
> is not an answer - it's a DoS.

We would have done our duty by fsyncing the inodes one at a time 
working up the dentry chain towards the root, and not trying to lock 
the whole chain.  If something happens while we're doing that it's an 
application race.

--
Daniel
