Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318691AbSICIwV>; Tue, 3 Sep 2002 04:52:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318696AbSICIwU>; Tue, 3 Sep 2002 04:52:20 -0400
Received: from portal.beam.ltd.uk ([62.49.82.227]:2449 "EHLO beam.beamnet")
	by vger.kernel.org with ESMTP id <S318691AbSICIwS>;
	Tue, 3 Sep 2002 04:52:18 -0400
Message-ID: <3D747950.8080605@beam.ltd.uk>
Date: Tue, 03 Sep 2002 09:56:48 +0100
From: Terry Barnaby <terry@beam.ltd.uk>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.0) Gecko/20020607
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: =?ISO-8859-1?Q?G=E9rard_Roudier?= <groudier@free.fr>
CC: linux-kernel@vger.kernel.org, mt <mt@beam.ltd.uk>
Subject: Re: Linux kernel lockup with BVM SCSI controller on MCPN765 PPC board
References: <20020901225240.W6132-100000@localhost.my.domain>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Gérard,

Thanks for the reply.
1. The PCI addresses of the SCSI controller look fine, (I enclose the output of
lspci -v for info).
2. We are running the driver with DMAMODE=0 as the Hawk PCI/Memory bridge
ASIC manual sates that it does not support PCI Dual Address cycles.

My original info was wrong in that both the working Mother board and non working
board has a 64bit PCI bus. As the driver is the same on both boards and the basic
kernel is correct this leads me to suspect either:

1. The Hawk Memory/PCI bridge chip is not being configured correctly.
2. There is a hardware compatibility issue between the Hawk chip and the SCSI chip.

The system can talk to the SCSI controller fine, when no SCSI devices are attached.
This also includes a DMA memory read and write test that works fine.
However, when a SCSI device is attached and the SCSI inquiry command is executed,
the system appears to completely lock up on the SCSI controller DMA'ing into host memory.
Note a CPU activity LED lights up solid when this occurs. This LED is connected to
a processor Databus activity line. We are not sure, from the documentation, if this
would light when the SCSI controller is DMA'ing to host memory.
We have a scope but little else as far as hardware debugging equipment.

We are reasonably addept Linux kernel programers, but this one has us beat so far ....
Any ideas on how to proceed would be very useful.

Terry


00:00.0 Host bridge: Motorola Hawk (rev 02)
         Flags: bus master, 66Mhz, medium devsel, latency 0
         I/O ports at <unassigned>
         Memory at bffc0000 (32-bit, non-prefetchable) [size=256K]

00:0b.0 ISA bridge: VIA Technologies, Inc. VT82C586/A/B PCI-to-ISA [Apollo VP] (
rev 41)
         Flags: bus master, stepping, medium devsel, latency 0, IRQ 14

00:0b.1 IDE interface: VIA Technologies, Inc. Bus Master IDE (rev 06) (prog-if 8
f [Master SecP SecO PriP PriO])
         Flags: bus master, stepping, medium devsel, latency 128, IRQ 14
         I/O ports at 7ffff8 [size=8]
         I/O ports at 7ffff4 [size=4]
         I/O ports at 7fffe8 [size=8]
         I/O ports at 7fffe4 [size=4]
         I/O ports at 7fffd0 [size=16]

00:0b.2 USB Controller: VIA Technologies, Inc. UHCI USB (rev 02) (prog-if 00 [UH
CI])
         Subsystem: Unknown device 0925:1234
         Flags: bus master, medium devsel, latency 128
         I/O ports at 7fffa0 [size=32]

00:0b.3 Non-VGA unclassified device: VIA Technologies, Inc. VT82C586B ACPI (rev
10)
         Flags: medium devsel, IRQ 14

00:0e.0 Ethernet controller: Digital Equipment Corporation DECchip 21142/43 (rev
  41)
         Subsystem: Motorola: Unknown device 3456
         Flags: bus master, medium devsel, latency 128, IRQ 18
         I/O ports at 7fff00 [size=128]
         Memory at bffbfc00 (32-bit, non-prefetchable) [size=1K]
         Expansion ROM at <unassigned> [disabled] [size=256K]

00:10.0 SCSI storage controller: Symbios Logic Inc. (formerly NCR): Unknown devi
ce 0021 (rev 01)
         Subsystem: BVM Ltd: Unknown device 0180
         Flags: bus master, 66Mhz, medium devsel, latency 128, IRQ 25
         I/O ports at 7ffe00 [size=256]
         Memory at bffbf800 (64-bit, non-prefetchable) [size=1K]
         Memory at bffbc000 (64-bit, non-prefetchable) [size=8K]
         Expansion ROM at <unassigned> [disabled] [size=128K]
         Capabilities: [40] Power Management version 2

00:13.0 Ethernet controller: Digital Equipment Corporation DECchip 21142/43 (rev
  41)
         Subsystem: Motorola: Unknown device 3456
         Flags: bus master, medium devsel, latency 128, IRQ 29
         I/O ports at 7ffd80 [size=128]
         Memory at bffbbc00 (32-bit, non-prefetchable) [size=1K]
         Expansion ROM at <unassigned> [disabled] [size=256K]

00:14.0 Bridge: Digital Equipment Corporation DECchip 21554 (rev 01)
         Subsystem: Motorola: Unknown device 4811
         Flags: bus master, medium devsel, latency 128, IRQ 20
         Memory at bffba000 (32-bit, non-prefetchable) [size=4K]
         I/O ports at 7ffc00 [size=256]
         Memory at bc000000 (32-bit, non-prefetchable) [size=32M]
         Memory at ba000000 (32-bit, non-prefetchable) [size=32M]
         Memory at b4000000 (32-bit, prefetchable) [size=64M]
         Capabilities: [dc] Power Management version 1
         Capabilities: [e4] Slot ID: 0 slots, First-, chassis 00
         Capabilities: [ec] #06 [0080]

Gérard Roudier wrote:
> On Fri, 30 Aug 2002, Terry Barnaby wrote:
> 
> 
>>Hi,
>>
>>We have a major problem with using a BVM SCSI controller on a Motorola
>>MCPN765 PowerPC Compact PCI Motherboard. When the SCSI driver module is
>>loaded and starts to perform SCSI device interrogation the system will
>>completely lock up.
>>It appears that the hardware is locked up, the kernel locks up during
>>a low level serial console print routine (serial_console_write). No interrupts
>>occur (we have even disabled interrupts in the serial_console_write routine
>>to make sure).
>>The BVM SCSI controller is based on the LSI53C1010-66 chip and we are using the
>>sym53c8xx_2 SCSI driver (although the same problem occurs with the
>>sym53c8xx SCSI driver.
>>We are using MontaVista Linux 2.1 with the 2.4.17 kernel.
>>
>>Using this SCSI controller board with a Motorola MCP750 PowerPC motherboard
>>works fine. One of the differences between the Motherboards is that the
>>MCPN765 has a 66MHz/64bit PCI bus while the MCP750 has a 33MHz/32bit PCI bus.
>>The MCPN765 uses a Hawk ASIC for Memory/PCI bus control.
>>
>>We have been attempting to debug the driver to find the cause but have been
>>hitting brick walls. The system appears to lock up when the SCSI board
>>is performing a DataIn phase under the control of its on-board SCRIPTS processor.
>>
>>As the system has completely locked up we have not been able to find the cause.
>>Any information on possible causes or ideas on how to proceed would be most
>>appreciated.
> 
> 
> The software driver hasn't any handle on the actual differences between
> the BUS that leads to failure and the one that allows success:
> 
> 1) The PCI clock is full hardware dependant. There is nothing software can
>    change here.
> 
> 2) Same for the PCI BUS path. A 64 bit PCI BUS just allows to transfer 64
>    bit of data per BUS cycle but a 32 bit PCI BUS can only transfer 32 bit
>    per PCI cycle.
> 
> 3) Both PCI BUSes width allows 64 bit memory addressing.
> 
> As we know, PCI device drivers relies on kernel generic PCI driver that
> provides configuration access and DMA address translation services. The
> kernel PCI related code uses machine-dependent and bridge-dependant
> methods. So, IMO, there is far more places than just the driver code that
> are involved in the failure you report (including the related pieces of
> hardware).
> 
> I would suggest you to check the following at first:
> 
> 1) Give a look at the PCI configuration space of the chip (or report it).
>    For example, a base address that doesn't fit in 32 bit is very
>    uncommon. Etc...
> 
> 2) Configure the driver for 32 bit DMA (DMA MODE = 0). This will ensure
>    that all DMA addresses will fit in 32 bit and that no PCI dual cycle
>    will occur on behalf of the 1033-66 chip.
> 
>  Gérard.
> 


-- 
   Dr Terry Barnaby                     BEAM Ltd
   Phone: +44 1454 324512               Northavon Business Center, Dean Rd
   Fax:   +44 1454 313172               Yate, Bristol, BS37 5NH, UK
   Email: terry@beam.ltd.uk             Web: www.beam.ltd.uk
   BEAM for: Visually Impaired X-Terminals, Parallel Processing, Software Dev
                          "Tandems are twice the fun !"

