Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315883AbSFJT3G>; Mon, 10 Jun 2002 15:29:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315893AbSFJT3F>; Mon, 10 Jun 2002 15:29:05 -0400
Received: from mailg.telia.com ([194.22.194.26]:15583 "EHLO mailg.telia.com")
	by vger.kernel.org with ESMTP id <S315883AbSFJT3A>;
	Mon, 10 Jun 2002 15:29:00 -0400
To: Patrick Mochel <mochel@osdl.org>
Cc: Tobias Diedrich <ranma@gmx.at>,
        Alessandro Suardi <alessandro.suardi@oracle.com>,
        <linux-kernel@vger.kernel.org>, <torvalds@transmeta.com>
Subject: Re: 2.5.20 - Xircom PCI Cardbus doesn't work
In-Reply-To: <Pine.LNX.4.33.0206100817090.654-100000@geena.pdx.osdl.net>
From: Peter Osterlund <petero2@telia.com>
Date: 10 Jun 2002 21:28:49 +0200
Message-ID: <m2lm9n2ary.fsf@ppro.localdomain>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) Emacs/20.7
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Patrick Mochel <mochel@osdl.org> writes:

> On 9 Jun 2002, Peter Osterlund wrote:
> 
> > Tobias Diedrich <ranma@gmx.at> writes:
> > 
> > > Peter Osterlund wrote:
> > > > Alessandro Suardi <alessandro.suardi@oracle.com> writes:
> > > > 
> > > > >   in 2.5.20 no oopsen but eth0 isn't seen anymore by the kernel:
> > > > 
> > > > Same problem here. My network card isn't seen either by the kernel in
> > > > 2.5.20.
> > > 
> > > This oneliner fixes it for me, but I don't know if that's the right fix:
> > 
> > Thanks, it fixes my problem too. (This patch is still needed in
> > 2.5.21.) However, in 2.5.21 I get an oops at shutdown in
> > device_detach. This happens both with and without your patch:
> 
> Sorry about the delay. Could you please try this patch and let me know if 
> it helps? It attempts to treat cardbus more like PCI, and let the PCI 
> helpers do the probing. 

It doesn't help unfortunately. The network card is not detected at
boot and I get the same oops at shutdown as with a vanilla 2.5.21
kernel.

> Note that it's based on the assumption that there is a cardbus bridge for 
> each cardbus slot. This appears to be true on all systems I've seen, but 
> it may not hold for all systems.

This is true on my system as well.

Here is the output from dmesg after booting (drivers/pci/probe.c
compiled with debugging turned on):

...
Initializing RT netlink socket
PCI: PCI BIOS revision 2.10 entry at 0xeafd0, last bus=2
PCI: Using configuration type 1
PCI: Probing PCI hardware
PCI: Probing PCI hardware (bus 00)
Scanning bus 00
Found 00:00 [8086/7100] 000600 00
Found 00:38 [8086/7110] 000680 00
Found 00:39 [8086/7111] 000101 00
Found 00:3a [8086/7112] 000c03 00
Found 00:3b [8086/7113] 000680 00
Found 00:40 [5333/8c01] 000300 00
Found 00:50 [104c/ac17] 000607 02
Found 00:51 [104c/ac17] 000607 02
Fixups for bus 00
Scanning behind PCI bridge 00:0a.0, config 000000, pass 0
Scanning behind PCI bridge 00:0a.1, config 000000, pass 0
Scanning behind PCI bridge 00:0a.0, config 000000, pass 1
Scanning behind PCI bridge 00:0a.1, config 000000, pass 1
Bus scan for 00 returning with max=08
PCI: Using IRQ router PIIX [8086/7110] at 00:07.0
PCI: IRQ 0 for device 00:0a.0 doesn't match PIRQ mask - try pci=usepirqmask
PCI: IRQ 0 for device 00:0a.1 doesn't match PIRQ mask - try pci=usepirqmask
apm: BIOS version 1.2 Flags 0x03 (Driver version 1.16)
Starting kswapd
BIO: pool of 256 setup, 14Kb (56 bytes/bio)
biovec: init pool 0, 1 entries, 12 bytes
biovec: init pool 1, 4 entries, 48 bytes
biovec: init pool 2, 16 entries, 192 bytes
biovec: init pool 3, 64 entries, 768 bytes
biovec: init pool 4, 128 entries, 1536 bytes
biovec: init pool 5, 256 entries, 3072 bytes
Limiting direct PCI/PCI transfers.
pty: 256 Unix98 ptys configured
Serial driver version 5.05c (2001-07-08) with MANY_PORTS SHARE_IRQ SERIAL_PCI en
abled
ttyS00 at 0x03f8 (irq = 4) is a 16550A
ttyS01 at 0x02f8 (irq = 3) is a 16550A
block: 224 slots per queue, batch=32
Floppy drive(s): fd0 is 1.44M
FDC 0 is a post-1991 82077
PPP generic driver version 2.4.2
ATA/ATAPI device driver v7.0.0
ATA: PCI bus speed 33.3MHz
ATA: unknown interface: Intel Corp. 82371AB PIIX4 IDE, PCI slot 00:07.1
hda: TOSHIBA MK4006MAV, DISK drive
hdc: CD-224E, ATAPI CD/DVD-ROM drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
ide1 at 0x170-0x177,0x376 on irq 15
 hda: 8007552 sectors, CHS=7944/16/63
 hda: [PTBL] [993/128/63] hda1 hda2 hda3 hda4
SCSI subsystem driver Revision: 1.00
scsi0 : SCSI host adapter emulation for ATAPI devices
scsi: device set offline - command error recover failed: host 0 channel 0 id 0 l
un 0
Linux Kernel Card Services 3.1.22
  options:  [pci] [cardbus] [pm]
PCI: IRQ 0 for device 00:0a.0 doesn't match PIRQ mask - try pci=usepirqmask
PCI: Assigned IRQ 10 for device 00:0a.0
PCI: IRQ 0 for device 00:0a.1 doesn't match PIRQ mask - try pci=usepirqmask
PCI: Assigned IRQ 10 for device 00:0a.1
Intel PCIC probe: not found.
NET4: Linux TCP/IP 1.0 for NET4.0
IP Protocols: ICMP, UDP, TCP
IP: routing cache hash table of 512 buckets, 4Kbytes
TCP: Hash tables configured (established 4096 bind 4096)
ip_conntrack version 2.0 (512 buckets, 4096 max) - 292 bytes per conntrack
NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
Yenta IRQ list 0a98, PCI irq10
Socket status: 30000068
Yenta IRQ list 0a98, PCI irq10
Socket status: 30000006
cs: cb_alloc(bus 1): vendor 0x13d1, device 0xab02
Scanning bus 01
Found 01:00 [13d1/ab02] 000200 00
Fixups for bus 01
Unknown bridge resource 0: assuming transparent
Unknown bridge resource 1: assuming transparent
Unknown bridge resource 2: assuming transparent
Bus scan for 01 returning with max=01
PCI: Device 01:00.0 not available because of resource collisions
VFS: Mounted root (ext2 filesystem) readonly.
Freeing unused kernel memory: 196k freed
Adding Swap: 104828k swap-space (priority -1)
usb.c: registered new driver usbfs
usb.c: registered new driver hub
usb-uhci-hcd.c: High bandwidth mode enabled.
PCI: Assigned IRQ 10 for device 00:07.2
hcd-pci.c: usb-uhci-hcd @ 00:07.2, Intel Corp. 82371AB PIIX4 USB
hcd-pci.c: irq 10, io base 0000f300
hcd.c: new USB bus registered, assigned bus number 1
...

-- 
Peter Osterlund - petero2@telia.com
http://w1.894.telia.com/~u89404340
