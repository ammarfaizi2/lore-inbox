Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271027AbTGPRrp (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Jul 2003 13:47:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270965AbTGPRrO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Jul 2003 13:47:14 -0400
Received: from hueytecuilhuitl.mtu.ru ([195.34.32.123]:57618 "EHLO
	hueymiccailhuitl.mtu.ru") by vger.kernel.org with ESMTP
	id S271001AbTGPRpn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Jul 2003 13:45:43 -0400
From: Andrey Borzenkov <arvidjaar@mail.ru>
To: linux-kernel@vger.kernel.org
Subject: 2.6.0-test1 - CRC errors on floppy block the whole system
Date: Wed, 16 Jul 2003 21:59:15 +0400
User-Agent: KMail/1.5
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200307162159.16021.arvidjaar@mail.ru>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Under KDE I went into floppy and made rm *. After this keyboard was lost - 
even CAPS LED did not respond to keypress. I stil could use mouse to start 
new windows and even execute some commands by copy'n'paste from available 
text :)

Attempt to exit KDE ended in black screen. I had to press reset; after that 
the following text was found in syslog (slightly abridged, it had much more 
those "floppy driver state"s).

Floppies are not that robust, everyone knows it. It is rather unfriendly to 
handle media errors in such manner :)

-andrey

Jul 16 21:31:01 localhost kernel: floppy0: data CRC error: track 0, head 0, 
sector 6, size 2
Jul 16 21:31:01 localhost kernel: end_request: I/O error, dev fd0, sector 5
Jul 16 21:31:01 localhost kernel: Unable to handle kernel paging request at 
virtual address cc623048
Jul 16 21:31:01 localhost kernel: printing eip:
Jul 16 21:31:01 localhost kernel: d2d18494
Jul 16 21:31:01 localhost kernel: *pde = 00032067
Jul 16 21:31:01 localhost kernel: *pte = 0c623000
Jul 16 21:31:01 localhost kernel: Oops: 0000 [#1]
Jul 16 21:31:01 localhost kernel: CPU:    0
Jul 16 21:31:01 localhost kernel: EIP:    0060:[<d2d18494>]    Tainted: P  
Jul 16 21:31:01 localhost kernel: EFLAGS: 00010246
Jul 16 21:31:01 localhost kernel: EIP is at bad_flp_intr+0x64/0x100 [floppy]
Jul 16 21:31:01 localhost kernel: eax: 00000000   ebx: 00000000   ecx: 
00000000   edx: 00000000
Jul 16 21:31:01 localhost kernel: esi: 00000000   edi: cc623048   ebp: 
cff5df38   esp: cff5df28
Jul 16 21:31:01 localhost kernel: ds: 007b   es: 007b   ss: 0068
Jul 16 21:31:01 localhost kernel: Process events/0 (pid: 4, 
threadinfo=cff5c000 task=c12c1000)
Jul 16 21:31:01 localhost kernel: Stack: 0000001f 0000001f 00000000 00000000 
cff5df60 d2d18e65 00000000 00000000 
Jul 16 21:31:01 localhost kernel: 00000002 00000000 00000000 d2d22be4 cff5c000 
00000000 cff5df6c d2d15ff4 
Jul 16 21:31:01 localhost kernel: d2d22c20 cff5dfec c0137cb2 00000000 cffa902c 
cffa901c 00000000 d2d15fe0 
Jul 16 21:31:01 localhost kernel: Call Trace:
Jul 16 21:31:01 localhost kernel: [<d2d18e65>] rw_interrupt+0x2b5/0x390 
[floppy]
Jul 16 21:31:01 localhost kernel: [<d2d15ff4>] 
main_command_interrupt+0x14/0x20 [floppy]
Jul 16 21:31:01 localhost kernel: [<c0137cb2>] worker_thread+0x232/0x3e0
Jul 16 21:31:01 localhost kernel: [<d2d15fe0>] main_command_interrupt+0x0/0x20 
[floppy]
Jul 16 21:31:01 localhost kernel: [<c01205b0>] default_wake_function+0x0/0x20
Jul 16 21:31:01 localhost kernel: [<c010b3d6>] ret_from_fork+0x6/0x20
Jul 16 21:31:01 localhost kernel: [<c01205b0>] default_wake_function+0x0/0x20
Jul 16 21:31:01 localhost kernel: [<c0137a80>] worker_thread+0x0/0x3e0
Jul 16 21:31:01 localhost kernel: [<c0109029>] kernel_thread_helper+0x5/0xc
Jul 16 21:31:01 localhost kernel: 
Jul 16 21:31:01 localhost kernel: Code: 8b 0f 8a 55 f3 8d 04 92 8d 04 42 c1 e0 
03 3b 88 90 36 d2 d2 
Jul 16 21:31:01 localhost kernel: <3>FAT: bread(block 5) in fat_access failed
Jul 16 21:31:21 localhost kernel: 
Jul 16 21:31:21 localhost kernel: floppy driver state
Jul 16 21:31:21 localhost kernel: -------------------
Jul 16 21:31:21 localhost kernel: now=621544 last interrupt=601544 diff=20000 
last called handler=d2d15fe0
Jul 16 21:31:21 localhost kernel: timeout_message=request done %d
Jul 16 21:31:21 localhost kernel: last output bytes:
Jul 16 21:31:21 localhost kernel: 0 90 601346
Jul 16 21:31:21 localhost kernel: 13 90 601346
Jul 16 21:31:21 localhost kernel: 0 90 601346
Jul 16 21:31:21 localhost kernel: 1a 90 601346
Jul 16 21:31:21 localhost kernel: 0 90 601346
Jul 16 21:31:21 localhost kernel: 3 90 601346
Jul 16 21:31:21 localhost kernel: c1 90 601346
Jul 16 21:31:21 localhost kernel: 10 90 601346
Jul 16 21:31:21 localhost kernel: 7 80 601346
Jul 16 21:31:21 localhost kernel: 0 90 601346
Jul 16 21:31:21 localhost kernel: 8 81 601347
Jul 16 21:31:21 localhost kernel: e6 80 601347
Jul 16 21:31:21 localhost kernel: 0 90 601347
Jul 16 21:31:21 localhost kernel: 0 90 601347
Jul 16 21:31:21 localhost kernel: 0 90 601347
Jul 16 21:31:21 localhost kernel: 6 90 601347
Jul 16 21:31:21 localhost kernel: 2 90 601347
Jul 16 21:31:21 localhost kernel: 12 90 601347
Jul 16 21:31:21 localhost kernel: 1b 90 601347
Jul 16 21:31:21 localhost kernel: ff 90 601347
Jul 16 21:31:21 localhost kernel: last result at 601544
Jul 16 21:31:21 localhost kernel: last redo_fd_request at 601346
Jul 16 21:31:21 localhost kernel: 40 20 20  0  0  6  2 
Jul 16 21:31:21 localhost kernel: status=80
Jul 16 21:31:21 localhost kernel: fdc_busy=1
Jul 16 21:31:21 localhost kernel: cont=d2d22c80
Jul 16 21:31:21 localhost kernel: current_req=00000000
Jul 16 21:31:21 localhost kernel: command_status=-1
Jul 16 21:31:21 localhost kernel: 
Jul 16 21:31:21 localhost kernel: floppy0: floppy timeout called
Jul 16 21:31:21 localhost kernel: floppy.c: no request in request_done
Jul 16 21:31:24 localhost kernel: 
Jul 16 21:31:24 localhost kernel: floppy driver state
Jul 16 21:31:24 localhost kernel: -------------------
Jul 16 21:31:24 localhost kernel: now=624545 last interrupt=621545 diff=3000 
last called handler=d2d177d0
Jul 16 21:31:24 localhost kernel: timeout_message=redo fd request
Jul 16 21:31:24 localhost kernel: last output bytes:
Jul 16 21:31:24 localhost kernel: 0 90 601346
Jul 16 21:31:24 localhost kernel: 3 90 601346
Jul 16 21:31:24 localhost kernel: c1 90 601346
Jul 16 21:31:24 localhost kernel: 10 90 601346
Jul 16 21:31:24 localhost kernel: 7 80 601346
Jul 16 21:31:24 localhost kernel: 0 90 601346
Jul 16 21:31:24 localhost kernel: 8 81 601347
Jul 16 21:31:24 localhost kernel: e6 80 601347
Jul 16 21:31:24 localhost kernel: 0 90 601347
Jul 16 21:31:24 localhost kernel: 0 90 601347
Jul 16 21:31:24 localhost kernel: 0 90 601347
Jul 16 21:31:24 localhost kernel: 6 90 601347
Jul 16 21:31:24 localhost kernel: 2 90 601347
Jul 16 21:31:24 localhost kernel: 12 90 601347
Jul 16 21:31:24 localhost kernel: 1b 90 601347
Jul 16 21:31:24 localhost kernel: ff 90 601347
Jul 16 21:31:24 localhost kernel: 8 80 621545
Jul 16 21:31:24 localhost kernel: 8 80 621545
Jul 16 21:31:24 localhost kernel: 8 80 621545
Jul 16 21:31:24 localhost kernel: 8 80 621545
Jul 16 21:31:24 localhost kernel: last result at 621545
Jul 16 21:31:24 localhost kernel: last redo_fd_request at 621544
Jul 16 21:31:24 localhost kernel: c3  0 
Jul 16 21:31:24 localhost kernel: status=80
Jul 16 21:31:24 localhost kernel: fdc_busy=1
Jul 16 21:31:24 localhost kernel: floppy_work.func=d2d177d0
Jul 16 21:31:24 localhost kernel: cont=d2d22c80
Jul 16 21:31:24 localhost kernel: current_req=c9b83004
Jul 16 21:31:24 localhost kernel: command_status=-1
Jul 16 21:31:24 localhost kernel: 
Jul 16 21:31:24 localhost kernel: floppy0: floppy timeout called
Jul 16 21:31:24 localhost kernel: end_request: I/O error, dev fd0, sector 19
Jul 16 21:31:24 localhost kernel: Buffer I/O error on device fd0, logical 
block 19
Jul 16 21:31:27 localhost kernel: 
Jul 16 21:31:27 localhost kernel: floppy driver state
Jul 16 21:31:27 localhost kernel: -------------------
Jul 16 21:31:27 localhost kernel: now=627545 last interrupt=624546 diff=2999 
last called handler=d2d177d0

[ ... STRIPPED ... ]

Jul 16 21:33:02 localhost kernel: floppy0: floppy timeout called
Jul 16 21:33:22 localhost kernel: 
Jul 16 21:33:22 localhost kernel: floppy driver state
Jul 16 21:33:22 localhost kernel: -------------------
Jul 16 21:33:22 localhost kernel: now=742567 last interrupt=645548 diff=97019 
last called handler=d2d177d0
Jul 16 21:33:22 localhost kernel: timeout_message=do wakeup
Jul 16 21:33:22 localhost kernel: last output bytes:
Jul 16 21:33:22 localhost kernel: 8 80 633547
Jul 16 21:33:22 localhost kernel: 8 80 633547
Jul 16 21:33:22 localhost kernel: 8 80 633547
Jul 16 21:33:22 localhost kernel: 8 80 633547
Jul 16 21:33:22 localhost kernel: 8 80 636548
Jul 16 21:33:22 localhost kernel: 8 80 636548
Jul 16 21:33:22 localhost kernel: 8 80 636548
Jul 16 21:33:22 localhost kernel: 8 80 636548
Jul 16 21:33:22 localhost kernel: 8 80 639547
Jul 16 21:33:22 localhost kernel: 8 80 639547
Jul 16 21:33:22 localhost kernel: 8 80 639547
Jul 16 21:33:22 localhost kernel: 8 80 639547
Jul 16 21:33:22 localhost kernel: 8 80 642548
Jul 16 21:33:22 localhost kernel: 8 80 642548
Jul 16 21:33:22 localhost kernel: 8 80 642548
kernel: 8 80 642548
kernel: 8 80 645548
kernel: 8 80 645548
kernel: 8 80 645548
kernel: 8 80 645548
kernel: last result at 645548
kernel: last redo_fd_request at 648547
kernel: c3  0 
kernel: status=80
kernel: fdc_busy=1
kernel: floppy_work.func=d2d1a0b0
kernel: cont=d2d22c80
kernel: current_req=00000000
kernel: command_status=-1
kernel: 
kernel: floppy0: floppy timeout called
kernel: floppy.c: no request in request_done
kernel: Debug: sleeping function called from illegal context at mm/slab.c:1811
kernel: Call Trace:
kernel: [<c0122ba8>] __might_sleep+0x58/0x70
kernel: [<c014c75f>] kmem_cache_alloc+0x18f/0x1a0
kernel: [<c015e8e4>] get_vm_area+0x24/0x160
kernel: [<c011e116>] __ioremap+0xa6/0xf0
kernel: [<c011e176>] ioremap_nocache+0x16/0xb0
kernel: [<d2ee9c57>] os_map_kernel_space+0x37/0x60 [nvidia]
kernel: [<d2dcfb97>] __nvsym00517+0x1f/0x2c [nvidia]
kernel: [<d2dd1a6e>] __nvsym00711+0x6e/0xdc [nvidia]
kernel: [<d2dd1afa>] __nvsym00718+0x1e/0x184 [nvidia]
kernel: [<d2dd2b28>] rm_init_adapter+0xc/0x10 [nvidia]
kernel: [<d2ee6db2>] nv_kern_open+0x102/0x210 [nvidia]
kernel: [<c016f17f>] chrdev_open+0x15f/0x350
kernel: [<c01b0d9f>] devfs_open+0x13f/0x160
kernel: [<c0163ce6>] dentry_open+0x156/0x240
kernel: [<c0163b81>] filp_open+0x51/0x60
kernel: [<c016412f>] sys_open+0x3f/0x70
kernel: [<c010b527>] syscall_call+0x7/0xb
kernel: 

