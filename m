Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261338AbTDUP3q (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Apr 2003 11:29:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261341AbTDUP3p
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Apr 2003 11:29:45 -0400
Received: from franka.aracnet.com ([216.99.193.44]:49844 "EHLO
	franka.aracnet.com") by vger.kernel.org with ESMTP id S261338AbTDUP3i
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Apr 2003 11:29:38 -0400
Date: Mon, 21 Apr 2003 08:41:38 -0700
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: [Bug 613] New: kernel BUG at drivers/block/ll_rw_blk.c:1969!  when mounting xfs/sw-raid0 
Message-ID: <27690000.1050939698@[10.10.2.4]>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

http://bugme.osdl.org/show_bug.cgi?id=613

           Summary: kernel BUG at drivers/block/ll_rw_blk.c:1969!  when
                    mounting xfs/sw-raid0
    Kernel Version: 2.5.68
            Status: NEW
          Severity: normal
             Owner: axboe@suse.de
         Submitter: cheapisp@sensewave.com


Distribution: Lunar Linux (custom, self assembled)
Hardware Environment: kt266a, xp1700+, ide
Software Environment: 
Gnu C                  3.2.2
Gnu make               3.80
util-linux             2.11z
mount                  2.11z
module-init-tools      0.9.11a
e2fsprogs              1.32
reiserfsprogs          3.6.4
xfsprogs               2.0.3
pcmcia-cs              3.2.3
PPP                    2.4.1
Linux C Library        2.3.2
Dynamic linker (ldd)   2.3.2
Linux C++ Library      5.0.2
Procps                 3.1.5
Net-tools              1.60
Console-tools          0.2.3
Sh-utils               2.0

Problem Description:
Oops during boot when my sw-raid0 is being mounted:

md: Autodetecting RAID arrays.
md: autorun ...
md: considering ide/host0/bus1/target0/lun0/part3 ...
md:  adding ide/host0/bus1/target0/lun0/part3 ...
md:  adding ide/host0/bus0/target0/lun0/part3 ...
md: created md0
md: bind<ide/host0/bus0/target0/lun0/part3>
md: bind<ide/host0/bus1/target0/lun0/part3>
md: running: 
<ide/host0/bus1/target0/lun0/part3><ide/host0/bus0/target0/lun0/part3>
md0: setting max_sectors to 128, segment boundary to 32767
raid0: looking at ide/host0/bus1/target0/lun0/part3
raid0:   comparing ide/host0/bus1/target0/lun0/part3(30202112) with 
ide/host0/bus1/target0/lun0/part3(30202112)
raid0:   END
raid0:   ==> UNIQUE
raid0: 1 zones
raid0: looking at ide/host0/bus0/target0/lun0/part3
raid0:   comparing ide/host0/bus0/target0/lun0/part3(30202112) with 
ide/host0/bus1/target0/lun0/part3(30202112)
raid0:   EQUAL
raid0: FINAL 1 zones
raid0: done.
raid0 : md_size is 60404224 blocks.
raid0 : conf->smallest->size is 60404224 blocks.
raid0 : nb_zone is 1.
raid0 : Allocating 8 bytes for hash.
md: ... autorun DONE.
XFS mounting filesystem ide1(22,2)
Ending clean XFS mount for filesystem: ide1(22,2)
VFS: Mounted root (xfs filesystem) readonly.
Freeing unused kernel memory: 160k freed
XFS mounting filesystem ide0(3,2)
Ending clean XFS mount for filesystem: ide0(3,2)
XFS mounting filesystem md(9,0)
------------[ cut here ]------------
kernel BUG at drivers/block/ll_rw_blk.c:1969!
invalid operand: 0000 [#1]
CPU:    0
EIP:    0060:[<c02ba001>]    Not tainted
EFLAGS: 00010246
EIP is at submit_bio+0x61/0x70
eax: 00000000   ebx: 00000000   ecx: 00000000   edx: cffc6a00
esi: cffc6a00   edi: 00000016   ebp: 00016000   esp: cf60fb18
ds: 007b   es: 007b   ss: 0068
Process mount (pid: 395, threadinfo=cf60e000 task=cf7d8d40)
Stack: 00000016 00001000 c024d38c 00000000 cffc6a00 00001000 00000000 03a01aff 
       00000000 00000000 00000016 0000000a 00000086 00000246 cf60e000 cf49aa5c 
       00000020 cfb00000 c024bfd3 00000080 000000d0 00000020 cf49a8c0 c024caa1 
Call Trace:
 [<c024d38c>] pagebuf_iorequest+0x1ec/0x400
 [<c024bfd3>] _pagebuf_get_pages+0xb3/0xd0
 [<c024caa1>] pagebuf_associate_memory+0x71/0x180
 [<c0256288>] xfsbdstrat+0x28/0x30
 [<c0233987>] xlog_bread+0x57/0xa0
 [<c0233e8f>] xlog_find_verify_cycle+0xef/0x1e0
 [<c02343a7>] xlog_find_head+0x1b7/0x460
 [<c013bd6a>] cache_alloc_refill+0x13a/0x1b0
 [<c023466d>] xlog_find_tail+0x1d/0x440
 [<c024ca22>] pagebuf_get_empty+0x52/0x60
 [<c0238ab7>] xlog_recover+0x37/0xf0
 [<c023009f>] xfs_log_mount+0x8f/0xf0
 [<c023a11b>] xfs_mountfs+0x61b/0xf50
 [<c024c89c>] pagebuf_get+0x12c/0x150
 [<c0239454>] xfs_xlatesb+0x44/0x200
 [<c0239748>] xfs_readsb+0x138/0x200
 [<c022d785>] xfs_ioinit+0x45/0x50
 [<c0242732>] xfs_mount+0x392/0x5d0
 [<c0257ab4>] vfs_mount+0x34/0x40
 [<c0257925>] linvfs_fill_super+0xa5/0x1c0
 [<c025fc57>] snprintf+0x27/0x30
 [<c01566f5>] sb_set_blocksize+0x25/0x60
 [<c015610b>] get_sb_bdev+0x12b/0x160
 [<c01655a2>] dput+0x22/0x1e0
 [<c0257a6f>] linvfs_get_sb+0x2f/0x40
 [<c0257880>] linvfs_fill_super+0x0/0x1c0
 [<c015635f>] do_kern_mount+0x5f/0xe0
 [<c016b425>] do_add_mount+0x95/0x190
 [<c016b755>] do_mount+0x155/0x1b0
 [<c016b5fa>] copy_mount_options+0xda/0xe0
 [<c016bc54>] sys_mount+0xd4/0x130
 [<c010ab77>] syscall_call+0x7/0xb

Code: 0f 0b b1 07 99 5b 45 c0 eb b0 90 8d 74 26 00 55 57 56 53 83 


Steps to reproduce:
Reboot.

CONFIG_MD=y
CONFIG_BLK_DEV_MD=y
# CONFIG_MD_LINEAR is not set
CONFIG_MD_RAID0=y
# CONFIG_MD_RAID1 is not set
# CONFIG_MD_RAID5 is not set
# CONFIG_MD_MULTIPATH is not set
# CONFIG_I2C_AMD756 is not set
# CONFIG_I2C_AMD8111 is not set
# CONFIG_AGP_AMD is not set
# CONFIG_AGP_AMD_8151 is not set
CONFIG_XFS_FS=y
# CONFIG_XFS_RT is not set
# CONFIG_XFS_QUOTA is not set
# CONFIG_XFS_POSIX_ACL is not set
CONFIG_DEVFS_FS=y
# CONFIG_DEVFS_MOUNT is not set
# CONFIG_DEVFS_DEBUG is not set


Additional info:
Filesys looks good under 2.4.20. (One file with one link misallocated)
This is a devfs-based system.


