Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282816AbRLORJZ>; Sat, 15 Dec 2001 12:09:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282815AbRLORJP>; Sat, 15 Dec 2001 12:09:15 -0500
Received: from chabotc.xs4all.nl ([213.84.192.197]:19072 "EHLO
	chabotc.xs4all.nl") by vger.kernel.org with ESMTP
	id <S282816AbRLORI7>; Sat, 15 Dec 2001 12:08:59 -0500
Subject: Re: Unfreeable buffer/cache problem in 2.4.17-rc1 still there
From: Chris Chabot <chabotc@reviewboard.com>
To: linux-kernel@vger.kernel.org
Cc: hahn@physics.mcmaster.ca, andrea@suse.de, marcelo@conectiva.com.br,
        brownfld@irridia.com
In-Reply-To: <Pine.LNX.4.33.0112151141280.19022-100000@coffee.psychology.mcmaster.ca>
In-Reply-To: <Pine.LNX.4.33.0112151141280.19022-100000@coffee.psychology.mcmaster.ca>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/1.0 (Preview Release)
Date: 15 Dec 2001 18:09:00 +0100
Message-Id: <1008436141.13195.0.camel@gandalf.chabotc.com>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mark Han wrote,
> first, forget silly crap like top; look at the /proc files.
> inode/dentry caches are just slab caches, which afaik 
> are not considered part of the 'cached' that top is talking about.
> (since top preceeds slab and is referring to buffer+page caches.)

Man somebody got out of the wrong side of the bed this morning ;-) The
problem is that those prety user end lights are the only things the user
see's ;-) So it might be worth considering exporting this 'secret'
information to the user end (count it as cache in /proc/memusage?)

> what makes you think there's anything wrong with this?  you have tons of
> memory, and aren't using it hard, so the kernel uses it to cache files,
> inodes, dentries, etc.

I know, cache is good. However first of all, 400 to 600 mb of cache used
for dentries/inodes seems a little steep to me (as not kernel hacker),
and when i do fire up memory hogging applications (mysql,apache,java
etc) the 'evaporated' memory is not returned for those applications.
Resulting in heavy swapping and a non-responsive system. For a dual p3
with 1 gig of ram, this feels like a problem, yes ;-)
do note then when i do a simple find /, it do see the memory being used
in cached and buffers. This is not the case for the 'missing memory'

Ken Brownfield wrote,
> I think "updatedb" at 4am is what you're looking for...  How much disk
> space do you have on this system?
The system has 2 x 18Gb scsi disks (/ and /home) and a single raid0 volume (4x 80 gig ide) as archival storage. Doing a find | wc -l on the archives alone tells me i have more then 340000 files there.. (ranging between a few bytes to  > 1 gig)

But indeed, when i run updatedb, the problem of non-visable memory (for
me using top / free anyways) does apear.. good catch!

Andrea wrote,
> this is an icache/dcache problem, can you reproduce on 2.4.17rc1aa1,
> it will shrink more aggressively.

doing that (updatedb), i dont have to wait a day or so to see what
happens, mem free (+buffers + cache from /proc/meminfo) is around 550Mb,
'used memory' (counting ps aux res usage) is < 100Mb. So quite a couple
of megabytes have disapeard again ;/

	-- Chris


