Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266307AbTAGL1e>; Tue, 7 Jan 2003 06:27:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266367AbTAGL1e>; Tue, 7 Jan 2003 06:27:34 -0500
Received: from pusa.informat.uv.es ([147.156.10.98]:58069 "EHLO
	pusa.informat.uv.es") by vger.kernel.org with ESMTP
	id <S266307AbTAGL1b>; Tue, 7 Jan 2003 06:27:31 -0500
Date: Tue, 7 Jan 2003 12:36:07 +0100
To: linux-kernel@vger.kernel.org
Subject: Re: aic7xxx broken in 2.5.53/54 ?
Message-ID: <20030107113607.GA32369@pusa.informat.uv.es>
References: <20030103101618.GB8582@in.ibm.com> <596830816.1041606846@aslan.scsiguy.com> <20030106073204.GA1875@in.ibm.com> <274040000.1041869813@aslan.scsiguy.com> <20030106163624.GA11873@pusa.informat.uv.es>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20030106163624.GA11873@pusa.informat.uv.es>
User-Agent: Mutt/1.3.28i
From: uaca@alumni.uv.es
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I'm running 2.5.54 and the system seems stable

anyway I see the error reported in my previous e-mail

aic7xxx: PCI Device 0:12:0 failed memory mapped test.  Using PIO.
aic7xxx: PCI Device 0:12:1 failed memory mapped test.  Using PIO.
scsi0 : Adaptec AIC7XXX EISA/VLB/PCI SCSI HBA DRIVER, Rev 6.2.25
        <Adaptec aic7896/97 Ultra2 SCSI adapter>
        aic7896/97: Ultra2 Wide Channel A, SCSI Id=7, 32/253 SCBs

scsi0: PCI error Interrupt at seqaddr = 0x2
scsi0: Signaled a Target Abort
scsi1: PCI error Interrupt at seqaddr = 0x2
scsi1: Signaled a Target Abort
(scsi0:A:0): 80.000MB/s transfers (40.000MHz, offset 63, 16bit)
  Vendor: QUANTUM   Model: ATLAS_V_36_WLS    Rev: 0230
  Type:   Direct-Access                      ANSI SCSI revision: 03
scsi0:A:0:0: Tagged Queuing enabled.  Depth 64
scsi1 : Adaptec AIC7XXX EISA/VLB/PCI SCSI HBA DRIVER, Rev 6.2.25
        <Adaptec aic7896/97 Ultra2 SCSI adapter>
        aic7896/97: Ultra2 Wide Channel B, SCSI Id=7, 32/253 SCBs

SCSI device sda: drive cache: write back
SCSI device sda: 71722776 512-byte hdwr sectors (36722 MB)
 sda: sda1 sda2 sda3 sda4 < sda5 sda6 sda7 sda8 >
Attached scsi disk sda at scsi0, channel 0, id 0, lun 0

no other messages seen while system running


controller's bios version is v2.57S2B3

My previous e-mail is appended here



On Mon, Jan 06, 2003 at 05:36:25PM +0100, uaca@alumni.uv.es wrote:
> Hi hav    
> 
> I have to report the same problem, tomorrow I will complete the info,
> including bios version and read-only tests on a disk device
> 
> At least I can say I've saw the message
> 
> >    scsi0: PCI error Interrupt at seqaddr = 0x2
> >    scsi0: Signaled a Target Abort
> >    scsi1: PCI error Interrupt at seqaddr = 0x2
> >    scsi1: Signaled a Target Abort
> 
> > It would be good to know the chipset on the motherboard.  As to why
> > the old driver worked, for 6.X.X drivers, you may have just been lucky.
> > For 5.X.X drivers, they perform a read after every register write to
> > "manually" prevent any byte-merging.  These reads are actually more
> > expensive than just using PIO.  Neither of these older drivers included
> > a test to try and catch fishy behavior.
> 
> 
> Kernel 2.4.x works fine
> 
> now some info about chipset, etc...
> 
> 
> 00:00.0 Host bridge: Intel Corporation 440GX - 82443GX Host bridge
> 	Flags: bus master, medium devsel, latency 64
> 	Memory at f8000000 (32-bit, prefetchable) [size=64M]
> 	Capabilities: <available only to root>
> 
> 00:01.0 PCI bridge: Intel Corporation 440GX - 82443GX AGP bridge (prog-if 00 [Normal decode])
> 	Flags: bus master, 66Mhz, medium devsel, latency 64
> 	Bus: primary=00, secondary=01, subordinate=02, sec-latency=64
> 
> 00:0b.0 ATM network controller: FORE Systems Inc PCA-200E
> 	Flags: bus master, medium devsel, latency 64, IRQ 18
> 	Memory at f4000000 (32-bit, non-prefetchable) [size=2M]
> 	Expansion ROM at <unassigned> [disabled] [size=8K]
> 
> 00:0c.0 SCSI storage controller: Adaptec 7896
> 	Subsystem: Adaptec: Unknown device 0053
> 	Flags: bus master, medium devsel, latency 64, IRQ 19
> 	BIST result: 00
> 	I/O ports at 2000 [disabled] [size=256]
> 	Memory at f4300000 (64-bit, non-prefetchable) [size=4K]
> 	Expansion ROM at <unassigned> [disabled] [size=128K]
> 	Capabilities: <available only to root>
> 
> 00:0c.1 SCSI storage controller: Adaptec 7896
> 	Subsystem: Adaptec: Unknown device 0053
> 	Flags: bus master, medium devsel, latency 64, IRQ 19
> 	BIST result: 00
> 	I/O ports at 2400 [disabled] [size=256]
> 	Memory at f4301000 (64-bit, non-prefetchable) [size=4K]
> 	Capabilities: <available only to root>
> 
> 00:0e.0 Ethernet controller: Intel Corporation 82557 [Ethernet Pro 100] (rev 08)
> 	Subsystem: Intel Corporation 82559 Fast Ethernet LAN on Motherboard
> 	Flags: bus master, medium devsel, latency 64, IRQ 21
> 	Memory at f4302000 (32-bit, non-prefetchable) [size=4K]
> 	I/O ports at 2800 [size=64]
> 	Memory at f4200000 (32-bit, non-prefetchable) [size=1M]
> 	Expansion ROM at <unassigned> [disabled] [size=1M]
> 	Capabilities: <available only to root>
> 
> 00:12.0 ISA bridge: Intel Corporation 82371AB PIIX4 ISA (rev 02)
> 	Flags: bus master, medium devsel, latency 0
> 
> 00:12.1 IDE interface: Intel Corporation 82371AB PIIX4 IDE (rev 01) (prog-if 80 [Master])
> 	Flags: bus master, medium devsel, latency 64
> 	I/O ports at 2860 [size=16]
> 
> 00:12.2 USB Controller: Intel Corporation 82371AB PIIX4 USB (rev 01) (prog-if 00 [UHCI])
> 	Flags: bus master, medium devsel, latency 64, IRQ 21
> 	I/O ports at 2840 [size=32]
> 
> 00:12.3 Bridge: Intel Corporation 82371AB PIIX4 ACPI (rev 02)
> 	Flags: medium devsel, IRQ 9
> 
> 00:14.0 VGA compatible controller: Cirrus Logic GD 5480 (rev 23) (prog-if 00 [VGA])
> 	Subsystem: Cirrus Logic CL-GD5480
> 	Flags: bus master, medium devsel, latency 64
> 	Memory at f6000000 (32-bit, prefetchable) [size=32M]
> 	Memory at f4303000 (32-bit, non-prefetchable) [size=4K]
> 	Expansion ROM at <unassigned> [disabled] [size=32K]
> 
> 01:0f.0 PCI bridge: Digital Equipment Corporation DECchip 21150 (rev 06) (prog-if 00 [Normal decode])
> 	Flags: bus master, fast Back2Back, 66Mhz, medium devsel, latency 240
> 	Bus: primary=01, secondary=02, subordinate=02, sec-latency=68
> 	Capabilities: <available only to root>
> 
> 
> processor	: 0
> vendor_id	: GenuineIntel
> cpu family	: 6
> model		: 8
> model name	: Pentium III (Coppermine)
> stepping	: 3
> cpu MHz		: 796.559
> cache size	: 256 KB
> fdiv_bug	: no
> hlt_bug		: no
> f00f_bug	: no
> coma_bug	: no
> fpu		: yes
> fpu_exception	: yes
> cpuid level	: 2
> wp		: yes
> flags		: fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat pse36 mmx fxsr sse
> bogomips	: 1589.24
> 
> processor	: 1
> vendor_id	: GenuineIntel
> cpu family	: 6
> model		: 8
> model name	: Pentium III (Coppermine)
> stepping	: 3
> cpu MHz		: 796.559
> cache size	: 256 KB
> fdiv_bug	: no
> hlt_bug		: no
> f00f_bug	: no
> coma_bug	: no
> fpu		: yes
> fpu_exception	: yes
> cpuid level	: 2
> wp		: yes
> flags		: fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat pse36 mmx fxsr sse
> bogomips	: 1592.52
> 
> 
> 
>                 Debian GNU/Linux: a dream come true
> -----------------------------------------------------------------------------
> "Computers are useless. They can only give answers."            Pablo Picasso
> 
> --->	Visita http://www.valux.org/ para saber acerca de la	<---
> --->	Asociación Valenciana de Usuarios de Linux		<---
>  
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

-- 
                Debian GNU/Linux: a dream come true
-----------------------------------------------------------------------------
"Computers are useless. They can only give answers."            Pablo Picasso

--->	Visita http://www.valux.org/ para saber acerca de la	<---
--->	Asociación Valenciana de Usuarios de Linux		<---
 
