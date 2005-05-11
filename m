Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261956AbVEKKFv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261956AbVEKKFv (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 May 2005 06:05:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261957AbVEKKFv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 May 2005 06:05:51 -0400
Received: from mailfe03.swip.net ([212.247.154.65]:10235 "EHLO swip.net")
	by vger.kernel.org with ESMTP id S261956AbVEKKEl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 May 2005 06:04:41 -0400
X-T2-Posting-ID: jLUmkBjoqvly7NM6d2gdCg==
Subject: Re: OOPS + 2.6.9-gentoo-r9 (and .10 and .11) + 2xHPT302 + RAID5
From: Alexander Nyberg <alexn@telia.com>
To: ray hilton <ray.hilton@gmail.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <5fcd2f1d050511013414c3f8d1@mail.gmail.com>
References: <5fcd2f1d050511013414c3f8d1@mail.gmail.com>
Content-Type: text/plain
Date: Wed, 11 May 2005 12:04:35 +0200
Message-Id: <1115805875.6575.3.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> We have been trying to re-build a new system after a system disk
> failed a couple of weeks ago.  It was a gentoo system running 2.4, but
> this time we figured we would take the plunge and install 2.6, since
> we had a couple of problems with 2.4 and its support of the ITE RAID
> card.  Now we have two HPT302 cards, 7x120Gb drives, one 160Gb drive
> attached to the motherboard, thats pretty much the only exceptional
> configuration, other than that, DVD-R, AMD2000+, 512Mb SDR memory...
> 
> Anyway, we are onto our second rebuild now, the first was done using
> reiserfs on the system disk, this had intermitent segfaults during the
> build, which we first put down to gcc, but later we realised it was
> something to do with the kernel's reiserfs driver since it was OOPSing
> in that module.  We then started getting segfaults with all manner of
> tools, including emerge (gentoo's port system) and corruption in the
> ports tree.  I tried reinstalling all the components, rebuilding the
> kernel with different gcc's but still the same.
> 
> So we figured we would rebuild and use ext3 as the root filesystem. 
> Worked fine up until an hour ago, when it started OOPSing with the
> following (see examples below).
> 
> Now, I am no C whizz, or kernel hacker, just very very confused as to
> what is going on.  We have tried 2.6.9,2.6.10 and 2.6.11 with gcc 3.3
> and 3.4 with a reiserfs root, and we get problems, and now we change
> to ext3, we get the same, which leads me to suspect its not
> reiserfs/ext3, but something messing with it.    My minimal research
> into possible causes has led me to think that raid5/md/lvm with the
> dual HPT302 cards could be doing something odd... I dont know how or
> why, hence my call for help!
> 
> Any help would be appreciated, or perhaps a point in the right
> direction!  I just cant beleive that something like this would have
> gone unoticed if it was a problem with the filesystem drivers.
> 

By the looks of this report, have you taken a long run with
http://www.memtest86.com/ ? If not I really think you should.



> Unable to handle kernel paging request at virtual address 00200004
>  printing eip:
> c0130292
> *pde = 00000000
> Oops: 0002 [#1]
> PREEMPT
> Modules linked in:
> CPU:    0
> EIP:    0060:[<c0130292>]    Not tainted VLI
> EFLAGS: 00010006   (2.6.9-gentoo-r9)
> EIP is at find_lock_page+0x32/0xe0
> eax: 00200000   ebx: 00200000   ecx: 00000000   edx: 00000000
> esi: 00000000   edi: e9dc0d08   ebp: 00000000   esp: ee264d38
> ds: 007b   es: 007b   ss: 0068
> Process emerge (pid: 23819, threadinfo=ee264000 task=c8e21aa0)
> Stack: e9dc0d08 00000000 00000000 00000000 00000000 e9dc0d04 c0131f1f e9dc0d04
>        00000000 00000000 000000d0 0037806c 00000000 ee264000 00000000 b71a4000
>        00000147 0037806c e9dc0c6c c03ea160 ef64d7e0 00000000 00000000 00000000
> Call Trace:
>  [<c0131f1f>] generic_file_buffered_write+0xff/0x5e0
>  [<c01c6df6>] do_get_write_access+0x256/0x600
>  [<c0168677>] inode_update_time+0xa7/0xe0
>  [<c013265d>] generic_file_aio_write_nolock+0x25d/0x480
>  [<c01c71e3>] journal_get_write_access+0x43/0x60
>  [<c01329d3>] generic_file_aio_write+0x83/0x100
>  [<c01b77a4>] ext3_file_write+0x44/0xe0
>  [<c014d9be>] do_sync_write+0xbe/0xf0
>  [<c0113200>] autoremove_wake_function+0x0/0x60
>  [<c014daac>] vfs_write+0xbc/0x170
>  [<c014dc31>] sys_write+0x51/0x80
>  [<c0104207>] syscall_call+0x7/0xb


