Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266116AbUFWEsX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266116AbUFWEsX (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Jun 2004 00:48:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266121AbUFWEsX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Jun 2004 00:48:23 -0400
Received: from LPBPRODUCTIONS.COM ([68.98.211.131]:8366 "HELO
	lpbproductions.com") by vger.kernel.org with SMTP id S266116AbUFWErs
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Jun 2004 00:47:48 -0400
From: "Matt H." <lkml@lpbproductions.com>
Reply-To: lkml@lpbproduction.scom
To: Diffie <diffie@gmail.com>
Subject: Re: [PATCH] Staircase 7.1 for 2.6.7-mm1
Date: Tue, 22 Jun 2004 21:47:30 -0700
User-Agent: KMail/1.6.52
Cc: Panagiotis Papadakos <papadako@csd.uoc.gr>,
       Con Kolivas <kernel@kolivas.org>, LKML <linux-kernel@vger.kernel.org>
References: <9dda34920406222056500f67d3@mail.gmail.com>
In-Reply-To: <9dda34920406222056500f67d3@mail.gmail.com>
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_jtQ2AG/XPHgDsuC"
Message-Id: <200406222147.31300.lkml@lpbproductions.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--Boundary-00=_jtQ2AG/XPHgDsuC
Content-Type: text/plain;
  charset="iso-8859-1";
  boundary=""
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Can you please apply the attched patch below. This fixed the problems for m=
e. Plus it also fixes the issue in the mm patch where the clock ticks were =
going twice as fast as they should be.

diff -urpN linux-2.6.7-old/arch/i386/kernel/mpparse.c linux-2.6.7/arch/i386=
/kernel/mpparse.c
=2D-- linux-2.6.7-old/arch/i386/kernel/mpparse.c=A0=A02004-06-22 21:40:01.6=
08433040 -0700
+++ linux-2.6.7/arch/i386/kernel/mpparse.c=A0=A0=A0=A0=A0=A02004-06-22 21:4=
3:20.943129560 -0700
@@ -1017,7 +1017,6 @@ void __init mp_config_acpi_legacy_irqs (
=A0
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0for (idx =3D 0; idx < mp_ir=
q_entries; idx++)
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0if =
(mp_irqs[idx].mpc_srcbus =3D=3D MP_ISA_BUS &&
=2D=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0(mp_irqs[idx].mpc_dstapic =3D=3D ioapic) &&
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0(mp_irqs[idx].mpc_srcbusirq =3D=3D i ||
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0mp_irqs[idx].mpc_dstirq =3D=3D i))
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0break;
diff -urpN linux-2.6.7-old/arch/x86_64/kernel/mpparse.c linux-2.6.7/arch/x8=
6_64/kernel/mpparse.c
=2D-- linux-2.6.7-old/arch/x86_64/kernel/mpparse.c=A0=A0=A0=A0=A0=A0=A0=A02=
004-06-22 21:40:09.816185272 -0700
+++ linux-2.6.7/arch/x86_64/kernel/mpparse.c=A0=A0=A0=A02004-06-22 21:43:38=
=2E899399792 -0700
@@ -861,7 +861,6 @@ void __init mp_config_acpi_legacy_irqs (
=A0
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0for (idx =3D 0; idx < mp_ir=
q_entries; idx++)
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0if =
(mp_irqs[idx].mpc_srcbus =3D=3D MP_ISA_BUS &&
=2D=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0(mp_irqs[idx].mpc_dstapic =3D=3D intsrc.mpc_dstapic) &&
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0(mp_irqs[idx].mpc_srcbusirq =3D=3D i ||
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0mp_irqs[idx].mpc_dstirq =3D=3D i))
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0break;
diff -urpN linux-2.6.7-old/include/linux/kernel.h linux-2.6.7/include/linux=
/kernel.h
=2D-- linux-2.6.7-old/include/linux/kernel.h=A0=A0=A0=A0=A0=A02004-06-22 21=
:40:40.858466128 -0700
+++ linux-2.6.7/include/linux/kernel.h=A0=A02004-06-22 21:44:00.644094096 -=
0700
@@ -55,7 +55,12 @@ void __might_sleep(char *file, int line)
=A0#endif
=A0
=A0#define abs(x) ({=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0\
=2D=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0typeof(x) __x =3D (x);=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0\
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0int __x =3D (x);=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0\
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0(__x < 0) ? -__x : __x;=A0=A0=
=A0=A0=A0=A0=A0=A0=A0\
+=A0=A0=A0=A0=A0=A0=A0})
+
+#define labs(x) ({=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0\
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0long __x =3D (x);=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0\
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0(__x < 0) ? -__x : __x;=A0=
=A0=A0=A0=A0=A0=A0=A0=A0\
=A0=A0=A0=A0=A0=A0=A0=A0})
=A0


Thanks,

Matt H.



On Tuesday 22 June 2004 8:56 pm, Diffie wrote:
> Hello folks,
>
> I have tried this staircase patch on 2.6.7-mm1 kernel under NForce2
> based system and when playing games the sound stops and skips every
> second and moving mouse at the same time makes the response very
> slow.The game is Unreal engine based.
>
> This does not happen with the 2.6.7-mm1 from akpm just when the kernel
> is patched using the above patch.
>
> System info:
>
> Slackware 10.0-rc2
> GCC 3.3.4
> Gigabyte 7NNXP mainboard
> AMD Athlon 3200+
> NForce2 Audio with ALSA 1.0.5
>
> uname :
>
> Linux blaze 2.6.7-mm1 #3 Tue Jun 22 02:26:12 EDT 2004 i686 unknown
> unknown GNU/Linux
>
> dmesg:
>
> Linux version 2.6.7-mm1 (root@blaze) (gcc version 3.3.4) #3 Tue Jun 22
> 02:26:12 EDT 2004
> BIOS-provided physical RAM map:
>  BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)
>  BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)
>  BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
>  BIOS-e820: 0000000000100000 - 000000003fff0000 (usable)
>  BIOS-e820: 000000003fff0000 - 000000003fff3000 (ACPI NVS)
>  BIOS-e820: 000000003fff3000 - 0000000040000000 (ACPI data)
>  BIOS-e820: 00000000fec00000 - 00000000fec01000 (reserved)
>  BIOS-e820: 00000000fee00000 - 00000000fee01000 (reserved)
>  BIOS-e820: 00000000ffff0000 - 0000000100000000 (reserved)
> 127MB HIGHMEM available.
> 896MB LOWMEM available.
> found SMP MP-table at 000f5240
> On node 0 totalpages: 262128
>   DMA zone: 4096 pages, LIFO batch:1
>   Normal zone: 225280 pages, LIFO batch:16
>   HighMem zone: 32752 pages, LIFO batch:7
> DMI 2.3 present.
> ACPI: RSDP (v000 Nvidia                                    ) @ 0x000f6bb0
> ACPI: RSDT (v001 Nvidia AWRDACPI 0x42302e31 AWRD 0x01010101) @ 0x3fff3000
> ACPI: FADT (v001 Nvidia AWRDACPI 0x42302e31 AWRD 0x01010101) @ 0x3fff3040
> ACPI: MADT (v001 Nvidia AWRDACPI 0x42302e31 AWRD 0x01010101) @ 0x3fff7680
> ACPI: DSDT (v001 NVIDIA AWRDACPI 0x00001000 MSFT 0x0100000c) @ 0x00000000
> ACPI: Local APIC address 0xfee00000
> ACPI: LAPIC (acpi_id[0x00] lapic_id[0x00] enabled)
> Processor #0 6:10 APIC version 16
> ACPI: LAPIC_NMI (acpi_id[0x00] dfl dfl lint[0x1])
> ACPI: IOAPIC (id[0x02] address[0xfec00000] gsi_base[0])
> IOAPIC[0]: Assigned apic_id 2
> IOAPIC[0]: apic_id 2, version 17, address 0xfec00000, GSI 0-23
> ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
> ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 high level)
> Enabling APIC mode:  Flat.  Using 1 I/O APICs
> Using ACPI (MADT) for SMP configuration information
> Built 1 zonelists
> Initializing CPU#0
> Kernel command line: auto BOOT_IMAGE=3DSlackware ro root=3D801 rootflags=
=3Dquota
> CPU 0 irqstacks, hard=3Dc0434000 soft=3Dc0433000
> PID hash table entries: 4096 (order 12: 32768 bytes)
> Detected 2205.476 MHz processor.
> Using tsc for high-res timesource
> Console: colour dummy device 80x25
> Dentry cache hash table entries: 131072 (order: 7, 524288 bytes)
> Inode-cache hash table entries: 65536 (order: 6, 262144 bytes)
> Memory: 1034888k/1048512k available (2249k kernel code, 12716k
> reserved, 844k data, 168k init, 131008k highmem)
> Checking if this processor honours the WP bit even in supervisor mode...
> Ok. Calibrating delay loop... 4358.14 BogoMIPS
> Mount-cache hash table entries: 512 (order: 0, 4096 bytes)
> CPU:     After generic identify, caps: 0383fbff c1c3fbff 00000000 00000000
> CPU:     After vendor identify, caps: 0383fbff c1c3fbff 00000000 00000000
> CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
> CPU: L2 Cache: 512K (64 bytes/line)
> CPU:     After all inits, caps: 0383fbff c1c3fbff 00000000 00000020
> Intel machine check architecture supported.
> Intel machine check reporting enabled on CPU#0.
> CPU: AMD Athlon(tm) XP 3200+ stepping 00
> Enabling fast FPU save and restore... done.
> Enabling unmasked SIMD FPU exception support... done.
> Checking 'hlt' instruction... OK.
> Generic cache decay timeout: 2 msecs.
> enabled ExtINT on CPU#0
> ESR value before enabling vector: 00000000
> ESR value after enabling vector: 00000000
> ENABLING IO-APIC IRQs
> init IO_APIC IRQs
>  IO-APIC (apicid-pin) 2-0, 2-16, 2-17, 2-18, 2-19, 2-20, 2-21, 2-22,
> 2-23 not connected.
> ..TIMER: vector=3D0x31 pin1=3D2 pin2=3D-1
> ..MP-BIOS bug: 8254 timer not connected to IO-APIC
> ...trying to set up timer (IRQ0) through the 8259A ...  failed.
> ...trying to set up timer as Virtual Wire IRQ... failed.
> ...trying to set up timer as ExtINT IRQ... works.
> Using local APIC timer interrupts.
> calibrating APIC timer ...
> ..... CPU clock speed is 2204.0608 MHz.
> ..... host bus clock speed is 400.0837 MHz.
> checking if image is initramfs...it isn't (ungzip failed); looks like an
> initrd Freeing initrd memory: 56k freed
> NET: Registered protocol family 16
> PCI: PCI BIOS revision 2.10 entry at 0xfabc0, last bus=3D3
> PCI: Using configuration type 1
> mtrr: v2.0 (20020519)
> ACPI: Subsystem revision 20040326
> ACPI: Interpreter enabled
> ACPI: Using IOAPIC for interrupt routing
> ACPI: PCI Root Bridge [PCI0] (00:00)
> PCI: Probing PCI hardware (bus 00)
> PCI: nForce2 C1 Halt Disconnect fixup
> ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
> ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.HUB0._PRT]
> ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.AGPB._PRT]
> ACPI: PCI Interrupt Link [LNK1] (IRQs 3 4 *5 6 7 10 11 12 14 15)
> ACPI: PCI Interrupt Link [LNK2] (IRQs 3 4 5 6 7 *10 11 12 14 15)
> ACPI: PCI Interrupt Link [LNK3] (IRQs 3 4 5 6 7 10 *11 12 14 15)
> ACPI: PCI Interrupt Link [LNK4] (IRQs 3 4 5 6 7 10 *11 12 14 15)
> ACPI: PCI Interrupt Link [LNK5] (IRQs 3 4 5 6 7 10 11 12 14 15) *0,
> disabled. ACPI: PCI Interrupt Link [LUBA] (IRQs 3 4 *5 6 7 10 11 12 14 15)
> ACPI: PCI Interrupt Link [LUBB] (IRQs 3 4 5 6 7 *10 11 12 14 15)
> ACPI: PCI Interrupt Link [LMAC] (IRQs 3 4 5 6 7 10 11 12 14 15) *9
> ACPI: PCI Interrupt Link [LAPU] (IRQs 3 4 *5 6 7 10 11 12 14 15)
> ACPI: PCI Interrupt Link [LACI] (IRQs 3 4 5 6 7 *10 11 12 14 15)
> ACPI: PCI Interrupt Link [LMCI] (IRQs 3 4 5 6 7 10 11 12 14 15) *0,
> disabled. ACPI: PCI Interrupt Link [LSMB] (IRQs 3 4 5 6 7 10 11 12 14 15)
> *9 ACPI: PCI Interrupt Link [LUB2] (IRQs 3 4 5 6 7 10 *11 12 14 15)
> ACPI: PCI Interrupt Link [LFIR] (IRQs 3 4 5 6 7 10 11 12 14 15) *9
> ACPI: PCI Interrupt Link [L3CM] (IRQs 3 4 5 6 7 10 11 12 14 15) *0,
> disabled. ACPI: PCI Interrupt Link [LIDE] (IRQs 3 4 5 6 7 10 11 12 14 15)
> *0, disabled. ACPI: PCI Interrupt Link [APC1] (IRQs *16), disabled.
> ACPI: PCI Interrupt Link [APC2] (IRQs *17), disabled.
> ACPI: PCI Interrupt Link [APC3] (IRQs *18), disabled.
> ACPI: PCI Interrupt Link [APC4] (IRQs *19), disabled.
> ACPI: PCI Interrupt Link [APC5] (IRQs *16), disabled.
> ACPI: PCI Interrupt Link [APCF] (IRQs 20 21 22) *0, disabled.
> ACPI: PCI Interrupt Link [APCG] (IRQs 20 21 22) *0, disabled.
> ACPI: PCI Interrupt Link [APCH] (IRQs 20 21 22) *0, disabled.
> ACPI: PCI Interrupt Link [APCI] (IRQs 20 21 22) *0, disabled.
> ACPI: PCI Interrupt Link [APCJ] (IRQs 20 21 22) *0, disabled.
> ACPI: PCI Interrupt Link [APCK] (IRQs 20 21 22) *0, disabled.
> ACPI: PCI Interrupt Link [APCS] (IRQs *23), disabled.
> ACPI: PCI Interrupt Link [APCL] (IRQs 20 21 22) *0, disabled.
> ACPI: PCI Interrupt Link [APCM] (IRQs 20 21 22) *0, disabled.
> ACPI: PCI Interrupt Link [AP3C] (IRQs 20 21 22) *0, disabled.
> ACPI: PCI Interrupt Link [APCZ] (IRQs 20 21 22) *0, disabled.
> SCSI subsystem initialized
> PCI: Using ACPI for IRQ routing
> ACPI: PCI Interrupt Link [APCS] enabled at IRQ 23
> ACPI: PCI interrupt 0000:00:01.1[A] -> GSI 23 (level, high) -> IRQ 23
> ACPI: PCI Interrupt Link [APCF] enabled at IRQ 22
> ACPI: PCI interrupt 0000:00:02.0[A] -> GSI 22 (level, high) -> IRQ 22
> ACPI: PCI Interrupt Link [APCG] enabled at IRQ 21
> ACPI: PCI interrupt 0000:00:02.1[B] -> GSI 21 (level, high) -> IRQ 21
> ACPI: PCI Interrupt Link [APCL] enabled at IRQ 20
> ACPI: PCI interrupt 0000:00:02.2[C] -> GSI 20 (level, high) -> IRQ 20
> ACPI: PCI Interrupt Link [APCH] enabled at IRQ 22
> ACPI: PCI interrupt 0000:00:04.0[A] -> GSI 22 (level, high) -> IRQ 22
> ACPI: PCI Interrupt Link [APCI] enabled at IRQ 21
> ACPI: PCI interrupt 0000:00:05.0[A] -> GSI 21 (level, high) -> IRQ 21
> ACPI: PCI Interrupt Link [APCJ] enabled at IRQ 20
> ACPI: PCI interrupt 0000:00:06.0[A] -> GSI 20 (level, high) -> IRQ 20
> ACPI: PCI Interrupt Link [APCM] enabled at IRQ 22
> ACPI: PCI interrupt 0000:00:0d.0[A] -> GSI 22 (level, high) -> IRQ 22
> ACPI: PCI Interrupt Link [APC3] enabled at IRQ 18
> ACPI: PCI interrupt 0000:01:0a.0[A] -> GSI 18 (level, high) -> IRQ 18
> ACPI: PCI Interrupt Link [APC1] enabled at IRQ 16
> ACPI: PCI interrupt 0000:01:0b.0[A] -> GSI 16 (level, high) -> IRQ 16
> ACPI: PCI Interrupt Link [APC2] enabled at IRQ 17
> ACPI: PCI interrupt 0000:01:0c.0[A] -> GSI 17 (level, high) -> IRQ 17
> ACPI: PCI Interrupt Link [APC4] enabled at IRQ 19
> ACPI: PCI interrupt 0000:03:00.0[A] -> GSI 19 (level, high) -> IRQ 19
> number of MP IRQ sources: 15.
> number of IO-APIC #2 registers: 24.
> testing the IO APIC.......................
> IO APIC #2......
> .... register #00: 02000000
> .......    : physical APIC id: 02
> .......    : Delivery Type: 0
> .......    : LTS          : 0
> .... register #01: 00170011
> .......     : max redirection entries: 0017
> .......     : PRQ implemented: 0
> .......     : IO APIC version: 0011
> .... register #02: 00000000
> .......     : arbitration: 00
> .... IRQ redirection table:
>  NR Log Phy Mask Trig IRR Pol Stat Dest Deli Vect:
>  00 000 00  1    0    0   0   0    0    0    00
>  01 001 01  0    0    0   0   0    1    1    39
>  02 000 00  1    0    0   0   0    0    0    00
>  03 001 01  0    0    0   0   0    1    1    41
>  04 001 01  0    0    0   0   0    1    1    49
>  05 001 01  0    0    0   0   0    1    1    51
>  06 001 01  0    0    0   0   0    1    1    59
>  07 001 01  1    0    0   0   0    1    1    61
>  08 001 01  0    0    0   0   0    1    1    69
>  09 001 01  0    1    0   0   0    1    1    71
>  0a 001 01  0    0    0   0   0    1    1    79
>  0b 001 01  0    0    0   0   0    1    1    81
>  0c 001 01  0    0    0   0   0    1    1    89
>  0d 001 01  0    0    0   0   0    1    1    91
>  0e 001 01  0    0    0   0   0    1    1    99
>  0f 001 01  0    0    0   0   0    1    1    A1
>  10 001 01  1    1    0   0   0    1    1    D1
>  11 001 01  1    1    0   0   0    1    1    D9
>  12 001 01  1    1    0   0   0    1    1    C9
>  13 001 01  1    1    0   0   0    1    1    E1
>  14 001 01  1    1    0   0   0    1    1    C1
>  15 001 01  1    1    0   0   0    1    1    B9
>  16 001 01  1    1    0   0   0    1    1    B1
>  17 001 01  1    1    0   0   0    1    1    A9
> IRQ to pin mappings:
> IRQ0 -> 0:2
> IRQ1 -> 0:1
> IRQ3 -> 0:3
> IRQ4 -> 0:4
> IRQ5 -> 0:5
> IRQ6 -> 0:6
> IRQ7 -> 0:7
> IRQ8 -> 0:8
> IRQ9 -> 0:9
> IRQ10 -> 0:10
> IRQ11 -> 0:11
> IRQ12 -> 0:12
> IRQ13 -> 0:13
> IRQ14 -> 0:14
> IRQ15 -> 0:15
> IRQ16 -> 0:16
> IRQ17 -> 0:17
> IRQ18 -> 0:18
> IRQ19 -> 0:19
> IRQ20 -> 0:20
> IRQ21 -> 0:21
> IRQ22 -> 0:22
> IRQ23 -> 0:23
> .................................... done.
> vesafb: framebuffer at 0xc0000000, mapped to 0xf8808000, size 3072k
> vesafb: mode is 1024x768x16, linelength=3D2048, pages=3D9
> vesafb: protected mode interface info at c000:581c
> vesafb: scrolling: redraw
> vesafb: directcolor: size=3D0:5:6:5, shift=3D0:11:5:0
> fb0: VESA VGA frame buffer device
> Machine check exception polling timer started.
> highmem bounce pool size: 64 pages
> Total HugeTLB memory allocated, 0
> VFS: Disk quotas dquot_6.5.1
> Dquot-cache hash table entries: 1024 (order 0, 4096 bytes)
> SGI XFS with ACLs, realtime, large block numbers, no debug enabled
> SGI XFS Quota Management subsystem
> Initializing Cryptographic API
> ACPI: Power Button (FF) [PWRF]
> ACPI: Processor [CPU0] (supports C1)
> bootsplash 3.1.4-2004/02/19: looking for picture.... silentjpeg size
> 24219 bytes, found (1024x768, 33509 bytes, v3).
> Console: switching to colour frame buffer device 118x36
> Serial: 8250/16550 driver $Revision: 1.90 $ 8 ports, IRQ sharing enabled
> ttyS0 at I/O 0x3f8 (irq =3D 4) is a 16550A
> ttyS1 at I/O 0x2f8 (irq =3D 3) is a 16550A
> RAMDISK driver initialized: 16 RAM disks of 8192K size 1024 blocksize
> Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
> ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=
=3Dxx
> NFORCE2: IDE controller at PCI slot 0000:00:09.0
> NFORCE2: chipset revision 162
> NFORCE2: not 100% native mode: will probe irqs later
> NFORCE2: BIOS didn't set cable bits correctly. Enabling workaround.
> NFORCE2: 0000:00:09.0 (rev a2) UDMA133 controller
>     ide0: BM-DMA at 0xf000-0xf007, BIOS settings: hda:DMA, hdb:DMA
>     ide1: BM-DMA at 0xf008-0xf00f, BIOS settings: hdc:DMA, hdd:DMA
> hda: WDC WD300BB-00AUA1, ATA DISK drive
> Using anticipatory io scheduler
> ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
> hdc: IOMEGA ZIP 100 ATAPI, ATAPI FLOPPY drive
> ide1 at 0x170-0x177,0x376 on irq 15
> hda: max request size: 128KiB
> hda: Host Protected Area detected.
>         current capacity is 58631231 sectors (30019 MB)
>         native  capacity is 58633344 sectors (30020 MB)
> hda: 58631231 sectors (30019 MB) w/2048KiB Cache, CHS=3D58165/16/63,
> UDMA(100) hda: cache flushes supported
>  hda: hda1
> ACPI: PCI interrupt 0000:01:0a.0[A] -> GSI 18 (level, high) -> IRQ 18
> scsi0 : Adaptec AIC7XXX EISA/VLB/PCI SCSI HBA DRIVER, Rev 6.2.36
>         <Adaptec 2940 Ultra2 SCSI adapter>
>         aic7890/91: Ultra2 Wide Channel A, SCSI Id=3D7, 32/253 SCBs
>
> (scsi0:A:3): 40.000MB/s transfers (20.000MHz, offset 15, 16bit)
>   Vendor: PLEXTOR   Model: CD-ROM PX-40TW    Rev: 1.05
>   Type:   CD-ROM                             ANSI SCSI revision: 02
> (scsi0:A:4): 20.000MB/s transfers (20.000MHz, offset 16)
>   Vendor: PLEXTOR   Model: CD-R   PX-W1210S  Rev: 1.06
>   Type:   CD-ROM                             ANSI SCSI revision: 02
> (scsi0:A:6): 80.000MB/s transfers (40.000MHz, offset 63, 16bit)
>   Vendor: IBM       Model: DDYS-T36950N      Rev: S80D
>   Type:   Direct-Access                      ANSI SCSI revision: 03
> scsi0:A:6:0: Tagged Queuing enabled.  Depth 32
> libata version 1.02 loaded.
> Found Controller: IT8212 UDMA/ATA133 RAID Controller
> FindDevices: device 0 is IDE
> Channel[0] BM-DMA at 0x9800-0x9807
> Channel[1] BM-DMA at 0x9808-0x980F
> scsi1 : ITE RAIDExpress133
>   Vendor: ITE       Model: IT8212F           Rev: 1.3
>   Type:   Direct-Access                      ANSI SCSI revision: 00
> SCSI device sda: 71687340 512-byte hdwr sectors (36704 MB)
> SCSI device sda: drive cache: write back
>  sda: sda1 sda2 sda3 sda4 < sda5 sda6 sda7 >
> Attached scsi disk sda at scsi0, channel 0, id 6, lun 0
> SCSI device sdb: 468883200 512-byte hdwr sectors (240068 MB)
> sdb: asking for cache data failed
> sdb: assuming drive cache: write through
>  sdb: sdb1
> Attached scsi disk sdb at scsi1, channel 0, id 0, lun 0
> serio: i8042 AUX port at 0x60,0x64 irq 12
> serio: i8042 KBD port at 0x60,0x64 irq 1
> mice: PS/2 mouse device common for all mice
> input: AT Translated Set 2 keyboard on isa0060/serio0
> input: PS/2 Generic Mouse on isa0060/serio1
> device-mapper: 4.1.0-ioctl (2003-12-10) initialised: dm@uk.sistina.com
> NET: Registered protocol family 2
> IP: routing cache hash table of 8192 buckets, 64Kbytes
> TCP: Hash tables configured (established 262144 bind 65536)
> NET: Registered protocol family 1
> NET: Registered protocol family 17
> ACPI: (supports S0 S3 S4 S5)
> BIOS EDD facility v0.15 2004-May-17, 3 devices found
> RAMDISK: Couldn't find valid RAM disk image starting at 0.
> XFS mounting filesystem sda1
> Ending clean XFS mount for filesystem: sda1
> VFS: Mounted root (xfs filesystem) readonly.
> Freeing unused kernel memory: 168k freed
> Adding 248968k swap on /dev/sda7.  Priority:-1 extents:1
> Real Time Clock Driver v1.12
> XFS mounting filesystem sda2
> Ending clean XFS mount for filesystem: sda2
> XFS mounting filesystem sda3
> Ending clean XFS mount for filesystem: sda3
> XFS mounting filesystem sda5
> Ending clean XFS mount for filesystem: sda5
> XFS mounting filesystem sda6
> Ending clean XFS mount for filesystem: sda6
> XFS mounting filesystem sdb1
> Ending clean XFS mount for filesystem: sdb1
> e1000: Ignoring new-style parameters in presence of obsolete ones
> Intel(R) PRO/1000 Network Driver - version 5.2.52-k4
> Copyright (c) 1999-2004 Intel Corporation.
> ACPI: PCI interrupt 0000:01:0b.0[A] -> GSI 16 (level, high) -> IRQ 16
> e1000: eth0: e1000_probe: Intel(R) PRO/1000 Network Connection
> e1000: eth0: e1000_watchdog: NIC Link is Up 100 Mbps Full Duplex
> ieee1394: Initialized config rom entry `ip1394'
> ohci1394: $Rev: 1223 $ Ben Collins <bcollins@debian.org>
> ACPI: PCI interrupt 0000:00:0d.0[A] -> GSI 22 (level, high) -> IRQ 22
> PCI: Setting latency timer of device 0000:00:0d.0 to 64
> ohci1394: fw-host0: OHCI-1394 1.1 (PCI): IRQ=3D[22]
> MMIO=3D[e6084000-e60847ff]  Max Packet=3D[2048]
> ACPI: PCI interrupt 0000:00:06.0[A] -> GSI 20 (level, high) -> IRQ 20
> PCI: Setting latency timer of device 0000:00:06.0 to 64
> intel8x0_measure_ac97_clock: measured 49422 usecs
> intel8x0: clocking to 47445
> forcedeth.c: Reverse Engineered nForce ethernet driver. Version 0.25.
> ACPI: PCI interrupt 0000:00:04.0[A] -> GSI 22 (level, high) -> IRQ 22
> PCI: Setting latency timer of device 0000:00:04.0 to 64
> eth1: no link during initialization.
> eth1: forcedeth.c: subsystem: 01458:e000 bound to 0000:00:04.0
> usbcore: registered new driver usbfs
> usbcore: registered new driver hub
> ACPI: PCI interrupt 0000:00:02.2[C] -> GSI 20 (level, high) -> IRQ 20
> ehci_hcd 0000:00:02.2: nVidia Corporation nForce2 USB Controller
> PCI: Setting latency timer of device 0000:00:02.2 to 64
> ehci_hcd 0000:00:02.2: irq 20, pci mem f8bee000
> ehci_hcd 0000:00:02.2: new USB bus registered, assigned bus number 1
> PCI: cache line size of 64 is not supported by device 0000:00:02.2
> ehci_hcd 0000:00:02.2: USB 2.0 enabled, EHCI 1.00, driver 2004-May-10
> hub 1-0:1.0: USB hub found
> hub 1-0:1.0: 6 ports detected
> Linux agpgart interface v0.100 (c) Dave Jones
> agpgart: Detected NVIDIA nForce2 chipset
> agpgart: Maximum main memory to use for agp memory: 941M
> agpgart: AGP aperture is 256M @ 0xb0000000
> ohci1394: fw-host0: SelfID received outside of bus reset sequence
> ieee1394: Host added: ID:BUS[0-00:1023]  GUID[8a1cc7ffff0020ed]
> ip1394: $Rev: 1224 $ Ben Collins <bcollins@debian.org>
> ip1394: eth2: IEEE-1394 IPv4 over 1394 Ethernet (fw-host0)
> nfs warning: mount version older than kernel
> NET: Registered protocol family 10
> IPv6 over IPv4 tunneling driver
> eth1: no IPv6 routers present
> fglrx: module license 'Proprietary. (C) 2002 - ATI Technologies,
> Starnberg, GERMANY' taints kernel.
> [fglrx] Maximum main memory to use for locked dma buffers: 929 MBytes.
> [fglrx] module loaded - fglrx 3.2.5 [Aug  6 2003] on minor 0
> [fglrx:drm_parse_option] *ERROR* "agplock" is not a valid option
> [fglrx] Maximum main memory to use for locked dma buffers: 929 MBytes.
> [fglrx] AGP detected, AgpState   =3D 0x1f00421b (hardware caps of chipset)
> agpgart: Found an AGP 3.0 compliant device at 0000:00:00.0.
> agpgart: Putting AGP V3 device at 0000:00:00.0 into 8x mode
> agpgart: Putting AGP V3 device at 0000:03:00.0 into 8x mode
> [fglrx] AGP enabled,  AgpCommand =3D 0x1f004312 (selected caps)
> [fglrx] free  AGP =3D 256126976
> [fglrx] max   AGP =3D 256126976
> [fglrx] free  LFB =3D 126877696
> [fglrx] max   LFB =3D 126877696
> [fglrx] free  Inv =3D 0
> [fglrx] max   Inv =3D 0
> [fglrx] total Inv =3D 0
> [fglrx] total TIM =3D 0
> [fglrx] total FB  =3D 0
> [fglrx] total AGP =3D 65536
>
>
> Also noticed that overall system response is reduced when using
> staircase and there seems to be more disk activity and well as lag
> when launching applications.
>
> The IO scheduler that i tried is the default one and CFQ which had same
> effects.
>
> I wanted to provide some feedback on the staircase and its effect on
> this kernel.
>
> Regards,
>
> Paul B.
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

--Boundary-00=_jtQ2AG/XPHgDsuC
Content-Type: text/x-diff;
  charset="iso-8859-1";
  name="2.6.7-mm1-time-fixes"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="2.6.7-mm1-time-fixes"

diff -urpN linux-2.6.7-old/arch/i386/kernel/mpparse.c linux-2.6.7/arch/i386/kernel/mpparse.c
--- linux-2.6.7-old/arch/i386/kernel/mpparse.c	2004-06-22 21:40:01.608433040 -0700
+++ linux-2.6.7/arch/i386/kernel/mpparse.c	2004-06-22 21:43:20.943129560 -0700
@@ -1017,7 +1017,6 @@ void __init mp_config_acpi_legacy_irqs (
 
 		for (idx = 0; idx < mp_irq_entries; idx++)
 			if (mp_irqs[idx].mpc_srcbus == MP_ISA_BUS &&
-				(mp_irqs[idx].mpc_dstapic == ioapic) &&
 				(mp_irqs[idx].mpc_srcbusirq == i ||
 				mp_irqs[idx].mpc_dstirq == i))
 					break;
diff -urpN linux-2.6.7-old/arch/x86_64/kernel/mpparse.c linux-2.6.7/arch/x86_64/kernel/mpparse.c
--- linux-2.6.7-old/arch/x86_64/kernel/mpparse.c	2004-06-22 21:40:09.816185272 -0700
+++ linux-2.6.7/arch/x86_64/kernel/mpparse.c	2004-06-22 21:43:38.899399792 -0700
@@ -861,7 +861,6 @@ void __init mp_config_acpi_legacy_irqs (
 
 		for (idx = 0; idx < mp_irq_entries; idx++)
 			if (mp_irqs[idx].mpc_srcbus == MP_ISA_BUS &&
-				(mp_irqs[idx].mpc_dstapic == intsrc.mpc_dstapic) &&
 				(mp_irqs[idx].mpc_srcbusirq == i ||
 				mp_irqs[idx].mpc_dstirq == i))
 					break;
diff -urpN linux-2.6.7-old/include/linux/kernel.h linux-2.6.7/include/linux/kernel.h
--- linux-2.6.7-old/include/linux/kernel.h	2004-06-22 21:40:40.858466128 -0700
+++ linux-2.6.7/include/linux/kernel.h	2004-06-22 21:44:00.644094096 -0700
@@ -55,7 +55,12 @@ void __might_sleep(char *file, int line)
 #endif
 
 #define abs(x) ({				\
-		typeof(x) __x = (x);		\
+		int __x = (x);			\
+		(__x < 0) ? -__x : __x;		\
+	})
+
+#define labs(x) ({				\
+		long __x = (x);			\
 		(__x < 0) ? -__x : __x;		\
 	})
 

--Boundary-00=_jtQ2AG/XPHgDsuC--
