Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318901AbSG1Ett>; Sun, 28 Jul 2002 00:49:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318902AbSG1Ets>; Sun, 28 Jul 2002 00:49:48 -0400
Received: from mx3.fuse.net ([216.68.1.123]:44749 "EHLO mta03.fuse.net")
	by vger.kernel.org with ESMTP id <S318901AbSG1Ets>;
	Sun, 28 Jul 2002 00:49:48 -0400
Message-ID: <3D4378B2.1000200@fuse.net>
Date: Sun, 28 Jul 2002 00:53:06 -0400
From: Nathaniel <wfilardo@fuse.net>
Organization: BentTroll Technologies
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.0) Gecko/20020710
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
CC: linux-kernel@vger.kernel.org
Subject: [OOPS] Re: PATCH: 2.5.29 Fix pnpbios
References: <E17YcDa-0002Mf-00@the-village.bc.nu>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:
> This should do the trick for pnpbios - we load the initial gdt into each
> gdt, and we load the parameters into the gdt of the cpu making the call 
> relying on the spinlock to avoid bouncing cpu due to pre-empt

I get the following (hand-transcribed) oops at bootup on a patched (see below) 2.5.29 on a UP Athlon 900Mhz system with an ASUS K7V (unsure about the V) motherboard.

PnPBIOS: Found PnP BIOS intallation structure at 0xc00fc2b0
PnPBIOS: PnP Version 1.0, entry 0xf0000:0xc2e0
general protection fault: 0000
CPU: 
0
EIP: 
0060:[<00000004>] 
Not tainted
EFLAGS: 
00010082
eax: 00000000 ebx: 00020078 ecx: 00700078 edx: 00000000
esi: 00000246 edi: 00020078 ebp: c12abf84 esp: c12abf00
ds: 0018 es: 0018 ss: 0018
Process swapper (pid: 1, threadinfo=c12aa000 task=c12a9040)
Stack: 00000000 00020078 00700078 00000000 c01f63e8 00000010 00000082 00000000
        00000000 00000018 00000018 00000246 00020078 c12abf84 c12abf84 000000a0
        c02a13da 00000000 c12aa000 00000000 c01f645b c12abf84 c12abf84 c02edee8
Call trace: [<c01f63e8>] [<c01f645b>] [<c0105088>] [<c105688>]
Code: Bad EIP value.
  <0> Kernel panic: attempted to kill init!
  Spurious 8295A interrupt: IRQ7.


 >>EIP; 00000004 Before first symbol   <=====

 >>ebx; 00020078 Before first symbol
 >>ecx; 00700078 Before first symbol
 >>edi; 00020078 Before first symbol
 >>ebp; c12abf84 <END_OF_CODE+f7c5d8/????>
 >>esp; c12abf00 <END_OF_CODE+f7c554/????>

Trace; c01f63e8 <__pnp_bios_dev_node_info+d8/140>
Trace; c01f645b <pnp_bios_dev_node_info+b/30>
Trace; c0105088 <init+28/170>
Trace; 0c105688 Before first symbol


I hope that is accurate and means something to somebody.

Patches applied to this tree:

acpi_system.c_needs_interrupt.h.patch
lkml-alan-fix_pnpbios.patch
lkml-mingo-AFTER-RR-FIX_CPUHP-scheduler_migration_fix.diff
lkml-mingo-fix_serial_irq_oopses
lkml-peter_osterlund-fix_LDM_config.patch
lkml-rr-fix_cpuhp_smp.patch
lkml-rr-fix_cpuhp_smp2.patch
lkml-wli-PAE_compile_fix.patch
netdev-random-core-rml-2.5.19-1.patch
netdev-random-drivers-rml-2.5.19-1.patch

None of these touch pnp except Alan's.

--Nathan


