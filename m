Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264477AbTEJT1Y (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 10 May 2003 15:27:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264478AbTEJT1X
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 10 May 2003 15:27:23 -0400
Received: from franka.aracnet.com ([216.99.193.44]:59352 "EHLO
	franka.aracnet.com") by vger.kernel.org with ESMTP id S264477AbTEJT1U
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 10 May 2003 15:27:20 -0400
Date: Sat, 10 May 2003 10:25:39 -0700
From: "Martin J. Bligh" <mbligh@aracnet.com>
Reply-To: LKML <linux-kernel@vger.kernel.org>
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: [Bug 701] New: slab corruption when mounting ext3
Message-ID: <4150000.1052587539@[10.10.2.4]>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

http://bugme.osdl.org/show_bug.cgi?id=701

           Summary: slab corruption when mounting ext3
    Kernel Version: 2.5.69
            Status: NEW
          Severity: high
             Owner: akpm@digeo.com
         Submitter: ken@krwtech.com


Distribution: custom
Hardware Environment: Tyan TigerMP with Dual Athlon MP, all SCSI system
Software Environment: gcc 3.2.3, mount mount-2.11z, e2fsprogs 1.32
Problem Description:

I get slab corruption while trying to mount the first partition with a ext3
journal, it doesn't happen when mounting the subsequent ones. It happens on
every boot, sometimes (about 33% of the time) causing mount to segfault and not
mount the other paritions - the rest of the time, it continues to boot normally

EXT3 FS 2.4-0.9.16, 02 Dec 2001 on sdc1, internal journal
Slab corruption: start=df827000, expend=df8277ff, problemat=df827000
Data: D0 75 64 C1 01 00 00 00 1A D6 46 C0 B4 67 F9 DF 04 00 00 00 A4 01 00 00 00
00 00 00 40 E6 3C C0 00 00 00 00 3C 86
81 DF 00 00 00 00 00 00 00 00 02 00 00 00 17 D6 46 C0 B8 67 F9 DF 04 00 00 00 24
01 00 00 00 00 00 00 90 80 12 C0 00 00
00 00 CC 3C 81 DF 00 00 00 00 00 00 00 00 04 00 00 00 25 D6 46 C0 90 67 F9 DF 04
00 00 00 A4 01 00 00 00 00 00 00 90 80
12 C0 00 00 00 00 40 3C 81 DF 00 00 00 00 00 00 00 00 05 00 00 00 36 D6 46 C0 98
67 F9 DF 04 00 00 00 A4 01 00 00 00 00
00 00 90 80 12 C0 00 00 00 00 B4 3B 81 DF 00 00 00 00 00 00 00 00 07 00 00 00 47
D6 46 C0 9C 67 F9 DF 04 00 00 00 A4 01
00 00 00 00 00 00 90 80 12 C0 00 00 00 00 28 3B 81 DF 00 00 00 00 00 00 00 00 08
00 00 00 A5 D6 46 C0 A4 67 F9 DF 04 00
00 00 A4 01 00 00 00 00 00 00 90 80 12 C0 00 00 00 00 9C 3A 81 DF 00 00 00 00 00
00 00 00 06 00 00 00 54 D6 46 C0 94 67
F9 DF 04 00 00 00 A4 01 00 00 00 00 00 00 90 80 12 C0 00 00 00 00 10 3A 81 DF 00
00 00 00 00 00 00 00 09 00 00 00 63 D6
46 C0 A0 67 F9 DF 04 00 00 00 A4 01 00 00 00 00 00 00 90 80 12 C0 00 00 00 00 84
39 81 DF 00 00 00 00 00 00 00 00 03 00
00 00 77 D6 46 C0 A8 67 F9 DF 04 00 00 00 A4 01 00 00 00 00 00 00 90 80 12 C0 00
00 00 00 C4 30 81 DF 00 00 00 00 00 00
00 00 0E 00 00 00 81 D6 46 C0 C4 67 F9 DF 04 00 00 00 A4 01 00 00 00 00 00 00 90
80 12 C0 00 00 00 00 50 31 81 DF 00 00
00 00 00 00 00 00 0A 00 00 00 8B D6 46 C0 AC 67 F9 DF 04 00 00 00 A4 01 00 00 00
00 00 00 90 80 12 C0 00 00 00 00 DC 31
81 DF 00 00 00 00 00 00 00 00 0B 00 00 00 97 D6 46 C0 B0 67 F9 DF 04 00 00 00 A4
01 00 00 00 00 00 00 90 80 12 C0 00 00
00 00 68 32 81 DF 00 00 00 00 00 00 00 00 0C 00 00 00 B4 59 43 C0 BC 67 F9 DF 04
00 00 00 A4 01 00 00 00 00 00 00 90 80
12 C0 00 00 00 00 F4 32 81 DF 00 00 00 00 00 00 00 00 0D 00 00 00 A4 D6 46 C0 C0
67 F9 DF 04 00 00 00 A4 01 00 00 00 00
00 00 90 80 12 C0 00 00 00 00 80 33 81 DF 00 00 00 00 00 00 00 00 0F 00 00 00 AF
D6 46 C0 C8 67 F9 DF 04 00 00 00 A4 01
00 00 00 00 00 00 D0 E6 3C C0 40 E7 3C C0 0C 34 81 DF 00 00 00 00 00 00 00 00 10
00 00 00 BC D6 46 C0 CC 67 F9 DF 04 00
00 00 A4 01 00 00 00 00 00 00 D0 E6 3C C0 40 E7 3C C0 E0 37 81 DF 00 00 00 00 00
00 00 00 00 00 00 00 00 00 00 00 00 00
00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
00 00 00 00 00 00 00 01 00 00 00 60 C2
4C C0 00 00 00 00 00 00 00 00 6D 01 00 00 04 70 82 DF 00 00 00 00 00 00 00 00 F4
82 81 DF 00 00 00 00 00 00 00 00 00 00
00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
00 00 00 00 00 00 00 00 00 00 00 00 00
00 00 10 00 00 00 CB D6 46 C0 00 00 00 00 00 00 00 00 6D 01 00 00 F0 72 82 DF 00
00 00 00 00 00 00 00 80 A3 73 C1 00 00
00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
00 00 00 00 00 00 00 00 00 00 00 00 00
00 00 00 00 00 00 00 00 00 00 05 00 00 00 95 D5 46 C0 00 00 00 00 00 00 00 00 6D
01 00 00 48 73 82 DF 00 00 00 00 00 00
00 00 70 4E FD DF 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
00 00 00 00 00 00 00 00 00 00 00 00 00
00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 03 00 00 00 03 33 43 C0 00
00 00 00 00 00 00 00 6D 01 00 00 A0 73
82 DF 00 00 00 00 00 00 00 00 B0 45 FD DF 00 00 00 00 00 00 00 00 00 00 00 00 00
00 00 00 00 00 00 00 00 00 00 00 00 00
00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
******************************************
************************************************************************************************************************
************************************************************************************************************************
************************************************************************************************************************
************************************************************************************************************************
************************************************************************************************************************
************************************************************************************************************************
************************************************************************************************************************
*************************************************************A5
Next: 08 7D 64 C1 01 00 00 00 29 D1 46 C0 74 36 81 DF 04 00 00 00 A4 01 00 00 00
00 00 00 90 80 12 C0
Call Trace:
 [<c0143dd8>] check_poison_obj+0x158/0x1a0
 [<c0145b11>] kmalloc+0x171/0x1b0
 [<c01b139b>] journal_init_revoke+0x8b/0x170
 [<c01b139b>] journal_init_revoke+0x8b/0x170
 [<c01b24e9>] journal_init_common+0x29/0x1b0
 [<c01b2652>] journal_init_common+0x192/0x1b0
 [<c01b273f>] journal_init_inode+0xf/0x120
 [<c01a7f10>] ext3_get_journal+0xb0/0x110
 [<c01a822f>] ext3_load_journal+0x7f/0x190
 [<c01a7cd9>] ext3_fill_super+0x909/0xa70
 [<c0196c26>] disk_name+0x66/0xc0
 [<c01650f8>] get_sb_bdev+0x128/0x160
 [<c017cc47>] alloc_vfsmnt+0x87/0xe0
 [<c01a8d2f>] ext3_get_sb+0x2f/0x33
 [<c01a73d0>] ext3_fill_super+0x0/0xa70
 [<c016534f>] do_kern_mount+0x5f/0xe0
 [<c017e395>] do_add_mount+0x95/0x180
 [<c017e6b5>] do_mount+0x155/0x1b0
 [<c017e55a>] copy_mount_options+0xda/0xe0
 [<c017ed6f>] sys_mount+0xef/0x190
 [<c010977b>] syscall_call+0x7/0xb

EXT3 FS 2.4-0.9.16, 02 Dec 2001 on sdc5, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
kjournald starting.  Commit interval 5 seconds
EXT3 FS 2.4-0.9.16, 02 Dec 2001 on sdc7, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
kjournald starting.  Commit interval 5 seconds
EXT3 FS 2.4-0.9.16, 02 Dec 2001 on sdd7, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
kjournald starting.  Commit interval 5 seconds
EXT3 FS 2.4-0.9.16, 02 Dec 2001 on sdc8, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
kjournald starting.  Commit interval 5 seconds
EXT3 FS 2.4-0.9.16, 02 Dec 2001 on sdb7, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
kjournald starting.  Commit interval 5 seconds
EXT3 FS 2.4-0.9.16, 02 Dec 2001 on sda1, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
kjournald starting.  Commit interval 5 seconds
EXT3 FS 2.4-0.9.16, 02 Dec 2001 on sda5, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
kjournald starting.  Commit interval 5 seconds
EXT3 FS 2.4-0.9.16, 02 Dec 2001 on sdb1, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
kjournald starting.  Commit interval 5 seconds
EXT3 FS 2.4-0.9.16, 02 Dec 2001 on sdb2, internal journal
EXT3-fs: mounted filesystem with ordered data mode.


Steps to reproduce:
occurs during bootup

