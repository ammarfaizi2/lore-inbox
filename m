Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261274AbUJXUEB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261274AbUJXUEB (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 24 Oct 2004 16:04:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261594AbUJXUEB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 24 Oct 2004 16:04:01 -0400
Received: from mail-relay-2.tiscali.it ([213.205.33.42]:37096 "EHLO
	mail-relay-2.tiscali.it") by vger.kernel.org with ESMTP
	id S261274AbUJXUCk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 24 Oct 2004 16:02:40 -0400
From: Lorenzo Allegrucci <l_allegrucci@yahoo.it>
Organization: -ENOENT
To: Jens Axboe <axboe@suse.de>
Subject: Re: 2.6.9-mm1 oops
Date: Sun, 24 Oct 2004 22:02:17 +0200
User-Agent: KMail/1.7
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
References: <200410231731.21778.l_allegrucci@yahoo.it> <20041024123016.GA31870@suse.de> <200410241620.50438.l_allegrucci@yahoo.it>
In-Reply-To: <200410241620.50438.l_allegrucci@yahoo.it>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200410242202.17981.l_allegrucci@yahoo.it>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 24 October 2004 16:20, Lorenzo Allegrucci wrote:
> On Sunday 24 October 2004 14:30, Jens Axboe wrote:
> > On Sat, Oct 23 2004, Lorenzo Allegrucci wrote:
> > > 
> > > 100% reproducible with elevator=cfq
> > 
> > but not with the other io schedulers?
> 
> No, now I can reproduce it with the anticipatory scheduler too.

I've just got the same oops using XFS instead of ext3.

Unable to handle kernel NULL pointer dereference at virtual address 0000007a
 printing eip:
c013f2c7
*pde = 00000000
Oops: 0000 [#1]
PREEMPT 
Modules linked in: xfs ipv6 dm_mod emu10k1 sound soundcore ac97_codec unix
CPU:    0
EIP:    0060:[put_page+7/144]    Not tainted VLI
EFLAGS: 00010296   (2.6.9-mm1) 
EIP is at put_page+0x7/0x90
eax: 0000007a   ebx: de3f3400   ecx: 00000000   edx: 0000007a
esi: 00000000   edi: 00000000   ebp: de3f3400   esp: dd93ac5c
ds: 007b   es: 007b   ss: 0068
Process diotest1 (pid: 4795, threadinfo=dd93a000 task=dd923a00)
Stack: de3f3400 c0178d50 0000007a 00000000 c0179c91 de3f3400 00000001 d59075ec 
       00000001 00000008 e0a96eb5 d8e63610 d8e636dc 00000000 00000000 00000000 
       00000000 00000000 de3f3400 00000000 08050000 0000000c c017a182 00000001 
Call Trace:
 [dio_cleanup+48/64] dio_cleanup+0x30/0x40
 [direct_io_worker+817/1568] direct_io_worker+0x331/0x620
 [pg0+543870645/1069630464] xfs_ilock_map_shared+0x25/0x40 [xfs]
 [__blockdev_direct_IO+514/752] __blockdev_direct_IO+0x202/0x2f0
 [pg0+544038528/1069630464] linvfs_get_blocks_direct+0x0/0x50 [xfs]
 [pg0+544032512/1069630464] linvfs_unwritten_convert_direct+0x0/0x70 [xfs]
 [pg0+544038830/1069630464] linvfs_direct_IO+0xde/0xe0 [xfs]
 [pg0+544038528/1069630464] linvfs_get_blocks_direct+0x0/0x50 [xfs]
 [pg0+544032512/1069630464] linvfs_unwritten_convert_direct+0x0/0x70 [xfs]
 [generic_file_direct_IO+121/160] generic_file_direct_IO+0x79/0xa0
 [generic_file_direct_write+134/416] generic_file_direct_write+0x86/0x1a0
 [pg0+544067824/1069630464] xfs_write+0x3b0/0xc00 [xfs]
 [pg0+544049612/1069630464] linvfs_write+0x8c/0xa0 [xfs]
 [do_sync_write+190/240] do_sync_write+0xbe/0xf0
 [autoremove_wake_function+0/96] autoremove_wake_function+0x0/0x60
 [do_sync_write+0/240] do_sync_write+0x0/0xf0
 [vfs_write+184/304] vfs_write+0xb8/0x130
 [sys_write+81/128] sys_write+0x51/0x80
 [syscall_call+7/11] syscall_call+0x7/0xb
Code: 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 83 ec 04 8b 54 24 08 <8b> 02 a9 00 80 00 00 75 44 8b 02 f6 c4 08 75 1f 8b 02 89 d1 a9 
 <1>Unable to handle kernel paging request at virtual address 5a3f30b0
 printing eip:
c0178939
*pde = 00000000
Oops: 0000 [#2]
PREEMPT 
Modules linked in: xfs ipv6 dm_mod emu10k1 sound soundcore ac97_codec unix
CPU:    0
EIP:    0060:[dio_get_page+25/96]    Not tainted VLI
EFLAGS: 00010a02   (2.6.9-mm1) 
EIP is at dio_get_page+0x19/0x60
eax: 5f000000   ebx: de3f3000   ecx: 00000000   edx: 00000000
esi: 00000000   edi: 00000000   ebp: de3f3000   esp: dc930c58
ds: 007b   es: 007b   ss: 0068
Process diotest4 (pid: 4947, threadinfo=dc930000 task=dcde9aa0)
Stack: 0000000e de3f3000 c0178d48 de3f3000 00000000 c0179c91 de3f3000 00000001 
       0000000e 0000003f 00000008 e0a96eb5 d14b65d0 d14b669c 00000000 00000000 
       00000000 0000f000 00000000 de3f3000 00000000 08051000 0000000c c017a182 
Call Trace:
 [dio_cleanup+40/64] dio_cleanup+0x28/0x40
 [direct_io_worker+817/1568] direct_io_worker+0x331/0x620
 [pg0+543870645/1069630464] xfs_ilock_map_shared+0x25/0x40 [xfs]
 [__blockdev_direct_IO+514/752] __blockdev_direct_IO+0x202/0x2f0
 [pg0+544038528/1069630464] linvfs_get_blocks_direct+0x0/0x50 [xfs]
 [pg0+544032512/1069630464] linvfs_unwritten_convert_direct+0x0/0x70 [xfs]
 [pg0+544038830/1069630464] linvfs_direct_IO+0xde/0xe0 [xfs]
 [pg0+544038528/1069630464] linvfs_get_blocks_direct+0x0/0x50 [xfs]
 [pg0+544032512/1069630464] linvfs_unwritten_convert_direct+0x0/0x70 [xfs]
 [filemap_fdatawait+115/128] filemap_fdatawait+0x73/0x80
 [generic_file_direct_IO+121/160] generic_file_direct_IO+0x79/0xa0
 [generic_file_direct_write+134/416] generic_file_direct_write+0x86/0x1a0
 [pg0+544067824/1069630464] xfs_write+0x3b0/0xc00 [xfs]
 [pg0+544049612/1069630464] linvfs_write+0x8c/0xa0 [xfs]
 [do_sync_write+190/240] do_sync_write+0xbe/0xf0
 [autoremove_wake_function+0/96] autoremove_wake_function+0x0/0x60
 [dnotify_parent+162/224] dnotify_parent+0xa2/0xe0
 [do_sync_write+0/240] do_sync_write+0x0/0xf0
 [vfs_write+184/304] vfs_write+0xb8/0x130
 [sys_write+81/128] sys_write+0x51/0x80
 [syscall_call+7/11] syscall_call+0x7/0xb
Code: 00 89 87 b0 00 00 00 eb a5 89 f6 8d bc 27 00 00 00 00 83 ec 08 89 5c 24 04 8b 5c 24 0c 8b 83 b0 01 00 00 39 83 b4 01 00 00 74 18 <8b> 94 83 b0 00 00 00 40 89 83 b0 01 00 00 89 d0 8b 5c 24 04 83 

-- 
I route therefore you are
