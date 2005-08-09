Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932344AbVHIF6s@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932344AbVHIF6s (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Aug 2005 01:58:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932226AbVHIF6s
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Aug 2005 01:58:48 -0400
Received: from gw.exalead.com ([84.233.148.29]:31977 "EHLO exalead.com")
	by vger.kernel.org with ESMTP id S932344AbVHIF6r (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Aug 2005 01:58:47 -0400
Message-ID: <42F845F7.50904@exalead.com>
Date: Tue, 09 Aug 2005 07:58:15 +0200
From: Xavier Roche <roche+kml2@exalead.com>
Organization: Exalead
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.7.8) Gecko/20050511
X-Accept-Language: fr, en-us, en, ja
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: [reiserfs] exception/panic while trying to write data
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi folks,

While trying to upgrade from Linux 2.6.7 to Linux 2.6.11.12, my reiserfs 
partition screwed up for an unknown reason (inconsistency in the 
filesystem ?) and the kernel started to reboot each 10 minutes ("panic 
loop")

I'm not sure this is related to 2.6.11.12 (the filesystem might have 
screwed up during the reboot), but the filesystem was ok before that (no 
errors at all), no disk (hardware) errors reported anywhere, no "brutal" 
power off or anything that could explain the problem. But INN was 
running on this fs, with some important load (many read/write 
operations, continuously)

I had to fsck.reiserfs --rebuild-tree the disk, but unfortunately many 
files were screwed up (blocks from other files before other files)

Here are the relevant entries related to reiserfs in the kernel log: (.. 
for log cuts) - I did not find any other clear references of the 
problem. If anyone gets any hints, he's welcome!

System: Linux 2.6.7-grsec #1 SMP i686
Disk: Maxtor 6Y080P0, ATA DISK drive, on a IDE Promise Technology, Inc. 
20269 (rev 02)

Aug  8 16:37:46 linux kernel: ReiserFS: hdh1: found reiserfs format 
"3.6" with standard journal
Aug  8 16:37:46 linux kernel: ReiserFS: hdh1: using ordered data mode
Aug  8 16:37:46 linux kernel: ReiserFS: hdh1: journal params: device 
hdh1, size 8192, journal first block 18, max trans len 1024, max batch 
900, max commit age 30, max trans age 30
Aug  8 16:37:46 linux kernel: ReiserFS: hdh1: checking transaction log 
(hdh1)
Aug  8 16:37:46 linux kernel: ReiserFS: hdh1: Using r5 hash to sort names
..
Aug  8 16:38:04 linux kernel: ------------[ cut here ]------------
Aug  8 16:38:04 linux kernel: SMP
Aug  8 16:38:04 linux kernel: Modules linked in: agpgart 3c59x ns83820 
md5 ipv6 reiserfs 8250 serial_core w83781d i2c_sensor i2c_isa i2c_viapro 
i2c_dev i2c_core softdog
Aug  8 16:38:04 linux kernel: CPU:    0
Aug  8 16:38:04 linux kernel: EIP:    0060:[pg0+809516114/1068598272] 
  Not tainted VLI
Aug  8 16:38:04 linux kernel: EFLAGS: 00010286   (2.6.11.12-grsec)
Aug  8 16:38:04 linux kernel: EIP is at reiserfs_in_journal+0x142/0x1b0 
[reiserfs]
Aug  8 16:38:04 linux kernel: eax: f0905f30   ebx: 00cf0000   ecx: 
00001a64   edx: f0881000
Aug  8 16:38:04 linux kernel: esi: ef0e0e00   edi: f0881114   ebp: 
00000000   esp: eb571bc0
Aug  8 16:38:04 linux kernel: ds: 007b   es: 007b   ss: 0068
Aug  8 16:38:04 linux kernel: Process innd (pid: 13370, 
threadinfo=eb570000 task=eb519550)
Aug  8 16:38:04 linux kernel: Stack: c023b122 00000172 c02a3f5e f0881000 
00000000 f0848cf0 ef0e0e00 eb571c4c
Aug  8 16:38:04 linux kernel:        f08c629f ef0e0e00 0000019e 00000000 
00000001 eb571c00 00000000 c04d63b8
Aug  8 16:38:04 linux kernel:        00000000 0000019e ef0e0e00 eb571c4c 
00000000 f08c659a eb571eb0 0000019e
Aug  8 16:38:04 linux kernel: Call Trace:
Aug  8 16:38:04 linux kernel:  [__delay+18/32] __delay+0x12/0x20
Aug  8 16:38:04 linux kernel:  [ide_execute_command+158/192] 
ide_execute_command+0x9e/0xc0
Aug  8 16:38:04 linux kernel:  [pg0+809370271/1068598272] 
scan_bitmap_block+0x29f/0x330 [reiserfs]
Aug  8 16:38:04 linux kernel:  [pg0+809371034/1068598272] 
scan_bitmap+0x16a/0x280 [reiserfs]
Aug  8 16:38:04 linux kernel:  [pg0+809375942/1068598272] 
reiserfs_allocate_blocknrs+0x196/0x510 [reiserfs]
Aug  8 16:38:04 linux kernel:  [pg0+809427645/1068598272] 
reiserfs_allocate_blocks_for_region+0x24d/0x1640 [reiserfs]
Aug  8 16:38:04 linux kernel:  [__wait_on_bit+81/112] 
__wait_on_bit+0x51/0x70
Aug  8 16:38:04 linux kernel:  [sync_buffer+0/80] sync_buffer+0x0/0x50
Aug  8 16:38:04 linux kernel:  [sync_buffer+0/80] sync_buffer+0x0/0x50
Aug  8 16:38:04 linux kernel:  [out_of_line_wait_on_bit+147/160] 
out_of_line_wait_on_bit+0x93/0xa0
Aug  8 16:38:04 linux kernel:  [wake_bit_function+0/96] 
wake_bit_function+0x0/0x60
Aug  8 16:38:04 linux kernel:  [pg0+809436082/1068598272] 
reiserfs_prepare_file_region_for_write+0x522/0x940 [reiserfs]
Aug  8 16:38:04 linux kernel:  [pg0+809438855/1068598272] 
reiserfs_file_write+0x6b7/0x6d0 [reiserfs]
Aug  8 16:38:04 linux kernel:  [__posix_lock_file+1111/1600] 
__posix_lock_file+0x457/0x640
Aug  8 16:38:04 linux kernel:  [may_open+94/544] may_open+0x5e/0x220
Aug  8 16:38:04 linux kernel:  [fcntl_setlk+283/720] fcntl_setlk+0x11b/0x2d0
Aug  8 16:38:04 linux kernel:  [get_empty_filp+195/272] 
get_empty_filp+0xc3/0x110
Aug  8 16:38:04 linux kernel:  [file_move+32/96] file_move+0x20/0x60
Aug  8 16:38:04 linux kernel:  [dentry_open+235/512] dentry_open+0xeb/0x200
Aug  8 16:38:04 linux kernel:  [_atomic_dec_and_lock+49/80] 
_atomic_dec_and_lock+0x31/0x50
Aug  8 16:38:04 linux kernel:  [dput+338/464] dput+0x152/0x1d0
Aug  8 16:38:04 linux kernel:  [vfs_write+174/304] vfs_write+0xae/0x130
Aug  8 16:38:04 linux kernel:  [sys_write+81/128] sys_write+0x51/0x80
Aug  8 16:38:04 linux kernel:  [syscall_call+7/11] syscall_call+0x7/0xb
Aug  8 16:38:04 linux kernel:  [ip_rt_init+139/960] ip_rt_init+0x8b/0x3c0
Aug  8 16:38:04 linux kernel: Code: e9 07 31 d1 8b 54 24 0c 81 e1 ff 1f 
00 00 8b 84 8a 1c 01 00 00 85 c0 74 0c 39 58 08 74 2c 8b 40 20 85 c0 75 
f4 31 c0 85 c0 74 0f <0f> 0b ee 01 dc 90 8f f0 b8 01 00 00 00 eb aa 8b 
86 78 01 00 00

Aug  8 16:38:04 linux kernel:  <0>Fatal exception: panic in 5 seconds
Aug  8 16:41:34 linux syslogd 1.4.1#17: restart.
..

Aug  8 16:41:34 linux kernel: ReiserFS: hdh1: found reiserfs format 
"3.6" with standard journal
Aug  8 16:41:34 linux kernel: ReiserFS: hdh1: using ordered data mode
Aug  8 16:41:34 linux kernel: ReiserFS: hdh1: journal params: device 
hdh1, size 8192, journal first block 18, max trans len 1024, max batch 
900, max commit age 30, max trans age 30
Aug  8 16:41:34 linux kernel: ReiserFS: hdh1: checking transaction log 
(hdh1)
Aug  8 16:41:34 linux kernel: ReiserFS: hdh1: replayed 4 transactions in 
0 seconds
Aug  8 16:41:34 linux kernel: ReiserFS: hdh1: Using r5 hash to sort names
..
Aug  8 16:41:41 linux kernel: ReiserFS: hdh1: warning: vs-4080: 
reiserfs_free_block: free_block (hdh1:12812293)[dev:blocknr]: bit 
already cleared
..
Aug  8 16:48:20 linux kernel: ReiserFS: warning: is_tree_node: node 
level 3 does not match to the expected one 1
Aug  8 16:48:20 linux kernel: ReiserFS: hdh1: warning: vs-5150: 
search_by_key: invalid format found in block 12812288. Fsck?
Aug  8 16:48:20 linux kernel: ReiserFS: warning: is_tree_node: node 
level 3 does not match to the expected one 1
Aug  8 16:48:20 linux kernel: ReiserFS: hdh1: warning: vs-5150: 
search_by_key: invalid format found in block 12812288. Fsck?
Aug  8 16:48:20 linux kernel: ReiserFS: warning: is_tree_node: node 
level 3 does not match to the expected one 1
Aug  8 16:48:20 linux kernel: ReiserFS: hdh1: warning: vs-5150: 
search_by_key: invalid format found in block 12812288. Fsck?
Aug  8 16:48:20 linux kernel: ReiserFS: warning: is_tree_node: node 
level 3 does not match to the expected one 1
Aug  8 16:48:20 linux kernel: ReiserFS: hdh1: warning: vs-5150: 
search_by_key: invalid format found in block 12812288. Fsck?
Aug  8 16:48:20 linux kernel: ReiserFS: warning: is_tree_node: node 
level 3 does not match to the expected one 1
Aug  8 16:48:20 linux kernel: ReiserFS: hdh1: warning: vs-5150: 
search_by_key: invalid format found in block 12812288. Fsck?
Aug  8 16:48:20 linux kernel: ReiserFS: warning: is_tree_node: node 
level 3 does not match to the expected one 1
Aug  8 16:48:20 linux kernel: ReiserFS: hdh1: warning: vs-5150: 
search_by_key: invalid format found in block 12812288. Fsck?
Aug  8 16:50:18 linux kernel: ReiserFS: warning: is_tree_node: node 
level 7 does not match to the expected one 1
Aug  8 16:50:18 linux kernel: ReiserFS: hdh1: warning: vs-5150: 
search_by_key: invalid format found in block 12812288. Fsck?
Aug  8 16:50:18 linux kernel: ReiserFS: warning: is_tree_node: node 
level 7 does not match to the expected one 1
Aug  8 16:50:18 linux kernel: ReiserFS: hdh1: warning: vs-5150: 
search_by_key: invalid format found in block 12812288. Fsck?
Aug  8 16:50:18 linux kernel: ReiserFS: warning: is_tree_node: node 
level 7 does not match to the expected one 1
Aug  8 16:50:18 linux kernel: ReiserFS: hdh1: warning: vs-5150: 
search_by_key: invalid format found in block 12812288. Fsck?
Aug  8 16:50:18 linux kernel: ReiserFS: warning: is_tree_node: node 
level 7 does not match to the expected one 1
Aug  8 16:50:18 linux kernel: ReiserFS: hdh1: warning: vs-5150: 
search_by_key: invalid format found in block 12812288. Fsck?
Aug  8 16:50:18 linux kernel: ReiserFS: warning: is_tree_node: node 
level 7 does not match to the expected one 1
Aug  8 16:50:18 linux kernel: ReiserFS: hdh1: warning: vs-5150: 
search_by_key: invalid format found in block 12812288. Fsck?
Aug  8 16:50:18 linux kernel: ReiserFS: warning: is_tree_node: node 
level 7 does not match to the expected one 1
Aug  8 16:50:18 linux kernel: ReiserFS: hdh1: warning: vs-5150: 
search_by_key: invalid format found in block 12812288. Fsck?
Aug  8 16:51:00 linux kernel: ------------[ cut here ]------------
Aug  8 16:51:00 linux kernel: SMP
Aug  8 16:51:00 linux kernel: Modules linked in: agpgart 3c59x ns83820 
md5 ipv6 reiserfs 8250 serial_core w83781d i2c_sensor i2c_isa i2c_viapro 
i2c_dev i2c_core softdog
Aug  8 16:51:00 linux kernel: CPU:    0
Aug  8 16:51:00 linux kernel: EIP:    0060:[pg0+809516114/1068598272] 
  Not tainted VLI
Aug  8 16:51:00 linux kernel: EFLAGS: 00010286   (2.6.11.12-grsec)
Aug  8 16:51:00 linux kernel: EIP is at reiserfs_in_journal+0x142/0x1b0 
[reiserfs]
Aug  8 16:51:00 linux kernel: eax: f090866c   ebx: 00cf0000   ecx: 
00000324   edx: f0881000
Aug  8 16:51:00 linux kernel: esi: ef32ae00   edi: f0881114   ebp: 
00000000   esp: eb0e1bc0
Aug  8 16:51:00 linux kernel: ds: 007b   es: 007b   ss: 0068
Aug  8 16:51:00 linux kernel: Process innd (pid: 10130, 
threadinfo=eb0e0000 task=eb08d570)
Aug  8 16:51:00 linux kernel: Stack: c023b122 00000172 c02a3f5e f0881000 
00000000 f0848cf0 ef32ae00 eb0e1c4c
Aug  8 16:51:00 linux kernel:        f08c629f ef32ae00 0000019e 00000000 
00000001 eb0e1c00 00000000 c04d63b8
Aug  8 16:51:00 linux kernel:        00000000 0000019e ef32ae00 eb0e1c4c 
00000000 f08c659a eb0e1eb0 0000019e
Aug  8 16:51:00 linux kernel: Call Trace:
Aug  8 16:51:00 linux kernel:  [__delay+18/32] __delay+0x12/0x20
Aug  8 16:51:00 linux kernel:  [ide_execute_command+158/192] 
ide_execute_command+0x9e/0xc0
Aug  8 16:51:00 linux kernel:  [pg0+809370271/1068598272] 
scan_bitmap_block+0x29f/0x330 [reiserfs]
Aug  8 16:51:00 linux kernel:  [pg0+809371034/1068598272] 
scan_bitmap+0x16a/0x280 [reiserfs]
Aug  8 16:51:00 linux kernel:  [pg0+809375942/1068598272] 
reiserfs_allocate_blocknrs+0x196/0x510 [reiserfs]
Aug  8 16:51:00 linux kernel:  [pg0+809427645/1068598272] 
reiserfs_allocate_blocks_for_region+0x24d/0x1640 [reiserfs]
Aug  8 16:51:00 linux kernel:  [__wait_on_bit+81/112] 
__wait_on_bit+0x51/0x70
Aug  8 16:51:00 linux kernel:  [sync_buffer+0/80] sync_buffer+0x0/0x50
Aug  8 16:51:00 linux kernel:  [sync_buffer+0/80] sync_buffer+0x0/0x50
Aug  8 16:51:00 linux kernel:  [out_of_line_wait_on_bit+147/160] 
out_of_line_wait_on_bit+0x93/0xa0
Aug  8 16:51:00 linux kernel:  [wake_bit_function+0/96] 
wake_bit_function+0x0/0x60
Aug  8 16:51:00 linux kernel:  [pg0+809436082/1068598272] 
reiserfs_prepare_file_region_for_write+0x522/0x940 [reiserfs]
Aug  8 16:51:00 linux kernel:  [pg0+809438855/1068598272] 
reiserfs_file_write+0x6b7/0x6d0 [reiserfs]
Aug  8 16:51:00 linux kernel:  [__posix_lock_file+1111/1600] 
__posix_lock_file+0x457/0x640
Aug  8 16:51:00 linux kernel:  [may_open+94/544] may_open+0x5e/0x220
Aug  8 16:51:00 linux kernel:  [fcntl_setlk+283/720] fcntl_setlk+0x11b/0x2d0
Aug  8 16:51:00 linux kernel:  [get_empty_filp+195/272] 
get_empty_filp+0xc3/0x110
Aug  8 16:51:00 linux kernel:  [file_move+32/96] file_move+0x20/0x60
Aug  8 16:51:00 linux kernel:  [dentry_open+235/512] dentry_open+0xeb/0x200
Aug  8 16:51:00 linux kernel:  [_atomic_dec_and_lock+49/80] 
_atomic_dec_and_lock+0x31/0x50
Aug  8 16:51:00 linux kernel:  [dput+338/464] dput+0x152/0x1d0
Aug  8 16:51:00 linux kernel:  [dnotify_parent+58/176] 
dnotify_parent+0x3a/0xb0
Aug  8 16:51:00 linux kernel:  [default_llseek+98/208] 
default_llseek+0x62/0xd0
Aug  8 16:51:00 linux kernel:  [vfs_write+174/304] vfs_write+0xae/0x130
Aug  8 16:51:00 linux kernel:  [sys_pwrite64+136/144] sys_pwrite64+0x88/0x90
Aug  8 16:51:00 linux kernel:  [syscall_call+7/11] syscall_call+0x7/0xb
Aug  8 16:51:00 linux kernel:  [ip_rt_init+139/960] ip_rt_init+0x8b/0x3c0
Aug  8 16:51:00 linux kernel: Code: e9 07 31 d1 8b 54 24 0c 81 e1 ff 1f 
00 00 8b 84 8a 1c 01 00 00 85 c0 74 0c 39 58 08 74 2c 8b 40 20 85 c0 75 
f4 31 c0 85 c0 74 0f <0f> 0b ee 01 dc 90 8f f0 b8 01 00 00 00 eb aa 8b 
86 78 01 00 00

Aug  8 16:51:00 linux kernel:  <0>Fatal exception: panic in 5 seconds
Aug  8 16:54:33 linux syslogd 1.4.1#17: restart.

..

Aug  8 16:54:40 linux kernel: ReiserFS: warning: is_tree_node: node 
level 7 does not match to the expected one 1
Aug  8 16:54:40 linux kernel: ReiserFS: hdh1: warning: vs-5150: 
search_by_key: invalid format found in block 12812288. Fsck?
Aug  8 16:54:40 linux kernel: ReiserFS: warning: is_tree_node: node 
level 7 does not match to the expected one 1
Aug  8 16:54:40 linux kernel: ReiserFS: hdh1: warning: vs-5150: 
search_by_key: invalid format found in block 12812288. Fsck?
Aug  8 16:54:40 linux kernel: ReiserFS: warning: is_tree_node: node 
level 7 does not match to the expected one 1
Aug  8 16:54:40 linux kernel: ReiserFS: hdh1: warning: vs-5150: 
search_by_key: invalid format found in block 12812288. Fsck?
Aug  8 16:54:40 linux kernel: ReiserFS: warning: is_tree_node: node 
level 7 does not match to the expected one 1
Aug  8 16:54:40 linux kernel: ReiserFS: hdh1: warning: vs-5150: 
search_by_key: invalid format found in block 12812288. Fsck?
Aug  8 16:54:40 linux kernel: ReiserFS: warning: is_tree_node: node 
level 7 does not match to the expected one 1
Aug  8 16:54:40 linux kernel: ReiserFS: hdh1: warning: vs-5150: 
search_by_key: invalid format found in block 12812288. Fsck?
Aug  8 16:54:40 linux kernel: ReiserFS: warning: is_tree_node: node 
level 7 does not match to the expected one 1
Aug  8 16:54:40 linux kernel: ReiserFS: hdh1: warning: vs-5150: 
search_by_key: invalid format found in block 12812288. Fsck?
Aug  8 16:54:40 linux kernel: ReiserFS: warning: is_tree_node: node 
level 7 does not match to the expected one 1
Aug  8 16:54:40 linux kernel: ReiserFS: hdh1: warning: vs-5150: 
search_by_key: invalid format found in block 12812288. Fsck?
Aug  8 16:56:37 linux kernel: ReiserFS: warning: is_tree_node: node 
level 23 does not match to the expected one 1
Aug  8 16:56:37 linux kernel: ReiserFS: hdh1: warning: vs-5150: 
search_by_key: invalid format found in block 12812288. Fsck?
Aug  8 16:56:37 linux kernel: ReiserFS: warning: is_tree_node: node 
level 23 does not match to the expected one 1
Aug  8 16:56:37 linux kernel: ReiserFS: hdh1: warning: vs-5150: 
search_by_key: invalid format found in block 12812288. Fsck?
Aug  8 16:56:37 linux kernel: ReiserFS: warning: is_tree_node: node 
level 23 does not match to the expected one 1
Aug  8 16:56:37 linux kernel: ReiserFS: hdh1: warning: vs-5150: 
search_by_key: invalid format found in block 12812288. Fsck?
Aug  8 16:56:37 linux kernel: ReiserFS: warning: is_tree_node: node 
level 23 does not match to the expected one 1
Aug  8 16:56:37 linux kernel: ReiserFS: hdh1: warning: vs-5150: 
search_by_key: invalid format found in block 12812288. Fsck?
Aug  8 16:56:37 linux kernel: ReiserFS: warning: is_tree_node: node 
level 23 does not match to the expected one 1
Aug  8 16:56:37 linux kernel: ReiserFS: hdh1: warning: vs-5150: 
search_by_key: invalid format found in block 12812288. Fsck?
Aug  8 16:56:37 linux kernel: ReiserFS: warning: is_tree_node: node 
level 23 does not match to the expected one 1
Aug  8 16:56:37 linux kernel: ReiserFS: hdh1: warning: vs-5150: 
search_by_key: invalid format found in block 12812288. Fsck?
Aug  8 16:57:23 linux kernel: ------------[ cut here ]------------
Aug  8 16:57:23 linux kernel: SMP
Aug  8 16:57:23 linux kernel: Modules linked in: agpgart 3c59x ns83820 
md5 ipv6 reiserfs 8250 serial_core w83781d i2c_sensor i2c_isa i2c_viapro 
i2c_dev i2c_core softdog
Aug  8 16:57:23 linux kernel: CPU:    0
Aug  8 16:57:23 linux kernel: EIP:    0060:[pg0+809516114/1068598272] 
  Not tainted VLI
Aug  8 16:57:23 linux kernel: EFLAGS: 00010286   (2.6.11.12-grsec)
Aug  8 16:57:23 linux kernel: EIP is at reiserfs_in_journal+0x142/0x1b0 
[reiserfs]
Aug  8 16:57:23 linux kernel: eax: f0907b74   ebx: 00ed0000   ecx: 
00000014   edx: f0881000
Aug  8 16:57:23 linux kernel: esi: ef13be00   edi: f0881114   ebp: 
00000000   esp: eb081bc0
Aug  8 16:57:23 linux kernel: ds: 007b   es: 007b   ss: 0068
Aug  8 16:57:23 linux kernel: Process innd (pid: 6783, 
threadinfo=eb080000 task=eb02a570)
Aug  8 16:57:23 linux kernel: Stack: 0008e001 00000000 00000001 f0881000 
00000000 f0848ed0 ef13be00 eb081c4c
Aug  8 16:57:23 linux kernel:        f08c629f ef13be00 000001da 00000000 
00000001 eb081c00 00000000 00000000
Aug  8 16:57:23 linux kernel:        00000000 000001da ef13be00 eb081c4c 
00000000 f08c659a eb081eb0 000001da
Aug  8 16:57:23 linux kernel: Call Trace:
Aug  8 16:57:23 linux kernel:  [pg0+809370271/1068598272] 
scan_bitmap_block+0x29f/0x330 [reiserfs]
Aug  8 16:57:23 linux kernel:  [pg0+809371034/1068598272] 
scan_bitmap+0x16a/0x280 [reiserfs]
Aug  8 16:57:23 linux kernel:  [pg0+809375942/1068598272] 
reiserfs_allocate_blocknrs+0x196/0x510 [reiserfs]
Aug  8 16:57:23 linux kernel:  [pg0+809427645/1068598272] 
reiserfs_allocate_blocks_for_region+0x24d/0x1640 [reiserfs]
Aug  8 16:57:23 linux kernel:  [pg0+809498883/1068598272] 
search_for_position_by_key+0x1d3/0x400 [reiserfs]
Aug  8 16:57:23 linux kernel:  [pg0+809403594/1068598272] 
make_cpu_key+0x5a/0x70 [reiserfs]
Aug  8 16:57:23 linux kernel:  [pg0+809492723/1068598272] 
pathrelse+0x23/0x40 [reiserfs]
Aug  8 16:57:23 linux kernel:  [pg0+809435627/1068598272] 
reiserfs_prepare_file_region_for_write+0x35b/0x940 [reiserfs]
Aug  8 16:57:23 linux kernel:  [pg0+809438855/1068598272] 
reiserfs_file_write+0x6b7/0x6d0 [reiserfs]
Aug  8 16:57:23 linux kernel:  [gr_acl_handle_hidden_file+56/208] 
gr_acl_handle_hidden_file+0x38/0xd0
Aug  8 16:57:23 linux kernel:  [link_path_walk+2378/3552] 
link_path_walk+0x94a/0xde0
Aug  8 16:57:23 linux kernel:  [__d_lookup+250/288] __d_lookup+0xfa/0x120
Aug  8 16:57:23 linux kernel:  [__posix_lock_file+1111/1600] 
__posix_lock_file+0x457/0x640
Aug  8 16:57:23 linux kernel:  [may_open+94/544] may_open+0x5e/0x220
Aug  8 16:57:23 linux kernel:  [fcntl_setlk+283/720] fcntl_setlk+0x11b/0x2d0
Aug  8 16:57:23 linux kernel:  [get_empty_filp+195/272] 
get_empty_filp+0xc3/0x110
Aug  8 16:57:23 linux kernel:  [file_move+32/96] file_move+0x20/0x60
Aug  8 16:57:23 linux kernel:  [dentry_open+235/512] dentry_open+0xeb/0x200
Aug  8 16:57:23 linux kernel:  [_atomic_dec_and_lock+49/80] 
_atomic_dec_and_lock+0x31/0x50
Aug  8 16:57:23 linux kernel:  [dput+338/464] dput+0x152/0x1d0
Aug  8 16:57:23 linux kernel:  [dnotify_parent+58/176] 
dnotify_parent+0x3a/0xb0
Aug  8 16:57:23 linux kernel:  [default_llseek+98/208] 
default_llseek+0x62/0xd0
Aug  8 16:57:23 linux kernel:  [vfs_write+174/304] vfs_write+0xae/0x130
Aug  8 16:57:23 linux kernel:  [sys_pwrite64+136/144] sys_pwrite64+0x88/0x90
Aug  8 16:57:23 linux kernel:  [syscall_call+7/11] syscall_call+0x7/0xb
Aug  8 16:57:23 linux kernel:  [ip_rt_init+139/960] ip_rt_init+0x8b/0x3c0
Aug  8 16:57:23 linux kernel: Code: e9 07 31 d1 8b 54 24 0c 81 e1 ff 1f 
00 00 8b 84 8a 1c 01 00 00 85 c0 74 0c 39 58 08 74 2c 8b 40 20 85 c0 75 
f4 31 c0 85 c0 74 0f <0f> 0b ee 01 dc 90 8f f0 b8 01 00 00 00 eb aa 8b 
86 78 01 00 00
Aug  8 16:57:23 linux kernel:  <0>Fatal exception: panic in 5 seconds
Aug  8 17:00:56 linux syslogd 1.4.1#17: restart.





