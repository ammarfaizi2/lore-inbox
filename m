Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276923AbRJKVGz>; Thu, 11 Oct 2001 17:06:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276928AbRJKVGq>; Thu, 11 Oct 2001 17:06:46 -0400
Received: from leibniz.math.psu.edu ([146.186.130.2]:11918 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S276923AbRJKVGl>;
	Thu, 11 Oct 2001 17:06:41 -0400
Date: Thu, 11 Oct 2001 17:07:04 -0400 (EDT)
From: Alexander Viro <viro@math.psu.edu>
To: Christian Ullrich <chris@chrullrich.de>
cc: linux-kernel@vger.kernel.org, reiserfs-list@namesys.com
Subject: Re: [reiserfs-list] Can't mount reiserfs with 2.4.11, 2.4.10 works
 fine
In-Reply-To: <20011011223231.A730@christian.chrullrich.de>
Message-ID: <Pine.GSO.4.21.0110111656200.24742-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 11 Oct 2001, Christian Ullrich wrote:

> I haven't yet gotten to test 2.4.12. I will do that asap
> and report the results.

2.4.12 shouldn't have changed anything in that area.
 
>    Device Boot    Start       End    Blocks   Id  System
> /dev/hdb1   *        63  10000367   5000152+   7  HPFS/NTFS
> /dev/hdb2      10000368  78063551  34031592    f  Win95 Ext'd (LBA)
> /dev/hdb3      78063552  80063423    999936   82  Linux swap
> /dev/hdb5      10000431  30973319  10486444+   7  HPFS/NTFS
> /dev/hdb6      48063519  78063551  15000016+  83  Linux
> 
> Expert command (m for help): p
> 
> Disk /dev/hdb: 16 heads, 63 sectors, 79428 cylinders
> 
> Nr AF  Hd Sec  Cyl  Hd Sec  Cyl    Start     Size ID
>  1 80   1   1    0  15  63 1023       63 10000305 07
>  2 00  15  63 1023  15  63 1023 10000368 68063184 0f
>  3 00  15  63 1023  15  63 1023 78063552  1999872 82
>  4 00   0   0    0   0   0    0        0        0 00
>  5 00  15  63 1023  15  63 1023       63 20972889 07
>  6 00  15  63 1023  15  63 1023       63 30000033 83

Umhm... Could you dd the sectors 0, 10000368 and 48063456 and mail them?

Another thing to do - take the patch I've sent and add

	printk("[%d %d]\n", start, size);

in the beginning of fs/partitions/check.c::add_gd_partition()

Then we should at least see what kernel thinks about the sizes and starting
sectors of your partitions.  It looks like they are screwed of hda6 (if
they are not, we can safely forget about partition-related reasons in your
case - then you really getting a block number out of range and we should look
in fs code; however, considering other bug reports I'd like to check the
partition-related problems first).

