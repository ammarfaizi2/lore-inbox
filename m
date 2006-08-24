Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965055AbWHXPzZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965055AbWHXPzZ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Aug 2006 11:55:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964997AbWHXPzZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Aug 2006 11:55:25 -0400
Received: from nf-out-0910.google.com ([64.233.182.185]:11624 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S965055AbWHXPzW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Aug 2006 11:55:22 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=a3htZHV9dVMDla7jfCnEymjxMQv6R8WS5hsoOjKHPTq0TaQ7jxXWQjdsv2LhSs4NEQSO8Ta5E1DoEE89jY63MlHHZlh53lWsMmKP22vVfyMS0e2uGgJGpVEsbq2lAxYvOkdGjKwkzbBpYOfNjtHgUfRwOt5ogtZq1B8BuS7gDYU=
Message-ID: <37a5ad990608240855w45cd8dcfm21edafd6cfe0631f@mail.gmail.com>
Date: Thu, 24 Aug 2006 23:55:21 +0800
From: "Zhen Zhou" <linuxnb@gmail.com>
To: "Andy Chittenden" <AChittenden@bluearc.com>
Subject: Re: 2.6.17 hangs during boot on ASUS M2NPV-VM motherboard
Cc: "Andrew Morton" <akpm@osdl.org>, linux-kernel@vger.kernel.org
In-Reply-To: <89E85E0168AD994693B574C80EDB9C27043F5EBA@uk-email.terastack.bluearc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <AcamZU83D6YFwDlPRZGLtXEmxZel2wAJqNMg>
	 <89E85E0168AD994693B574C80EDB9C27043F5EBA@uk-email.terastack.bluearc.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/13/06, Andy Chittenden <AChittenden@bluearc.com> wrote:
> > On Thu, 13 Jul 2006 08:56:01 +0100
> > "Andy Chittenden" <AChittenden@bluearc.com> wrote:
> >
> > > > On Wed, 12 Jul 2006 08:58:52 +0100
> > > > "Andy Chittenden" <AChittenden@bluearc.com> wrote:
> > > >
> > > > > I tried to install the linux-image-2.6.17-1-amd64-k8-smp
> > > > debian package
> > > > > on a ASUS M2NPV-VM motherboard based system and it hung
> > > > during boot. The
> > > > > last message on the console was:
> > > > >
> > > > >  io scheduler cfq registered
> > > >
> > > > Suggest you add initcall_debug to the kernel boot command
> > > > line.  That'll
> > > > tell us which initcall got stuck.
> > >
> > > I was only able to scrounge 5 minutes on this system this morning.
> > > Here's the last few messages output with initcall_debug on:
> > >
> > > Calling initcall .... init+0x0/0xc()
> > > Calling initcall .... noop_init+0x0/0xc()
> > > io scheduler noop registered
> > > Calling initcall .... as_init+0x0/0x4f()
> > > io scheduler anticipatory registered (default)
> > > Calling initcall .... deadline_init+0x0/0x4f()
> > > io scheduler deadline registered
> > > Calling initcall .... cfq_init+0x0/0xcc()
> > > io scheduler cfq registered
> > > Calling initcall .... pci_init+0x0/0x2b()
> > >
> > > What other info can I grab? (Although I have to fit in with that
> > > system's production schedule so I may not be able to come
> > back with that
> > > until later on today/tomorrow).
> >
> > Seems one of the quirks has gone bad.  The below should tell
> > us which one.
> > You'll need to correlate it with the machine's lspci output please.
> >
> >
> > --- a/drivers/pci/pci.c~a
> > +++ a/drivers/pci/pci.c
> > @@ -925,6 +925,7 @@ static int __devinit pci_init(void)
> >       struct pci_dev *dev = NULL;
> >
> >       while ((dev = pci_get_device(PCI_ANY_ID, PCI_ANY_ID,
> > dev)) != NULL) {
> > +             printk("%s: fix up %s\n", __FUNCTION__, pci_name(dev));
> >               pci_fixup_device(pci_fixup_final, dev);
> >       }
> >       return 0;
>
> Having applied that patch, I get:
>
> pci_init: fix up 0000:00:00.0
> pci_init: fix up 0000:00:00.1
> pci_init: fix up 0000:00:00.2
> pci_init: fix up 0000:00:00.3
> pci_init: fix up 0000:00:00.4
> pci_init: fix up 0000:00:00.5
> pci_init: fix up 0000:00:00.6
> pci_init: fix up 0000:00:00.7
> pci_init: fix up 0000:00:02.0
> pci_init: fix up 0000:00:03.0
> pci_init: fix up 0000:00:04.0
> pci_init: fix up 0000:00:05.0
> pci_init: fix up 0000:00:09.0
> pci_init: fix up 0000:00:0a.0
> pci_init: fix up 0000:00:0a.1
> pci_init: fix up 0000:00:0a.2
> pci_init: fix up 0000:00:0b.0
>
> lspci -v gives:
>
> 00:00.0 RAM memory: nVidia Corporation C51 Host Bridge (rev a2)
>         Subsystem: ASUSTeK Computer Inc. Unknown device 81c0
>         Flags: bus master, 66MHz, fast devsel, latency 0
>         Capabilities: [44] HyperTransport: Slave or Primary Interface
>         Capabilities: [e0] HyperTransport: MSI Mapping
>
> 00:00.1 RAM memory: nVidia Corporation C51 Memory Controller 0 (rev a2)
>         Subsystem: ASUSTeK Computer Inc. Unknown device 81c0
>         Flags: 66MHz, fast devsel
>
> 00:00.2 RAM memory: nVidia Corporation C51 Memory Controller 1 (rev a2)
>         Subsystem: ASUSTeK Computer Inc. Unknown device 81c0
>         Flags: 66MHz, fast devsel
>
> 00:00.3 RAM memory: nVidia Corporation C51 Memory Controller 5 (rev a2)
>         Subsystem: ASUSTeK Computer Inc. Unknown device 81c0
>         Flags: 66MHz, fast devsel
>
> 00:00.4 RAM memory: nVidia Corporation C51 Memory Controller 4 (rev a2)
>         Subsystem: ASUSTeK Computer Inc. Unknown device 81c0
>         Flags: bus master, 66MHz, fast devsel, latency 0
>
> 00:00.5 RAM memory: nVidia Corporation C51 Host Bridge (rev a2)
>         Subsystem: ASUSTeK Computer Inc. Unknown device 81c0
>         Flags: bus master, 66MHz, fast devsel, latency 0
>         Capabilities: [44] #00 [00fe]
>         Capabilities: [fc] #00 [0000]
>
> 00:00.6 RAM memory: nVidia Corporation C51 Memory Controller 3 (rev a2)
>         Subsystem: ASUSTeK Computer Inc. Unknown device 81c0
>         Flags: 66MHz, fast devsel
>
> 00:00.7 RAM memory: nVidia Corporation C51 Memory Controller 2 (rev a2)
>         Subsystem: ASUSTeK Computer Inc. Unknown device 81c0
>         Flags: 66MHz, fast devsel
>
> 00:02.0 PCI bridge: nVidia Corporation C51 PCI Express Bridge (rev a1)
> (prog-if 00 [Normal decode])
>         Flags: bus master, fast devsel, latency 0
>         Bus: primary=00, secondary=01, subordinate=01, sec-latency=0
>         I/O behind bridge: 0000a000-0000afff
>         Memory behind bridge: fd800000-fd8fffff
>         Prefetchable memory behind bridge:
> 00000000fd700000-00000000fd700000
>         Capabilities: [40] #0d [0000]
>         Capabilities: [48] Power Management version 2
>         Capabilities: [50] Message Signalled Interrupts: 64bit+
> Queue=0/1 Enable+
>         Capabilities: [60] HyperTransport: MSI Mapping
>         Capabilities: [80] Express Root Port (Slot+) IRQ 0
>         Capabilities: [100] Virtual Channel
>
> 00:03.0 PCI bridge: nVidia Corporation C51 PCI Express Bridge (rev a1)
> (prog-if 00 [Normal decode])
>         Flags: bus master, fast devsel, latency 0
>         Bus: primary=00, secondary=02, subordinate=02, sec-latency=0
>         I/O behind bridge: 00008000-00008fff
>         Memory behind bridge: fde00000-fdefffff
>         Prefetchable memory behind bridge:
> 00000000fdd00000-00000000fdd00000
>         Capabilities: [40] #0d [0000]
>         Capabilities: [48] Power Management version 2
>         Capabilities: [50] Message Signalled Interrupts: 64bit+
> Queue=0/1 Enable+
>         Capabilities: [60] HyperTransport: MSI Mapping
>         Capabilities: [80] Express Root Port (Slot+) IRQ 0
>         Capabilities: [100] Virtual Channel
>
> 00:04.0 PCI bridge: nVidia Corporation C51 PCI Express Bridge (rev a1)
> (prog-if 00 [Normal decode])
>         Flags: bus master, fast devsel, latency 0
>         Bus: primary=00, secondary=03, subordinate=03, sec-latency=0
>         I/O behind bridge: 0000b000-0000bfff
>         Memory behind bridge: fdc00000-fdcfffff
>         Prefetchable memory behind bridge:
> 00000000fd900000-00000000fd900000
>         Capabilities: [40] #0d [0000]
>         Capabilities: [48] Power Management version 2
>         Capabilities: [50] Message Signalled Interrupts: 64bit+
> Queue=0/1 Enable+
>         Capabilities: [60] HyperTransport: MSI Mapping
>         Capabilities: [80] Express Root Port (Slot+) IRQ 0
>         Capabilities: [100] Virtual Channel
>
> 00:05.0 VGA compatible controller: nVidia Corporation C51PV [GeForce
> 6150] (rev a2) (prog-if 00 [VGA])
>         Subsystem: ASUSTeK Computer Inc. Unknown device 81cd
>         Flags: bus master, 66MHz, fast devsel, latency 0, IRQ 58
>         Memory at fc000000 (32-bit, non-prefetchable) [size=16M]
>         Memory at e0000000 (64-bit, prefetchable) [size=256M]
>         Memory at fb000000 (64-bit, non-prefetchable) [size=16M]
>         [virtual] Expansion ROM at dc000000 [disabled] [size=128K]
>         Capabilities: [48] Power Management version 2
>         Capabilities: [50] Message Signalled Interrupts: 64bit+
> Queue=0/0 Enable-
>
> 00:09.0 RAM memory: nVidia Corporation MCP51 Host Bridge (rev a2)
>         Subsystem: ASUSTeK Computer Inc. Unknown device 81c0
>         Flags: bus master, 66MHz, fast devsel, latency 0
>         Capabilities: [44] HyperTransport: Slave or Primary Interface
>         Capabilities: [e0] HyperTransport: MSI Mapping
>
> 00:0a.0 ISA bridge: nVidia Corporation MCP51 LPC Bridge (rev a3)
>         Subsystem: ASUSTeK Computer Inc. Unknown device 81c0
>         Flags: bus master, 66MHz, fast devsel, latency 0
>
> 00:0a.1 SMBus: nVidia Corporation MCP51 SMBus (rev a3)
>         Subsystem: ASUSTeK Computer Inc. Unknown device 81c0
>         Flags: 66MHz, fast devsel, IRQ 255
>         I/O ports at 4c00 [size=64]
>         I/O ports at 4c40 [size=64]
>         Capabilities: [44] Power Management version 2
>
> 00:0a.2 RAM memory: nVidia Corporation MCP51 Memory Controller 0 (rev
> a3)
>         Subsystem: ASUSTeK Computer Inc. Unknown device 81c0
>         Flags: 66MHz, fast devsel
>
> 00:0b.0 USB Controller: nVidia Corporation MCP51 USB Controller (rev a3)
> (prog-if 10 [OHCI])
>         Subsystem: ASUSTeK Computer Inc. Unknown device 81c0
>         Flags: bus master, 66MHz, fast devsel, latency 0, IRQ 233
>         Memory at fe02f000 (32-bit, non-prefetchable) [size=4K]
>         Capabilities: [44] Power Management version 2
>
> 00:0b.1 USB Controller: nVidia Corporation MCP51 USB Controller (rev a3)
> (prog-if 20 [EHCI])
>         Subsystem: ASUSTeK Computer Inc. Unknown device 81c0
>         Flags: bus master, 66MHz, fast devsel, latency 0, IRQ 217
>         Memory at fe02e000 (32-bit, non-prefetchable) [size=256]
>         Capabilities: [44] Debug port
>         Capabilities: [80] Power Management version 2
>
> 00:0d.0 IDE interface: nVidia Corporation MCP51 IDE (rev a1) (prog-if 8a
> [Master SecP PriP])
>         Subsystem: ASUSTeK Computer Inc. Unknown device 81c0
>         Flags: bus master, 66MHz, fast devsel, latency 0
>         I/O ports at f400 [size=16]
>         Capabilities: [44] Power Management version 2
>
> 00:0e.0 IDE interface: nVidia Corporation MCP51 Serial ATA Controller
> (rev a1) (prog-if 85 [Master SecO PriO])
>         Subsystem: ASUSTeK Computer Inc. Unknown device 81c0
>         Flags: bus master, 66MHz, fast devsel, latency 0, IRQ 50
>         I/O ports at 09f0 [size=8]
>         I/O ports at 0bf0 [size=4]
>         I/O ports at 0970 [size=8]
>         I/O ports at 0b70 [size=4]
>         I/O ports at e000 [size=16]
>         Memory at fe02d000 (32-bit, non-prefetchable) [size=4K]
>         Capabilities: [44] Power Management version 2
>         Capabilities: [b0] Message Signalled Interrupts: 64bit+
> Queue=0/2 Enable-
>         Capabilities: [cc] HyperTransport: MSI Mapping
>
> 00:0f.0 IDE interface: nVidia Corporation MCP51 Serial ATA Controller
> (rev a1) (prog-if 85 [Master SecO PriO])
>         Subsystem: ASUSTeK Computer Inc. Unknown device 81c0
>         Flags: bus master, 66MHz, fast devsel, latency 0, IRQ 217
>         I/O ports at 09e0 [size=8]
>         I/O ports at 0be0 [size=4]
>         I/O ports at 0960 [size=8]
>         I/O ports at 0b60 [size=4]
>         I/O ports at cc00 [size=16]
>         Memory at fe02c000 (32-bit, non-prefetchable) [size=4K]
>         Capabilities: [44] Power Management version 2
>         Capabilities: [b0] Message Signalled Interrupts: 64bit+
> Queue=0/2 Enable-
>         Capabilities: [cc] HyperTransport: MSI Mapping
>
> 00:10.0 PCI bridge: nVidia Corporation MCP51 PCI Bridge (rev a2)
> (prog-if 01 [Subtractive decode])
>         Flags: bus master, 66MHz, fast devsel, latency 0
>         Bus: primary=00, secondary=04, subordinate=04, sec-latency=128
>         I/O behind bridge: 00009000-00009fff
>         Memory behind bridge: fdb00000-fdbfffff
>         Prefetchable memory behind bridge: fda00000-fdafffff
>         Capabilities: [b8] #0d [0000]
>         Capabilities: [8c] HyperTransport: MSI Mapping
>
> 00:10.1 Audio device: nVidia Corporation MCP51 High Definition Audio
> (rev a2)
>         Subsystem: ASUSTeK Computer Inc. Unknown device 81cb
>         Flags: bus master, 66MHz, fast devsel, latency 0, IRQ 225
>         Memory at fe024000 (32-bit, non-prefetchable) [size=16K]
>         Capabilities: [44] Power Management version 2
>         Capabilities: [50] Message Signalled Interrupts: 64bit+
> Queue=0/0 Enable-
>         Capabilities: [6c] HyperTransport: MSI Mapping
>
> 00:14.0 Bridge: nVidia Corporation MCP51 Ethernet Controller (rev a3)
>         Subsystem: ASUSTeK Computer Inc. Unknown device 816a
>         Flags: bus master, 66MHz, fast devsel, latency 0, IRQ 225
>         Memory at fe02b000 (32-bit, non-prefetchable) [size=4K]
>         I/O ports at c800 [size=8]
>         Capabilities: [44] Power Management version 2
>
> 00:18.0 Host bridge: Advanced Micro Devices [AMD] K8 [Athlon64/Opteron]
> HyperTransport Technology Configuration
>         Flags: fast devsel
>         Capabilities: [80] HyperTransport: Host or Secondary Interface
>
> 00:18.1 Host bridge: Advanced Micro Devices [AMD] K8 [Athlon64/Opteron]
> Address Map
>         Flags: fast devsel
>
> 00:18.2 Host bridge: Advanced Micro Devices [AMD] K8 [Athlon64/Opteron]
> DRAM Controller
>         Flags: fast devsel
>
> 00:18.3 Host bridge: Advanced Micro Devices [AMD] K8 [Athlon64/Opteron]
> Miscellaneous Control
>         Flags: fast devsel
>         Capabilities: [f0] #0f [0010]
>
> 04:05.0 FireWire (IEEE 1394): Texas Instruments TSB43AB22/A
> IEEE-1394a-2000 Controller (PHY/Link) (prog-if 10 [OHCI])
>         Subsystem: ASUSTeK Computer Inc. K8N4-E Mainboard
>         Flags: bus master, medium devsel, latency 32, IRQ 209
>         Memory at fdbff000 (32-bit, non-prefetchable) [size=2K]
>         Memory at fdbf8000 (32-bit, non-prefetchable) [size=16K]
>         Capabilities: [44] Power Management version 2
>
> So I guess there's something awry with the USB controller driver?
>
> --
> Andy, BlueArc Engineering
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>
Why don't you think this is usb problem?

I use motherboard ASUS M2NPV-MX, I use Fedora 5. I got the same
problem that you had, after I upgrade kernel from 2.6.15-1.2054 to
kernel-2.6.17-1.2174_FC5, it hung on boot:

io scheduler cfq registered

So I guess this related with new nforce chipset, but have no idea
which components got trouble.

here is my dmesg:

Bootdata ok (command line is ro root=/dev/VolGroup00/LogVol00 rhgb quiet)
Linux version 2.6.15-1.2054_FC5
(bhcompile@hs20-bc1-7.build.redhat.com) (gcc version 4.1.0 20060304
(Red Hat 4.1.0-3)) #1 SMP Tue Mar 14 15:48:20 EST 2006
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009f000 (usable)
 BIOS-e820: 000000000009f000 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 000000003def0000 (usable)
  BIOS-e820: 000000003def0000 - 000000003def3000 (ACPI NVS)
  BIOS-e820: 000000003def3000 - 000000003df00000 (ACPI data)
 BIOS-e820: 000000003e000000 - 0000000040000000 (reserved)
 BIOS-e820: 00000000f0000000 - 00000000f4000000 (reserved)
 BIOS-e820: 00000000fec00000 - 0000000100000000 (reserved)
ACPI: RSDP (v000 Nvidia                                ) @ 0x00000000000f7240
ACPI: RSDT (v001 Nvidia AWRDACPI 0x42302e31 AWRD 0x00000000) @
0x000000003def3040
ACPI: FADT (v001 Nvidia AWRDACPI 0x42302e31 AWRD 0x00000000) @
0x000000003def30c0
ACPI: SSDT (v001 PTLTD  POWERNOW 0x00000001  LTP 0x00000001) @
0x000000003defaf40
ACPI: MCFG (v001 Nvidia AWRDACPI 0x42302e31 AWRD 0x00000000) @
0x000000003defb180
ACPI: MADT (v001 Nvidia AWRDACPI 0x42302e31 AWRD 0x00000000) @
0x000000003defae80
ACPI: DSDT (v001 NVIDIA AWRDACPI 0x00001000 MSFT 0x0100000e) @
0x0000000000000000
Scanning NUMA topology in Northbridge 24
Number of nodes 1
Node 0 MemBase 0000000000000000 Limit 000000003def0000
NUMA: Using 63 for the hash shift.
Using node hash shift of 63
Bootmem setup node 0 0000000000000000-000000003def0000
On node 0 totalpages: 248471
  DMA zone: 2786 pages, LIFO batch:0
  DMA32 zone: 245685 pages, LIFO batch:31
  Normal zone: 0 pages, LIFO batch:0
  HighMem zone: 0 pages, LIFO batch:0
Nvidia board detected. Ignoring ACPI timer override.
ACPI: PM-Timer IO Port: 0x4008
ACPI: Local APIC address 0xfee00000
ACPI: LAPIC (acpi_id[0x00] lapic_id[0x00] enabled)
Processor #0 15:11 APIC version 16
ACPI: LAPIC (acpi_id[0x01] lapic_id[0x01] enabled)
Processor #1 15:11 APIC version 16
ACPI: LAPIC_NMI (acpi_id[0x00] high edge lint[0x1])
ACPI: LAPIC_NMI (acpi_id[0x01] high edge lint[0x1])
ACPI: IOAPIC (id[0x02] address[0xfec00000] gsi_base[0])
IOAPIC[0]: apic_id 2, version 17, address 0xfec00000, GSI 0-23
ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
ACPI: BIOS IRQ0 pin2 override ignored.
ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 high level)
ACPI: INT_SRC_OVR (bus 0 bus_irq 14 global_irq 14 high edge)
ACPI: INT_SRC_OVR (bus 0 bus_irq 15 global_irq 15 high edge)
ACPI: IRQ9 used by override.
ACPI: IRQ14 used by override.
ACPI: IRQ15 used by override.
Setting APIC routing to physical flat
Using ACPI (MADT) for SMP configuration information
Allocating PCI resources starting at 50000000 (gap: 40000000:b0000000)
Checking aperture...
CPU 0: aperture @ 0 size 32 MB
No AGP bridge found
SMP: Allowing 2 CPUs, 0 hotplug CPUs
Built 1 zonelists
Kernel command line: ro root=/dev/VolGroup00/LogVol00 rhgb quiet
Initializing CPU#0
PID hash table entries: 4096 (order: 12, 131072 bytes)
Disabling vsyscall due to use of PM timer
time.c: Using 3.579545 MHz WALL PM GTOD PM timer.
time.c: Detected 2004.220 MHz processor.
Console: colour VGA+ 80x25
Dentry cache hash table entries: 131072 (order: 8, 1048576 bytes)
Inode-cache hash table entries: 65536 (order: 7, 524288 bytes)
Memory: 990216k/1014720k available (2307k kernel code, 24116k
reserved, 1212k data, 196k init)
Calibrating delay using timer specific routine.. 4017.51 BogoMIPS (lpj=8035039)
Security Framework v1.0.0 initialized
SELinux:  Initializing.
SELinux:  Starting in permissive mode
selinux_register_security:  Registering secondary module capability
Capability LSM initialized as secondary
Mount-cache hash table entries: 256
CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
CPU: L2 Cache: 512K (64 bytes/line)
CPU 0(2) -> Node 0 -> Core 0
..MP-BIOS bug: 8254 timer not connected to IO-APIC
 failed.
Using local APIC timer interrupts.
result 12526393
Detected 12.526 MHz APIC timer.
Booting processor 1/2 APIC 0x1
Initializing CPU#1
Calibrating delay using timer specific routine.. 4017.32 BogoMIPS (lpj=8034659)
CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
CPU: L2 Cache: 512K (64 bytes/line)
CPU 1(2) -> Node 0 -> Core 1
AMD Athlon(tm) 64 X2 Dual Core Processor 3800+ stepping 02
CPU 1: Syncing TSC to CPU 0.
CPU 1: synchronized TSC with CPU 0 (last diff 0 cycles, maxerr 521 cycles)
Brought up 2 CPUs
testing NMI watchdog ... OK.
migration_cost=306
checking if image is initramfs... it is
Freeing initrd memory: 1858k freed
DMI 2.3 present.
NET: Registered protocol family 16
ACPI: bus type pci registered
PCI: Using configuration type 1
PCI: Using MMCONFIG at f0000000
ACPI: Subsystem revision 20060127
ACPI: Interpreter enabled
ACPI: Using IOAPIC for interrupt routing
ACPI: PCI Root Bridge [PCI0] (0000:00)
PCI: Probing PCI hardware (bus 00)
Boot video device is 0000:00:05.0
PCI: Transparent bridge - 0000:00:10.0
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.HUB0._PRT]
ACPI: PCI Interrupt Link [LNK1] (IRQs 5 7 9 10 11 14 15) *0, disabled.
ACPI: PCI Interrupt Link [LNK2] (IRQs 5 7 9 10 11 14 15) *0, disabled.
ACPI: PCI Interrupt Link [LNK3] (IRQs 5 7 9 10 11 14 15) *0, disabled.
ACPI: PCI Interrupt Link [LNK4] (IRQs 5 7 9 10 11 14 15) *0, disabled.
ACPI: PCI Interrupt Link [LNK5] (IRQs 5 7 9 10 11 14 15) *0, disabled.
ACPI: PCI Interrupt Link [LNK6] (IRQs 5 7 9 10 11 14 15) *0, disabled.
ACPI: PCI Interrupt Link [LNK7] (IRQs *5 7 9 10 11 14 15)
ACPI: PCI Interrupt Link [LNK8] (IRQs 5 7 9 10 11 14 15) *0, disabled.
ACPI: PCI Interrupt Link [LUBA] (IRQs *5 7 9 10 11 14 15)
ACPI: PCI Interrupt Link [LUBB] (IRQs 5 7 9 10 11 14 15) *0, disabled.
ACPI: PCI Interrupt Link [LMAC] (IRQs 5 7 9 10 *11 14 15)
ACPI: PCI Interrupt Link [LACI] (IRQs 5 7 9 10 11 14 15) *0, disabled.
ACPI: PCI Interrupt Link [LAZA] (IRQs 5 7 9 10 *11 14 15)
ACPI: PCI Interrupt Link [LPMU] (IRQs 5 7 9 10 11 14 15) *0, disabled.
ACPI: PCI Interrupt Link [LMCI] (IRQs 5 7 9 10 11 14 15) *0, disabled.
ACPI: PCI Interrupt Link [LSMB] (IRQs 5 7 9 *10 11 14 15)
ACPI: PCI Interrupt Link [LUB2] (IRQs *5 7 9 10 11 14 15)
ACPI: PCI Interrupt Link [LIDE] (IRQs 5 7 9 10 11 14 15) *0, disabled.
ACPI: PCI Interrupt Link [LSID] (IRQs *5 7 9 10 11 14 15)
ACPI: PCI Interrupt Link [LFID] (IRQs 5 7 9 10 *11 14 15)
ACPI: PCI Interrupt Link [APC1] (IRQs 16) *0, disabled.
ACPI: PCI Interrupt Link [APC2] (IRQs 17) *0, disabled.
ACPI: PCI Interrupt Link [APC3] (IRQs 18) *0, disabled.
ACPI: PCI Interrupt Link [APC4] (IRQs 19) *0, disabled.
ACPI: PCI Interrupt Link [APC5] (IRQs 16) *0, disabled.
ACPI: PCI Interrupt Link [APC6] (IRQs 16) *0, disabled.
ACPI: PCI Interrupt Link [APC7] (IRQs 16) *0, disabled.
ACPI: PCI Interrupt Link [APC8] (IRQs 16) *0, disabled.
ACPI: PCI Interrupt Link [APCF] (IRQs 20 21 22 23) *0, disabled.
ACPI: PCI Interrupt Link [APCG] (IRQs 20 21 22 23) *0, disabled.
ACPI: PCI Interrupt Link [APCH] (IRQs 20 21 22 23) *0, disabled.
ACPI: PCI Interrupt Link [APCJ] (IRQs 20 21 22 23) *0, disabled.
ACPI: PCI Interrupt Link [APMU] (IRQs 20 21 22 23) *0, disabled.
ACPI: PCI Interrupt Link [AAZA] (IRQs 20 21 22 23) *0, disabled.
ACPI: PCI Interrupt Link [APCK] (IRQs 20 21 22 23) *0, disabled.
ACPI: PCI Interrupt Link [APCS] (IRQs 20 21 22 23) *0, disabled.
ACPI: PCI Interrupt Link [APCL] (IRQs 20 21 22 23) *0, disabled.
ACPI: PCI Interrupt Link [APCM] (IRQs 20 21 22 23) *0, disabled.
ACPI: PCI Interrupt Link [APCZ] (IRQs 20 21 22 23) *0, disabled.
ACPI: PCI Interrupt Link [APSI] (IRQs 20 21 22 23) *0, disabled.
ACPI: PCI Interrupt Link [APSJ] (IRQs 20 21 22 23) *0, disabled.
Linux Plug and Play Support v0.97 (c) Adam Belay
pnp: PnP ACPI init
pnp: PnP ACPI: found 12 devices
usbcore: registered new driver usbfs
usbcore: registered new driver hub
PCI: Using ACPI for IRQ routing
PCI: If a device doesn't work, try "pci=routeirq".  If it helps, post a report
PCI-DMA: Disabling IOMMU.
pnp: 00:01: ioport range 0x4000-0x407f could not be reserved
pnp: 00:01: ioport range 0x4080-0x40ff has been reserved
pnp: 00:01: ioport range 0x4400-0x447f has been reserved
pnp: 00:01: ioport range 0x4480-0x44ff could not be reserved
pnp: 00:01: ioport range 0x4800-0x487f has been reserved
pnp: 00:01: ioport range 0x4880-0x48ff has been reserved
pnp: 00:01: ioport range 0x2000-0x207f has been reserved
pnp: 00:01: ioport range 0x2080-0x20ff has been reserved
PCI: Bridge: 0000:00:02.0
  IO window: a000-afff
  MEM window: fd800000-fd8fffff
  PREFETCH window: fd700000-fd7fffff
PCI: Bridge: 0000:00:03.0
  IO window: 8000-8fff
  MEM window: fde00000-fdefffff
  PREFETCH window: fdd00000-fddfffff
PCI: Bridge: 0000:00:04.0
  IO window: b000-bfff
  MEM window: fdc00000-fdcfffff
  PREFETCH window: fd900000-fd9fffff
PCI: Bridge: 0000:00:10.0
  IO window: 9000-9fff
  MEM window: fdb00000-fdbfffff
  PREFETCH window: fda00000-fdafffff
PCI: Setting latency timer of device 0000:00:02.0 to 64
PCI: Setting latency timer of device 0000:00:03.0 to 64
PCI: Setting latency timer of device 0000:00:04.0 to 64
PCI: Setting latency timer of device 0000:00:10.0 to 64
IA32 emulation $Id: sys_ia32.c,v 1.32 2002/03/24 13:02:28 ak Exp $
audit: initializing netlink socket (disabled)
audit(1156424473.468:1): initialized
Total HugeTLB memory allocated, 0
VFS: Disk quotas dquot_6.5.1
Dquot-cache hash table entries: 512 (order 0, 4096 bytes)
SELinux:  Registering netfilter hooks
Initializing Cryptographic API
ksign: Installing public key data
Loading keyring
- Added public key E0DE27A645ACF9C1
- User ID: Red Hat, Inc. (Kernel Module GPG key)
io scheduler noop registered
io scheduler anticipatory registered
io scheduler deadline registered
io scheduler cfq registered (default)
PCI: Setting latency timer of device 0000:00:02.0 to 64
pcie_portdrv_probe->Dev[02fc:10de] has invalid IRQ. Check vendor BIOS
assign_interrupt_mode Found MSI capability
Allocate Port Service[0000:00:02.0:pcie00]
Allocate Port Service[0000:00:02.0:pcie03]
PCI: Setting latency timer of device 0000:00:03.0 to 64
pcie_portdrv_probe->Dev[02fd:10de] has invalid IRQ. Check vendor BIOS
assign_interrupt_mode Found MSI capability
Allocate Port Service[0000:00:03.0:pcie00]
Allocate Port Service[0000:00:03.0:pcie03]
PCI: Setting latency timer of device 0000:00:04.0 to 64
pcie_portdrv_probe->Dev[02fb:10de] has invalid IRQ. Check vendor BIOS
assign_interrupt_mode Found MSI capability
Allocate Port Service[0000:00:04.0:pcie00]
Allocate Port Service[0000:00:04.0:pcie03]
pci_hotplug: PCI Hot Plug PCI Core version: 0.5
ACPI: Fan [FAN] (on)
ACPI: Thermal Zone [THRM] (40 C)
Real Time Clock Driver v1.12ac
Linux agpgart interface v0.101 (c) Dave Jones
PNP: PS/2 Controller [PNP0303:PS2K] at 0x60,0x64 irq 1
PNP: PS/2 controller doesn't have AUX irq; using default 12
serio: i8042 AUX port at 0x60,0x64 irq 12
serio: i8042 KBD port at 0x60,0x64 irq 1
Serial: 8250/16550 driver $Revision: 1.90 $ 4 ports, IRQ sharing enabled
serial8250: ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
00:07: ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
isa bounce pool size: 16 pages
RAMDISK driver initialized: 16 RAM disks of 16384K size 1024 blocksize
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
NFORCE-MCP51: IDE controller at PCI slot 0000:00:0d.0
NFORCE-MCP51: chipset revision 161
NFORCE-MCP51: not 100% native mode: will probe irqs later
NFORCE-MCP51: 0000:00:0d.0 (rev a1) UDMA133 controller
    ide0: BM-DMA at 0xf400-0xf407, BIOS settings: hda:DMA, hdb:DMA
    ide1: BM-DMA at 0xf408-0xf40f, BIOS settings: hdc:DMA, hdd:DMA
Probing IDE interface ide0...
hda: SONY CD-RW CRX175A1, ATAPI CD/DVD-ROM drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
Probing IDE interface ide1...
Probing IDE interface ide1...
hda: ATAPI 40X CD-ROM CD-R/RW drive, 2048kB Cache, UDMA(33)
Uniform CD-ROM driver Revision: 3.20
ide-floppy driver 0.99.newide
usbcore: registered new driver libusual
usbcore: registered new driver hiddev
usbcore: registered new driver usbhid
drivers/usb/input/hid-core.c: v2.6:USB HID core driver
mice: PS/2 mouse device common for all mice
md: md driver 0.90.3 MAX_MD_DEVS=256, MD_SB_DISKS=27
md: bitmap version 4.39
NET: Registered protocol family 2
IP route cache hash table entries: 32768 (order: 6, 262144 bytes)
TCP established hash table entries: 131072 (order: 10, 4194304 bytes)
TCP bind hash table entries: 65536 (order: 9, 2097152 bytes)
TCP: Hash tables configured (established 131072 bind 65536)
TCP reno registered
TCP bic registered
Initializing IPsec netlink socket
NET: Registered protocol family 1
NET: Registered protocol family 17
powernow-k8: Found 2 AMD Athlon 64 / Opteron processors (version 1.60.0)
powernow-k8:    0 : fid 0xc (2000 MHz), vid 0xa (1300 mV)
powernow-k8:    1 : fid 0xa (1800 MHz), vid 0xc (1250 mV)
powernow-k8:    2 : fid 0x2 (1000 MHz), vid 0x12 (1100 mV)
cpu_init done, current fid 0xc, vid 0xa
ACPI wakeup devices:
HUB0 XVRA XVRB XVRC USB0 USB2 AZAD MMAC MMCI UAR1 PS2K
ACPI: (supports S0 S1 S3 S4 S5)
Freeing unused kernel memory: 196k freed
Write protecting the kernel read-only data: 432k
input: AT Translated Set 2 keyboard as /class/input/input0
SCSI subsystem initialized
libata version 1.20 loaded.
sata_nv 0000:00:0e.0: version 0.8
ACPI: PCI Interrupt Link [APSI] enabled at IRQ 23
GSI 16 sharing vector 0xB1 and IRQ 16
ACPI: PCI Interrupt 0000:00:0e.0[A] -> Link [APSI] -> GSI 23 (level,
low) -> IRQ 16
PCI: Setting latency timer of device 0000:00:0e.0 to 64
ata1: SATA max UDMA/133 cmd 0x9F0 ctl 0xBF2 bmdma 0xE000 irq 16
ata2: SATA max UDMA/133 cmd 0x970 ctl 0xB72 bmdma 0xE008 irq 16
ata1: SATA link up 3.0 Gbps (SStatus 123)
ata1: dev 0 cfg 49:2f00 82:746b 83:7f01 84:4023 85:7469 86:3c01 87:4023 88:407f
ata1: dev 0 ATA-7, max UDMA/133, 312581808 sectors: LBA48
ata1: dev 0 configured for UDMA/133
scsi0 : sata_nv
ata2: SATA link down (SStatus 0)
scsi1 : sata_nv
  Vendor: ATA       Model: WDC WD1600JS-22M  Rev: 02.0
  Type:   Direct-Access                      ANSI SCSI revision: 05
SCSI device sda: 312581808 512-byte hdwr sectors (160042 MB)
sda: Write Protect is off
sda: Mode Sense: 00 3a 00 00
SCSI device sda: drive cache: write back
SCSI device sda: 312581808 512-byte hdwr sectors (160042 MB)
sda: Write Protect is off
sda: Mode Sense: 00 3a 00 00
SCSI device sda: drive cache: write back
 sda: sda1 sda2
sd 0:0:0:0: Attached scsi disk sda
ACPI: PCI Interrupt Link [APSJ] enabled at IRQ 22
GSI 17 sharing vector 0xB9 and IRQ 17
ACPI: PCI Interrupt 0000:00:0f.0[A] -> Link [APSJ] -> GSI 22 (level,
low) -> IRQ 17
PCI: Setting latency timer of device 0000:00:0f.0 to 64
ata3: SATA max UDMA/133 cmd 0x9E0 ctl 0xBE2 bmdma 0xCC00 irq 17
ata4: SATA max UDMA/133 cmd 0x960 ctl 0xB62 bmdma 0xCC08 irq 17
ata3: SATA link down (SStatus 0)
scsi2 : sata_nv
ata4: SATA link down (SStatus 0)
scsi3 : sata_nv
device-mapper: 4.5.0-ioctl (2005-10-04) initialised: dm-devel@redhat.com
ReiserFS: dm-0: found reiserfs format "3.6" with standard journal
ReiserFS: dm-0: using ordered data mode
ReiserFS: dm-0: journal params: device dm-0, size 8192, journal first
block 18, max trans len 1024, max batch 900, max commit age 30, max
trans age 30
ReiserFS: dm-0: checking transaction log (dm-0)
ReiserFS: dm-0: Using r5 hash to sort names
SELinux:  Disabled at runtime.
SELinux:  Unregistering netfilter hooks
forcedeth.c: Reverse Engineered nForce ethernet driver. Version 0.49.
ACPI: PCI Interrupt Link [APCH] enabled at IRQ 21
GSI 18 sharing vector 0xC1 and IRQ 18
ACPI: PCI Interrupt 0000:00:14.0[A] -> Link [APCH] -> GSI 21 (level,
low) -> IRQ 18
PCI: Setting latency timer of device 0000:00:14.0 to 64
ohci_hcd: 2005 April 22 USB 1.1 'Open' Host Controller (OHCI) Driver (PCI)
sd 0:0:0:0: Attached scsi generic sg0 type 0
eth0: forcedeth.c: subsystem: 01043:816a bound to 0000:00:14.0
ACPI: PCI Interrupt Link [APCF] enabled at IRQ 20
GSI 19 sharing vector 0xC9 and IRQ 19
ACPI: PCI Interrupt 0000:00:0b.0[A] -> Link [APCF] -> GSI 20 (level,
low) -> IRQ 19
PCI: Setting latency timer of device 0000:00:0b.0 to 64
ohci_hcd 0000:00:0b.0: OHCI Host Controller
ohci_hcd 0000:00:0b.0: new USB bus registered, assigned bus number 1
ohci_hcd 0000:00:0b.0: irq 19, io mem 0xfe02f000
usb usb1: configuration #1 chosen from 1 choice
hub 1-0:1.0: USB hub found
hub 1-0:1.0: 8 ports detected
ACPI: PCI Interrupt Link [AAZA] enabled at IRQ 23
ACPI: PCI Interrupt 0000:00:10.1[B] -> Link [AAZA] -> GSI 23 (level,
low) -> IRQ 16
PCI: Setting latency timer of device 0000:00:10.1 to 64
usb 1-3: new low speed USB device using ohci_hcd and address 2
usb 1-3: configuration #1 chosen from 1 choice
input: Logitech USB-PS/2 Optical Mouse as /class/input/input1
input: USB HID v1.10 Mouse [Logitech USB-PS/2 Optical Mouse] on
usb-0000:00:0b.0-3
ACPI: PCI Interrupt Link [APCL] enabled at IRQ 22
ACPI: PCI Interrupt 0000:00:0b.1[B] -> Link [APCL] -> GSI 22 (level,
low) -> IRQ 17
PCI: Setting latency timer of device 0000:00:0b.1 to 64
ehci_hcd 0000:00:0b.1: EHCI Host Controller
ehci_hcd 0000:00:0b.1: debug port 1
PCI: cache line size of 64 is not supported by device 0000:00:0b.1
ehci_hcd 0000:00:0b.1: new USB bus registered, assigned bus number 2
ehci_hcd 0000:00:0b.1: irq 17, io mem 0xfe02e000
ehci_hcd 0000:00:0b.1: USB 2.0 started, EHCI 1.00, driver 10 Dec 2004
usb usb2: configuration #1 chosen from 1 choice
hub 2-0:1.0: USB hub found
hub 2-0:1.0: 8 ports detected
usb 1-3: USB disconnect, address 2
usb 1-3: new low speed USB device using ohci_hcd and address 3
Non-volatile memory driver v1.2
usb 1-3: configuration #1 chosen from 1 choice
input: Logitech USB-PS/2 Optical Mouse as /class/input/input2
input: USB HID v1.10 Mouse [Logitech USB-PS/2 Optical Mouse] on
usb-0000:00:0b.0-3
floppy0: no floppy controllers found
parport: PnPBIOS parport detected.
parport0: PC-style at 0x378 (0x778), irq 7 [PCSPP,TRISTATE]
lp0: using parport0 (interrupt-driven).
lp0: console ready
NET: Registered protocol family 10
lo: Disabled Privacy Extensions
IPv6 over IPv4 tunneling driver
ACPI: Power Button (FF) [PWRF]
ACPI: Power Button (CM) [PWRB]
ibm_acpi: ec object not found
md: Autodetecting RAID arrays.
md: autorun ...
md: ... autorun DONE.
ReiserFS: sda1: found reiserfs format "3.6" with standard journal
ReiserFS: sda1: using ordered data mode
ReiserFS: sda1: journal params: device sda1, size 8192, journal first
block 18, max trans len 1024, max batch 900, max commit age 30, max
trans age 30
ReiserFS: sda1: checking transaction log (sda1)
ReiserFS: sda1: Using r5 hash to sort names
Adding 1998840k swap on /dev/VolGroup00/LogVol01.  Priority:-1
extents:1 across:1998840k

Zhou Zhen
