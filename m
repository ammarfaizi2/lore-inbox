Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265643AbUAMU7S (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Jan 2004 15:59:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265644AbUAMU7S
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Jan 2004 15:59:18 -0500
Received: from spoetnik.kulnet.kuleuven.ac.be ([134.58.240.46]:10903 "EHLO
	spoetnik.kulnet.kuleuven.ac.be") by vger.kernel.org with ESMTP
	id S265643AbUAMU7H (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Jan 2004 15:59:07 -0500
Date: Tue, 13 Jan 2004 21:58:57 +0100
From: Bastiaan Van Eeckhoudt <bastiaanve@gmx.net>
To: linux-kernel@vger.kernel.org
Subject: oops when using neofb framebuffer driver on 2.6.1
Message-Id: <20040113215857.713ef029.bastiaanve@gmx.net>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I'm getting the following oops when I use the neofb framebuffer driver.
It is triggered by generating a lot of text on the console, like cat'ing
big text files.
I'm using the 2.6.1 kernel on a Dell Latitude CP233.
It has the following VGA controller:
00:02.0 VGA compatible controller: Neomagic Corporation NM2160
[MagicGraph 128XD]
I didn't have this problem with 2.4 kernels.

Jan 13 20:25:42 narco kernel: Unable to handle kernel paging
request<1>Unable to handle kernel paging request at virtual address
c8c081c0
Jan 13 20:25:42 narco kernel:  printing eip:
Jan 13 20:25:42 narco kernel: c02211fd
Jan 13 20:25:42 narco kernel: *pde = 011e3067
Jan 13 20:25:42 narco kernel: *pte = 00000000
Jan 13 20:25:42 narco kernel: Oops: 0002 [#1]
Jan 13 20:25:42 narco kernel: CPU:    0
Jan 13 20:25:42 narco kernel: EIP:    0060:[cfb_imageblit+973/1616]   
Not tainted
Jan 13 20:25:42 narco kernel: EFLAGS: 00010246
Jan 13 20:25:42 narco kernel: EIP is at cfb_imageblit+0x3cd/0x650
Jan 13 20:25:42 narco kernel: eax: 00000000   ebx: c8c081c0   ecx:
00000000   edx: 00000000
Jan 13 20:25:42 narco kernel: esi: 00000004   edi: c11ce224   ebp:
00000001   esp: c6fd9a30
Jan 13 20:25:42 narco kernel: ds: 007b   es: 007b   ss: 0068
Jan 13 20:25:42 narco kernel: Process cat (pid: 499, threadinfo=c6fd8000
task=c7341960)
Jan 13 20:25:42 narco kernel: Stack: 0000004b 0000004b c1192560 00000000
00000000 00000000 00000000 c1189200 
Jan 13 20:25:42 narco kernel:        c12fe5b0 c1188f70 00000000 00000001
c018b9eb c7c4b3c4 c12fe5b0 00000000 
Jan 13 20:25:42 narco kernel:        00000000 00000000 c7efecc0 c0300620
c11ce224 07070707 0000000f 00000026 
Jan 13 20:25:42 narco kernel: Call Trace:
Jan 13 20:25:42 narco kernel:  [do_get_write_access+699/1456]
do_get_write_access+0x2bb/0x5b0
Jan 13 20:25:42 narco kernel:  [putcs_aligned+341/448]
putcs_aligned+0x155/0x1c0
Jan 13 20:25:42 narco kernel:  [accel_putcs+147/192]
accel_putcs+0x93/0xc0
Jan 13 20:25:42 narco kernel:  [__alloc_pages+151/768]
__alloc_pages+0x97/0x300
Jan 13 20:25:42 narco kernel:  [fbcon_putcs+119/128]
fbcon_putcs+0x77/0x80
Jan 13 20:25:42 narco kernel:  [vt_console_print+610/784]
vt_console_print+0x262/0x310
Jan 13 20:25:42 narco kernel:  [__call_console_drivers+77/96]
__call_console_drivers+0x4d/0x60
Jan 13 20:25:42 narco kernel:  [call_console_drivers+92/256]
call_console_drivers+0x5c/0x100
Jan 13 20:25:42 narco kernel:  [release_console_sem+80/208]
release_console_sem+0x50/0xd0
Jan 13 20:25:42 narco kernel:  [printk+264/368] printk+0x108/0x170
Jan 13 20:25:42 narco kernel:  [search_exception_tables+36/48]
search_exception_tables+0x24/0x30
Jan 13 20:25:42 narco kernel:  [bitfill32+93/208] bitfill32+0x5d/0xd0
Jan 13 20:25:42 narco kernel:  [do_page_fault+359/1308]
do_page_fault+0x167/0x51c
Jan 13 20:25:42 narco kernel:  [do_softirq+147/160] do_softirq+0x93/0xa0
Jan 13 20:25:42 narco kernel:  [do_IRQ+277/336] do_IRQ+0x115/0x150
Jan 13 20:25:42 narco kernel:  [common_interrupt+24/32]
common_interrupt+0x18/0x20
Jan 13 20:25:42 narco kernel:  [cfb_imageblit+1598/1616]
cfb_imageblit+0x63e/0x650
Jan 13 20:25:42 narco kernel:  [cfb_imageblit+1598/1616]
cfb_imageblit+0x63e/0x650
Jan 13 20:25:42 narco kernel:  [do_page_fault+0/1308]
do_page_fault+0x0/0x51c
Jan 13 20:25:42 narco kernel:  [error_code+45/64] error_code+0x2d/0x40
Jan 13 20:25:42 narco kernel:  [bitfill32+93/208] bitfill32+0x5d/0xd0
Jan 13 20:25:42 narco kernel:  [cfb_fillrect+379/768]
cfb_fillrect+0x17b/0x300
Jan 13 20:25:42 narco kernel:  [soft_cursor+347/496]
soft_cursor+0x15b/0x1f0
Jan 13 20:25:42 narco kernel:  [bitfill32+0/208] bitfill32+0x0/0xd0
Jan 13 20:25:42 narco kernel:  [accel_clear_margins+194/272]
accel_clear_margins+0xc2/0x110
Jan 13 20:25:42 narco kernel:  [fbcon_scroll+1976/2768]
fbcon_scroll+0x7b8/0xad0
Jan 13 20:25:42 narco kernel:  [scrup+274/304] scrup+0x112/0x130
Jan 13 20:25:42 narco kernel:  [lf+86/96] lf+0x56/0x60
Jan 13 20:25:42 narco kernel:  [do_con_trol+2859/3328]
do_con_trol+0xb2b/0xd00
Jan 13 20:25:42 narco kernel:  [do_con_write+1082/1840]
do_con_write+0x43a/0x730
Jan 13 20:25:42 narco kernel:  [con_put_char+51/64]
con_put_char+0x33/0x40
Jan 13 20:25:42 narco kernel:  [opost+146/400] opost+0x92/0x190
Jan 13 20:25:42 narco kernel:  [write_chan+429/528]
write_chan+0x1ad/0x210
Jan 13 20:25:42 narco kernel:  [default_wake_function+0/32]
default_wake_function+0x0/0x20
Jan 13 20:25:42 narco kernel:  [default_wake_function+0/32]
default_wake_function+0x0/0x20
Jan 13 20:25:42 narco kernel:  [tty_write+438/624] tty_write+0x1b6/0x270
Jan 13 20:25:42 narco kernel:  [write_chan+0/528] write_chan+0x0/0x210
Jan 13 20:25:42 narco kernel:  [vfs_write+140/208] vfs_write+0x8c/0xd0
Jan 13 20:25:42 narco kernel:  [sys_write+45/80] sys_write+0x2d/0x50
Jan 13 20:25:42 narco kernel:  [syscall_call+7/11] syscall_call+0x7/0xb
Jan 13 20:25:42 narco kernel: 
Jan 13 20:25:42 narco kernel: Code: 89 03 83 c3 04 85 f6 75 06 be 08 00
00 00 47 8b 4c 24 04 49 

Greetings,

Bastiaan

-- 
Bastiaan Van Eeckhoudt
bastiaan[at]vaneeckhoudt[dot]net
