Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263575AbTKKPqG (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Nov 2003 10:46:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263578AbTKKPqG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Nov 2003 10:46:06 -0500
Received: from hauptpostamt.charite.de ([193.175.66.220]:25537 "EHLO
	hauptpostamt.charite.de") by vger.kernel.org with ESMTP
	id S263575AbTKKPqA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Nov 2003 10:46:00 -0500
Date: Tue, 11 Nov 2003 16:45:58 +0100
From: Ralf Hildebrandt <Ralf.Hildebrandt@charite.de>
To: linux-kernel@vger.kernel.org
Subject: 2.6.0-tes9-bk15 visor causes kernel NULL pointer dereference
Message-ID: <20031111154558.GE27685@charite.de>
Mail-Followup-To: linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Yes, my kernel is tainted because of the nvdia module.

kpilot tries to access /dev/ttyUSB1, and I get:

Nov 11 15:20:49 hummus2 kernel: visor ttyUSB0: Handspring Visor / Palm OS converter now disconnected from ttyUSB0
Nov 11 15:20:49 hummus2 kernel: Unable to handle kernel NULL pointer dereference at virtual address 00000024
Nov 11 15:20:49 hummus2 kernel:  printing eip:
Nov 11 15:20:49 hummus2 kernel: c0163eb3
Nov 11 15:20:49 hummus2 kernel: *pde = 00000000
Nov 11 15:20:49 hummus2 kernel: Oops: 0002 [#1]
Nov 11 15:20:49 hummus2 kernel: CPU:    0
Nov 11 15:20:49 hummus2 kernel: EIP:    0060:[simple_rmdir+53/77]    Tainted: PF 
Nov 11 15:20:49 hummus2 kernel: EFLAGS: 00010202
Nov 11 15:20:49 hummus2 kernel: EIP is at simple_rmdir+0x35/0x4d
Nov 11 15:20:49 hummus2 kernel: eax: 00000000   ebx: c4795780   ecx: c4795788   edx: ffffffd9
Nov 11 15:20:49 hummus2 kernel: esi: c321f380   edi: c479579c   ebp: 00000000   esp: c28a7e44
Nov 11 15:20:49 hummus2 kernel: ds: 007b   es: 007b   ss: 0068
Nov 11 15:20:49 hummus2 kernel: Process kpilotDaemon (pid: 1782, threadinfo=c28a6000 task=c4642cc0)
Nov 11 15:20:49 hummus2 kernel: Stack: c4795780 c015f363 c2d53280 c4795780 c0174176 c321f380 c4795780 c4795980 
Nov 11 15:20:49 hummus2 kernel:        c4795780 c017422c c4795780 c4795980 c681bea0 c68abccc cbe09c80 c01b25f7 
Nov 11 15:20:49 hummus2 kernel:        c681bea0 c034dc40 c681bea0 c681be78 c01f7886 c681bea0 c681be78 00000000 
Nov 11 15:20:49 hummus2 kernel: Call Trace:
Nov 11 15:20:49 hummus2 kernel:  [iput+85/111] iput+0x55/0x6f
Nov 11 15:20:49 hummus2 kernel:  [remove_dir+76/111] remove_dir+0x4c/0x6f
Nov 11 15:20:49 hummus2 kernel:  [sysfs_remove_dir+145/210] sysfs_remove_dir+0x91/0xd2
Nov 11 15:20:49 hummus2 kernel:  [kobject_del+64/110] kobject_del+0x40/0x6e
Nov 11 15:20:49 hummus2 kernel:  [device_del+112/155] device_del+0x70/0x9b
Nov 11 15:20:49 hummus2 kernel:  [device_unregister+19/35] device_unregister+0x13/0x23
Nov 11 15:20:49 hummus2 kernel:  [_end+292206965/1069745528] destroy_serial+0x182/0x1bb [usbserial]
Nov 11 15:20:49 hummus2 kernel:  [kobject_cleanup+123/125] kobject_cleanup+0x7b/0x7d
Nov 11 15:20:49 hummus2 kernel:  [_end+292202881/1069745528] serial_close+0x8b/0xdf [usbserial]
Nov 11 15:20:49 hummus2 kernel:  [release_dev+1685/1762] release_dev+0x695/0x6e2
Nov 11 15:20:49 hummus2 kernel:  [scheduler_tick+1162/1174] scheduler_tick+0x48a/0x496
Nov 11 15:20:49 hummus2 kernel:  [d_callback+36/57] d_callback+0x24/0x39
Nov 11 15:20:49 hummus2 kernel:  [rcu_do_batch+51/59] rcu_do_batch+0x33/0x3b
Nov 11 15:20:49 hummus2 kernel:  [tty_release+15/21] tty_release+0xf/0x15
Nov 11 15:20:49 hummus2 kernel:  [__fput+227/245] __fput+0xe3/0xf5
Nov 11 15:20:49 hummus2 kernel:  [filp_close+89/134] filp_close+0x59/0x86
Nov 11 15:20:49 hummus2 kernel:  [sys_close+80/95] sys_close+0x50/0x5f
Nov 11 15:20:49 hummus2 kernel:  [syscall_call+7/11] syscall_call+0x7/0xb
Nov 11 15:20:49 hummus2 kernel: 
Nov 11 15:20:49 hummus2 kernel: Code: 83 68 24 01 89 34 24 89 5c 24 04 e8 9f ff ff ff 31 d2 83 6e 
Nov 11 15:20:54 hummus2 kernel:  0: NVRM: AGPGART: unable to retrieve symbol table


----- End forwarded message -----

-- 
Ralf Hildebrandt (Im Auftrag des Referat V a)   Ralf.Hildebrandt@charite.de
Charite - Universitätsmedizin Berlin            Tel.  +49 (0)30-450 570-155
Gemeinsame Einrichtung von FU- und HU-Berlin    Fax.  +49 (0)30-450 570-916
Referat V a - Kommunikationsnetze -             AIM.  ralfpostfix
