Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261373AbTEFUGq (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 May 2003 16:06:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261414AbTEFUGq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 May 2003 16:06:46 -0400
Received: from pat.uio.no ([129.240.130.16]:57307 "EHLO pat.uio.no")
	by vger.kernel.org with ESMTP id S261373AbTEFUGj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 May 2003 16:06:39 -0400
Date: Tue, 6 May 2003 22:19:09 +0200 (MEST)
From: Peder Stray <peder@ifi.uio.no>
To: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
cc: linux-kernel@vger.kernel.org
Subject: Re: Files truncate on vfat filesystem
In-Reply-To: <87addzu9ll.fsf@devron.myhome.or.jp>
Message-ID: <Pine.SOL.4.51.0305062212320.25815@tyrfing.ifi.uio.no>
References: <wa1ade0gkl3.fsf@tyrfing.ifi.uio.no> <87k7d4t1ay.fsf@devron.myhome.or.jp>
 <Pine.SOL.4.51.0305062018090.25815@tyrfing.ifi.uio.no> <87addzu9ll.fsf@devron.myhome.or.jp>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 7 May 2003, OGAWA Hirofumi wrote:

> Peder Stray <peder@ifi.uio.no> writes:
>
> > The problem is verry inconsistent as i said earlier, so the number of
> > files in a directory doesn't seem to matter, nor do the depth in the
> > directory structure. Some files i manage to copy yo the disk, some files i
> > don't... I havent managed to find any pattern in what files this affects.
>
> I meant, "directory entry pointer" is position of the directory entry
> in the _partition_. like the following,

aha, that was what you ment...

> in fs/fat/misc.c:fat__get_entry()
>
>	offset &= sb->s_blocksize - 1;
>	*de = (struct msdos_dir_entry *) ((*bh)->b_data + offset);
>	*ino = (sector << sbi->dir_per_block_bits) + (offset >> MSDOS_DIR_BITS);
>        ^^^
>
> This is used for _updates_ (not create) of the directory entry. And
> there is a possibility of cause of the problem which you said.  If my
> guess is right and a partition will be splited small, a problem will
> not occur.
>
> In short, I think it's the bug of fat driver and it's needed the fix.

So effeivly all directories located over a given boundry on the disk would
be affected? Would removing a file written to the disk early and making a
few directories insted fix some of the problems... Have to try that...

Need to find a way to get back the 17G of allocated but unsuable data
too...

-- 
  Peder Stray
