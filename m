Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265700AbSLWBdb>; Sun, 22 Dec 2002 20:33:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265759AbSLWBdb>; Sun, 22 Dec 2002 20:33:31 -0500
Received: from warden-p.diginsite.com ([208.29.163.248]:38828 "HELO
	warden.diginsite.com") by vger.kernel.org with SMTP
	id <S265700AbSLWBda>; Sun, 22 Dec 2002 20:33:30 -0500
From: David Lang <david.lang@digitalinsight.com>
To: "Joseph D. Wagner" <wagnerjd@prodigy.net>
Cc: "'Torben Frey'" <kernel@mailsammler.de>, linux-kernel@vger.kernel.org
Date: Sun, 22 Dec 2002 17:29:33 -0800 (PST)
Subject: RE: Horrible drive performance under concurrent i/o jobs (dlh
 problem?)
In-Reply-To: <000d01c2a8b6$3d102e20$941e1c43@joe>
Message-ID: <Pine.LNX.4.44.0212221714360.10806-100000@dlang.diginsite.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 21 Dec 2002, Joseph D. Wagner wrote:

> > As for speed, as long as you are on the same
> > spindles there is no definante speed gain for
> > having lots of partitions and there is a
> > definante cost to having lots of partitions.
> > If you think about it, if you have separate
> > partitions you KNOW that you will have to seek
> > across a large portion of the disk to get
> > from /root to /var where they may not be
> > seperated that much if they are one filesystem.
>
> Ok, now here's where you're just plain wrong.
>
> SHORT ANSWER: Segregating partitions reduces seek time.  Period.
>
> LONG ANSWER: Reads and writes tend to be grouped within a partition.  For
> example, if you're starting a program, you're going to be doing a lot of
> reads somewhere in the /usr partition.  If the program uses temporary files,
> you're going to do a lot of reads & writes in the /tmp partition.  If you're
> saving a file, you're going to be doing lots of writes to the /home
> partition.  Hence, since most disk accesses occur in groups within a
> partition, preference should be giving to reducing seek time WITHIN a
> partition, rather than reducing seek time BETWEEN partitions.

with one partition you MAY have to seek across the disk to get from one
file to another (depends on the optimization of the filesystem)

with multiple partitions you WILL have to seek across the disk becouse
files on one partition are forrced by your partitioning to be on a
seperate part of the drive.

if all your access it to the same file it won't matter how you are
partitioned, but if you read a file from one filesystem, put intermediate
results in /tmp, then put the final result back on the first filesystem
you will end up doing a LOT of seeking between the partitions.

I am not saying that a single partition is nessasarily faster, but I am
saying that multiple partitions are not a definante win, and under some
conditions can be a significant loss.

it's like filesystem type, you need to look at what you are doing and plan
accordingly.

David Lang
