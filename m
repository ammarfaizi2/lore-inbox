Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281159AbRKEOKZ>; Mon, 5 Nov 2001 09:10:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281160AbRKEOKP>; Mon, 5 Nov 2001 09:10:15 -0500
Received: from ahriman.Bucharest.roedu.net ([141.85.128.71]:7046 "HELO
	ahriman.bucharest.roedu.net") by vger.kernel.org with SMTP
	id <S281159AbRKEOKE>; Mon, 5 Nov 2001 09:10:04 -0500
Date: Mon, 5 Nov 2001 16:11:21 +0200 (EET)
From: Mihai RUSU <dizzy@roedu.net>
X-X-Sender: <dizzy@ahriman.bucharest.roedu.net>
To: Tux mailing list <tux-list@redhat.com>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: Lots of questions about tux and kernel setup
In-Reply-To: <Pine.LNX.4.30.0111051429040.18879-100000@mustard.heime.net>
Message-ID: <Pine.LNX.4.33.0111051607320.8028-100000@ahriman.bucharest.roedu.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 5 Nov 2001, Roy Sigurd Karlsbakk wrote:

> > to answer other "not asked" questions of yours ill point you to :
> > http://www.specbench.org/osg/web99/results/res2000q4/web99-20001127-00075.html
> >
> > as that should help you very much :) (that /proc tweaking its pretty cool)
>
> Thanks!
>
no problem

> Just one thing...
>
> I need redundancy, so I can't go with RAID 0. I thought I'd go with RAID
> 4, to avoid reading the parity info (and thereby wasting time), and still
> have some quite good redundancy.
>
i see
we use raid-5 in production here

> Q: Should I use hardware RAID or software RAID here? I can see they've
> been using a rather large stripe (or chunk) size on the RAID (2MB). The
> RAID controller I planned to use only supports up to 512kB stripes. As I
> said, the files I'm reading are rather large - up to 10GB each, or at
> least 1GB. I'm reading 4-7Mbps (500-900kB) per connection and each
> connection reads only one file. Will a large stripe size help me here?
>

if you got the money i recommend Mylex AccelRAID (www.mylex.com)
they are very well supported on linux and pretty fast too :)

im not a raid expert but i found some interesting information in the
DAC960 docs (/usr/src/linux/Documentation/README.DAC960)

Quote:

For maximum performance and the most efficient E2FSCK performance, it is
recommended that EXT2 file systems be built with a 4KB block size and 16
block stride to match the DAC960 controller's 64KB default stripe size.
The command "mke2fs -b 4096 -R stride=16 <device>" is appropriate.
Unless there will be a large number of small files on the file systems, it
is also beneficial to add the "-i 16384" option to increase the bytes per
inode parameter thereby reducing the file system metadata.  Finally, on
systems that will only be run with Linux 2.2 or later kernels it is
beneficial to enable sparse superblocks with the "-s 1" option.

now i know you will not use ext2 (for data at least) but its a start point
to optimize the RAID and FS (whatever your choice)

i recommend XFS for those large files you have there

----------------------------
Mihai RUSU
"... and what if this is as good as it gets ?"

