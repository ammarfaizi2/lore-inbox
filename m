Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317244AbSEXSm0>; Fri, 24 May 2002 14:42:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317245AbSEXSmZ>; Fri, 24 May 2002 14:42:25 -0400
Received: from mark.mielke.cc ([216.209.85.42]:12805 "EHLO mark.mielke.cc")
	by vger.kernel.org with ESMTP id <S317244AbSEXSmX>;
	Fri, 24 May 2002 14:42:23 -0400
Date: Fri, 24 May 2002 14:36:25 -0400
From: Mark Mielke <mark@mark.mielke.cc>
To: Alexander Viro <viro@math.psu.edu>
Cc: Linus Torvalds <torvalds@transmeta.com>, Andrea Arcangeli <andrea@suse.de>,
        linux-kernel@vger.kernel.org
Subject: Re: negative dentries wasting ram
Message-ID: <20020524143625.A25016@mark.mielke.cc>
In-Reply-To: <Pine.LNX.4.44.0205240927580.11495-100000@home.transmeta.com> <Pine.GSO.4.21.0205241259230.9792-100000@weyl.math.psu.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 24, 2002 at 01:00:14PM -0400, Alexander Viro wrote:
> > The only think we save is a dentry kfree/kmalloc in this case, nbot a FS
> > downcall. And I think Andrea is right that it can waste memory for the
> > likely much more common case where the file just stays removed.
> ???
> It's lookup + unlink + lookup + create vs. lookup + unlink + create.

I would rather use kernel memory for far more useful things, such as
more room for actual dentries/inodes, or negative dentries found from
failed lookup() calls (i.e. proven useful).

The overhead of unlink()/create() probably swamps the rather minimal
gain from a saved lookup() in this not very common situation.

Just the opinion of somebody that doesn't matter... :-)
mark

-- 
mark@mielke.cc/markm@ncf.ca/markm@nortelnetworks.com __________________________
.  .  _  ._  . .   .__    .  . ._. .__ .   . . .__  | Neighbourhood Coder
|\/| |_| |_| |/    |_     |\/|  |  |_  |   |/  |_   | 
|  | | | | \ | \   |__ .  |  | .|. |__ |__ | \ |__  | Ottawa, Ontario, Canada

  One ring to rule them all, one ring to find them, one ring to bring them all
                       and in the darkness bind them...

                           http://mark.mielke.cc/

