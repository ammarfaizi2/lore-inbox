Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267409AbSLSBG4>; Wed, 18 Dec 2002 20:06:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267403AbSLSBG4>; Wed, 18 Dec 2002 20:06:56 -0500
Received: from adsl-206-170-148-147.dsl.snfc21.pacbell.net ([206.170.148.147]:10512
	"EHLO gw.goop.org") by vger.kernel.org with ESMTP
	id <S267409AbSLSBGF>; Wed, 18 Dec 2002 20:06:05 -0500
Subject: modules oops in 2.5.52
From: Jeremy Fitzhardinge <jeremy@goop.org>
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: Linux Kernel List <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Organization: 
Message-Id: <1040260444.1316.4.camel@ixodes.goop.org>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.1 
Date: 18 Dec 2002 17:14:05 -0800
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I just had an oops in the modules code:

Dec 18 16:58:59 ixodes kernel: Unable to handle kernel paging request at virtual address f8980924
Dec 18 16:58:59 ixodes kernel:  printing eip:
Dec 18 16:58:59 ixodes kernel: f896756d
Dec 18 16:58:59 ixodes kernel: *pde = 01bfc067
Dec 18 16:58:59 ixodes kernel: *pte = 00000000
Dec 18 16:58:59 ixodes kernel: Oops: 0000
Dec 18 16:58:59 ixodes kernel: CPU:    0
Dec 18 16:58:59 ixodes kernel: EIP:    0060:[<f896756d>]    Not tainted
Dec 18 16:58:59 ixodes kernel: EFLAGS: 00010282
Dec 18 16:58:59 ixodes kernel: EIP is at __exitfn+0xd/0x4c [parport_pc]
Dec 18 16:58:59 ixodes kernel: eax: d7b01c80   ebx: c0355bb8   ecx: c0355bb8   edx: c02f2b50
Dec 18 16:58:59 ixodes kernel: esi: f8964000   edi: 00000000   ebp: f4b9df5c   esp: f4b9df50
Dec 18 16:58:59 ixodes kernel: ds: 0068   es: 0068   ss: 0068
Dec 18 16:58:59 ixodes kernel: Process modprobe (pid: 1358, threadinfo=f4b9c000 task=eb929280)
Dec 18 16:58:59 ixodes kernel: Stack: f4b9c000 c0355bb8 f8964000 f4b9dfbc c0127d61 c02f2b50 00000077 0000003b
Dec 18 16:58:59 ixodes kernel:        70726170 5f74726f e1006370 f5025480 f5025380 40013000 40014000 f5025480
Dec 18 16:58:59 ixodes kernel:        f5025380 e1e4b200 e1e4b220 00000000 f4b9dfbc c0136839 00e4b200 40013000
Dec 18 16:58:59 ixodes kernel: Call Trace:
Dec 18 16:58:59 ixodes kernel:  [<c0127d61>] sys_delete_module+0x1bf/0x1e2
Dec 18 16:58:59 ixodes kernel:  [<c0136839>] sys_munmap+0x57/0x76
Dec 18 16:58:59 ixodes kernel:  [<c01090c3>] syscall_call+0x7/0xb
Dec 18 16:58:59 ixodes kernel:
Dec 18 16:58:59 ixodes kernel: Code: 8b 35 24 09 98 f8 85 f6 89 c3 74 24 85 db 74 0f f6 43 10 01
Dec 18 16:59:00 ixodes kernel:  end_request: I/O error, dev hdc, sector 0
Dec 18 16:59:00 ixodes kernel: end_request: I/O error, dev hdc, sector 0

I doubt parport_pc was being used.  I think this was caused by the
vmware-config script trying to unload modules.  Vmware was not loaded at
the time.

Now, any process which touches /proc/modules hangs, I guess because a
lock was being held.

I have module-init-tools 0.9.3 installed.

The only other patch in the kernel is AndrewM's buffer head tracing
code.

	J

