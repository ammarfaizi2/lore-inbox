Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262059AbUK3NAg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262059AbUK3NAg (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Nov 2004 08:00:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262058AbUK3NAg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Nov 2004 08:00:36 -0500
Received: from hermine.aitel.hist.no ([158.38.50.15]:47375 "HELO
	hermine.aitel.hist.no") by vger.kernel.org with SMTP
	id S262059AbUK3NAU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Nov 2004 08:00:20 -0500
Message-ID: <41AC7086.1030005@hist.no>
Date: Tue, 30 Nov 2004 14:07:18 +0100
From: Helge Hafting <helge.hafting@hist.no>
User-Agent: Mozilla Thunderbird 0.9 (X11/20041124)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: John Richard Moser <nigelenki@comcast.net>
CC: linux-kernel@vger.kernel.org
Subject: Re: Designing Another File System
References: <41ABF7C5.5070609@comcast.net>
In-Reply-To: <41ABF7C5.5070609@comcast.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

John Richard Moser wrote:

> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1
>
> Greetings.
>
> I've been interested in file system design for a while, and I think I
> may be able to design one.  Being poor, I would like to patent/sell it
> when done;

Well, if you want to make money - you get to do the work.  Including
the initial research into filesystem design. 

> however, whatever the result, I'd assuredly give a free
> license to implement the resulting file system in GPL2 licensed code (if
> you're not making money off it, I'm not making money off it).  This is
> similar in principle to how Hans Reiser sells his file system I think.

GPL means no restrictions, you can't prevent, say, redhat from
selling distro CDs with your GPL'ed fs.  As for _patenting_ it, well,
people here generally dislike software patents for good reasons.
You don't need a patent for this either - a copyright is probably
what you're after.

>
> 2)  Are there any other security concerns aside from information leaking
> (deleted data being left over on disk, which may pop up in incompletely
> written files)?

Have you considered what kind of data loss you'll get if power fails
before stuff is written to disk, or while it is being written?  That sort
of thing is important to users, because it really happens a lot.  Can you
design so a good fsck for your fs is possible?

> 6)  How do I lay out a time field for atime/dtime/ctime/mtime?
>
Any way you like, as long as you actually store the information
in a retrieveable way.

>
> A few more specifics, as Block size grows, the file system does not lose
> efficiency.  Fragment Blocks should skillfully subdivide huge Blocks
> with a third level index, increasing seek time O(+1) for the information
> stored in the Fragment Block:
>
>
> - -Inode
> |-Meta-data
> ||-Data Block
> |||-Data (2 seeks)
> ||-Fragment Block
> |||-Fragment
> ||||-Data (3 seeks)
>
>
> Fragment Blocks can store anything but Inodes, so it would be advisable
> to avoid huge Blocks; if a Block is 25% of the disk, for example, one
> Block must be dedicated to serving up Inode information.  Also, with
> 64KiB blocks, a 256TiB file system can be created.  Larger Blocks will
> allow larger file systems; a larger file system will predictably house
> more files (unless it houses one gargantuan relational data base-- the
> only plausible situation where my design would require more, smaller
> blocks to be more efficient).
>
> Directories will have to be some sort of on disk BsomethingTree. . . B*,
> B+, something.  I have no idea how to implement this :D  I'll assume I

Then you have a lot to learn about fs design - before you can
design anything _sellable_.  Take a look at the details of
existing linux fs'es - and be happy that you can do that at all because
they aren't patented or otherwise restricted.

> treat the directory data as a logically contiguous file (yes I'm gonna
> store directory data just like file data).  I could use a string hash of
> the Directory Entry name with disambiguation at the end, except my
> options here seem limited:
>
>
> - - Use a 32 bit string hash, 4 levels, 8 bits per level.  256 entries of
> 32 bit {offset} for the next level per level, 1024B per level on unique
> paths.  Worst case 1 path per file, 65536 files in the worst case
> measure 1 root (1KiB) + 256 L2 (256KiB) + 65536 L3 (64M) + 65536 L4
> (64M), total 128MiB, collision rate is probably low.  Ouch.
>
> - - Use a 16 bit string hash, 2 levels, 8 bits per level.  256 entries of
> 32 bit {offset) for the next level per level, 1024B per level on unique
> path.  Worst case 1 path per file, 65536 files in the worst case measure
> 1 root (1KiB) + 256 L2 (256KiB), no disambiguation, though collision
> rate is probably higher than that.  Beyond 65536 creates collisions.
> Hitting a disambiguation situation is going to be fairly common.
>
>
> I guess the second would be better?  I can't locate any directories on
> my drive with >2000 entries *shrug*.  The end key is just the entry
> {name,inode} pair.

If you want this fs to be generically used, expect some people to show
up with millions of files in a directory or tens of millions. 
They will not be amused if the lookup isn't O(1). . .

There are still fs'es around that don't look up names in O(1)
time, but some O(1) fs'es exist.  So, to _sell_ you need to be among the
better ones.

> Any ideas?
>
Write a serious free fs, and get help here.  Or go commercial - sell
your fs and pay your developers and helpers.

Helge Hafting
