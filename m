Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261497AbUJXOVL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261497AbUJXOVL (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 24 Oct 2004 10:21:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261495AbUJXOVL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 24 Oct 2004 10:21:11 -0400
Received: from mail-relay-4.tiscali.it ([213.205.33.44]:34521 "EHLO
	mail-relay-4.tiscali.it") by vger.kernel.org with ESMTP
	id S261497AbUJXOVB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 24 Oct 2004 10:21:01 -0400
From: Lorenzo Allegrucci <l_allegrucci@yahoo.it>
Organization: -ENOENT
To: Jens Axboe <axboe@suse.de>
Subject: Re: 2.6.9-mm1 oops
Date: Sun, 24 Oct 2004 16:20:50 +0200
User-Agent: KMail/1.7
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
References: <200410231731.21778.l_allegrucci@yahoo.it> <20041024123016.GA31870@suse.de>
In-Reply-To: <20041024123016.GA31870@suse.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200410241620.50438.l_allegrucci@yahoo.it>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 24 October 2004 14:30, Jens Axboe wrote:
> On Sat, Oct 23 2004, Lorenzo Allegrucci wrote:
> > 
> > 100% reproducible with elevator=cfq
> 
> but not with the other io schedulers?

No, now I can reproduce it with the anticipatory scheduler too.

> > Unable to handle kernel NULL pointer dereference at virtual address 00000000
> >  printing eip:
> > c013f2c7
> > *pde = 00000000
> > Oops: 0000 [#1]
> > PREEMPT 
> > Modules linked in: ipv6 dm_mod emu10k1 sound soundcore ac97_codec unix
> > CPU:    0
> > EIP:    0060:[put_page+7/144]    Not tainted VLI
> > EFLAGS: 00010282   (2.6.9-mm1) 
> > EIP is at put_page+0x7/0x90
> > eax: 00000000   ebx: df047400   ecx: 00000000   edx: 00000000
> > esi: 00000000   edi: 00000000   ebp: df047400   esp: cadd0c80
> > ds: 007b   es: 007b   ss: 0068
> > Process diotest4 (pid: 4498, threadinfo=cadd0000 task=de712a40)
> > Stack: df047400 c0178d50 00000000 00000000 c0179c91 df047400 00000001 c01b391b 
> >        c86b6b00 cb0c9b80 cadd0d1c cb0c9c38 c019d31e cee0b0b0 00000000 00000000 
> >        00003000 00000000 df047400 00000000 08051000 0000000c c017a182 00000001 
> > Call Trace:
> >  [dio_cleanup+48/64] dio_cleanup+0x30/0x40
> >  [direct_io_worker+817/1568] direct_io_worker+0x331/0x620
> >  [journal_put_journal_head+59/192] journal_put_journal_head+0x3b/0xc0
> >  [ext3_do_update_inode+366/944] ext3_do_update_inode+0x16e/0x3b0
> >  [__blockdev_direct_IO+514/752] __blockdev_direct_IO+0x202/0x2f0
> >  [ext3_direct_io_get_blocks+0/240] ext3_direct_io_get_blocks+0x0/0xf0
> >  [ext3_direct_IO+201/576] ext3_direct_IO+0xc9/0x240
> >  [ext3_direct_io_get_blocks+0/240] ext3_direct_io_get_blocks+0x0/0xf0
> >  [generic_file_direct_IO+121/160] generic_file_direct_IO+0x79/0xa0
> >  [generic_file_direct_write+134/416] generic_file_direct_write+0x86/0x1a0
> >  [generic_file_aio_write_nolock+689/1200] generic_file_aio_write_nolock+0x2b1/0x4b0
> >  [generic_file_aio_write+131/256] generic_file_aio_write+0x83/0x100
> >  [ext3_file_write+68/224] ext3_file_write+0x44/0xe0
> >  [do_sync_write+190/240] do_sync_write+0xbe/0xf0
> >  [autoremove_wake_function+0/96] autoremove_wake_function+0x0/0x60
> >  [dnotify_parent+162/224] dnotify_parent+0xa2/0xe0
> >  [do_sync_write+0/240] do_sync_write+0x0/0xf0
> >  [vfs_write+184/304] vfs_write+0xb8/0x130
> >  [sys_write+81/128] sys_write+0x51/0x80
> >  [syscall_call+7/11] syscall_call+0x7/0xb
> 
> Please provide a test case, or at least a description of the problem.

I can 100% reproduce it running "runalltests.sh -x 100" of
ltp-full-20040804.
The test cases seem to be diotest1 and diotest4 because they always
appear in the oops, but I couldn't reproduce it running diotest1 and
diotest4 alone.

-- 
I route therefore you are
