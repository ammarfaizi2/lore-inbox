Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263038AbVD2WgI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263038AbVD2WgI (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Apr 2005 18:36:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263039AbVD2WgI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Apr 2005 18:36:08 -0400
Received: from mailfe04.swip.net ([212.247.154.97]:45206 "EHLO swip.net")
	by vger.kernel.org with ESMTP id S263038AbVD2Wfn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Apr 2005 18:35:43 -0400
X-T2-Posting-ID: jLUmkBjoqvly7NM6d2gdCg==
Subject: reiserfs on top of md/lvm problems
From: Alexander Nyberg <alexn@telia.com>
To: reiserfs-dev@namesys.com
Cc: linux-kernel@vger.kernel.org
Content-Type: text/plain
Date: Sat, 30 Apr 2005 00:35:38 +0200
Message-Id: <1114814138.991.10.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I was about to set up a test environment but didn't get very 
far. This is in relation to the thread:
"ftp server crashes on heavy load: possible scheduler bug".
This happens with both 4KSTACKS and without. 

Setup is 5 IDE disks in raid5 on /dev/md0
lvcreate /dev/md0
vgcreate vg00 /dev/md0
lvcreate -L 20G -n slap1 vg00
lvcreate -L 20G -n slap2 vg00

And after that I get the report below.
btw, ext3 survives this fine so there appears to be nothing wrong with the setup.
Does reiserfs have bad interaction with md/lvm?


slapme:~# mkfs.reiserfs /dev/vg00/slap1
All data on /dev/vg00/slap1 will be lost. Do you really want to create reiser filesystem (v3.6) (y/n) y
Creating reiser filesystem (v3.6) with standard journal on /dev/vg00/slap1
initializing skiped area: done
initializing journal: done
syncing...done
slapme:~# mkfs.reiserfs /dev/vg00/slap2
All data on /dev/vg00/slap2 will be lost. Do you really want to create reiser filesystem (v3.6) (y/n) y
Creating reiser filesystem (v3.6) with standard journal on /dev/vg00/slap2
initializing skiped area: done
initializing journal: done
syncing...done
slapme:~# cd /mnt/
slapme:/mnt# ll
total 36260
drwxr-xr-x  2 alex root     4096 Mar 12 19:58 boot
-rw-r--r--  1 alex alex 37075679 Apr 30 01:30 linux-2.6.11.tar.bz2
drwxr-xr-x  2 root root     4096 Apr 30 01:25 slap1
drwxr-xr-x  2 root root     4096 Apr 30 01:25 slap2
slapme:/mnt# mount /dev/vg00/slap1 slap1
ReiserFS: dm-0: found reiserfs format "3.6" with standard journal
ReiserFS: dm-0: using ordered data mode
ReiserFS: dm-0: journal params: device dm-0, size 8192, journal first block 18, max trans len 1024, max ba0ReiserFS: dm-0: checking transaction log (dm-0)
ReiserFS: dm-0: Using r5 hash to sort names
slapme:/mnt# mount /dev/vg00/slap2 slap2
ReiserFS: dm-1: found reiserfs format "3.6" with standard journal
ReiserFS: dm-1: using ordered data mode
ReiserFS: dm-1: journal params: device dm-1, size 8192, journal first block 18, max trans len 1024, max ba0ReiserFS: dm-1: checking transaction log (dm-1)
cd slapReiserFS: dm-1: Using r5 hash to sort names
slapme:/mnt# cd slap1
slapme:/mnt/slap1# ll
total 0
slapme:/mnt/slap1# tar -jxf ../linux-2.6.11.tar.bz2
ReiserFS: warning: is_leaf: item location seems wrong (second one): *3.6* [2 2397 0x0 SD], item_len 47, it5ReiserFS: dm-0: warning: vs-5150: search_by_key: invalid format found in block 1605632. Fsck?
ReiserFS: warning: is_leaf: item location seems wrong (second one): *3.6* [2 2397 0x0 SD], item_len 46, it5ReiserFS: dm-0: warning: vs-5150: search_by_key: invalid format found in block 1605632. Fsck?
ReiserFS: dm-0: warning: vs-13050: reiserfs_update_sd: i/o failure occurred trying to update [2304 2452 0xatar: linux-2.6.11/drivers/usb/input/wReiserFS: dm-0: warning: vs-4080: reiserfs_free_block: free_block (dmdacom.c: Cannot write: Input/output error
tar: SReiserFS: warning: is_tree_node: node level 3 does not match to the expected one 1
kipping to next ReiserFS: dm-0: warning: vs-5150: search_by_key: invalid format found in block 1605632. Fs?header
tar: ArcReiserFS: dm-0: warning: vs-13050: reiserfs_update_sd: i/o failure occurred trying to update [2304ahive contains obReiserFS: warning: is_tree_node: node level 3 does not match to the expected one 1
solescent base-6ReiserFS: dm-0: warning: vs-5150: search_by_key: invalid format found in block 1605632. Fs?4 headers
Unable to handle kernel NULL pointer dereference at virtual address 0000001c
 printing eip:
c01ac351
*pde = 00000000
Oops: 0000 [#1]
PREEMPT
CPU:    0
EIP:    0060:[<c01ac351>]    Not tainted VLI
EFLAGS: 00010286   (2.6.12-rc3)
EIP is at prepare_for_delete_or_cut+0x31/0x700
eax: 00000000   ebx: ddc4fe88   ecx: ddc4fe04   edx: 00000000
esi: 00000000   edi: 00000000   ebp: ddc4fb94   esp: ddc4fb24
ds: 007b   es: 007b   ss: 0068
Process tar (pid: 465, threadinfo=ddc4e000 task=df9e0040)
Stack: 00000000 d5d4abdc d5e1e000 00000ab0 0000ffff d5d4ab90 00000ab0 00001000
       c1a54e00 00000900 00000998 00001000 20000000 00000001 c1a54e00 00000000
       00000000 00000900 00000998 00000001 20000000 0ab0ffff 000105e8 d5d4abdc
Call Trace:
 [<c01040cf>] show_stack+0x7f/0xa0
 [<c0104265>] show_registers+0x155/0x1c0
 [<c0104460>] die+0xf0/0x190
 [<c011608b>] do_page_fault+0x31b/0x670
 [<c0103ccf>] error_code+0x4f/0x54
 [<c01ad9d5>] reiserfs_cut_from_item+0xd5/0x5c0
 [<c01ae228>] reiserfs_do_truncate+0x2c8/0x5d0
 [<c0199254>] reiserfs_truncate_file+0xe4/0x270
 [<c019ad10>] reiserfs_file_release+0x250/0x470
 [<c01580d2>] __fput+0xc2/0xe0
 [<c01568f8>] filp_close+0x48/0x70
 [<c0156992>] sys_close+0x72/0xb0
 [<c0103249>] syscall_call+0x7/0xb


