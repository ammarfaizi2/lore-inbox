Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263445AbTC2RSZ>; Sat, 29 Mar 2003 12:18:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263446AbTC2RSZ>; Sat, 29 Mar 2003 12:18:25 -0500
Received: from franka.aracnet.com ([216.99.193.44]:37029 "EHLO
	franka.aracnet.com") by vger.kernel.org with ESMTP
	id <S263445AbTC2RST>; Sat, 29 Mar 2003 12:18:19 -0500
Date: Sat, 29 Mar 2003 09:29:28 -0800
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: [Bug 518] New: unable to handle kernel paging request
Message-ID: <59900000.1048958968@[10.10.2.4]>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

http://bugme.osdl.org/show_bug.cgi?id=518

           Summary: unable to handle kernel paging request
    Kernel Version: 2.5.66
            Status: NEW
          Severity: normal
             Owner: jsimmons@infradead.org
         Submitter: jochen@jochen.org


Distribution: Debain sarge
Hardware Environment: IBM Thinkpad 600

Problem Description:

A couple of minutes after boot the machine hangs,  Num Lock toggles,
but the machine is not responsive anymore.

This is from the syslog:

Mar 29 17:28:48 gswi1164 kernel: Linux agpgart interface v0.100 (c) Dave Jones
Mar 29 17:30:56 gswi1164 kernel:  printing eip:
Mar 29 17:30:56 gswi1164 kernel: c02630a6
Mar 29 17:30:56 gswi1164 kernel: Oops: 0002 [#1]
Mar 29 17:30:56 gswi1164 kernel: CPU:    0
Mar 29 17:30:56 gswi1164 kernel: EIP:    0060:[cfb_imageblit+630/1680]    Not tainted
Mar 29 17:30:56 gswi1164 kernel: EFLAGS: 00010246
Mar 29 17:30:56 gswi1164 kernel: EIP is at cfb_imageblit+0x276/0x690
Mar 29 17:30:56 gswi1164 kernel: eax: c6c0e000   ebx: 00000000   ecx: c6c0e004   edx: c03b99b8
Mar 29 17:30:56 gswi1164 kernel: esi: c5fb20a0   edi: 0000004b   ebp: c4753a3c   esp: c475396c
Mar 29 17:30:56 gswi1164 kernel: ds: 007b   es: 007b   ss: 0068
Mar 29 17:30:56 gswi1164 kernel: Process bash (pid: 936, threadinfo=c4752000 task=c57d20c0)
Mar 29 17:30:56 gswi1164 kernel: Stack: c6c0e000 c034f704 0000011d c5fb20c6 ffffffff 00000026 00000010 07070707
Mar 29 17:30:56 gswi1164 kernel:        c5e71924 c5e82a0c c5e71f64 0000000e c5fb20c6 c47539b8 c02378c3 c5e71f64
Mar 29 17:30:56 gswi1164 kernel:        c5e82a0c 00000010 c5e82a0c c47539e0 c023809d c5e82a0c c5e71f64 00000000
Mar 29 17:30:56 gswi1164 kernel: Call Trace:
Mar 29 17:30:56 gswi1164 kernel:  [deadline_add_drq_rb+59/84] deadline_add_drq_rb+0x3b/0x54
Mar 29 17:30:56 gswi1164 kernel:  [deadline_insert_request+245/296] deadline_insert_request+0xf5/0x128
Mar 29 17:30:56 gswi1164 kernel:  [__make_request+931/1108] __make_request+0x3a3/0x454
Mar 29 17:30:56 gswi1164 kernel:  [neofb_imageblit+41/48] neofb_imageblit+0x29/0x30
Mar 29 17:30:56 gswi1164 kernel:  [putcs_aligned+312/364] putcs_aligned+0x138/0x16c
Mar 29 17:30:56 gswi1164 kernel:  [accel_putcs+140/184] accel_putcs+0x8c/0xb8
Mar 29 17:30:56 gswi1164 kernel:  [fbcon_putcs+119/132] fbcon_putcs+0x77/0x84
Mar 29 17:30:56 gswi1164 kernel:  [vt_console_print+619/708] vt_console_print+0x26b/0x2c4
Mar 29 17:30:56 gswi1164 kernel:  [__call_console_drivers+59/80] __call_console_drivers+0x3b/0x50
Mar 29 17:30:56 gswi1164 kernel:  [_call_console_drivers+80/88] _call_console_drivers+0x50/0x58
Mar 29 17:30:56 gswi1164 kernel:  [call_console_drivers+220/232] call_console_drivers+0xdc/0xe8
Mar 29 17:30:56 gswi1164 kernel:  [release_console_sem+91/208] release_console_sem+0x5b/0xd0
Mar 29 17:30:56 gswi1164 kernel:  [printk+295/344] printk+0x127/0x158
Mar 29 17:30:56 gswi1164 kernel:  [do_page_fault+603/1038] do_page_fault+0x25b/0x40e
Mar 29 17:30:56 gswi1164 kernel:  [do_page_fault+0/1038] do_page_fault+0x0/0x40e
Mar 29 17:30:56 gswi1164 kernel:  [do_timer+77/212] do_timer+0x4d/0xd4
Mar 29 17:30:56 gswi1164 kernel:  [timer_interrupt+92/332] timer_interrupt+0x5c/0x14c
Mar 29 17:30:56 gswi1164 kernel:  [cfb_imageblit+624/1680] cfb_imageblit+0x270/0x690
Mar 29 17:30:56 gswi1164 kernel:  [error_code+45/56] error_code+0x2d/0x38
Mar 29 17:30:56 gswi1164 kernel:  [bitfill32+153/480] bitfill32+0x99/0x1e0
Mar 29 17:30:56 gswi1164 kernel:  [bitfill32+0/480] bitfill32+0x0/0x1e0
Mar 29 17:30:56 gswi1164 kernel:  [cfb_fillrect+384/656] cfb_fillrect+0x180/0x290
Mar 29 17:30:56 gswi1164 kernel:  [neofb_imageblit+41/48] neofb_imageblit+0x29/0x30
Mar 29 17:30:56 gswi1164 kernel:  [putcs_aligned+312/364] putcs_aligned+0x138/0x16c
Mar 29 17:30:56 gswi1164 kernel:  [neofb_fillrect+41/48] neofb_fillrect+0x29/0x30
Mar 29 17:30:56 gswi1164 kernel:  [accel_clear+122/132] accel_clear+0x7a/0x84
Mar 29 17:30:56 gswi1164 kernel:  [fbcon_clear+276/288] fbcon_clear+0x114/0x120
Mar 29 17:30:56 gswi1164 kernel:  [fbcon_scroll+1876/2452] fbcon_scroll+0x754/0x994
Mar 29 17:30:56 gswi1164 kernel:  [scrup+113/264] scrup+0x71/0x108
Mar 29 17:30:56 gswi1164 kernel:  [lf+51/100] lf+0x33/0x64
Mar 29 17:30:56 gswi1164 kernel:  [do_con_trol+373/3620] do_con_trol+0x175/0xe24
Mar 29 17:30:56 gswi1164 kernel:  [do_con_write+1442/1624] do_con_write+0x5a2/0x658
Mar 29 17:30:56 gswi1164 kernel:  [con_put_char+45/52] con_put_char+0x2d/0x34
Mar 29 17:30:56 gswi1164 kernel:  [opost+406/420] opost+0x196/0x1a4
Mar 29 17:30:56 gswi1164 kernel:  [write_chan+309/500] write_chan+0x135/0x1f4
Mar 29 17:30:56 gswi1164 kernel:  [default_wake_function+0/28] default_wake_function+0x0/0x1c
Mar 29 17:30:56 gswi1164 kernel:  [default_wake_function+0/28] default_wake_function+0x0/0x1c
Mar 29 17:30:56 gswi1164 kernel:  [tty_write+468/648] tty_write+0x1d4/0x288
Mar 29 17:30:56 gswi1164 kernel:  [write_chan+0/500] write_chan+0x0/0x1f4
Mar 29 17:30:56 gswi1164 kernel:  [vfs_write+196/352] vfs_write+0xc4/0x160
Mar 29 17:30:56 gswi1164 kernel:  [sys_write+42/64] sys_write+0x2a/0x40
Mar 29 17:30:56 gswi1164 kernel:  [syscall_call+7/11] syscall_call+0x7/0xb
Mar 29 17:30:56 gswi1164 kernel:
Mar 29 17:30:56 gswi1164 kernel: Code: 89 18 83 c4 0c 83 7d c0 00 75 08 c7 45 c0 08 00 00 00 46 83
Mar 29 17:32:09 gswi1164 kernel:  <1>Unable to handle kernel paging request at virtual address c6c0e000
Mar 29 17:32:09 gswi1164 kernel:  printing eip:
Mar 29 17:32:09 gswi1164 kernel: c0261229
Mar 29 17:32:09 gswi1164 kernel: Oops: 0000 [#2]
Mar 29 17:32:09 gswi1164 kernel: CPU:    0
Mar 29 17:32:09 gswi1164 kernel: EIP:    0060:[bitfill32+153/480]    Not tainted
Mar 29 17:32:09 gswi1164 kernel: EFLAGS: 00010212
Mar 29 17:32:09 gswi1164 kernel: EIP is at bitfill32+0x99/0x1e0
Mar 29 17:32:09 gswi1164 kernel: eax: c6c0e000   ebx: c6c0e000   ecx: 00000000   edx: 00002000
Mar 29 17:32:09 gswi1164 kernel: esi: 00000000   edi: 00002000   ebp: c2d31cf4   esp: c2d31cc4
Mar 29 17:32:09 gswi1164 kernel: ds: 007b   es: 007b   ss: 0068
Mar 29 17:32:09 gswi1164 kernel: Process dmesg (pid: 1285, threadinfo=c2d30000 task=c45aec60)
Mar 29 17:32:09 gswi1164 kernel: Stack: c6c0e000 c034f5a0 00000092 c6c0e000 c034f5a0 00000092 00000000 c0261190
Mar 29 17:32:09 gswi1164 kernel:        00000000 c6c0e000 00000000 ffffffff c2d31d48 c0261bd0 c6c0e000 00000000
Mar 29 17:32:09 gswi1164 kernel:        00000000 00002000 00000000 00000400 00000800 00000007 00000010 c0260949
Mar 29 17:32:09 gswi1164 kernel: Call Trace:
Mar 29 17:32:09 gswi1164 kernel:  [bitfill32+0/480] bitfill32+0x0/0x1e0
Mar 29 17:32:09 gswi1164 kernel:  [cfb_fillrect+384/656] cfb_fillrect+0x180/0x290
Mar 29 17:32:09 gswi1164 kernel:  [neofb_imageblit+41/48] neofb_imageblit+0x29/0x30
Mar 29 17:32:09 gswi1164 kernel:  [putcs_aligned+312/364] putcs_aligned+0x138/0x16c
Mar 29 17:32:09 gswi1164 kernel:  [neofb_fillrect+41/48] neofb_fillrect+0x29/0x30
Mar 29 17:32:09 gswi1164 kernel:  [accel_clear+122/132] accel_clear+0x7a/0x84
Mar 29 17:32:09 gswi1164 kernel:  [fbcon_clear+276/288] fbcon_clear+0x114/0x120
Mar 29 17:32:09 gswi1164 kernel:  [fbcon_scroll+1876/2452] fbcon_scroll+0x754/0x994
Mar 29 17:32:09 gswi1164 kernel:  [scrup+113/264] scrup+0x71/0x108
Mar 29 17:32:09 gswi1164 kernel:  [lf+51/100] lf+0x33/0x64
Mar 29 17:32:09 gswi1164 kernel:  [do_con_trol+373/3620] do_con_trol+0x175/0xe24
Mar 29 17:32:09 gswi1164 kernel:  [do_con_write+1442/1624] do_con_write+0x5a2/0x658
Mar 29 17:32:09 gswi1164 kernel:  [con_put_char+45/52] con_put_char+0x2d/0x34
Mar 29 17:32:09 gswi1164 kernel:  [opost+406/420] opost+0x196/0x1a4
Mar 29 17:32:09 gswi1164 kernel:  [write_chan+309/500] write_chan+0x135/0x1f4
Mar 29 17:32:09 gswi1164 kernel:  [default_wake_function+0/28] default_wake_function+0x0/0x1c
Mar 29 17:32:09 gswi1164 kernel:  [tty_write+468/648] tty_write+0x1d4/0x288
Mar 29 17:32:09 gswi1164 kernel:  [write_chan+0/500] write_chan+0x0/0x1f4
Mar 29 17:32:09 gswi1164 kernel:  [vfs_write+196/352] vfs_write+0xc4/0x160
Mar 29 17:32:09 gswi1164 kernel:  [sys_write+42/64] sys_write+0x2a/0x40
Mar 29 17:32:09 gswi1164 kernel:  [syscall_call+7/11] syscall_call+0x7/0xb
Mar 29 17:32:09 gswi1164 kernel:
Mar 29 17:32:09 gswi1164 kernel: Code: 8b 10 89 f0 31 d0 23 45 fc 31 d0 8b 55 f4 89 02 8b 4d 0c 83
Mar 29 17:32:11 gswi1164 kernel:  <1>Unable to handle kernel paging request at virtual address c6c12000
Mar 29 17:32:11 gswi1164 kernel:  printing eip:
Mar 29 17:32:11 gswi1164 kernel: c0261229
Mar 29 17:32:11 gswi1164 kernel: Oops: 0000 [#3]
Mar 29 17:32:11 gswi1164 kernel: CPU:    0
Mar 29 17:32:11 gswi1164 kernel: EIP:    0060:[bitfill32+153/480]    Not tainted
Mar 29 17:32:11 gswi1164 kernel: EFLAGS: 00010212
Mar 29 17:32:11 gswi1164 kernel: EIP is at bitfill32+0x99/0x1e0
Mar 29 17:32:11 gswi1164 kernel: eax: c6c12000   ebx: c6c12000   ecx: 00000000   edx: 00002000
Mar 29 17:32:11 gswi1164 kernel: esi: 00000000   edi: 00002000   ebp: c5f7bcb0   esp: c5f7bc80
Mar 29 17:32:11 gswi1164 kernel: ds: 007b   es: 007b   ss: 0068
Mar 29 17:32:11 gswi1164 kernel: Process events/0 (pid: 3, threadinfo=c5f7a000 task=c5f8ac60)
Mar 29 17:32:11 gswi1164 kernel: Stack: c6c12000 c034f5a0 00000092 c6c12000 c034f5a0 00000092 00000000 c0261190
Mar 29 17:32:11 gswi1164 kernel:        00000000 c6c12000 00000000 ffffffff c5f7bd04 c0261bd0 c6c12000 00000000
Mar 29 17:32:11 gswi1164 kernel:        00000000 00002000 00000000 00000400 00000810 00000046 00000010 c5f7a000
Mar 29 17:32:11 gswi1164 kernel: Call Trace:
Mar 29 17:32:11 gswi1164 kernel:  [bitfill32+0/480] bitfill32+0x0/0x1e0
Mar 29 17:32:11 gswi1164 kernel:  [cfb_fillrect+384/656] cfb_fillrect+0x180/0x290
Mar 29 17:32:11 gswi1164 kernel:  [do_IRQ+276/304] do_IRQ+0x114/0x130
Mar 29 17:32:11 gswi1164 kernel:  [neofb_fillrect+41/48] neofb_fillrect+0x29/0x30
Mar 29 17:32:11 gswi1164 kernel:  [accel_clear+122/132] accel_clear+0x7a/0x84
Mar 29 17:32:11 gswi1164 kernel:  [fbcon_clear+276/288] fbcon_clear+0x114/0x120
Mar 29 17:32:11 gswi1164 kernel:  [fbcon_scroll+1876/2452] fbcon_scroll+0x754/0x994
Mar 29 17:32:11 gswi1164 kernel:  [scrup+113/264] scrup+0x71/0x108
Mar 29 17:32:11 gswi1164 kernel:  [lf+51/100] lf+0x33/0x64
Mar 29 17:32:11 gswi1164 kernel:  [do_con_trol+373/3620] do_con_trol+0x175/0xe24
Mar 29 17:32:11 gswi1164 kernel:  [do_con_write+1442/1624] do_con_write+0x5a2/0x658
Mar 29 17:32:11 gswi1164 kernel:  [con_put_char+45/52] con_put_char+0x2d/0x34
Mar 29 17:32:11 gswi1164 kernel:  [opost+406/420] opost+0x196/0x1a4
Mar 29 17:32:11 gswi1164 kernel:  [n_tty_receive_buf+1904/4188] n_tty_receive_buf+0x770/0x105c
Mar 29 17:32:11 gswi1164 kernel:  [accel_cursor+729/740] accel_cursor+0x2d9/0x2e4
Mar 29 17:32:11 gswi1164 kernel:  [__wake_up_locked+14/20] __wake_up_locked+0xe/0x14
Mar 29 17:32:11 gswi1164 kernel:  [console_callback+0/184] console_callback+0x0/0xb8
Mar 29 17:32:11 gswi1164 kernel:  [fb_callback+0/140] fb_callback+0x0/0x8c
Mar 29 17:32:11 gswi1164 kernel:  [mod_timer+246/340] mod_timer+0xf6/0x154
Mar 29 17:32:11 gswi1164 kernel:  [flush_to_ldisc+227/240] flush_to_ldisc+0xe3/0xf0
Mar 29 17:32:11 gswi1164 kernel:  [flush_to_ldisc+0/240] flush_to_ldisc+0x0/0xf0
Mar 29 17:32:11 gswi1164 kernel:  [worker_thread+411/616] worker_thread+0x19b/0x268
Mar 29 17:32:11 gswi1164 kernel:  [worker_thread+0/616] worker_thread+0x0/0x268
Mar 29 17:32:11 gswi1164 kernel:  [default_wake_function+0/28] default_wake_function+0x0/0x1c
Mar 29 17:32:11 gswi1164 kernel:  [kernel_thread_helper+5/12] kernel_thread_helper+0x5/0xc
Mar 29 17:32:11 gswi1164 kernel:
Mar 29 17:32:11 gswi1164 kernel: Code: 8b 10 89 f0 31 d0 23 45 fc 31 d0 8b 55 f4 89 02 8b 4d 0c 83

This is with Jack Simmons fbdev patch for the illegal context applied.
I also run the following USB patch:

--- 1.15/drivers/usb/core/urb.c Thu Mar 13 10:45:40 2003
+++ edited/drivers/usb/core/urb.c       Thu Mar 20 11:17:55 2003
@@ -384,11 +384,11 @@
        /* FIXME
         * We should not care about the state here, but the host controllers
         * die a horrible death if we unlink a urb for a device that has been
-        * physically removed.
+        * physically removed.  (after driver->disconnect returns...)
         */
        if (urb &&
            urb->dev &&
-           (urb->dev->state >= USB_STATE_DEFAULT) &&
+           // (urb->dev->state >= USB_STATE_DEFAULT) &&
            urb->dev->bus &&
            urb->dev->bus->op)
                return urb->dev->bus->op->unlink_urb(urb);

