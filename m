Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261443AbUBUATZ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Feb 2004 19:19:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261446AbUBUATZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Feb 2004 19:19:25 -0500
Received: from fw.osdl.org ([65.172.181.6]:1679 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261443AbUBUATO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Feb 2004 19:19:14 -0500
Date: Fri, 20 Feb 2004 16:11:39 -0800
From: "Randy.Dunlap" <rddunlap@osdl.org>
To: "Elliot Mackenzie" <macka@adixein.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: PROBLEM: Panic booting from USB disk in ioremap.c (line 81)
Message-Id: <20040220161139.3bd95852.rddunlap@osdl.org>
In-Reply-To: <001301c3f80f$3ebbf890$4301a8c0@waverunner>
References: <20040220113031.0414ff65.rddunlap@osdl.org>
	<001301c3f80f$3ebbf890$4301a8c0@waverunner>
Organization: OSDL
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
X-Face: +5V?h'hZQPB9<D&+Y;ig/:L-F$8p'$7h4BBmK}zo}[{h,eqHI1X}]1UhhR{49GL33z6Oo!`
 !Ys@HV,^(Xp,BToM.;N_W%gT|&/I#H@Z:ISaK9NqH%&|AO|9i/nB@vD:Km&=R2_?O<_V^7?St>kW
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 21 Feb 2004 10:11:24 +1000 "Elliot Mackenzie" <macka@adixein.com> wrote:

| OK, I have done that, and I recompiled an identical kernel with spinlock
| support (first incarnation did not have it).
| 
| Files on syslinux USB disk include vmlinuz (2.6.3), initrd and syslinux
| config.
| 
| Cheers,
| Elliot.

Duh, I forgot.  Please look up these initcall addresses in your
System.map file (or post it on the web or mail it).

But that size=0xedeb0000 is a problem... just to figure out where
it's coming from, using the initcall symbols.



| Now we get this:
| ==========================
| Calling initcall 0xc03f7e19
| Calling initcall 0xc03f819c
| Calling initcall 0xc03f1e7c
| Calling initcall 0xc03e7084
| Calling initcall 0xc03e7101
| Calling initcall 0xc03e90e2
| remap_area_pages BUG: address=0xce800000, size=0xedeb0000,
| end=0xbc6b0000
| Call Trace:
|  [<c0119318>] remap_area_pges+0x210/0x21d
|  [<c0149169>] get_vm_area+0x32/0x36
|  [<c01193ff>] __ioremap+0xda/0x104
|  [<c03e9249>] sbf_init+0x167/0x180
|  [<c03e46f1>] do_init_calls+0x28/0x93 
|  [<c03e90e2>] sbf_init+0x0/0x180
|  [<c012ca54>] init_workqueues+0xf/0x27
|  [<c01050bc>] init+0x30/0x134
|  [<c010508c>] init+0x0/0x134
|  [<c0109255>] kernel_thread_helper+0x5/0xb
| ------------[ cut here ]------------
| kernel BUG at arch/i386/mm/ioremap.c:84!
| invalid operand: 0000 [#1]
| CPU: 0
| EIP:	0060:[<c0119318>]		Not tainted
| EFLAGS: 00010292
| EIP is at remap_area_pages+0x210/0x21d
| eax: c0000001    ebx: edeb0000   ecx: c0369a50   edx: 00000282
| esi: 0dffc0000   edi: ce800000   ebp: 00000000   esp: cde55f3c
| ds:  007b    es: 007b   ss: 0068
| Process swapper (pid: 1, theadinfo=cde54000 task=cdfb3900)
| Stack:  c03250e0 ce800000 edeb0000 bc6b0000 cdffb100 000000d0 c0101cec
| edeb0000 0dffc000 bc6b0000 c0101ce8 c0149169 edeb0000 0dffc000 ce800000
| 00000000 c01193ff ce800000 3f7fc000 edeb0000 00000000 00000000 00000024
| ce800000
| Call Trace:
|  [<c0149169>] get_vm_area+0x32/0x36
|  [<c01193ff>] __ioremap+0xda/0x104
|  [<c03e9249>] sbf_init+0x167/0x180
|  [<c03e46f1>] do_init_calls+0x28/0x93 
|  [<c03e90e2>] sbf_init+0x0/0x180
|  [<c012ca54>] init_workqueues+0xf/0x27
|  [<c01050bc>] init+0x30/0x134
|  [<c010508c>] init+0x0/0x134
|  [<c0109255>] kernel_thread_helper+0x5/0xb
| 
| Code: 0f 0b 54 00 ab 4d 32 c0 e9 1d fe ff ff 83 ec 20 89 5c 24 10
|  <0>Kernel panic: Attempted to kill init!
| ==========================
| <snip>
| |
| | The call trace must be missing some helpful info, then.
| | I say that only because the data supplied does not look usb-device
| | specific.
| 
| | Please apply the patch below (for 2.6.3) and reboot that kernel
| | with "initcall_debug" added to the kernel boot command line,
| | and send the resulting (failing) output back to us.
| |
| | --
| | ~Randy
| <snip>

--
~Randy
