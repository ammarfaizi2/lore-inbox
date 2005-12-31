Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750764AbVLaVoh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750764AbVLaVoh (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 31 Dec 2005 16:44:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751323AbVLaVoh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 31 Dec 2005 16:44:37 -0500
Received: from relay02.mail-hub.dodo.com.au ([202.136.32.45]:63389 "EHLO
	relay02.mail-hub.dodo.com.au") by vger.kernel.org with ESMTP
	id S1750764AbVLaVog (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 31 Dec 2005 16:44:36 -0500
From: Grant Coady <grant_lkml@dodo.com.au>
To: linux-kernel@vger.kernel.org
Subject: 2.6.14.5: segfault / oops with ide-scsi
Date: Sun, 01 Jan 2006 08:44:30 +1100
Organization: http://bugsplatter.mine.nu/
Reply-To: gcoady@gmail.com
Message-ID: <8budr11mfchfp03ncrpqjeck6f04urom8n@4ax.com>
X-Mailer: Forte Agent 2.0/32.652
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi there,

Got this, trying to mount CDROM on a troublesome box I've not had 
for long, Intel ICH 801 / 810 -- this with "hdc=ide-scsi":

root@niner:~# mount /dev/sr0 /mnt/cdrom/
mount: you must specify the filesystem type
root@niner:~# mount -t iso9660 /dev/sr0 /mnt/cdrom/
mount: /dev/sr0 is not a valid block device
root@niner:~# mount -t iso9660 /dev/sg0 /mnt/cdrom/
mount: /dev/sg0 is not a block device
root@niner:~# mount -t iso9660 /dev/hdc /mnt/cdrom/
Segmentation fault

Even if this be finger trouble, it should not oops?

Jan  1 08:29:15 niner kernel: ide-scsi is deprecated for cd burning! Use ide-cd and give dev=/dev/hdX as device
Jan  1 08:30:02 niner kernel: ide-scsi: unsup command: dev hdc: flags = REQ_CMD REQ_STARTED
Jan  1 08:30:02 niner kernel: sector 64, nr/cnr 2/2
Jan  1 08:30:02 niner kernel: bio c9e095e0, biotail c9e095e0, buffer c7feb000, data 00000000, len 0
Jan  1 08:30:02 niner kernel: end_request: I/O error, dev hdc, sector 64
Jan  1 08:30:02 niner kernel: isofs_fill_super: bread failed, dev=hdc, iso_blknum=16, block=32
Jan  1 08:30:02 niner kernel: Unable to handle kernel NULL pointer dereference at virtual address 00000000
Jan  1 08:30:02 niner kernel:  printing eip:
Jan  1 08:30:02 niner kernel: c01d9206
Jan  1 08:30:02 niner kernel: *pde = 00000000
Jan  1 08:30:02 niner kernel: Oops: 0000 [#1]
Jan  1 08:30:02 niner kernel: Modules linked in: isofs zlib_inflate ide_scsi e100 3c59x
Jan  1 08:30:02 niner kernel: CPU:    0
Jan  1 08:30:02 niner kernel: EIP:    0060:[<c01d9206>]    Not tainted VLI
Jan  1 08:30:02 niner kernel: EFLAGS: 00010246   (2.6.14.5a)
Jan  1 08:30:02 niner kernel: EIP is at get_kobj_path_length+0x26/0x40
Jan  1 08:30:02 niner kernel: eax: 00000000   ebx: 00000000   ecx: ffffffff   edx: c91a826c
Jan  1 08:30:02 niner kernel: esi: 00000001   edi: 00000000   ebp: ffffffff   esp: c7f9fdcc
Jan  1 08:30:02 niner kernel: ds: 007b   es: 007b   ss: 0068
Jan  1 08:30:02 niner kernel: Process mount (pid: 547, threadinfo=c7f9f000 task=c8fe2090)
Jan  1 08:30:02 niner kernel: Stack: c117c520 c927c200 ffffffea c91a826c c01d929f c91a826c 00000282 c7f65e14
Jan  1 08:30:02 niner kernel:        00000000 c117c520 c927c200 ffffffea 00000000 c01d9be8 c91a826c 000000d0
Jan  1 08:30:02 niner kernel:        00000020 00000064 fffffff4 c117c520 c927c200 ffffffea c7fd1000 c01d9cf8
Jan  1 08:30:02 niner kernel: Call Trace:
Jan  1 08:30:02 niner kernel:  [<c01d929f>] kobject_get_path+0x1f/0x80
Jan  1 08:30:02 niner kernel:  [<c01d9be8>] do_kobject_uevent+0x28/0x110
Jan  1 08:30:02 niner kernel:  [<c01d9cf8>] kobject_uevent+0x28/0x30
Jan  1 08:30:02 niner kernel:  [<c0158f0e>] bdev_uevent+0x2e/0x50
Jan  1 08:30:02 niner kernel:  [<c01590a6>] kill_block_super+0x26/0x50
Jan  1 08:30:02 niner kernel:  [<c01584a6>] deactivate_super+0x56/0x70
Jan  1 08:30:02 niner kernel:  [<c0159051>] get_sb_bdev+0x121/0x150
Jan  1 08:30:02 niner kernel:  [<c0168cd3>] dput+0x33/0x180
Jan  1 08:30:02 niner kernel:  [<ca926fe0>] isofs_get_sb+0x30/0x40 [isofs]
Jan  1 08:30:02 niner kernel:  [<ca925cd0>] isofs_fill_super+0x0/0x6e0 [isofs]
Jan  1 08:30:02 niner kernel:  [<c015928f>] do_kern_mount+0x5f/0xe0
Jan  1 08:30:02 niner kernel:  [<c016de6c>] do_new_mount+0x9c/0xe0
Jan  1 08:30:02 niner kernel:  [<c016e457>] do_mount+0x157/0x1b0
Jan  1 08:30:02 niner kernel:  [<c016e2a3>] copy_mount_options+0x63/0xc0
Jan  1 08:30:02 niner kernel:  [<c016e84a>] sys_mount+0x9a/0xe0
Jan  1 08:30:02 niner kernel:  [<c0102fd9>] syscall_call+0x7/0xb
Jan  1 08:30:02 niner kernel: Code: 90 8d 74 26 00 55 bd ff ff ff ff 57 56 be 01 00 00 00 53 8b 54 24 14 31 db 8d b6 00 00 00 00 8d bf 00 00 00 00 8b 3a 89 e9 89 d8 <f2> ae f7 d1 49 8b 52 24 8d 74 31 01 85 d2 75 ea 5b 89 f0 5e 5f

Box info" http://bugsplatter.mine.nu/test/boxen/niner/

Prior to adding the "hdc=ide-scsi" to lilo, the box is able to 
boot from cdrom, then cannot read the cdrom.  Trying to mount it 
results in many of these in syslog:

Jan  1 08:14:12 niner kernel: hdc: attached ide-cdrom driver.
Jan  1 08:15:25 niner kernel: hdc: command error: status=0x51 { DriveReady SeekComplete Error }
Jan  1 08:15:25 niner kernel: hdc: command error: error=0x52
Jan  1 08:15:25 niner kernel: end_request: I/O error, dev 16:00 (hdc), sector 0
Jan  1 08:15:25 niner kernel: hdc: command error: status=0x51 { DriveReady SeekComplete Error }
Jan  1 08:15:25 niner kernel: hdc: command error: error=0x52
Jan  1 08:15:25 niner kernel: end_request: I/O error, dev 16:00 (hdc), sector 4
Jan  1 08:15:25 niner kernel: hdc: command error: status=0x51 { DriveReady SeekComplete Error }
Jan  1 08:15:25 niner kernel: hdc: command error: error=0x52
Jan  1 08:15:25 niner kernel: end_request: I/O error, dev 16:00 (hdc), sector 0

What next?

Thanks,
Grant.
