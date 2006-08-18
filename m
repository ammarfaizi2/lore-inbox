Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751428AbWHRRao@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751428AbWHRRao (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Aug 2006 13:30:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751427AbWHRRao
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Aug 2006 13:30:44 -0400
Received: from viper.oldcity.dca.net ([216.158.38.4]:26278 "HELO
	viper.oldcity.dca.net") by vger.kernel.org with SMTP
	id S1751430AbWHRRan (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Aug 2006 13:30:43 -0400
Subject: Re: R: How to avoid serial port buffer overruns?
From: Lee Revell <rlrevell@joe-job.com>
To: Russell King <rmk+lkml@arm.linux.org.uk>
Cc: Giampaolo Tomassoni <g.tomassoni@libero.it>,
       Linux Kernel ML <linux-kernel@vger.kernel.org>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Paul Fulghum <paulkf@microgate.com>
In-Reply-To: <20060818170450.GC21101@flint.arm.linux.org.uk>
References: <NBBBIHMOBLOHKCGIMJMDGEIMFNAA.g.tomassoni@libero.it>
	 <1155920400.24907.63.camel@mindpipe>
	 <20060818170450.GC21101@flint.arm.linux.org.uk>
Content-Type: text/plain
Date: Fri, 18 Aug 2006 13:30:40 -0400
Message-Id: <1155922240.2924.5.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2006-08-18 at 18:04 +0100, Russell King wrote:
> On Fri, Aug 18, 2006 at 01:00:00PM -0400, Lee Revell wrote:
> > On Fri, 2006-08-18 at 10:48 +0200, Giampaolo Tomassoni wrote:
> > > > On Thu, 2006-08-17 at 00:19 +0100, Russell King wrote:
> > > > 
> > > > 
> > > > OK, thanks.  FWIW here is the serial board we are using:
> > > > 
> > > > http://www.moschip.com/html/MCS9845.html
> > > > 
> > > > The hardware guy says "The mn9845cv, have in default 2 serial ports and
> > > > one ISA bus, where we have connected the tl16c554, quad serial port."
> > > > 
> > > > Hopefully Ingo's latency tracer can tell me what is holding off
> > > > interrupts.
> > > 
> > > I beg your pardon: I'm not used that much to interrupts handling in Linux, but this piece of code from sound/drivers/serial-u16550.c in a linux-2.6.16:
> > 
> > OK, they are not using serial-u16550 but 8250_fourport for some reason:
> 
> Doesn't look like it.  fourport cards have their ports at 0x1a0..0x1bf
> and 0x2a0..0x2bf, and have some special and non-standard features.
> 

Which driver is being used then?

# cat /proc/interrupts 
           CPU0       
  0:     801050    IO-APIC-edge  timer
  1:         42    IO-APIC-edge  i8042
  7:          0    IO-APIC-edge  parport0
  8:          4    IO-APIC-edge  rtc
  9:          0   IO-APIC-level  acpi
 12:      11022    IO-APIC-edge  i8042
 14:       2517    IO-APIC-edge  ide0
169:     536096   IO-APIC-level  ohci1394, ICE1712
185:       3908   IO-APIC-level  eth0, serial
193:       8610   IO-APIC-level  libata
201:        326   IO-APIC-level  uhci_hcd:usb1, uhci_hcd:usb2,
uhci_hcd:usb3, uhci_hcd:usb4, ehci_hcd:usb5
217:      84947   IO-APIC-level  nvidia
NMI:          0 
LOC:     800973 
ERR:          0
MIS:          0

# lsmod | egrep serial\|8250
8250_fourport           2048  0 [permanent]
8250_pnp                8704  0 
parport_serial          7680  0 
parport_pc             31984  1 parport_serial
8250_pci               19968  1 parport_serial
8250                   22704  12 8250_pnp,8250_pci
serial_core            19200  1 8250

Serial: 8250/16550 driver $Revision: 1.90 $ 10 ports, IRQ sharing
enabled
serial8250: ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
pci_hotplug: PCI Hot Plug PCI Core version: 0.5
shpchp: Standard Hot Plug PCI Controller Driver version: 0.4
Linux agpgart interface v0.101 (c) Dave Jones
agpgart: Detected AGP bridge 0
agpgart: AGP aperture is 128M @ 0xe8000000
parport: PnPBIOS parport detected.
parport0: PC-style at 0x378, irq 7 [PCSPP,TRISTATE]
Real Time Clock Driver v1.12ac
input: PC Speaker as /class/input/input1
ACPI: PCI Interrupt 0000:00:0b.0[A] -> GSI 19 (level, low) -> IRQ 185
0000:00:0b.0: ttyS4 at I/O 0xdd00 (irq = 185) is a 16550A
0000:00:0b.0: ttyS5 at I/O 0xe300 (irq = 185) is a 16550A
0000:00:0b.0: ttyS6 at I/O 0xe400 (irq = 185) is a 16550A
0000:00:0b.0: ttyS7 at I/O 0xd000 (irq = 185) is a 16550A
0000:00:0b.0: ttyS8 at I/O 0xd100 (irq = 185) is a 16550A
0000:00:0b.0: ttyS9 at I/O 0xd200 (irq = 185) is a 16550A

Lee

