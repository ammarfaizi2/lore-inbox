Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751423AbVKAXGL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751423AbVKAXGL (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Nov 2005 18:06:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751424AbVKAXGL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Nov 2005 18:06:11 -0500
Received: from jack.kinetikon.it ([62.152.125.81]:45742 "EHLO
	mail.towertech.it") by vger.kernel.org with ESMTP id S1751423AbVKAXGK
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Nov 2005 18:06:10 -0500
Date: Wed, 2 Nov 2005 00:06:41 +0100
From: Alessandro Zummo <alessandro.zummo@towertech.it>
To: linux-kernel@vger.kernel.org
Subject: 2.6.14-git4 panic in block layer/usb/usb-storage
Message-ID: <20051102000641.3550bfd6@inspiron>
Organization: Tower Technologies
X-Mailer: Sylpheed
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



 Hello,

  I've just had a panic on my NSLU2 ARM/ixp4xx little-endian
 (patches on http://www.nslu2-linux.org) .

  The panic occurs when the root filesystem
 is being mounted from an usb attached hd.

  I've got it in both 2.6.14-git1 and -git4,
 didn't tested git2 and git3 but I think it doesn't matter :)

 2.6.14 worked perfectly.

  
Waiting 7sec before mounting root device...
  Vendor: HITACHI_  Model: DK23DA-20         Rev:  0 0
  Type:   Direct-Access                      ANSI SCSI revision: 00
SCSI device sda: 39070080 512-byte hdwr sectors (20004 MB)
sda: assuming drive cache: write through
SCSI device sda: 39070080 512-byte hdwr sectors (20004 MB)
sda: assuming drive cache: write through
 sda: sda1 sda2 sda3
Attached scsi disk sda at scsi0, channel 0, id 0, lun 0
kjournald starting.  Commit interval 5 seconds
EXT3-fs: mounted filesystem with ordered data mode.
VFS: Mounted root (ext3 filesystem) readonly.
Freeing init memory: 76K
Unable to handle kernel NULL pointer dereference at virtual address 00000000
pgd = c0004000
[00000000] *pgd=00000000
Internal error: Oops: f5 [#1]
Modules linked in:
CPU: 0
PC is at __wake_up_common+0x28/0x7c
LR is at 0x0
pc : [<c002e4e4>]    lr : [<00000000>]    Not tainted
sp : c024bdac  ip : c024bdd8  fp : c024bdd4
r10: 00000003  r9 : c024bdf0  r8 : 00000000
r7 : c03d24ac  r6 : 00000001  r5 : c0000008  r4 : 00000001
r3 : 00000000  r2 : 00000001  r1 : 00000003  r0 : c0000008
Flags: nzcv  IRQs off  FIQs on  Mode SVC_32  Segment kernel
Control: 397F  Table: 00004000  DAC: 00000017
Process ksoftirqd/0 (pid: 2, stack limit = 0xc024a194)
Stack: (0xc024bdac to 0xc024c000)
bda0:                            00000013 c0279c54 00000001 c03d24ac 00004000
bdc0: 00000000 00000000 c024bdec c024bdd8 c002e564 c002e4c8 c024bdf0 c0215080
bde0: c024be04 c024bdf0 c0046f14 c002e544 c0215080 00000000 c024be18 c024be08
be00: c0050714 c0046ee8 c0277120 c024be34 c024be1c c0096164 c00506d4 c0277120
be20: c00960b0 00000000 c024be4c c024be38 c0077418 c00960bc 00004000 c0277120
be40: c024be7c c024be50 c013c040 c0077394 00000000 c03d24ac c034bcc0 00000001
be60: 00000001 c0280bc4 00004000 00000200 c024be8c c024be80 c013c17c c013bf64
be80: c0240 c024a000 c024bfc4
bfa0: c024bfac c00371d0 c0036c40 c024a000 c0245f50 00000000 c024bff4 c024bfc8
bfc0: c0046958 c003716c 00000001 ffffffff ffffffff 00000000 00000000 00000000
bfe0: 00000000 00000000 00000000 c024bff8 c0034198 c00468d8 d9a4f65d c838adb2
Backtrace:
[<c002e4bc>] (__wake_up_common+0x0/0x7c) from [<c002e564>] (__wake_up+0x2c/0x34)
[<c002e538>] (__wake_up+0x0/0x34) from [<c0046f14>] (__wake_up_bit+0x38/0x3c)
 r4 = C0215080
[<c0046edc>] (__wake_up_bit+0x0/0x3c) from [<c0050714>] (unlock_page+0x4c/0x58)
[<c00506c8>] (unlock_page+0x0/0x58) from [<c0096164>] (mpage_end_io_read+0xb4/0xd0)
 r4 = C0277120
[<c00960b0>] (mpage_end_io_read+0x0/0xd0) from [<c0077418>] (bio_endio+0x90/0x9c)
 r6 = 00000000  r5 = C00960B0  r4 = C0277120
[<c0077388>] (bio_endio+0x0/0x9c) from [<c013c040>] (__end_that_request_first+0xe8/0x1fc)
 r5 = C0277120  r4 = 00004000
[<c013bf58>] (__end_that_request_first+0x0/0x1fc) from [<c013c17c>] (end_that_request_cc0036c78>] (do_softirq+0x44/0x50)
 r8 = FFFFFFFC  r7 = C0037160  r6 = C01D5940  r5 = 00000000
 r4 = 60000013
[<c0036c34>] (do_softirq+0x0/0x50) from [<c00371d0>] (ksoftirqd+0x70/0xb8)
 r4 = C024A000
[<c0037160>] (ksoftirqd+0x0/0xb8) from [<c0046958>] (kthread+0x8c/0xb8)
 r6 = 00000000  r5 = C0245F50  r4 = C024A000
[<c00468cc>] (kthread+0x0/0xb8) from [<c0034198>] (do_exit+0x0/0x408)
 r8 = 00000000  r7 = 00000000  r6 = 00000000  r5 = 00000000
 r4 = 00000000
Code: e15e0000 e1a04002 e1a08003 e59b9004 (e59e7000)
 <0>Kernel panic - not syncing: Aiee, killing interrupt handler!

-- 

 Best regards,

 Alessandro Zummo,
  Tower Technologies - Turin, Italy

  http://www.towertech.it

