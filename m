Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261967AbTLWSBZ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 Dec 2003 13:01:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261868AbTLWSBZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 Dec 2003 13:01:25 -0500
Received: from findaloan.ca ([66.11.177.6]:194 "EHLO mark.mielke.cc")
	by vger.kernel.org with ESMTP id S261967AbTLWSBF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 Dec 2003 13:01:05 -0500
Date: Tue, 23 Dec 2003 12:34:29 -0500
From: Mark Mielke <mark@mark.mielke.cc>
To: Ian Kent <raven@themaw.net>
Cc: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: DevFS vs. udev
Message-ID: <20031223173429.GA9032@mark.mielke.cc>
References: <E1AYl4w-0007A5-R3@O.Q.NET> <Pine.LNX.4.44.0312240005180.4342-100000@raven.themaw.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0312240005180.4342-100000@raven.themaw.net>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 24, 2003 at 12:19:00AM +0800, Ian Kent wrote:
> When this thread first started I had a look at the code and, I must admit, 
> it is a little untidy (ugly actually). I think it would require a 
> considerable amount of effort just to make it maintainable. Maybe then 
> some of the problems (whatever they are) would present themselves.
> So it's deprecated in 2.6. Is this only because no one is willing to take 
> on maintenance of it or is it to late?

In true open source style, it is never too late.

All you need to do is convince enough influential people to include *your*
fixes into the tree. At this point in time, it looks like you would need
to improve the devfs code quite a bit to change their minds. udev, once
implemented, will be elegant (interface-wise) competition.

The arguments against udev that I have seen to date are:

    1) Device metadata does not belong in user space. To this, I say 'why'?
       For *decades*, /dev has existed as a file system without *any* kernel
       support. udev follows in these steps. devfs is the drastically
       different model that has been difficult to make work right in all
       circumstances. /dev has a file system only had problems of capacity.

    2) udev is slow. To this, I say 'prove it'. Why should it be slow?
       As a tmpfs file system, I *assume* that the vfs name lookup routines
       are implemented quite efficiently. What would make udev be slow?
       How often are devices added and removed from the kernel? Does anybody
       have a real life scenario where a kernel model is added and removed
       hundreds of times a second?

    3) udev takes up more memory. Why should this be the case? It is in
       user space, meaning that for a running system, it, and it's
       configuration file don't even need to take up swap space. The only
       space requirements are those dictated by the file system. For tmpfs
       I doubt the space is that much more than devfs (both need kernel
       data structures to be initialized and in existence). For a regular
       file system, it isn't a fair comparison, but the cost should be
       quite minimal. They're device files. They don't have data outside
       their inode structure.

I blame the udev people for this thread. :-) They should have their beast
*finished* already, and their sales skills need to be improved. Volunteer
techies! Hehe...

mark

-- 
mark@mielke.cc/markm@ncf.ca/markm@nortelnetworks.com __________________________
.  .  _  ._  . .   .__    .  . ._. .__ .   . . .__  | Neighbourhood Coder
|\/| |_| |_| |/    |_     |\/|  |  |_  |   |/  |_   | 
|  | | | | \ | \   |__ .  |  | .|. |__ |__ | \ |__  | Ottawa, Ontario, Canada

  One ring to rule them all, one ring to find them, one ring to bring them all
                       and in the darkness bind them...

                           http://mark.mielke.cc/

