Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286411AbSAINfQ>; Wed, 9 Jan 2002 08:35:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286468AbSAINfH>; Wed, 9 Jan 2002 08:35:07 -0500
Received: from medusa.sparta.lu.se ([194.47.250.193]:24637 "EHLO
	medusa.sparta.lu.se") by vger.kernel.org with ESMTP
	id <S286411AbSAINfA>; Wed, 9 Jan 2002 08:35:00 -0500
Date: Wed, 9 Jan 2002 13:26:56 +0100 (MET)
From: Bjorn Wesen <bjorn@sparta.lu.se>
To: linux-kernel@vger.kernel.org
Subject: Re: fs corruption recovery?
In-Reply-To: <200201090326.g093QBF27608@vindaloo.ras.ucalgary.ca>
Message-ID: <Pine.LNX.3.96.1020109130708.26105A-100000@medusa.sparta.lu.se>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 8 Jan 2002, Richard Gooch wrote:
> And these companies don't really do much that you can't do yourself. I
> had a failing drive some years ago, where some sectors couldn't be
> read. So I tried to dd the raw device to a file elsewhere. Of course,
> dd will quit when it has an I/O error. So I wrote a recovery utility
> that writes a zero sector if reading the input sector gives an I/O
> error. Unfortunately, I couldn't mount the file (too much corruption),
> but I was able to use debugfs on it. I got the most important data
> back.

I thought I'd just chip in with a story about hard disk recovery here.
There is a snippet in the end relating to ext2 at least :)

Once upon a time, there was a program called DiskSalv (or something) for
the Amiga, which did the Right Thing - it tried to extract as many files
as possible from a broken disk, onto _another_ disk. That was great.

Now, 15 years later, it seems as if disk rescue programs still use the
method of trying to fix the broken disk directly. That's all good and well
for the occational missing update due to an OS crash, but should never be
done on a physically broken medium of course, if one cares about the
files..

So when my Windows (TM) FAT32 partition broke physically some months ago,
I was stunned in that I could not seem to find any tool which did the
Right Thing. All tools I found wanted to actually try to fix the partition
instead of just giving up on it and extracting what's possible to extract.

I wound up writing my own FAT32 salvage program in Linux which did exactly
that - guesses parameters even if the boot block is wasted, scans for
possible directories even if the root dir is gone, uses the backup FAT if
the other one is broken.. and then copies all the dirs and files it could
read onto the rescue medium, interactively if wanted. That was great.

Actually just some weeks ago a friend got into the same mess - could find
no program to fix the hard disk, he was ready to give up and format it,
when we thought, hey come put your disk in my computer and we'll fire up
this Linux program which will magically get your files back. Said and
done, he got all his files back even though the boot block and root dirs
were mangled (get this - he had run some program included with WinXP
called "diskfix" or something, which had more or less said "your disk is
broken. I'm setting FAT on it", upon it had quick-formatted it with
_FAT12_ yes FAT12 :) There was a big ROTFL when I discovered that. Nice
utility...

Now, when the same thing happens on an ext2 partition, something similar
should be possible to do, shouldn't it ? Is the "copy the raw data to
another partition" really necessary ?

Thing is, there are like two situations when something on a partition
breaks.. either you just want to get the partition working again and don't
really care about the data, or you care about the data but not the
partition. So if you really want to get your data back, you are willing to
take your chances on things you normally aren't. Exactly how big
corruption can e2fsck face (in the case of a copied raw partition so it
can write to it) and still recover the files ? Does it find loose files
whose directory entries are lost etc ? (impossible in FAT unfortunately)

/BW

