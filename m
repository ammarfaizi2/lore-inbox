Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263329AbTJLQiN (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 12 Oct 2003 12:38:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263479AbTJLQiN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 12 Oct 2003 12:38:13 -0400
Received: from smtp.terra.es ([213.4.129.129]:32652 "EHLO tsmtp3.ldap.isp")
	by vger.kernel.org with ESMTP id S263329AbTJLQiK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 12 Oct 2003 12:38:10 -0400
Message-ID: <006f01c390e8$abdf33d0$d3481850@azorw2k>
From: "Dailos Franchy Gil" <dalas@terra.es>
To: <linux-kernel@vger.kernel.org>
Subject: Data loss, maybe related with "slab error"?
Date: Sun, 12 Oct 2003 17:45:47 -0000
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.50.4522.1200
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4522.1200
X-GPGRelay-Relayed: GPGrelay Version 0.82 (Win32)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I've read the "slab corruption of hpsb..." thread (John Mock,
Oct 10 2003) and the Alastair Tse's bugreport in
http://bugme.osdl.org/show_bug.cgi?id=1258, but not sure if
related.

Running 2.6.0-test7, too. I have lost most of the directories
from /home/me (ext3). When the loss happened, I was probably
running at least two downloading programs, compiling and
testing the camera driver. The problem seems to be related
with the "slab error" messages, since the two only errors in
my logs appear approx. at the same time the loss happened.

Both errors are right after the "pwc Closing video device"
message (an USB related issue, as in John Mock's case?). May
videodev's "has no release callback" message be related, too?

The partition is clean, according to fsck.

[...]
Oct 11 15:21:44 azor kernel: Linux video capture interface: v1.00
Oct 11 15:21:44 azor kernel: pwc Philips PCA645/646 + PCVC675/680/690 +
PCVC730/740/750 webcam module version 8.11 loaded.
Oct 11 15:21:44 azor kernel: pwc Also supports the Askey VC010, various
Logitech QuickCams, Samsung MPC-C10 and MPC-C30,
Oct 11 15:21:44 azor kernel: pwc the Creative WebCam 5, SOTEC Afina Eye and
Visionite VCS-UC300 and VCS-UM100.
Oct 11 15:21:44 azor kernel: pwc Logitech QuickCam 4000 Pro USB webcam
detected.
Oct 11 15:21:44 azor kernel: videodev: "Logitech QuickCam Pro 4000" has no
release callback. Please fix your driver for proper sysfs support, see
http://lwn.net/Articles/36850/
Oct 11 15:21:44 azor kernel: pwc Registered as /dev/video0.
Oct 11 15:21:44 azor kernel: drivers/usb/core/usb.c: registered new driver
Philips webcam
[...]
Oct 11 16:07:51 azor kernel: pwc Closing video device: 506 frames received,
dumped 3 frames, 0 frames with errors.
Oct 11 16:07:55 azor kernel: ******** [several lines with lots of *s and a
few numbers in hex] ***A5
Oct 11 16:07:55 azor kernel: Next: 00 80 D2 C8 00 20 65 C1 80 00 00 00 80 00
B9 CA 05 00 00 00 0D 00 00 00 02 00 00 00 FE FF FF FF
Oct 11 16:07:55 azor kernel: slab error in check_poison_obj(): cache
`size-16384': object was modified after freeing
Oct 11 16:07:55 azor kernel: Call Trace:
Oct 11 16:07:55 azor kernel:  [<c013b59c>] __kmalloc+0x18c/0x1e0
Oct 11 16:07:55 azor kernel:  [<c023dc02>] alloc_skb+0x32/0xd0
Oct 11 16:07:55 azor kernel:  [<c023d4bf>] sock_alloc_send_pskb+0xbf/0x1c0
Oct 11 16:07:55 azor kernel:  [<c023d5d9>] sock_alloc_send_skb+0x19/0x30
Oct 11 16:07:55 azor kernel:  [<c02958dc>] unix_stream_sendmsg+0x18c/0x390
Oct 11 16:07:55 azor kernel:  [<c023a701>] sock_sendmsg+0xd1/0xe0
Oct 11 16:07:55 azor kernel:  [<c023a8bd>] sock_aio_read+0xed/0xf0
Oct 11 16:07:55 azor kernel:  [<c023aa94>] sock_readv_writev+0x64/0xa0
Oct 11 16:07:55 azor kernel:  [<c0199d43>] inode_has_perm+0x53/0x90
Oct 11 16:07:55 azor kernel:  [<c023ab65>] sock_writev+0x45/0x50
Oct 11 16:07:55 azor kernel:  [<c023ab20>] sock_writev+0x0/0x50
Oct 11 16:07:55 azor kernel:  [<c014f386>] do_readv_writev+0x226/0x290
Oct 11 16:07:55 azor kernel:  [<c0123f66>] update_wall_time+0x16/0x40
Oct 11 16:07:55 azor kernel:  [<c01101c5>] timer_interrupt+0x25/0x110
Oct 11 16:07:56 azor kernel:  [<c014f489>] vfs_writev+0x49/0x60
Oct 11 16:07:56 azor kernel:  [<c014f538>] sys_writev+0x38/0x60
Oct 11 16:07:56 azor kernel:  [<c010aeef>] syscall_call+0x7/0xb
Oct 11 16:07:56 azor kernel:
[...]
Oct 11 17:32:23 azor kernel: Debug: sleeping function called from invalid
context at include/asm/uaccess.h:474
Oct 11 17:32:23 azor kernel: in_atomic():0, irqs_disabled():1
Oct 11 17:32:23 azor kernel: Call Trace:
Oct 11 17:32:23 azor kernel:  [<c011b032>] __might_sleep+0x82/0x90
Oct 11 17:32:23 azor kernel:  [<c010d18b>] save_v86_state+0x6b/0x1d0
Oct 11 17:32:23 azor kernel:  [<c010dbe7>] handle_vm86_fault+0xb7/0x8e0
Oct 11 17:32:23 azor kernel:  [<c01101c5>] timer_interrupt+0x25/0x110
Oct 11 17:32:23 azor kernel:  [<c010c9fc>] do_IRQ+0xcc/0x100
Oct 11 17:32:23 azor kernel:  [<c010bcf0>] do_general_protection+0x0/0x170
Oct 11 17:32:23 azor kernel:  [<c010b099>] error_code+0x2d/0x38
Oct 11 17:32:23 azor kernel:  [<c010aeef>] syscall_call+0x7/0xb
Oct 11 17:32:23 azor kernel:
[...]
Oct 11 17:34:11 azor kernel: usb 1-2: control timeout on ep0in
Oct 11 17:34:14 azor kernel: pwc Closing video device: 28 frames received,
dumped 7 frames, 0 frames with errors.
Oct 11 17:34:16 azor kernel: ****** [several lines with lots of *s and a few
numbers in hex] ****A5
Oct 11 17:34:16 azor kernel: Next: 00 00 00 C7 45 B8 03 00 00 00 8D 45 E4 50
8B 45 08 8B 00 FF 75 08 FF 90 A0 02 00 00 DB E2 89 45
Oct 11 17:34:16 azor kernel: slab error in check_poison_obj(): cache
`size-16384': object was modified after freeing
Oct 11 17:34:16 azor kernel: Call Trace:
Oct 11 17:34:16 azor kernel:  [<c013b59c>] __kmalloc+0x18c/0x1e0
Oct 11 17:34:16 azor kernel:  [<c023dc02>] alloc_skb+0x32/0xd0
Oct 11 17:34:16 azor kernel:  [<c023d4bf>] sock_alloc_send_pskb+0xbf/0x1c0
Oct 11 17:34:16 azor kernel:  [<c023d5d9>] sock_alloc_send_skb+0x19/0x30
Oct 11 17:34:16 azor kernel:  [<c02958dc>] unix_stream_sendmsg+0x18c/0x390
Oct 11 17:34:16 azor kernel:  [<c023a701>] sock_sendmsg+0xd1/0xe0
Oct 11 17:34:16 azor kernel:  [<c023a8bd>] sock_aio_read+0xed/0xf0
Oct 11 17:34:16 azor kernel:  [<c023aa94>] sock_readv_writev+0x64/0xa0
Oct 11 17:34:16 azor kernel:  [<c0199d43>] inode_has_perm+0x53/0x90
Oct 11 17:34:16 azor kernel:  [<c023ab65>] sock_writev+0x45/0x50
Oct 11 17:34:16 azor kernel:  [<c023ab20>] sock_writev+0x0/0x50
Oct 11 17:34:16 azor kernel:  [<c014f386>] do_readv_writev+0x226/0x290
Oct 11 17:34:16 azor kernel:  [<c0123f66>] update_wall_time+0x16/0x40
Oct 11 17:34:16 azor kernel:  [<c01101c5>] timer_interrupt+0x25/0x110
Oct 11 17:34:16 azor kernel:  [<c014f489>] vfs_writev+0x49/0x60
Oct 11 17:34:16 azor kernel:  [<c014f538>] sys_writev+0x38/0x60
Oct 11 17:34:16 azor kernel:  [<c010aeef>] syscall_call+0x7/0xb
Oct 11 17:34:16 azor kernel:
Oct 11 17:34:18 azor kernel: pwc Video mode VGA@10 fps is only supported
with the decompressor module (pwcx).
Oct 11 17:34:18 azor kernel: pwc Video mode VGA@10 fps is only supported
with the decompressor module (pwcx).
Oct 11 17:34:19 azor kernel: usb 1-2: control timeout on ep0in



