Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272360AbRIKJzr>; Tue, 11 Sep 2001 05:55:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272357AbRIKJzh>; Tue, 11 Sep 2001 05:55:37 -0400
Received: from humbolt.nl.linux.org ([131.211.28.48]:25350 "EHLO
	humbolt.nl.linux.org") by vger.kernel.org with ESMTP
	id <S272360AbRIKJz1>; Tue, 11 Sep 2001 05:55:27 -0400
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@bonn-fries.net>
To: Rik van Riel <riel@conectiva.com.br>,
        Linus Torvalds <torvalds@transmeta.com>
Subject: Re: linux-2.4.10-pre5
Date: Tue, 11 Sep 2001 12:02:51 +0200
X-Mailer: KMail [version 1.3.1]
Cc: Andreas Dilger <adilger@turbolabs.com>, Andrea Arcangeli <andrea@suse.de>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.33L.0109101937370.2490-100000@duckman.distro.conectiva>
In-Reply-To: <Pine.LNX.4.33L.0109101937370.2490-100000@duckman.distro.conectiva>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <20010911095541Z16308-26183+1020@humbolt.nl.linux.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On September 11, 2001 12:39 am, Rik van Riel wrote:
> On Mon, 10 Sep 2001, Linus Torvalds wrote:
> 
> > (Ugly secret: because I tend to have tons of memory, I sometimes do
> >
> > 	find tree1 tree2 -type f | xargs cat > /dev/null
> 
> This suggests we may want to do agressive readahead on the
> inode blocks.
> 
> They are small enough to - mostly - cache and should reduce
> the amount of disk seeks quite a bit. In an 8 MB block group
> with one 128 byte inode every 8 kB, we have a total of 128 kB
> of inodes...

I tested this idea by first doing a ls -R on the tree, then Linus's find 
command:

    time ls -R linux >/dev/null
    time find linux -type f | xargs cat > /dev/null

the plan being that the ls command would read all the inode blocks and hardly 
any of the files would be big enough to have an index block, so we would 
effectively have all metadata in cache.

According to your theory the total time for the two commands should be less 
than the second command alone.  But it wasn't, the two commands together took 
almost exactly the same time as the second command by itself.

There goes that theory.

--
Daniel
