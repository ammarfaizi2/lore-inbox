Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264196AbSIVMux>; Sun, 22 Sep 2002 08:50:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264232AbSIVMux>; Sun, 22 Sep 2002 08:50:53 -0400
Received: from kol77.saturnus.vein.hu ([193.6.40.77]:39553 "EHLO
	bazooka.saturnus.vein.hu") by vger.kernel.org with ESMTP
	id <S264196AbSIVMuv>; Sun, 22 Sep 2002 08:50:51 -0400
Date: Sun, 22 Sep 2002 14:54:54 +0200
To: Mikael Pettersson <mikpe@csd.uu.se>
Cc: bazooka@vekoll.saturnus.vein.hu, linux-kernel@vger.kernel.org
Subject: Re: ESR bad value...
Message-ID: <20020922125454.GA763@bazooka.saturnus.vein.hu>
References: <200209221142.NAA10111@harpo.it.uu.se>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="5mCyUwZo2JvN/JJP"
Content-Disposition: inline
In-Reply-To: <200209221142.NAA10111@harpo.it.uu.se>
User-Agent: Mutt/1.4i
From: Banai Zoltan <bazooka@vekoll.vein.hu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--5mCyUwZo2JvN/JJP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi!
On Sun, Sep 22, 2002 at 01:42:07PM +0200, Mikael Pettersson wrote:
> On Sat, 21 Sep 2002 17:43:48 +0200, Banai Zoltan wrote:
> >I have a problem with kernels >2.4.17,
> >booting them i got error message
> >ESR bad value enabling vector 00000004
> >Using 2.2.x and <=2.4.17 there is no probelm
> >
> >The hardware is an Intergraph TDZ-310
> >PPro-200Mhz, 450KX/GX chipset.
> >
> >My config with 2.4.19-ac4 (is similar to configs
> >use with 2.4.9 with JFS) is attached.
> 
> There is no such message in a standard 2.4.19 kernel.
> Please post the _exact_ message(s). Also, are you sure it's
> an error and not just informational? Does the box work?

Sorry! You are right, i did not had time for write it down
becouse it is a production system.
But i grepped the source and found the right message in:
./arch/i386/kernel/apic.c so the message i seen was:
printk("ESR value before enabling vector: %08lx\n", value); 

and the system stopped booting after that.
(This is a MP motherboard with one processor.)

Disabling 
CONFIG_X86_UP_IOAPIC=y                                                                                                                       
CONFIG_X86_IO_APIC=y                                                                                                                         
CONFIG_X86_LOCAL_APIC=y
makes system boot!

I attach the lcpci -v output hoping it will help.



> 
> /Mikael
> 
Regards,
-- 
Banai Zoltan

--5mCyUwZo2JvN/JJP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=lspci

00:01.0 PCI bridge: Digital Equipment Corporation DECchip 21050 (rev 02) (prog-if 00 [Normal decode])
	Flags: bus master, medium devsel, latency 64
	Bus: primary=00, secondary=01, subordinate=01, sec-latency=64
	I/O behind bridge: 0000f000-0000ffff
	Memory behind bridge: fcb00000-febfffff
	Prefetchable memory behind bridge: fab00000-fcafffff

00:02.0 Non-VGA unclassified device: Intel Corp. 82378IB [SIO ISA Bridge] (rev 88)
	Flags: bus master, medium devsel, latency 0

00:06.0 Ethernet controller: Intel Corp. 82557 [Ethernet Pro 100] (rev 01)
	Flags: bus master, medium devsel, latency 64, IRQ 15
	Memory at ffbe7000 (32-bit, prefetchable) [size=4K]
	I/O ports at ef40 [size=32]
	Memory at ff800000 (32-bit, non-prefetchable) [size=1M]
	Expansion ROM at ff700000 [disabled] [size=1M]

00:07.0 SCSI storage controller: Adaptec AIC-7860 (rev 01)
	Flags: bus master, medium devsel, latency 64, IRQ 11
	I/O ports at e800 [disabled] [size=256]
	Memory at ffbef000 (32-bit, non-prefetchable) [size=4K]

00:0d.0 Ethernet controller: 3Com Corporation 3c905B 100BaseTX [Cyclone] (rev 64)
	Subsystem: 3Com Corporation 3C905B Fast Etherlink XL 10/100
	Flags: bus master, medium devsel, latency 64, IRQ 9
	I/O ports at ec00 [size=128]
	Memory at ffbeef80 (32-bit, non-prefetchable) [size=128]
	Expansion ROM at ffbc0000 [disabled] [size=128K]
	Capabilities: [dc] Power Management version 1

00:0e.0 Ethernet controller: Hewlett-Packard Company J2585A
	Flags: medium devsel, IRQ 10
	I/O ports at e400 [size=256]
	Memory at ffbec000 (32-bit, non-prefetchable) [disabled] [size=8K]

00:14.0 RAM memory: Intel Corp. 450KX/GX [Orion] - 82453KX/GX Memory controller (rev 05)
	Flags: fast devsel

00:19.0 Host bridge: Intel Corp. 450KX/GX [Orion] - 82454KX/GX PCI bridge (rev 06)
	Flags: bus master, medium devsel, latency 64

01:07.0 SCSI storage controller: Adaptec AHA-7850
	Flags: bus master, medium devsel, latency 64, IRQ 11
	I/O ports at f800 [disabled] [size=256]
	Memory at febe7000 (32-bit, non-prefetchable) [size=4K]

01:0c.0 Display controller: Intergraph Corporation: Unknown device 00e1 (rev 60)
	Flags: bus master, medium devsel, latency 16, IRQ 9
	Memory at febe8000 (32-bit, non-prefetchable) [size=32K]

01:0d.0 VGA compatible controller: Cirrus Logic GD 5430/40 [Alpine] (rev 47) (prog-if 00 [VGA])
	Flags: VGA palette snoop, medium devsel
	Memory at fb000000 (32-bit, prefetchable) [size=16M]
	Expansion ROM at fd000000 [disabled] [size=16M]

01:0e.0 Ethernet controller: 3Com Corporation 3c905 100BaseTX [Boomerang]
	Flags: bus master, medium devsel, latency 64, IRQ 15
	I/O ports at ff00 [size=64]
	Expansion ROM at febf0000 [disabled] [size=64K]


--5mCyUwZo2JvN/JJP--
