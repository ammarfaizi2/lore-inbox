Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261290AbVFNSjJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261290AbVFNSjJ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Jun 2005 14:39:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261293AbVFNSjJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Jun 2005 14:39:09 -0400
Received: from vapor.arctrix.com ([66.220.1.99]:57870 "HELO vapor.arctrix.com")
	by vger.kernel.org with SMTP id S261290AbVFNSim (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Jun 2005 14:38:42 -0400
Date: Tue, 14 Jun 2005 12:38:41 -0600
From: Neil Schemenauer <nas@arctrix.com>
To: linux-kernel@vger.kernel.org
Subject: 2.6.12-rc6-mm1: kernel BUG at fs/inode.c:1106
Message-ID: <20050614183841.GA32323@mems-exchange.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-PGP-Fingerprint: 9B3B 987B F40E 9320 0619  0A17 A366 302E B1DE 86CE
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I had the same problem with vmlinuz-2.6.12-rc5-mm2.  The BUG is
trigged when umounting an NTFS partition.  I can provide the .config
file is it helps.

kernel BUG at fs/inode.c:1106!
invalid operand: 0000 [#1]
Modules linked in: tuner tvaudio bttv video_buf firmware_class i2c_algo_bit v4l2_common btcx_risc tveeprom videodev vfat fat ntfs w83781d hwmon i2c_sensor i2c_viapro i2c_core e100 mii
CPU:    0
EIP:    0060:[<c01651ba>]    Not tainted VLI
EFLAGS: 00210246   (2.6.12-rc6-mm1)
EIP is at iput+0x7a/0x90
eax: f8966620   ebx: e2056dfc   ecx: 00000000   edx: c9c86000
esi: e2056f00   edi: e2056dfc   ebp: e2056f00   esp: c9c86ee8
ds: 007b   es: 007b   ss: 0068
Process umount (pid: 24623, threadinfo=c9c86000 task=c7d76a40)
Stack: f7a65674 f7a65674 c0170e44 00000000 00000000 e2056f08 e2056dfc f7a65674
       f7a65674 f67c6b9c f8966620 c9c86000 c01645cf c9c86f1c c9c86f1c f7a65600
       f67c6b9c c015320b f89666a0 c18e41e0 f7a65600 f89666a0 c0153bc5 f7a65640
Call Trace:
 [<c0170e44>] inotify_unmount_inodes+0xc4/0xf0
 [<c01645cf>] invalidate_inodes+0x2f/0x60
 [<c015320b>] generic_shutdown_super+0x6b/0x140
 [<c0153bc5>] kill_block_super+0x25/0x40
 [<c01530eb>] deactivate_super+0x5b/0x90
 [<c0166c4b>] sys_umount+0x3b/0x90
 [<c014301a>] do_munmap+0xea/0x120
 [<c0166cb7>] sys_oldumount+0x17/0x20
 [<c0102b25>] syscall_call+0x7/0xb
Code: 18 85 c0 0f 45 d0 89 d8 ff d2 8b 5c 24 04 83 c4 08 c3 c7 04 24 c0 1e 34 c0 e8 93 1d fb ff e8 fe de f9 ff eb bd 89 d8 ff d2 eb b0 <0f> 0b 52 04 ac 8f 34 c0 eb 9b 8d b6 00 00 00 00 8d bf 00 00 00
 Badness in do_exit at kernel/exit.c:789
 [<c0118ff5>] do_exit+0x405/0x410
 [<c0103458>] die+0x138/0x140
 [<c0103780>] do_invalid_op+0x0/0xc0
 [<c010381c>] do_invalid_op+0x9c/0xc0
 [<c013b272>] pagevec_lookup+0x22/0x30
 [<c01651ba>] iput+0x7a/0x90
 [<c016d2e9>] write_inode_now+0x79/0xb0
 [<c0139e28>] cache_flusharray+0x48/0xc0
 [<c01b0016>] memmove+0x36/0x40
 [<c0102d3f>] error_code+0x4f/0x54
 [<c01651ba>] iput+0x7a/0x90
 [<c0170e44>] inotify_unmount_inodes+0xc4/0xf0
 [<c01645cf>] invalidate_inodes+0x2f/0x60
 [<c015320b>] generic_shutdown_super+0x6b/0x140
 [<c0153bc5>] kill_block_super+0x25/0x40
 [<c01530eb>] deactivate_super+0x5b/0x90
 [<c0166c4b>] sys_umount+0x3b/0x90
 [<c014301a>] do_munmap+0xea/0x120
 [<c0166cb7>] sys_oldumount+0x17/0x20
 [<c0102b25>] syscall_call+0x7/0xb


