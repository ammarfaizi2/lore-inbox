Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314512AbSEKEkc>; Sat, 11 May 2002 00:40:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314557AbSEKEkb>; Sat, 11 May 2002 00:40:31 -0400
Received: from c16410.randw1.nsw.optusnet.com.au ([210.49.25.29]:54515 "EHLO
	mail.chubb.wattle.id.au") by vger.kernel.org with ESMTP
	id <S314512AbSEKEk3>; Sat, 11 May 2002 00:40:29 -0400
From: Peter Chubb <peter@chubb.wattle.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15580.41133.804879.723610@wombat.chubb.wattle.id.au>
Date: Sat, 11 May 2002 14:40:13 +1000
To: Andreas Dilger <adilger@clusterfs.com>
Cc: Peter Chubb <peter@chubb.wattle.id.au>,
        Jeremy Andrews <jeremy@kerneltrap.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] remove 2TB block device limit
In-Reply-To: <20020510234623.GC12975@turbolinux.com>
X-Mailer: VM 7.03 under 21.4 (patch 6) "Common Lisp" XEmacs Lucid
Comments: Hyperbole mail buttons accepted, v04.18.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> "Andreas" == Andreas Dilger <adilger@clusterfs.com> writes:

Andreas> On May 11, 2002 05:12 +1000, Peter Chubb wrote:
>> See http://www.gelato.unsw.edu.au/~peterc/lfs.html (which I'm
>> intending to update next week, after some testing to check the new
>> limits with my new code -- I found the 1TB limit in the generic
>> code (someone using a signed int instead of unsigned long))

Andreas> Any chance you could rename this from "LFS" to something else
Andreas> (e.g. LBD for Large Block Device).  LFS == Large File Summit
Andreas> which describes the use/access of > 2GB _files_ on 32-bit
Andreas> systems under Unix.

Will do.

Andreas> Does x86-64 and/or ia64 actually _use_ > 4kB page sizes?  If
Andreas> so, it may be more worthwhile to allow larger block sizes
Andreas> with e2fsprogs.  It may be that the kernel supports >4kB
Andreas> blocks already on systems with larger PAGE_SIZE, I don't know
Andreas> (no way for me to test this).

ia64 uses 16k standard; you can choose up to 64k and get performance
gains.
The main limitation on performance on a modern architecture is the
limited TLB coverage of the large real address space --- large pages
give fewer TLB entries for the same coverage, which leads to better
performance.

>> It's extremely unlikely that you'd want to use a non-journalled
>> file system on such a large partition, so your best bets are
>> reiserfs, jfs or XFS.

Andreas> I find it somewhat ironic that you suggest reiserfs over
Andreas> ext3, when in fact they both currently have the same 16TB
Andreas> filesystem limit.  On your web page, you say the ext[23]
Andreas> limit is 1TB, which it definitely is not (unless there are
Andreas> bugs in the code).  There is currently a 16TB filesystem
Andreas> limit for 4kB blocks, but there are plans towards fixing that
Andreas> also.

I found the limitation --- it was in the block layer, not ext2.
There were bugs in the other FS that let me create files bigger than
the 2TB pagecache limit, even though when I tried to write them bad
things happened.

Updating that web page is on my TODO list for Monday...

>> --- Limitations imposed by the partitioning scheme.  As far as I
>> know, only the EFI GUID partitioning scheme uses 64-bit block
>> offsets, so under any other scheme you're limited to 2^32 or 2^31
>> blocks per disc; some use the underlying hardware sector size, some
>> use a block size that's multiple of this.

Andreas> LVM does not need to have partitions, and presumably EVMS
Andreas> using Linux or AIX LVM devices doesn't either.

Sure.  Discs and hardware raids don't need partitions either, providing the
size of the media is smaller than the filesystem-layout-imposed size limit. 

The reasons, as far as I'm concerned, for partitioning a disc are:
    -- convenience, to allow controlled sharing of discs
    -- to allow striping of swap space across multiple spindles (have
       a swap partition on each drive)
    -- to keep filesystem size below backup-medium size.

If you want to boot from a drive, it'd better have a volume header
that the firmware (e.g., the BIOS) understands, too.

Peter Chubb
peterc@gelato.unsw.edu.au	http://www.gelato.unsw.edu.au
