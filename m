Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268154AbTAKVtr>; Sat, 11 Jan 2003 16:49:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268155AbTAKVtq>; Sat, 11 Jan 2003 16:49:46 -0500
Received: from dclient217-162-108-200.hispeed.ch ([217.162.108.200]:48391 "HELO
	ritz.dnsalias.org") by vger.kernel.org with SMTP id <S268154AbTAKVto>;
	Sat, 11 Jan 2003 16:49:44 -0500
Subject: AGP oops on rmmod
From: Daniel Ritz <daniel.ritz@gmx.ch>
To: davej@codemonkey.org.uk, linux-kernel@vger.kernel.org
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.3 
Date: 11 Jan 2003 22:58:56 +0100
Message-Id: <1042322347.3418.34.camel@cast2.alcatel.ch>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

maybe already know...kernel is 2.5.56

modprobe apggart
modprobe intel-agp
-> lsmod shows 'em
rmmod intel-agp
-> produces that one:


Unable to handle kernel NULL pointer dereference at virtual address 00000000
 printing eip:
00000000
*pde = 00000000
Oops: 0000
CPU:    0
EIP:    0060:[<00000000>]    Not tainted
EFLAGS: 00010246
EIP is at 0x0
eax: 00000000   ebx: d0891220   ecx: c0290ac4   edx: 00000000
esi: c5f7e000   edi: 00000000   ebp: c5f7ff54   esp: c5f7ff50
ds: 007b   es: 007b   ss: 0068
Process rmmod (pid: 2100, threadinfo=c5f7e000 task=c9b48d80)
Stack: d0895246 c5f7ff60 d0895379 d089527c c5f7ff68 d088f648 c5f7ffbc c0128225
       bffff884 65746e69 67615f6c c0290a84 65746e69 67615f6c cbe10070 c9ccd3b4
       00001000 c9ccd3d4 c99572b4 c5f7ffbc c01379dc c9ccd3b4 40016000 00001000
Call Trace:
 [<d0895246>] agp_backend_cleanup+0xa/0x2f76adc4 [agpgart]
 [<d0895379>] agp_unregister_driver+0x21/0x2f76aca8 [agpgart]
 [<d089527c>] agp_power+0x0/0x2f76ad84 [agpgart]
 [<d088f648>] +0x8/0x2f7709c0 [intel_agp]
 [<c0128225>] sys_delete_module+0x1b5/0x1d8
 [<c01379dc>] sys_munmap+0x44/0x64
 [<c010a89b>] syscall_call+0x7/0xb

Code:  Bad EIP value.


machine is a toshiba tecra 8000 laptop, p3-500, lspci:
00:00.0 Host bridge: Intel Corporation 440BX/ZX - 82443BX/ZX Host bridge (AGP disabled) (rev 03)
00:04.0 VGA compatible controller: Neomagic Corporation [MagicMedia 256AV] (rev 12)
00:05.0 Bridge: Intel Corporation 82371AB PIIX4 ISA (rev 02)
00:05.1 IDE interface: Intel Corporation 82371AB PIIX4 IDE (rev 01)
00:05.2 USB Controller: Intel Corporation 82371AB PIIX4 USB (rev 01)
00:05.3 Bridge: Intel Corporation 82371AB PIIX4 ACPI (rev 02)
00:09.0 Communication controller: Toshiba America Info Systems FIR Port (rev 23)
00:0b.0 CardBus bridge: Toshiba America Info Systems ToPIC97 (rev 05)
00:0b.1 CardBus bridge: Toshiba America Info Systems ToPIC97 (rev 05)

as you can see the chipset has agp disabled.



