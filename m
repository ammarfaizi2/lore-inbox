Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751207AbWDXUDV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751207AbWDXUDV (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Apr 2006 16:03:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751205AbWDXUDU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Apr 2006 16:03:20 -0400
Received: from pproxy.gmail.com ([64.233.166.180]:3599 "EHLO pproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751207AbWDXUDU convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Apr 2006 16:03:20 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=ovLA+RadhJ8elUysbrf6MJ8Crs/ydgPHBxVxxRtVaIZfG4bR+bdSNcqvaK21RokkrGdADB4m4xzyAZqA1f5Di1TycSrYTB+igty0FEUQMaDZXD7SnLl/MqTlquUuR8Ua8lHLZoG3PRyXbts5jUf4Y9lLp+CNjhtpYFQboxPDBNM=
Message-ID: <9da79ce60604241303w7b182a66o430ad244f8f101e3@mail.gmail.com>
Date: Mon, 24 Apr 2006 17:03:19 -0300
From: "Pablo Gonzalez Mateos" <patulo@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: nForce 430 SATA support
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi folks, I'm new in the list, and having the following problem, my hw
its an MSI k8ngm2 (nforce4 430) with an AMD64 X2, 2 GB DDR and 3 SATA I
Western Digital 250 Gb/each.

I've tried to install Debian etch (2.6.15-amd64), and it found the
/dev/sda, /dev/sdb /dev/sdc automagically, but when it started to
making the filesystems, the system freezed with a sata 0x35 error.

I've installed a PATA drive, and etch worked without problems there.
After that, I downloaded and compiled an 2.6.16.9 from scratch, booted
it, and tried to format with mkfs.ext3 every SATA drive with the same problem...

In the nvidia site I've found drivers for Linux for audio and video,
but nothing for SATA... so I decided to ask you.

Here you have a syslog dump:

Apr 24 15:11:30 rs00 kernel: Unable to handle kernel paging request at
ffff85003ff2adf0 RIP:
Apr 24 15:11:30 rs00 kernel: <ffffffff80169928>{__block_write_full_page+161}
Apr 24 15:11:30 rs00 kernel: PGD 0
Apr 24 15:11:30 rs00 kernel: Oops: 0000 [1] SMP
Apr 24 15:11:30 rs00 kernel: CPU 0
Apr 24 15:11:30 rs00 kernel: Modules linked in: ide_scsi sd_mod
sata_nv ide_cd cdrom libata psmouse forcedeth scsi_mod serio_raw
ehci_hcd ohci_hcd ext3 jbd id
e_disk ide_generic via82cxxx sis5513 generic amd74xx ide_core
Apr 24 15:11:30 rs00 kernel: Pid: 3430, comm: mkfs.ext3 Not tainted 2.6.16.9 #1
Apr 24 15:11:30 rs00 kernel: RIP:
0010:[__block_write_full_page+161/691]
<ffffffff80169928>{__block_write_full_page+161}
Apr 24 15:11:30 rs00 kernel: RSP: 0018:ffff81007c62f8c8  EFLAGS: 00010297
Apr 24 15:11:30 rs00 kernel: RAX: 0000000000000023 RBX:
ffff85003ff2adf0 RCX: 0000000000000003
Apr 24 15:11:30 rs00 kernel: RDX: ffffffff8016ce29 RSI:
ffff810001dfd0f8 RDI: ffff81007df46b40
Apr 24 15:11:30 rs00 kernel: RBP: ffff810001dfd0f8 R08:
ffff81007df46b40 R09: ffff81007c62fb38
Apr 24 15:11:30 rs00 kernel: R10: ffffffff8016ce29 R11:
ffffffff801d1c24 R12: 0000000006480e61
Apr 24 15:11:30 rs00 kernel: R13: ffff81003ff2ad98 R14:
ffff81007df46b40 R15: 000000001c65a598
Apr 24 15:11:30 rs00 kernel: FS:  00002ae11803d6d0(0000)
GS:ffffffff803b2000(0000) knlGS:0000000000000000
Apr 24 15:11:30 rs00 kernel: CS:  0010 DS: 0000 ES: 0000 CR0: 000000008005003b
Apr 24 15:11:30 rs00 kernel: CR2: ffff85003ff2adf0 CR3:
000000007dfd5000 CR4: 00000000000006e0
Apr 24 15:11:30 rs00 kernel: Process mkfs.ext3 (pid: 3430, threadinfo
ffff81007c62e000, task ffff81007e989080)
Apr 24 15:11:30 rs00 kernel: Stack: ffff81007c62fb38 ffffffff8016ce29
000000007c62f948 ffff810001dfd0f8
Apr 24 15:11:30 rs00 kernel:        ffff81007c62fb38 ffff81007df46c88
0000000000000007 ffff81007ebe8288
Apr 24 15:11:30 rs00 kernel:        ffffffffffffffff ffffffff80185df8
Apr 24 15:11:30 rs00 kernel: Call Trace:
<ffffffff8016ce29>{blkdev_get_block+0}
<ffffffff80185df8>{mpage_writepages+414}
Apr 24 15:11:30 rs00 kernel:
<ffffffff8016bfe2>{blkdev_writepage+0}
<ffffffff8014e925>{do_writepages+32}
Apr 24 15:11:30 rs00 kernel:
<ffffffff801847a7>{__writeback_single_inode+426}
<ffffffff80166e0e>{init_buffer_head+22}
Apr 24 15:11:30 rs00 kernel:
<ffffffff801629a6>{cache_alloc_refill+109}
<ffffffff80184e85>{sync_sb_inodes+463}
Apr 24 15:11:30 rs00 kernel:
<ffffffff80185152>{writeback_inodes+125}
<ffffffff8014e515>{balance_dirty_pages_ratelimited+251}
Apr 24 15:11:30 rs00 kernel:
<ffffffff8014a42d>{generic_file_buffered_write+1236}
Apr 24 15:11:30 rs00 kernel:
<ffffffff8012e1ef>{current_fs_time+59}
<ffffffff8014b5cd>{__generic_file_aio_write_nolock+765}
Apr 24 15:11:30 rs00 kernel:
<ffffffff8014b8dd>{generic_file_aio_write_nolock+32}
Apr 24 15:11:30 rs00 kernel:
<ffffffff8014b9b8>{generic_file_write_nolock+143}
<ffffffff8013b8f4>{autoremove_wake_function+0}
Apr 24 15:11:30 rs00 kernel:        <ffffffff8016c52b>{block_llseek+0}
<ffffffff8016c555>{block_llseek+42}
Apr 24 15:11:30 rs00 kernel:
<ffffffff802a840f>{__mutex_lock_slowpath+751}
<ffffffff8016c0f6>{blkdev_file_write+26}
Apr 24 15:11:30 rs00 kernel:        <ffffffff80165c32>{vfs_write+206}
<ffffffff8016651c>{sys_write+69}
Apr 24 15:11:30 rs00 kernel:        <ffffffff8010a862>{system_call+126}
Apr 24 15:11:30 rs00 kernel:
Apr 24 15:11:30 rs00 kernel: Code: 8b 03 89 c0 a8 20 75 40 8b 03 89 c0
a8 02 74 38 b9 01 00 00
Apr 24 15:11:30 rs00 kernel: RIP
<ffffffff80169928>{__block_write_full_page+161} RSP <ffff81007c62f8c8>
Apr 24 15:11:30 rs00 kernel: CR2: ffff85003ff2adf0


Thank you very much. Any help would be appreciated !!!.
Best regards.
Pablo.
