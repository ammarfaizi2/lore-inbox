Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261270AbVCNHxf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261270AbVCNHxf (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Mar 2005 02:53:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261293AbVCNHxf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Mar 2005 02:53:35 -0500
Received: from kishna.firstlight.net ([63.80.208.5]:43214 "EHLO
	kishna.firstlight.net") by vger.kernel.org with ESMTP
	id S261270AbVCNHx0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Mar 2005 02:53:26 -0500
Date: Sun, 13 Mar 2005 23:53:23 -0800 (PST)
From: Neil Whelchel <koyama@firstlight.net>
To: linux-kernel@vger.kernel.org
Subject: Crash V4L + SATA ?
Message-ID: <Pine.LNX.4.44.0503132335170.810-100000@kishna.firstlight.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,
I have ran into a crash that seems to occur when I use my BT848 card along
with a Promise TX4 SATA card. (I have not been able to reproduce the crash
when I don't use the drives that are attached to the TX4 card.)
The BT848 and the TX4 are the only add-on cards attached to the system
which is a VIA VT8377 / VT8237 based Athlon board. I have had similar
crashes since 2.6.8 (maybe even before), I am currently using 2.6.11.2
with RAID 5 on six drives. (Four on the TX4 and two more on the built-in
controller on the MB.)
Every crash that I am aware of occurs between 30 seconds and 2 minutes
after I see the following lines in the kernel message buffer.

bttv0: OCERR @ 0c0d3014,bits: HSYNC OFLOW OCERR*
ata3: status=0x51 { DriveReady SeekComplete Error }
ata3: error=0x40 { UncorrectableError }
bttv0: OCERR @ 0c0d3014,bits: HSYNC OFLOW OCERR*


Unable to handle kernel paging request at virtual address 10101010
 printing eip:
d0a816f6
*pde = 00000000
Oops: 0000 [#1]
PREEMPT
Modules linked in: bttv video_buf firmware_class btcx_risc tveeprom
CPU:    0
EIP:    0060:[<d0a816f6>]    Not tainted VLI
EFLAGS: 00210202   (2.6.11.2)
EIP is at videobuf_dma_free+0x36/0xf0 [video_buf]
eax: 00000000   ebx: c97bf000   ecx: 00000208   edx: 10101010
esi: 00000000   edi: cc63ed04   ebp: d0ac7e60   esp: c328bbec
ds: 007b   es: 007b   ss: 0068
Process mythbackend (pid: 1232, threadinfo=c328a000 task=cf1aa550)
Stack: d0ac7e60 d0a81670 c3ef8000 cc63ed04 cc63ece0 d0ac7e60 d0ab6630 cc63ed04
       cc63ed04 00000000 cc63ece0 00000000 cc63ca00 d0aaee44 d0ac7e60 cc63ece0
       00000001 000001e0 000001e0 00000004 cc63ca00 cc63e7e0 c1384a20 00000008
Call Trace:
 [<d0a81670>] videobuf_dma_pci_unmap+0x30/0x80 [video_buf]
 [<d0ab6630>] bttv_dma_free+0x60/0xa0 [bttv]
 [<d0aaee44>] bttv_do_ioctl+0x1214/0x1790 [bttv]
 [<c01156dc>] recalc_task_prio+0x8c/0x160
 [<c0115814>] activate_task+0x64/0x80
 [<c01156dc>] recalc_task_prio+0x8c/0x160
 [<c0115814>] activate_task+0x64/0x80
 [<c011590a>] try_to_wake_up+0x8a/0xc0
 [<c0116478>] __wake_up_common+0x38/0x60
 [<c01164f5>] __wake_up+0x55/0x80
 [<c01230d2>] del_timer+0x92/0xc0
 [<c041706b>] svc_sock_enqueue+0x14b/0x2d0
 [<c02d7943>] scsi_delete_timer+0x13/0x30
 [<c02d4f40>] scsi_done+0x10/0x30
 [<c02e46bb>] ata_scsi_qc_complete+0x2b/0x50
 [<c01156dc>] recalc_task_prio+0x8c/0x160
 [<c0115814>] activate_task+0x64/0x80
 [<c011590a>] try_to_wake_up+0x8a/0xc0
 [<c01156dc>] recalc_task_prio+0x8c/0x160
 [<c0115814>] activate_task+0x64/0x80
 [<c011590a>] try_to_wake_up+0x8a/0xc0
 [<c0116478>] __wake_up_common+0x38/0x60
 [<c01156dc>] recalc_task_prio+0x8c/0x160
 [<c0225db6>] copy_from_user+0x46/0x80
 [<c02add66>] video_usercopy+0xf6/0x170
 [<c0116478>] __wake_up_common+0x38/0x60
 [<c01164f5>] __wake_up+0x55/0x80
 [<c01156dc>] recalc_task_prio+0x8c/0x160
 [<c010e470>] mark_offset_tsc+0x270/0x370
 [<d0aaf3fb>] bttv_ioctl+0x3b/0x60 [bttv]
 [<d0aadc30>] bttv_do_ioctl+0x0/0x1790 [bttv]
 [<c016c7d0>] do_ioctl+0x70/0xb0
 [<c016ca25>] vfs_ioctl+0x65/0x200
 [<c0159a99>] fget_light+0x89/0xa0
 [<c016cc05>] sys_ioctl+0x45/0x70
 [<c010330f>] syscall_call+0x7/0xb
Code: 07 3d 12 11 72 19 0f 85 aa 00 00 00 8b 47 18 85 c0 0f 85 92 00 00 00
8b 5f 08 85 db 74 3f 8b 4f 1c 31 f6 83 f9 00 7e 26 8b 14 b3 <8b> 02 f6 c4
08 75 17 8b 42 04 40 74 67 83 42 04 ff 0f 98 c0 84


Any ideas or suggestions would be greatly appreciated.
-Neil Whelchel-
First Light Internet Services
760 366-0145
- We don't do Window$, that's what the janitor is for -

Bubble Memory, n.:
        A derogatory term, usually referring to a person's
intelligence.  See also "vacuum tube".

