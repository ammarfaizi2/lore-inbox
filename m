Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261323AbTIOS4y (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Sep 2003 14:56:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261326AbTIOS4y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Sep 2003 14:56:54 -0400
Received: from 153.Red-213-4-13.pooles.rima-tde.net ([213.4.13.153]:50699 "EHLO
	small.felipe-alfaro.com") by vger.kernel.org with ESMTP
	id S261323AbTIOS4w (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Sep 2003 14:56:52 -0400
Subject: 2.6.0-test5-mm2: oops when trying to suspend
From: Felipe Alfaro Solana <felipe_alfaro@linuxmail.org>
To: Linux Kernel Mailinglist <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Message-Id: <1063652209.1330.4.camel@teapot.felipe-alfaro.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.4 
Date: Mon, 15 Sep 2003 20:56:50 +0200
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

I get the following oops when trying to suspend my computer.

Stopping tasks: =====|
Unable to handle kernel paging request at virtual address fffffff4
 printing eip:
d091c634
*pde = 00002067
*pte = 00000000
Oops: 0000 [#1]
PREEMPT
CPU:     0
EIP:    0068:[<d091c634>]    Not taintled VLI
EFLAGS: 00010283
EIP is at usb_device_suspend+0x24/0x50 [usbcore]
eax: 00000000   ebx: c13a4898   ecx: c13a4880   edx: ffffffe0
esi: 00000000   edi: 00000002   ebp: 00000002   esp: cffa1ec4
ds: 007b   es: 007b   ss: 0068
Process bash (pid: 1, threadinfo=cffa0000 task=c12bb940)
Stack: cffa1ecc 00000000 c0216e41 c13a4898 00000002 00000000 c030874c
c0216f26
       c13a4898 00000002 00000000 00000002 00000002 c01386c3 00000002
00000000
       c02d41c0 c01387ea 00000002 00000000 cffa1f55 cffa1f38 c01eda09
00000002
Call Trace:
 [<c0216e41>] suspend_device+0x81/0x100
 [<c0216f26>] device_suspend+0x66/0x80
 [<c01386c3>] suspend_prepare+0x63/0xa0
 [<c01387ea>] enter_state+0x4a/0xb0
 [<c01eda09>] acpi_suspend+0x3e/0x4d
 [<c01edb65>] acpi_system_write_sleep+0xa6/0xcd
 [<c01edb7a>] acpi_system_write_sleep+0xbb/0xcd
 [<c01edabf>] acpi_system_write_sleep+0x0/0xcd
 [<c015ab28>] vfs_write+0xb8/0x140
 [<c015ac62>] sys_write+0x42/0x70
 [<c029aa07>] syscall_call+0x7/0xb

Code: 90 90 90 90 90 90 90 73 ec 08 8b 54 24 0c 8b 42 70 3d 20 27 92 d0
74 1f 81
 7a 74 84 32 93 d0 74 16 8d 4a e8 89 c2 83 ea 20 74 0c <8b> 42 14 85 c0
75 0b 90
 8d 74 26 00 31 c0 83 c4 08 c3 89 0c 24
 <0>Kernel panic: Attempted to kill init!

To reproduce:

1. boot 2.6.0-test5-mm2 ro root=/dev/hda3 init=/bin/bash 1
2 .mount -t proc /proc /proc
3. /sbin/modprobe uhci-hcd
4. echo 3 > /proc/acpi/sleep


