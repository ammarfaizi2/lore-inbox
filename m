Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267261AbSK3Prv>; Sat, 30 Nov 2002 10:47:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267265AbSK3Prv>; Sat, 30 Nov 2002 10:47:51 -0500
Received: from dhcp024-210-222-139.woh.rr.com ([24.210.222.139]:51780 "EHLO
	mail.tacomeat.net") by vger.kernel.org with ESMTP
	id <S267261AbSK3Prv>; Sat, 30 Nov 2002 10:47:51 -0500
Date: Sat, 30 Nov 2002 10:45:56 -0500 (EST)
Message-Id: <20021130.104556.59462872.hoho@tacomeat.net>
To: linux-kernel@vger.kernel.org
Subject: Reiserfs broken in 2.5.50 (possibly nanosecond stat timefields?)
From: Colin Slater <hoho@tacomeat.net>
X-Mailer: Mew version 2.2 on Emacs 21.2 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Upon compiling and booting 2.5.50, there seemed to be a flurry of
messages regarding /etc/mtab and /etc/mtab~77 or ~32 or some other
random numbers. ls in /etc seems to look good, but upon opening mtab
up in vi, I get a kernel BUG, and everything stops responding. I flip
VT's and type my username, but never get a password prompt. I rebooted
again, and cat'ed dmesg to a file just for safety. That works, until I
open it up, where I get the BUG again. Reboot to 2.5.47, everything
seems to work ok. Open up the dmesg file I saved, no bug, but the file
seems to be garbage. hexdump looks like

0000000: 6c64 2e73 6f2d 312e 372e 3000 2c03 0000  ld.so-1.7.0.,...
0000010: 0300 0000 504c 0000 5c4c 0000 0300 0000  ....PL..\L......
0000020: 714c 0000 7b4c 0000 0300 0000 8e4c 0000  qL..{L.......L..

ld.so? My systems is completely reiserfs (3.6), and nothing has
changed in my config file between 2.5.47 and 2.5.50. Upon looking
through the source tree, it seems like lines 1134-7 in
fs/reiserfs/namei.c seem to be throwing this panic. Only changesets to
touch namei.c in the past 4 months are "nanosecond stat timefields" and
"*_mknod prototype". I really can't see why these would cause this
problem, so maybe someone else does. Hand-copied output from the
BUG() follows, so this is only what I thought was important and might
contain errors. If you need any other information I will gladly supply
it.

  Colin

vs-7050: new entry is found, new inode==0
--cut here--
kernel BUG at fs/reiserfs/prints.c:336
invalid operand:0000
EIP: 0060:[<c01c70e9>]   Not Tainted
EIP is at reiserfs_panic+0x29/0x60
Call Trace
   reiserfs_rename+0x33d/0x9e0
   journal_end+0x16/0x20
   reiserfs_get_block+0xeb5/0xf20
   __getblk+0x17/0x30
   is_tree_node+0x36/0x50
   ...(There is more if it's really needed)

Code 0F 0B 50 01 78 3F 38 c0 68 60 D8 53 C0 B8 90 3C 38 C0 8D 96
Segmentation Fault
