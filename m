Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264331AbTCYXfC>; Tue, 25 Mar 2003 18:35:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264333AbTCYXfC>; Tue, 25 Mar 2003 18:35:02 -0500
Received: from ma-northadams1a-382.bur.adelphia.net ([24.52.175.126]:27800
	"EHLO ma-northadams1a-382.bur.adelphia.net") by vger.kernel.org
	with ESMTP id <S264331AbTCYXfB>; Tue, 25 Mar 2003 18:35:01 -0500
Date: Tue, 25 Mar 2003 18:46:02 -0500
From: Eric Buddington <eric@ma-northadams1a-382.bur.adelphia.net>
To: linux-kernel@vger.kernel.org
Subject: 2.5.66: BUG at drivers/usb/storage/usb.c:972
Message-ID: <20030325184602.G17703@ma-northadams1a-382.bur.adelphia.net>
Reply-To: ebuddington@wesleyan.edu
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Organization: ECS Labs
X-Eric-Conspiracy: there is no conspiracy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

AMD K6-250
Linux 2.5.66
NEC CD burner in an external IDE->USB case
NEC USB 2.0 PCI card

When powering on the CD burner, I got the following message (not known
to be repeatable). I'm assuming that ksymoops is unnecessary since the
stack seems to be already decoded.

-Eric

-------------------------------------------------------------------
usb-storage: *** thread awakened.
usb-storage: Command WRITE_10 (10 bytes)
usb-storage:  2a 00 00 00 4c d4 00 00 17 00
usb-storage: Bulk command S 0x43425355 T 0x18e3e Trg 0 LUN 0 L 56304 F 0 CL 10
usb-storage: usb_stor_bulk_transfer_buf(): xfer 31 bytes
usb-storage: Status code -19; transferred 0/31
usb-storage: -- unknown error
usb-storage: Bulk command transfer result=3
usb-storage: -- transport indicates error, resetting
usb-storage: Bulk reset requested
usb-storage: Soft reset failed: -19
usb-storage: scsi cmd done, result=0x70000
usb-storage: *** thread sleeping.
usb-storage: storage_disconnect() called
SCSI device not inactive - rq_status=0, target=0, pid=101949, state=4106, owner=
260.
drivers/scsi/hosts.c:245: spin_is_locked on uninitialized spinlock c6a8c528.
drivers/scsi/scsi.c:326: spin_lock(drivers/scsi/scsi_scan.c:c6a7903c) already lo
cked by drivers/scsi/hosts.c/215
Device busy???
usb-storage: -- SCSI refused to unregister
------------[ cut here ]------------
kernel BUG at drivers/usb/storage/usb.c:972!
invalid operand: 0000 [#1]
CPU:    0
EIP:    0060:[<c89e111d>]    Not tainted
EFLAGS: 00010246
EIP is at storage_disconnect+0x17d/0x305 [usb_storage]
eax: 0000002e   ebx: c6a8c4e4   ecx: 00000000   edx: 063e0a15
esi: c6a79200   edi: c7206094   ebp: c70fbec4   esp: c70fbeb8
ds: 007b   es: 007b   ss: 0068
Process khubd (pid: 72, threadinfo=c70fa000 task=c7646660)
Stack: c89eb5e0 c89f73fc c89f7360 c70fbee0 c899b2a6 c7206094 00000001 c72060ac 
       c89f7378 c75814e4 c70fbef4 c0248fcb c72060ac c89b9260 c72060ac c70fbf08 
       c02490e5 c72060ac c03a8400 c72060ac c70fbf28 c0248672 c72060ac c72060ac 
Call Trace:
 [<c89eb5e0>] +0x1e60/0x6a7c [usb_storage]
 [<c89f73fc>] usb_storage_driver+0x9c/0xc4 [usb_storage]
 [<c89f7360>] usb_storage_driver+0x0/0xc4 [usb_storage]
 [<c899b2a6>] usb_device_remove+0x116/0x154 [usbcore]
 [<c89f7378>] usb_storage_driver+0x18/0xc4 [usb_storage]
 [<c0248fcb>] device_release_driver+0x57/0x5c
 [<c89b9260>] usb_bus_type+0x40/0x100 [usbcore]
 [<c02490e5>] bus_remove_device+0x55/0x8c
 [<c0248672>] device_del+0x66/0x98
 [<c02486b1>] device_unregister+0xd/0x1a
 [<c899bc26>] usb_disconnect+0xa2/0x118 [usbcore]
 [<c89abe41>] +0x659/0xcb8 [usbcore]
 [<c899eaed>] usb_hub_port_connect_change+0x319/0x320 [usbcore]
 [<c899eeba>] usb_hub_events+0x3c6/0x524 [usbcore]
 [<c899f045>] usb_hub_thread+0x2d/0xe4 [usbcore]
 [<c011c7a0>] default_wake_function+0x0/0x14
 [<c89b9398>] khubd_wait+0x18/0x20 [usbcore]
 [<c89b9398>] khubd_wait+0x18/0x20 [usbcore]
 [<c899f018>] usb_hub_thread+0x0/0xe4 [usbcore]
 [<c0107179>] kernel_thread_helper+0x5/0xc

Code: 0f 0b cc 03 46 09 9f c8 8d 65 f8 5b 5e c9 c3 ff b6 c0 00 00 
