Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136502AbREIOj2>; Wed, 9 May 2001 10:39:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136501AbREIOjT>; Wed, 9 May 2001 10:39:19 -0400
Received: from elektra.higherplane.net ([203.37.52.137]:64143 "EHLO
	elektra.higherplane.net") by vger.kernel.org with ESMTP
	id <S136502AbREIOjF>; Wed, 9 May 2001 10:39:05 -0400
Date: Thu, 10 May 2001 00:49:59 +1000
From: john slee <indigoid@higherplane.net>
To: Mart?n Marqu?s <martin@bugs.unl.edu.ar>
Cc: linux-kernel@vger.kernel.org
Subject: Re: reiserfs, xfs, ext2, ext3
Message-ID: <20010510004959.B7653@higherplane.net>
In-Reply-To: <01050910381407.26653@bugs>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.17i
In-Reply-To: <01050910381407.26653@bugs>; from martin@bugs.unl.edu.ar on Wed, May 09, 2001 at 10:38:14AM +0300
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 09, 2001 at 10:38:14AM +0300, Mart?n Marqu?s wrote:
> We are waiting for a server with dual PIII, RAID 1,0 and 5 18Gb scsi disks to
> come so we can change our proxy server, that will run on Linux with Squid.
> One disk will go inside (I think?) and the other 4 on a tower conected to the
> RAID, which will be have the cache of the squid server.

that's a pretty huge cache, have you considered using 8*9gb disks
instead of 4*18?  what sort of request throughput/latency are you
aiming for?  as the number of requests grows, disk seek times are
a very real problem.

> One of my partners thinks that we should use reiserfs on all the server (the
> partitions of the Linux distro, and the cache partitions), and I found out
> that reiserfs has had lots of bugs, and is marked as experimental in kernel

well, lots of bugs in reiserfs have been fixed.. obviously there are
more bugs to come (as always), but on the whole a lot of people are very
happy with it.  there certainly haven't been many posts of reiserfs
corruption lately at all on linux-kernel.

> 2.4.4. Not to mention that the people of RH discourage there users from using
> it.

they do?

> So what I want is to know which is the status of this 3 journaling FS. Which
> is the one we should look for?

xfs, while wonderful, probably isn't what you're looking for.  AFAIK it
is intended more for very very very large files.

> I think that the data lose is not significant in a proxy cache, if the FS is
> really fast, as is said reiserfs is.

data loss is always significant.  consider the case where you are forced
to rebuild the filesystem squid's cache directories reside on...
admittedly it is an extreme case, but it is a possibility all the same.

reiserfs is supposed to be very good with lots of small files, which is
the typical case for a squid cache.  however there's no substitute for
actual testing.  benchmark your squid server (use polygraph, from the
squid website) with each fs, and remember to test each of squid's
cache_dir options (diskd, aufs, coffs, ufs).

also appropriate could be ext2 with daniel phillips' directory indexing
patches.

test.  test.  test.  good luck.

j.

-- 
"Bobby, jiggle Grandpa's rat so it looks alive, please" -- gary larson
