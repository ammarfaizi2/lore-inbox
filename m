Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264726AbUGFXWE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264726AbUGFXWE (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Jul 2004 19:22:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264704AbUGFXWD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Jul 2004 19:22:03 -0400
Received: from e3.ny.us.ibm.com ([32.97.182.103]:47820 "EHLO e3.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S264726AbUGFXUp convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Jul 2004 19:20:45 -0400
Content-Type: text/plain;
  charset="us-ascii"
From: Badari Pulavarty <pbadari@us.ibm.com>
To: linux-kernel@vger.kernel.org
Subject: GPF on 2.6.7 - Known issue ?
Date: Tue, 6 Jul 2004 15:53:31 -0700
User-Agent: KMail/1.4.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Message-Id: <200407061553.31658.pbadari@us.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I am getting GPF while trying to do IO to RAW devices on 2.6.7.
Is this known/fixed issue ? This is on AMD64 box.

The last working kernel is 2.6.5 and 2.6.6 is where this problem
started.

Please let me know.

Thanks,
Badari

kernel: general protection fault: 0000 [1] SMP
kernel: CPU 0
kernel: Modules linked in: qla2300 qla2xxx scsi_transport_fc
kernel: Pid: 3776, comm: db2sysc Not tainted 2.6.7
kernel: RIP: 0010:[<ffffffff801499ba>] <ffffffff801499ba>{set_page_dirty+42}
kernel: RSP: 0018:000001003b6e3bc8  EFLAGS: 00010286
kernel: RAX: 4828478948000000 RBX: 0000010001e70038 RCX: 00000000c0000100
kernel: RDX: ffffffff80160700 RSI: 00000100dff47400 RDI: 0000010001e70038
kernel: RBP: 0000010001e70038 R08: 000001003b6e2000 R09: 0000000000000000
kernel: R10: 00000000ffffffff R11: 0000000000000000 R12: 00000100dff47400
kernel: R13: 00000107ffd6a400 R14: 000001001d17adc0 R15: 0000000000000001
kernel: FS:  0000002a99cdb200(0000) GS:ffffffff80452680(0000) knlGS:0000000000000000
kernel: CS:  0010 DS: 0000 ES: 0000 CR0: 000000008005003b
kernel: CR2: 0000002a95d0d000 CR3: 0000000000101000 CR4: 00000000000006e0
kernel: Process db2sysc (pid: 3776, threadinfo 000001003b6e2000, task 000001003b6e5190)
kernel: Stack: 00000100387d1cc0 ffffffff80149a19 00000107f2d80000 0000010001e70038
kernel:        0000000000000000 ffffffff801838ab 0000000000000000 0000000000000000
kernel:        00000107ffd6a400 0000000000000000
kernel: Call Trace:<ffffffff80149a19>{set_page_dirty_lock+41} <ffffffff801838ab>{dio_bio_complete+139}
kernel:        <ffffffff80184a90>{__blockdev_direct_IO+2752} <ffffffff80169c55>{blkdev_direct_IO+69}
kernel:        <ffffffff80169850>{blkdev_get_blocks+0} <ffffffff80145cd4>{generic_file_direct_IO+100}
kernel:        <ffffffff80145dfe>{__generic_file_aio_read+222} <ffffffff80145fe4>{generic_file_read+116}
kernel:        <ffffffff8026c871>{raw_open+209} <ffffffff8016b562>{chrdev_open+418}
kernel:        <ffffffff8014b940>{file_ra_state_init+32} <ffffffff80160ec1>{dentry_open+289}
kernel:        <ffffffff80163337>{vfs_read+199} <ffffffff801633eb>{sys_pread64+91}
kernel:        <ffffffff8011064a>{system_call+126}
kernel:
kernel: Code: 48 8b 40 20 48 85 c0 74 04 ff d0 eb 1c 48 83 c4 08 66 66 90
kernel: RIP <ffffffff801499ba>{set_page_dirty+42} RSP <000001003b6e3bc8>

