Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269023AbUIMWpw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269023AbUIMWpw (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Sep 2004 18:45:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269008AbUIMWpv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Sep 2004 18:45:51 -0400
Received: from post.pl ([212.85.96.51]:60176 "HELO v00051.home.net.pl")
	by vger.kernel.org with SMTP id S269032AbUIMWmR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Sep 2004 18:42:17 -0400
Message-ID: <414622C9.1030701@post.pl>
Date: Tue, 14 Sep 2004 00:44:25 +0200
From: Marcin Garski <mgarski@post.pl>
Reply-To: mgarski@post.pl
User-Agent: Mozilla Thunderbird 0.7.2 (Linux)
X-Accept-Language: pl, en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Copying huge amount of data on ReiserFS, XFS and Silicon Image 3112
 cause oops.
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[Please CC me on replies, I am not subscribed to the list, thanks]

Hello,

I bought a new HDD Maxtor 6Y160M0 and connected it as hdg to Sil 3112 
(CONFIG_BLK_DEV_SIIMAGE) on Abit NF7-S V2.0. I also have ST380013AS 
(with Fedora Core 2 on hde2 and 2.6.5 kernel) as hde.

On all disks i've used XFS.

When i start to copy a huge amount of data (mainly from hde2 to hdg2), 
after some time i got this messages in dmesg:

------------------------------------------
Filesystem "hde2": corrupt dinode 100940291, extent total = 1094480095,
nblocks = 1.  Unmount and run xfs_repair.
0x0: 49 4e 81 a4 01 02 00 01 00 00 00 00 00 00 00 00
Filesystem "hde2": XFS internal error xfs_iformat(1) at line 475 of file
fs/xfs/xfs_inode.c.  Caller 0xc020504d
Call Trace:
    [<c0203b01>] xfs_iformat+0x2f1/0x610
    [<c020504d>] xfs_iread+0x21d/0x270
    [<c020504d>] xfs_iread+0x21d/0x270
    [<c020504d>] xfs_iread+0x21d/0x270
    [<c02023d6>] xfs_iget_core+0xb6/0x4c0
    [<c02028f9>] xfs_iget+0x119/0x150
    [<c021eae4>] xfs_dir_lookup_int+0xb4/0x130
    [<c0224320>] xfs_lookup+0x50/0x90
    [<c0230247>] linvfs_lookup+0x67/0xa0
    [<c014e1fb>] real_lookup+0xcb/0xf0
    [<c014e466>] do_lookup+0x96/0xb0
    [<c014e89c>] link_path_walk+0x41c/0x800
    [<c014ee99>] path_lookup+0x69/0x110
    [<c014f109>] __user_walk+0x49/0x60
    [<c0140fd7>] sys_access+0x87/0x150
    [<c0139184>] sys_munmap+0x44/0x70
    [<c0103c39>] sysenter_past_esp+0x52/0x71

Filesystem "hde2": corrupt dinode 100940291, extent total = 1094480095,
nblocks = 1.  Unmount and run xfs_repair.
0x0: 49 4e 81 a4 01 02 00 01 00 00 00 00 00 00 00 00
Filesystem "hde2": XFS internal error xfs_iformat(1) at line 475 of file
fs/xfs/xfs_inode.c.  Caller 0xc020504d
Call Trace:
    [<c0203b01>] xfs_iformat+0x2f1/0x610
    [<c020504d>] xfs_iread+0x21d/0x270
    [<c020504d>] xfs_iread+0x21d/0x270
    [<c020504d>] xfs_iread+0x21d/0x270
    [<c02023d6>] xfs_iget_core+0xb6/0x4c0
    [<c02028f9>] xfs_iget+0x119/0x150
    [<c021eae4>] xfs_dir_lookup_int+0xb4/0x130
    [<c0224320>] xfs_lookup+0x50/0x90
    [<c0230247>] linvfs_lookup+0x67/0xa0
    [<c014e1fb>] real_lookup+0xcb/0xf0
    [<c014e466>] do_lookup+0x96/0xb0
    [<c014e89c>] link_path_walk+0x41c/0x800
    [<c014ee99>] path_lookup+0x69/0x110
    [<c014f109>] __user_walk+0x49/0x60
    [<c0140fd7>] sys_access+0x87/0x150
    [<c0139184>] sys_munmap+0x44/0x70
    [<c0103c39>] sysenter_past_esp+0x52/0x71
------------------------------------------

Then some files from /tmp disappeard, and i can't do anything because of 
I/O errors. So i've do reset and run LinuxRescueCD, and xfs_repair -n 
/dev/hde2 (-n because first i want to know whats happen with my 
filesystem). I've cut some of xfs_repair output to be more readable.

---------------xfs_repair--------------
Phase 1 - find and verify superblock...
Phase 2 - using internal log
           - scan filesystem freespace and inode maps...
ir_freecount/free mismatch, inode chunk 2/817984, freecount 7 nfree 15
badly aligned inode rec (starting inode = 67108871)
bad starting inode # (67108871 (0x2 0x7)) in ino rec, skipping rec
ir_freecount/free mismatch, inode chunk 10/439648, freecount 0 nfree 6
badly aligned inode rec (starting inode = 335544320)
bad starting inode # (335544320 (0xa 0x0)) in ino rec, skipping rec
           - found root inode chunk
Phase 3 - for each AG...
           - scan (but don't clear) agi unlinked lists...
found inodes not in the inode allocation tree
           - process known inodes and perform inode discovery...
           - agno = 0
           - agno = 1
           - agno = 2
imap claims in-use inode 67926854 is free, would correct imap
***[CUT]***
imap claims a free inode 67926878 is in use, would correct imap and
clear inode
           - agno = 3
bad attr fork offset 130 in inode 100940291, should be 15
would have cleared inode 100940291
           - agno = 4
           - agno = 5
           - agno = 6
found illegal null character in symlink inode 201807591
problem with symbolic link in inode 201807591
would have cleared inode 201807591
           - agno = 7
           - agno = 8
bmap rec out of order, inode 270703707 entry 141 [o s c] [20
171339130359809 59904], 140 [2147 21009514 3]
bad data fork in inode 270703707
would have cleared inode 270703707
           - agno = 9
inode 302305035 - bad extent starting block number 2251801961168901,
offset 16470
bad data fork in inode 302305035
would have cleared inode 302305035
           - agno = 10
imap claims in-use inode 335983977 is free, would correct imap
***[CUT]***
           - agno = 11
           - agno = 12
           - agno = 13
           - agno = 14
           - agno = 15
           - process newly discovered inodes...
Phase 4 - check for duplicate blocks...
           - setting up duplicate extent list...
           - check for inodes claiming duplicate blocks...
           - agno = 0
entry "gkb" in shortform directory 414538 references non-existent inode
335998936
would have junked entry "gkb" in directory inode 414538
           - agno = 1
entry "wireless-applet" at block 0 offset 3552 in directory inode
33554562 references non-existent inode 336014381
           would clear inode number in entry at offset 3552...
***[CUT]***
           - agno = 2
entry "digikam.mo" at block 1 offset 1464 in directory inode 67109275
references non-existent inode 67926984
           would clear inode number in entry at offset 1464...
***[CUT]***
entry "200402171505.jpg" at block 0 offset 2224 in directory inode
67188966 references non-existent inode 67927000
           would clear inode number in entry at offset 2224...
***[CUT]***
non-existent inode 67926982
           - agno = 3
entry "next.png" at block 1 offset 1064 in directory inode 100939445
references free inode 100940291
           would clear inode number in entry at offset 1064...
bad attr fork offset 130 in inode 100940291, should be 15
would have cleared inode 100940291
entry "it" in shortform directory 100982740 references non-existent
inode 336014420
would have junked entry "it" in directory inode 100982740
           - agno = 4
entry "FLAC++" at block 1 offset 1360 in directory inode 134217861
references non-existent inode 67926976
           would clear inode number in entry at offset 1360...
entry
***[CUT]***
           - agno = 5
entry "es" in shortform directory 168555826 references non-existent
inode 336011080
would have junked entry "es" in directory inode 168555826
***[CUT]***
           - agno = 6
entry "authmysql.7.gz" at block 0 offset 416 in directory inode
201807586 references free inode 201807591
           would clear inode number in entry at offset 416...
found illegal null character in symlink inode 201807591
problem with symbolic link in inode 201807591
would have cleared inode 201807591
           - agno = 7
           - agno = 8
entry "ui" in shortform directory 270353966 references non-existent
inode 335998891
would have junked entry "ui" in directory inode 270353966
entry "1.3.part" at block 0 offset 216 in directory inode 270700305
references free inode 270703707
           would clear inode number in entry at offset 216...
bmap rec out of order, inode 270703707 entry 141 [o s c] [20
171339130359809 59904], 140 [2147 21009514 3]
bad data fork in inode 270703707
would have cleared inode 270703707
           - agno = 9
entry "vfs" at block 1 offset 1128 in directory inode 301990016
references non-existent inode 335998902
           would clear inode number in entry at offset 1128...
entry "crop" at block 0 offset 104 in directory inode 302290754
references non-existent inode 335998889
           would clear inode number in entry at offset 104...
entry "figures" in shortform directory 302290773 references non-existent
inode 336011037
would have junked entry "figures" in directory inode 302290773
[CUT]
bad data fork in inode 302305035
would have cleared inode 302305035
           - agno = 10
entry "gnome-media-2.0.mo" at block 0 offset 2784 in directory inode
335544765 references non-existent inode 336014428
           would clear inode number in entry at offset 2784...
***[CUT]***
	- agno = 11
entry ".." at block 0 offset 32 in directory inode 369753744 references
non-existent inode 336011080
           would clear inode number in entry at offset 32...
***[CUT]***
--
           - agno = 12
entry "fdomain" at block 0 offset 192 in directory inode 402880938
references non-existent inode 67927022
           would clear inode number in entry at offset 192...
           - agno = 13
entry "ko" in shortform directory 436462447 references non-existent
inode 336011114
would have junked entry "ko" in directory inode 436462447
entry "ommincho" in shortform directory 440571678 references
non-existent inode 67927032
would have junked entry "ommincho" in directory inode 440571678
           - agno = 14
entry "module.h" in shortform directory 469849797 references
non-existent inode 67927013
would have junked entry "module.h" in directory inode 469849797
***[CUT]***
No modify flag set, skipping phase 5
Inode allocation btrees are too corrupted, skipping phases 6 and 7
No modify flag set, skipping filesystem flush and exiting.
---------------xfs_repair---------------------------------

I thought, nice mess, i don't want to touch it.
I've swap disks (hde - Maxtor, hdg - Seagate).
After a while i have newly installed FC2 on my new Maxtor hde1 (but now 
on ReiserFS instead XFS, but hde2 are still XFS).
Then i've done mount -o ro on corrupted Seagate and backup some data 
from Seagate to Maxtor. During this (i've used Midnight Commander), 
suddenly mc hangup (as zombie) and i've got this in dmesg:

---------------------mc------------------------
mc: page allocation failure. order:4, mode:0xd0
   [<c012f358>] __alloc_pages+0x2d8/0x350
   [<c012f3ef>] __get_free_pages+0x1f/0x40
   [<c01324fd>] kmem_getpages+0x1d/0xb0
   [<c0133016>] cache_grow+0x96/0x130
   [<c01331ee>] cache_alloc_refill+0x13e/0x200
   [<c0133660>] __kmalloc+0x70/0x80
   [<c0277159>] kmem_alloc+0x59/0xc0
   [<c0253c4f>] xfs_iread_extents+0x4f/0x110
   [<c018ea01>] leaf_paste_in_buffer+0x1b1/0x320
   [<c022c23e>] xfs_bmapi+0x20e/0x1430
   [<c0176df8>] balance_leaf+0xc98/0x2fb0
   [<c0196fcf>] get_cnode+0x1f/0xa0
   [<c019b191>] journal_mark_dirty+0x131/0x2b0
   [<c0196fcf>] get_cnode+0x1f/0xa0
   [<c0196fcf>] get_cnode+0x1f/0xa0
   [<c018f3b3>] leaf_paste_entries+0x133/0x240
   [<c0176d0a>] balance_leaf+0xbaa/0x2fb0
   [<c018663c>] ip_check_balance+0x29c/0xb50
   [<c018663c>] ip_check_balance+0x29c/0xb50
   [<c0257b86>] xfs_iomap+0x1a6/0x530
   [<c0278727>] linvfs_get_block_core+0xa7/0x280
   [<c0147605>] __find_get_block+0x45/0xb0
   [<c019137d>] is_tree_node+0x6d/0x70
   [<c0191b9f>] search_by_key+0x78f/0x10d0
   [<c027893f>] linvfs_get_block+0x3f/0x50
   [<c0162e4e>] do_mpage_readpage+0x34e/0x360
   [<c028c9df>] radix_tree_node_alloc+0x1f/0x60
   [<c028cc62>] radix_tree_insert+0xe2/0x100
   [<c012b002>] add_to_page_cache+0x52/0x70
   [<c0162f94>] mpage_readpages+0x134/0x160
   [<c0278900>] linvfs_get_block+0x0/0x50
   [<c0131cc4>] read_pages+0x134/0x140
   [<c0278900>] linvfs_get_block+0x0/0x50
   [<c012f36a>] __alloc_pages+0x2ea/0x350
   [<c0131f1f>] do_page_cache_readahead+0xcf/0x130
   [<c0132083>] page_cache_readahead+0x103/0x1f0
   [<c012b7bc>] do_generic_mapping_read+0xdc/0x470
   [<c012bdee>] __generic_file_aio_read+0x1be/0x1f0
   [<c012bb50>] file_read_actor+0x0/0xe0
   [<c027ec75>] xfs_read+0x155/0x270
   [<c02a364b>] pty_write_room+0x2b/0x30
   [<c027b08a>] linvfs_read+0x8a/0xa0
   [<c0144ba4>] do_sync_read+0x84/0xb0
   [<c011f020>] do_sigaction+0x150/0x1a0
   [<c0144c88>] vfs_read+0xb8/0x130
   [<c0144f31>] sys_read+0x51/0x80
   [<c0103e39>] sysenter_past_esp+0x52/0x71
---------------------mc------------------------

So i've changed FS on hde2 from XFS to ReiserFS (so now all FS on Maxtor 
are ReiserFS), and copy all data from Seagate to Maxtor. This time i got 
this:

--------------------------------------
attempt to access beyond end of device
hdg2: rw=0, want=791944122319592, limit=155091510
attempt to access beyond end of device
hdg2: rw=0, want=791944122319720, limit=155091510
attempt to access beyond end of device
hdg2: rw=0, want=791944122319848, limit=155091510
attempt to access beyond end of device
hdg2: rw=0, want=791944122319520, limit=155091510
--------------------------------------

When all my data was "secure", i've compiled new 2.6.8.1 kernel, but now 
with CONFIG_SCSI_SATA_SIL instead of previous CONFIG_BLK_DEV_SIIMAGE and 
changed FS on Seagate from XFS to ReiserFS (now all FS on Seagate are 
ReiserFS).

Then i want to copy some data, but now i don't remember exactly from 
which disk to which. And then got this in dmesg:

--------------------------------------
attempt to access beyond end of device
sdb1: rw=0, want=639959048, limit=156296322
attempt to access beyond end of device
sdb1: rw=0, want=639959048, limit=156296322
Buffer I/O error on device sdb1, logical block 79994880
attempt to access beyond end of device
sdb1: rw=0, want=639959048, limit=156296322
Buffer I/O error on device sdb1, logical block 79994880
attempt to access beyond end of device
sdb1: rw=0, want=1445199880, limit=156296322
attempt to access beyond end of device
sdb1: rw=0, want=1274085384, limit=156296322
attempt to access beyond end of device
sdb1: rw=0, want=1445199880, limit=156296322
Buffer I/O error on device sdb1, logical block 180649984
attempt to access beyond end of device
sdb1: rw=0, want=1445199880, limit=156296322
Buffer I/O error on device sdb1, logical block 180649984
ReiserFS: sdb1: found reiserfs format "3.6" with standard journal
ReiserFS: sdb1: using ordered data mode
ReiserFS: sdb1: journal params: device sdb1, size 8192, journal first
block 18,
max trans len 1024, max batch 900, max commit age 30, max trans age 30
ReiserFS: sdb1: checking transaction log (sdb1)
ReiserFS: sdb1: Using r5 hash to sort names
ReiserFS: sdb1: warning: vs-4075: reiserfs_free_block: block 79994880 is
out of
range on sdb1
ReiserFS: sdb1: warning: vs-4080: reiserfs_free_block: free_block
(sdb1:1418237)
[dev:blocknr]: bit already cleared
ReiserFS: sdb1: warning: vs-4080: reiserfs_free_block: free_block
(sdb1:1418236)
[dev:blocknr]: bit already cleared
ReiserFS: sdb1: warning: vs-4080: reiserfs_free_block: free_block
(sdb1:1418235)
[dev:blocknr]: bit already cleared
ReiserFS: sdb1: warning: vs-4080: reiserfs_free_block: free_block
(sdb1:1418234)
[dev:blocknr]: bit already cleared
ReiserFS: sdb1: warning: vs-4080: reiserfs_free_block: free_block
(sdb1:1418223)
[dev:blocknr]: bit already cleared
--------------------------------------

And then oops

------------------oops-----------------------
ksymoops 2.4.9 on i686 2.6.8.1.  Options used
        -V (default)
        -k /proc/ksyms (default)
        -l /proc/modules (default)
        -o /lib/modules/2.6.8.1/ (default)
        -m /usr/src/linux-2.6.8.1/System.map (specified)

Error (regular_file): read_ksyms stat /proc/ksyms failed
ksymoops: No such file or directory
No modules in ksyms, skipping objects
No ksyms, skipping lsmod
Unable to handle kernel paging request at virtual address 0015b613
c0196bfa
*pde = 0fb90067
Oops: 0000 [#1]
CPU:    0
EIP:    0060:[<c0196bfa>]    Not tainted
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00210206   (2.6.8.1)
eax: 0015b60f   ebx: 0000147a   ecx: dfcc8e00   edx: 0015b60f
esi: 00001000   edi: e0b0d0ec   ebp: 00000000   esp: d40f9b58
ds: 007b   es: 007b   ss: 0068
Stack: e0b0d10c e0b0d10c 0a3d1000 dfcc8e00 c019bafb dfcc8e00 0a3d1000
e0b0d0ec
          00000034 d40f9f10 0a3d1000 00000001 ca0c2d0c c01749c5 d40f9f10
dfcc8e00
          0a3d1000 00000000 d40f9f10 00000238 cd09971c d40f8000 c0192eaa
d40f9f10
Call Trace:
    [<c019bafb>] journal_mark_freed+0x9b/0x200
    [<c01749c5>] reiserfs_free_block+0x35/0x60
    [<c0192eaa>] prepare_for_delete_or_cut+0x58a/0x7a0
    [<c0193f1f>] reiserfs_cut_from_item+0xcf/0x5a0
    [<c014758a>] bh_lru_install+0x8a/0xc0
    [<c019470f>] reiserfs_do_truncate+0x28f/0x5b0
    [<c01939ad>] reiserfs_delete_object+0x3d/0x70
    [<c017c182>] reiserfs_delete_inode+0x82/0xc0
    [<c017c100>] reiserfs_delete_inode+0x0/0xc0
    [<c015c411>] generic_delete_inode+0x51/0xd0
    [<c0153680>] vfs_unlink+0xa0/0x190
    [<c015c615>] iput+0x55/0x70
    [<c015387e>] sys_unlink+0x10e/0x140
    [<c0103e39>] sysenter_past_esp+0x52/0x71
Code: 8b 40 04 0f ab 30 8b 7c 24 0c 8b 5c 24 04 8b 74 24 08 31 c0


   >>EIP; c0196bfa <set_bit_in_list_bitmap+3a/70>   <=====

   >>ecx; dfcc8e00 <pg0+1f79fe00/3fad5000>
   >>edi; e0b0d0ec <pg0+205e40ec/3fad5000>
   >>esp; d40f9b58 <pg0+13bd0b58/3fad5000>

Trace; c019bafb <journal_mark_freed+9b/200>
Trace; c01749c5 <reiserfs_free_block+35/60>
Trace; c0192eaa <prepare_for_delete_or_cut+58a/7a0>
Trace; c0193f1f <reiserfs_cut_from_item+cf/5a0>
Trace; c014758a <bh_lru_install+8a/c0>
Trace; c019470f <reiserfs_do_truncate+28f/5b0>
Trace; c01939ad <reiserfs_delete_object+3d/70>
Trace; c017c182 <reiserfs_delete_inode+82/c0>
Trace; c017c100 <reiserfs_delete_inode+0/c0>
Trace; c015c411 <generic_delete_inode+51/d0>
Trace; c0153680 <vfs_unlink+a0/190>
Trace; c015c615 <iput+55/70>
Trace; c015387e <sys_unlink+10e/140>
Trace; c0103e39 <sysenter_past_esp+52/71>

Code;  c0196bfa <set_bit_in_list_bitmap+3a/70>
00000000 <_EIP>:
Code;  c0196bfa <set_bit_in_list_bitmap+3a/70>   <=====
      0:   8b 40 04                  mov    0x4(%eax),%eax   <=====
Code;  c0196bfd <set_bit_in_list_bitmap+3d/70>
      3:   0f ab 30                  bts    %esi,(%eax)
Code;  c0196c00 <set_bit_in_list_bitmap+40/70>
      6:   8b 7c 24 0c               mov    0xc(%esp),%edi
Code;  c0196c04 <set_bit_in_list_bitmap+44/70>
      a:   8b 5c 24 04               mov    0x4(%esp),%ebx
Code;  c0196c08 <set_bit_in_list_bitmap+48/70>
      e:   8b 74 24 08               mov    0x8(%esp),%esi
Code;  c0196c0c <set_bit_in_list_bitmap+4c/70>
     12:   31 c0                     xor    %eax,%eax


1 error issued.  Results may not be reliable.
------------------oops-----------------------

MC hangup, i didn't have access to Seagate. But other things was working 
as usualy (i could browse in Internet, etc.)
I restart computer and one more time try to copy some data, and one more 
time.

--------------------------------------
attempt to access beyond end of device
sdb1: rw=0, want=639959048, limit=156296322
attempt to access beyond end of device
sdb1: rw=0, want=639959048, limit=156296322
Buffer I/O error on device sdb1, logical block 79994880
attempt to access beyond end of device
sdb1: rw=0, want=639959048, limit=156296322
Buffer I/O error on device sdb1, logical block 79994880
attempt to access beyond end of device
sdb1: rw=0, want=1445199880, limit=156296322
attempt to access beyond end of device
sdb1: rw=0, want=1274085384, limit=156296322
attempt to access beyond end of device
sdb1: rw=0, want=1445199880, limit=156296322
Buffer I/O error on device sdb1, logical block 180649984
attempt to access beyond end of device
sdb1: rw=0, want=1445199880, limit=156296322
Buffer I/O error on device sdb1, logical block 180649984
ReiserFS: sdb1: warning: vs-4075: reiserfs_free_block: block 79994880 is
out of range on sdb1
ReiserFS: sdb1: warning: vs-4080: reiserfs_free_block: free_block
(sdb1:1418237)[dev:blocknr]: bit already cleared
ReiserFS: sdb1: warning: vs-4080: reiserfs_free_block: free_block
(sdb1:1418236)[dev:blocknr]: bit already cleared
ReiserFS: sdb1: warning: vs-4080: reiserfs_free_block: free_block
(sdb1:1418235)[dev:blocknr]: bit already cleared
ReiserFS: sdb1: warning: vs-4080: reiserfs_free_block: free_block
(sdb1:1418234)[dev:blocknr]: bit already cleared
ReiserFS: sdb1: warning: vs-4080: reiserfs_free_block: free_block
(sdb1:1418223)[dev:blocknr]: bit already cleared
ReiserFS: sdb1: warning: vs-4075: reiserfs_free_block: block 171773952
is out of range on sdb1
ReiserFS: sdb1: warning: vs-4075: reiserfs_free_block: block 313507840
is out of range on sdb1
ReiserFS: sdb1: warning: vs-4080: reiserfs_free_block: free_block
(sdb1:1726698)[dev:blocknr]: bit already cleared
ReiserFS: sdb1: warning: vs-4080: reiserfs_free_block: free_block
(sdb1:1726697)[dev:blocknr]: bit already cleared
--------------------------------------

And oops

--------------oops---------------------------
ksymoops 2.4.9 on i686 2.6.8.1.  Options used
        -V (default)
        -k /proc/ksyms (default)
        -l /proc/modules (default)
        -o /lib/modules/2.6.8.1/ (default)
        -m /usr/src/linux-2.6.8.1/System.map (specified)

Error (regular_file): read_ksyms stat /proc/ksyms failed
ksymoops: No such file or directory
No modules in ksyms, skipping objects
No ksyms, skipping lsmod
Unable to handle kernel NULL pointer dereference at virtual address 00000c00
c0196bfd
*pde = 1888a067
Oops: 0002 [#1]
CPU:    0
EIP:    0060:[<c0196bfd>]    Not tainted
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00210286   (2.6.8.1)
eax: 00000000   ebx: 00001c19   ecx: dffc2c00   edx: e0aa5028
esi: 00006000   edi: e0a84104   ebp: 00000000   esp: c3039b58
ds: 007b   es: 007b   ss: 0068
Stack: e0a8410c e0a8410c 0e0ce000 dffc2c00 c019bafb dffc2c00 0e0ce000
e0a84104
          00000034 c3039f10 0e0ce000 00000001 cfe1684c c01749c5 c3039f10
dffc2c00
          0e0ce000 00000000 c3039f10 00000290 d276c5bc c3038000 c0192eaa
c3039f10
Call Trace:
    [<c019bafb>] journal_mark_freed+0x9b/0x200
    [<c01749c5>] reiserfs_free_block+0x35/0x60
    [<c0192eaa>] prepare_for_delete_or_cut+0x58a/0x7a0
    [<c0193f1f>] reiserfs_cut_from_item+0xcf/0x5a0
    [<c014758a>] bh_lru_install+0x8a/0xc0
    [<c019470f>] reiserfs_do_truncate+0x28f/0x5b0
    [<c028cf61>] radix_tree_gang_lookup+0x51/0x70
    [<c01939ad>] reiserfs_delete_object+0x3d/0x70
    [<c017c182>] reiserfs_delete_inode+0x82/0xc0
    [<c017c100>] reiserfs_delete_inode+0x0/0xc0
    [<c015c411>] generic_delete_inode+0x51/0xd0
    [<c015c615>] iput+0x55/0x70
    [<c015387e>] sys_unlink+0x10e/0x140
    [<c0103e39>] sysenter_past_esp+0x52/0x71
Code: 0f ab 30 8b 7c 24 0c 8b 5c 24 04 8b 74 24 08 31 c0 83 c4 10


   >>EIP; c0196bfd <set_bit_in_list_bitmap+3d/70>   <=====

   >>ecx; dffc2c00 <pg0+1fa99c00/3fad5000>
   >>edx; e0aa5028 <pg0+2057c028/3fad5000>
   >>edi; e0a84104 <pg0+2055b104/3fad5000>
   >>esp; c3039b58 <pg0+2b10b58/3fad5000>

Trace; c019bafb <journal_mark_freed+9b/200>
Trace; c01749c5 <reiserfs_free_block+35/60>
Trace; c0192eaa <prepare_for_delete_or_cut+58a/7a0>
Trace; c0193f1f <reiserfs_cut_from_item+cf/5a0>
Trace; c014758a <bh_lru_install+8a/c0>
Trace; c019470f <reiserfs_do_truncate+28f/5b0>
Trace; c028cf61 <radix_tree_gang_lookup+51/70>
Trace; c01939ad <reiserfs_delete_object+3d/70>
Trace; c017c182 <reiserfs_delete_inode+82/c0>
Trace; c017c100 <reiserfs_delete_inode+0/c0>
Trace; c015c411 <generic_delete_inode+51/d0>
Trace; c015c615 <iput+55/70>
Trace; c015387e <sys_unlink+10e/140>
Trace; c0103e39 <sysenter_past_esp+52/71>

Code;  c0196bfd <set_bit_in_list_bitmap+3d/70>
00000000 <_EIP>:
Code;  c0196bfd <set_bit_in_list_bitmap+3d/70>   <=====
      0:   0f ab 30                  bts    %esi,(%eax)   <=====
Code;  c0196c00 <set_bit_in_list_bitmap+40/70>
      3:   8b 7c 24 0c               mov    0xc(%esp),%edi
Code;  c0196c04 <set_bit_in_list_bitmap+44/70>
      7:   8b 5c 24 04               mov    0x4(%esp),%ebx
Code;  c0196c08 <set_bit_in_list_bitmap+48/70>
      b:   8b 74 24 08               mov    0x8(%esp),%esi
Code;  c0196c0c <set_bit_in_list_bitmap+4c/70>
      f:   31 c0                     xor    %eax,%eax
Code;  c0196c0e <set_bit_in_list_bitmap+4e/70>
     11:   83 c4 10                  add    $0x10,%esp


1 error issued.  Results may not be reliable.
--------------oops---------------------------

So i restart my computer and then during mount on startup:

-------------------boot------------------------------------------------
Sep 11 11:48:24 drosera kernel: ReiserFS: sdb1: using ordered data mode
Sep 11 11:48:24 drosera kernel: ReiserFS: sdb1: journal params: device
sdb1, size 8192, journal first block 18, max trans len 1024, max batch
900, max commit age 30, max trans age 30
Sep 11 11:48:24 drosera kernel: ReiserFS: sdb1: checking transaction log
(sdb1)
Sep 11 11:48:24 drosera kernel: ReiserFS: sdb1: Using r5 hash to sort names
-------------------boot------------------------------------------------

And oops

-------------Mount oops----------------------
ksymoops 2.4.9 on i686 2.6.8.1.  Options used
        -V (default)
        -k /proc/ksyms (default)
        -l /proc/modules (default)
        -o /lib/modules/2.6.8.1/ (default)
        -m /usr/src/linux-2.6.8.1/System.map (specified)

Error (regular_file): read_ksyms stat /proc/ksyms failed
ksymoops: No such file or directory
No modules in ksyms, skipping objects
No ksyms, skipping lsmod
Sep 11 11:48:24 drosera kernel: ReiserFS: sdb1: Removing [36994 36998
0x0 SD]..<1>Unable to handle kernel paging request at virtual address
e0a9b1e8
Sep 11 11:48:24 drosera kernel: c0196bf0
Sep 11 11:48:24 drosera kernel: *pde = 0158c067
Sep 11 11:48:24 drosera kernel: Oops: 0000 [#1]
Sep 11 11:48:24 drosera kernel: CPU:    0
Sep 11 11:48:24 drosera kernel: EIP:    0060:[<c0196bf0>]    Not tainted
Using defaults from ksymoops -t elf32-i386 -a i386
Sep 11 11:48:24 drosera kernel: EFLAGS: 00010212   (2.6.8.1)
Sep 11 11:48:24 drosera kernel: eax: e0a96000   ebx: 0000147a   ecx:
dffc2c00   edx: 00001000
Sep 11 11:48:24 drosera kernel: esi: 00001000   edi: e0a840e4   ebp:
00000000   esp: df5df928
Sep 11 11:48:24 drosera kernel: ds: 007b   es: 007b   ss: 0068
Sep 11 11:48:24 drosera kernel: Stack: e0a8410c e0a8410c 0a3d1000
dffc2c00 c019bafb dffc2c00 0a3d1000 e0a840e4
Sep 11 11:48:24 drosera kernel:        00000034 df5dfce0 0a3d1000
00000001 dd95e42c c01749c5 df5dfce0 dffc2c00
Sep 11 11:48:24 drosera kernel:        0a3d1000 00000000 df5dfce0
00000238 deeb871c df5de000 c0192eaa df5dfce0
Sep 11 11:48:24 drosera kernel: Call Trace:
Sep 11 11:48:24 drosera kernel:  [<c019bafb>] journal_mark_freed+0x9b/0x200
Sep 11 11:48:24 drosera kernel:  [<c01749c5>] reiserfs_free_block+0x35/0x60
Sep 11 11:48:24 drosera kernel:  [<c0192eaa>]
prepare_for_delete_or_cut+0x58a/0x7a0
Sep 11 11:48:24 drosera kernel:  [<c0193f1f>]
reiserfs_cut_from_item+0xcf/0x5a0
Sep 11 11:48:24 drosera kernel:  [<c014758a>] bh_lru_install+0x8a/0xc0
Sep 11 11:48:24 drosera kernel:  [<c019470f>]
reiserfs_do_truncate+0x28f/0x5b0
Sep 11 11:48:24 drosera kernel:  [<c01939ad>]
reiserfs_delete_object+0x3d/0x70
Sep 11 11:48:24 drosera kernel:  [<c017c182>]
reiserfs_delete_inode+0x82/0xc0
Sep 11 11:48:24 drosera kernel:  [<c01150e0>] printk+0x100/0x140
Sep 11 11:48:24 drosera kernel:  [<c017c100>] reiserfs_delete_inode+0x0/0xc0
Sep 11 11:48:24 drosera kernel:  [<c015c411>] generic_delete_inode+0x51/0xd0
Sep 11 11:48:24 drosera kernel:  [<c015c615>] iput+0x55/0x70
Sep 11 11:48:24 drosera kernel:  [<c0188887>] finish_unfinished+0x1e7/0x350
Sep 11 11:48:24 drosera kernel:  [<c019c788>] do_journal_end+0x7b8/0xb30
Sep 11 11:48:24 drosera kernel:  [<c019b3b0>] journal_end+0xa0/0xc0
Sep 11 11:48:24 drosera kernel:  [<c018aa57>]
reiserfs_fill_super+0x527/0x6d0
Sep 11 11:48:24 drosera kernel:  [<c017ec10>]
reiserfs_init_locked_inode+0x0/0x20
Sep 11 11:48:24 drosera kernel:  [<c01713e2>] disk_name+0x62/0xb0
Sep 11 11:48:24 drosera kernel:  [<c014ba5e>] sb_set_blocksize+0x2e/0x60
Sep 11 11:48:24 drosera kernel:  [<c014b47d>] get_sb_bdev+0x11d/0x150
Sep 11 11:48:24 drosera kernel:  [<c01513f0>] do_lookup+0x30/0xb0
Sep 11 11:48:24 drosera kernel:  [<c018ac6f>] get_super_block+0x2f/0x40
Sep 11 11:48:24 drosera kernel:  [<c018a530>] reiserfs_fill_super+0x0/0x6d0
Sep 11 11:48:24 drosera kernel:  [<c014b6c7>] do_kern_mount+0x57/0xe0
Sep 11 11:48:24 drosera kernel:  [<c015ec7c>] do_new_mount+0x9c/0xf0
Sep 11 11:48:24 drosera kernel:  [<c015f1e7>] do_mount+0x147/0x1a0
Warning (Oops_read): Code line not seen, dumping what data is available


   >>EIP; c0196bf0 <set_bit_in_list_bitmap+30/70>   <=====

   >>eax; e0a96000 <pg0+2056d000/3fad5000>
   >>ecx; dffc2c00 <pg0+1fa99c00/3fad5000>
   >>edi; e0a840e4 <pg0+2055b0e4/3fad5000>
   >>esp; df5df928 <pg0+1f0b6928/3fad5000>

Trace; c019bafb <journal_mark_freed+9b/200>
Trace; c01749c5 <reiserfs_free_block+35/60>
Trace; c0192eaa <prepare_for_delete_or_cut+58a/7a0>
Trace; c0193f1f <reiserfs_cut_from_item+cf/5a0>
Trace; c014758a <bh_lru_install+8a/c0>
Trace; c019470f <reiserfs_do_truncate+28f/5b0>
Trace; c01939ad <reiserfs_delete_object+3d/70>
Trace; c017c182 <reiserfs_delete_inode+82/c0>
Trace; c01150e0 <printk+100/140>
Trace; c017c100 <reiserfs_delete_inode+0/c0>
Trace; c015c411 <generic_delete_inode+51/d0>
Trace; c015c615 <iput+55/70>
Trace; c0188887 <finish_unfinished+1e7/350>
Trace; c019c788 <do_journal_end+7b8/b30>
Trace; c019b3b0 <journal_end+a0/c0>
Trace; c018aa57 <reiserfs_fill_super+527/6d0>
Trace; c017ec10 <reiserfs_init_locked_inode+0/20>
Trace; c01713e2 <disk_name+62/b0>
Trace; c014ba5e <sb_set_blocksize+2e/60>
Trace; c014b47d <get_sb_bdev+11d/150>
Trace; c01513f0 <do_lookup+30/b0>
Trace; c018ac6f <get_super_block+2f/40>
Trace; c018a530 <reiserfs_fill_super+0/6d0>
Trace; c014b6c7 <do_kern_mount+57/e0>
Trace; c015ec7c <do_new_mount+9c/f0>
Trace; c015f1e7 <do_mount+147/1a0>


1 warning and 1 error issued.  Results may not be reliable.
------------------Mount oops-------------------------------

Then system hungup.

 From LinuxRescueCD i've disabled mounting sdb1 on startup, boot my 
Fedora and done reiserfsck --rebuild-tree and try to mount Seagate (sdb1)

--------------mount after reiserfsck---------------------------------
ReiserFS: sdb1: found reiserfs format "3.6" with standard journal
ReiserFS: sdb1: using ordered data mode
ReiserFS: sdb1: journal params: device sdb1, size 8192, journal first
block 18, max trans len 1024, max batch 900, max commit age 30, max
trans age 30
ReiserFS: sdb1: checking transaction log (sdb1)
ReiserFS: sdb1: Using r5 hash to sort names
--------------mount after reiserfsck---------------------------------

And oops

------------opps during mount-------------
ksymoops 2.4.9 on i686 2.6.8.1.  Options used
        -V (default)
        -k /proc/ksyms (default)
        -l /proc/modules (default)
        -o /lib/modules/2.6.8.1/ (default)
        -m /usr/src/linux-2.6.8.1/System.map (specified)

Error (regular_file): read_ksyms stat /proc/ksyms failed
ksymoops: No such file or directory
No modules in ksyms, skipping objects
No ksyms, skipping lsmod
ReiserFS: sdb1: Removing [36994 36998 0x0 SD]..<1>Unable to handle
kernel paging request at virtual address 74622d75
c0196bfa
*pde = 00000000
Oops: 0000 [#1]
CPU:    0
EIP:    0060:[<c0196bfa>]    Not tainted
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00210206   (2.6.8.1)
eax: 74622d71   ebx: 0000147a   ecx: c1573e00   edx: 74622d71
esi: 00001000   edi: e0b0d0e4   ebp: 00000000   esp: c9e4b928
ds: 007b   es: 007b   ss: 0068
Stack: e0b0d10c e0b0d10c 0a3d1000 c1573e00 c019bafb c1573e00 0a3d1000
e0b0d0e4
          00000034 c9e4bce0 0a3d1000 00000001 c9935e2c c01749c5 c9e4bce0
c1573e00
          0a3d1000 00000000 c9e4bce0 00000238 c9fee71c c9e4a000 c0192eaa
c9e4bce0
Call Trace:
    [<c019bafb>] journal_mark_freed+0x9b/0x200
    [<c01749c5>] reiserfs_free_block+0x35/0x60
    [<c0192eaa>] prepare_for_delete_or_cut+0x58a/0x7a0
    [<c0193f1f>] reiserfs_cut_from_item+0xcf/0x5a0
    [<c014758a>] bh_lru_install+0x8a/0xc0
    [<c019470f>] reiserfs_do_truncate+0x28f/0x5b0
    [<c01939ad>] reiserfs_delete_object+0x3d/0x70
    [<c017c182>] reiserfs_delete_inode+0x82/0xc0
    [<c01150e0>] printk+0x100/0x140
    [<c017c100>] reiserfs_delete_inode+0x0/0xc0
    [<c015c411>] generic_delete_inode+0x51/0xd0
    [<c015c615>] iput+0x55/0x70
    [<c0188887>] finish_unfinished+0x1e7/0x350
    [<c019c788>] do_journal_end+0x7b8/0xb30
    [<c019b3b0>] journal_end+0xa0/0xc0
    [<c018aa57>] reiserfs_fill_super+0x527/0x6d0
    [<c017ec10>] reiserfs_init_locked_inode+0x0/0x20
    [<c01713e2>] disk_name+0x62/0xb0
    [<c014ba5e>] sb_set_blocksize+0x2e/0x60
    [<c014b47d>] get_sb_bdev+0x11d/0x150
    [<c018ac6f>] get_super_block+0x2f/0x40
    [<c018a530>] reiserfs_fill_super+0x0/0x6d0
    [<c014b6c7>] do_kern_mount+0x57/0xe0
    [<c015ec7c>] do_new_mount+0x9c/0xf0
    [<c015f1e7>] do_mount+0x147/0x1a0
    [<c015f043>] copy_mount_options+0x63/0xc0
    [<c015f5a0>] sys_mount+0xa0/0xf0
    [<c0103e39>] sysenter_past_esp+0x52/0x71
Code: 8b 40 04 0f ab 30 8b 7c 24 0c 8b 5c 24 04 8b 74 24 08 31 c0


   >>EIP; c0196bfa <set_bit_in_list_bitmap+3a/70>   <=====

   >>ecx; c1573e00 <pg0+104ae00/3fad5000>
   >>edi; e0b0d0e4 <pg0+205e40e4/3fad5000>
   >>esp; c9e4b928 <pg0+9922928/3fad5000>

Trace; c019bafb <journal_mark_freed+9b/200>
Trace; c01749c5 <reiserfs_free_block+35/60>
Trace; c0192eaa <prepare_for_delete_or_cut+58a/7a0>
Trace; c0193f1f <reiserfs_cut_from_item+cf/5a0>
Trace; c014758a <bh_lru_install+8a/c0>
Trace; c019470f <reiserfs_do_truncate+28f/5b0>
Trace; c01939ad <reiserfs_delete_object+3d/70>
Trace; c017c182 <reiserfs_delete_inode+82/c0>
Trace; c01150e0 <printk+100/140>
Trace; c017c100 <reiserfs_delete_inode+0/c0>
Trace; c015c411 <generic_delete_inode+51/d0>
Trace; c015c615 <iput+55/70>
Trace; c0188887 <finish_unfinished+1e7/350>
Trace; c019c788 <do_journal_end+7b8/b30>
Trace; c019b3b0 <journal_end+a0/c0>
Trace; c018aa57 <reiserfs_fill_super+527/6d0>
Trace; c017ec10 <reiserfs_init_locked_inode+0/20>
Trace; c01713e2 <disk_name+62/b0>
Trace; c014ba5e <sb_set_blocksize+2e/60>
Trace; c014b47d <get_sb_bdev+11d/150>
Trace; c018ac6f <get_super_block+2f/40>
Trace; c018a530 <reiserfs_fill_super+0/6d0>
Trace; c014b6c7 <do_kern_mount+57/e0>
Trace; c015ec7c <do_new_mount+9c/f0>
Trace; c015f1e7 <do_mount+147/1a0>
Trace; c015f043 <copy_mount_options+63/c0>
Trace; c015f5a0 <sys_mount+a0/f0>
Trace; c0103e39 <sysenter_past_esp+52/71>

Code;  c0196bfa <set_bit_in_list_bitmap+3a/70>
00000000 <_EIP>:
Code;  c0196bfa <set_bit_in_list_bitmap+3a/70>   <=====
      0:   8b 40 04                  mov    0x4(%eax),%eax   <=====
Code;  c0196bfd <set_bit_in_list_bitmap+3d/70>
      3:   0f ab 30                  bts    %esi,(%eax)
Code;  c0196c00 <set_bit_in_list_bitmap+40/70>
      6:   8b 7c 24 0c               mov    0xc(%esp),%edi
Code;  c0196c04 <set_bit_in_list_bitmap+44/70>
      a:   8b 5c 24 04               mov    0x4(%esp),%ebx
Code;  c0196c08 <set_bit_in_list_bitmap+48/70>
      e:   8b 74 24 08               mov    0x8(%esp),%esi
Code;  c0196c0c <set_bit_in_list_bitmap+4c/70>
     12:   31 c0                     xor    %eax,%eax


1 error issued.  Results may not be reliable.
------------opps during mount-------------

This time i could also i.e run Quake 3, listen music, but i couldn't 
access Seagate.

I've downloaded from Seagate website SeaTools Desktop and do Full scan 
of disk, but SeaTools didn't find anything. So i've return to Fedora and 
mount Seagate, and after a while (a bit longer that normaly) i've 
cleanly mounted Seagate.

Now if i create new partition on Seagate, makefs.reiserfs and then copy 
i.e 40GB of data from Maxtor to Seagate everything goes fine, but if i 
try to copy something from Seagate to Maxtor i get this messages:
--------------------------------------------
attempt to access beyond end of device
sdb1: rw=0, want=3792961544, limit=156296322
attempt to access beyond end of device
sdb1: rw=0, want=2043510792, limit=156296322
attempt to access beyond end of device
sdb1: rw=0, want=3792961544, limit=156296322
Buffer I/O error on device sdb1, logical block 474120192
attempt to access beyond end of device
sdb1: rw=0, want=3792961544, limit=156296322
Buffer I/O error on device sdb1, logical block 474120192
---------------------------------------------

I could reproduce this bug, so if you need more informations, write me 
what should i do and how to debug/track this bug.

I've found this thread on LKML, maybe this will be in some way useful:
http://groups.google.pl/groups?hl=pl&lr=&ie=UTF-8&threadm=fa.ie9bln8.a1o8q6%40ifi.uio.no&rnum=1&prev=/groups%3Fq%3D%2522set_bit_in_list_bitmap%252B3a/70%2522%26hl%3Dpl%26lr%3D%26ie%3DUTF-8%26sa%3DN%26tab%3Dwg
-- 
Best Regards
Marcin Garski
