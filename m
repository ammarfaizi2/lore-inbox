Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276888AbRJCGye>; Wed, 3 Oct 2001 02:54:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276889AbRJCGyY>; Wed, 3 Oct 2001 02:54:24 -0400
Received: from note.orchestra.cse.unsw.EDU.AU ([129.94.242.29]:58885 "HELO
	note.orchestra.cse.unsw.EDU.AU") by vger.kernel.org with SMTP
	id <S276888AbRJCGyK>; Wed, 3 Oct 2001 02:54:10 -0400
From: Neil Brown <neilb@cse.unsw.edu.au>
To: Andreas Dilger <adilger@turbolabs.com>
Date: Wed, 3 Oct 2001 16:54:12 +1000 (EST)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15290.46612.877715.135811@notabene.cse.unsw.edu.au>
Cc: Alexander Viro <viro@math.psu.edu>,
        Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org,
        Ingo Molnar <mingo@elte.hu>
Subject: Re: 2.4.11-pre2 fs/buffer.c: invalidate: busy buffer
In-Reply-To: message from Andreas Dilger on Wednesday October 3
In-Reply-To: <9pe345$8ic$1@penguin.transmeta.com>
	<Pine.GSO.4.21.0110030014270.21861-100000@weyl.math.psu.edu>
	<20011003004139.B8954@turbolinux.com>
X-Mailer: VM 6.72 under Emacs 20.7.2
X-face: [Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday October 3, adilger@turbolabs.com wrote:
> On Oct 03, 2001  00:21 -0400, Alexander Viro wrote:
> > AFAICS, md.c also doesn't play nice with buffe cache.
  snip
> > 
snip
> 
> Three possibilities:
> 1) Save the blocksize and restore it afterwards (ugly, not 100% fix)
> 2) Do I/O in the current blocksize, which adds slight complication to
>    this function, but not too much (loop on the number of blocks to
>    write, normally only one).  I don't know what impact this has
>    on superblock consistency, but in theory none because you can't
>    guarantee larger than single-sector I/O anyways, although there
>    _may_ be a slightly increased chance of not getting a bh in OOM.
>    Compiled but untested patch below.  I had also looked at the read
>    path, but it is only used for new disks so no harm in setting blocksize.
> 3) Rewrite to do I/O directly via pagecache?

4) Rewrite to do I/O directly via generic_make_request just like it
   does for all other I/O to underlying devices.
   It is on my (mental) todo list, but doesn't have a high priority.
   At the same time, it would be good to get write_disk_sb to notice
   if the write failed.....

NeilBrown
