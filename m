Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932153AbWIOS3U@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932153AbWIOS3U (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 15 Sep 2006 14:29:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932158AbWIOS3U
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Sep 2006 14:29:20 -0400
Received: from chain.digitalkingdom.org ([64.81.49.134]:32742 "EHLO
	chain.digitalkingdom.org") by vger.kernel.org with ESMTP
	id S932153AbWIOS3T (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Sep 2006 14:29:19 -0400
Date: Fri, 15 Sep 2006 11:29:15 -0700
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Same MCE on 4 working machines (was Re: Early boot hang on recent 2.6 kernels (> 2.6.3), on x86-64 with 16gb of RAM)
Message-ID: <20060915182915.GR4610@chain.digitalkingdom.org>
References: <20060912223258.GM4612@chain.digitalkingdom.org> <20060914190548.GI4610@chain.digitalkingdom.org> <1158320742.29932.20.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1158320742.29932.20.camel@localhost.localdomain>
User-Agent: Mutt/1.5.12-2006-07-14
From: Robin Lee Powell <rlpowell@digitalkingdom.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 15, 2006 at 12:45:42PM +0100, Alan Cox wrote:
> Ar Iau, 2006-09-14 am 12:05 -0700, ysgrifennodd Robin Lee Powell:
> > NET: Registered protocol family 16
> > CPU 0: Machine Check Exception:                7 Bank 3: b40000000000083b
> > RIP 10:<ffffffff8023a44c> {pci_conf1_read+0xac/0xe0}
> > TSC d189cea ADDR fdfc000cfe
> 
> We went to do a PCI configuration cycle and your box blew up.
> Thats pretty clear. Could be down to the various changes in how we
> do PCI accesses tripping up a problem box, or triggering a bug.

*nod*  I'm totally on the fence about that; the company that made
these boxes (Penguin Computing) seems to have some clue issues, and
the motherboard is an Arima (sp?) HDAMA v2, which I gather is one of
the very earliest SMP Opteron boards.

Note that with the answers I give below I'm using the kernel that
hangs at:

Security Framework v1.0.0 initialized
Mount-cache hash table entries: 256
CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
CPU: L2 Cache: 1024K (64 bytes/line)

for the first CPU, and that doesn't generate an MCE unless I use
acpi=off, so I'll be doing each option twice (once with just the
option you gave, and once with it plus acpi=off).

This is my 2.6.17.11 kernel; the Debian 2.6.8-12 kernel gets to the
MCE without any options; dunno why yet.

The MCE this kernel gives is:

HARDWARE ERROR
CPU 0: Machine Check Exception:                7 Bank 3: b40000000000083b
RIP 10:<ffffffff80308e7e> {pci_conf1_read+0xbe/0xf0}
TSC 1a0c706340 ADDR fdfc000cfc
This is not a software problem!
Run through mcelog --ascii to decode and contact your hardware vendor
Kernel panic - not syncing: Uncorrected machine check

> See what effect 
> 
> 	pci=bios

No effect.

> 	pci=conf1

No effect.

> 	pci=conf2

No effect without acpi=off.

With acpi=off, it gets rather farther before apparently failing to
talk the 3-ware card:

- ----------------------

Brought up 2 CPUs
testing NMI watchdog ... OK.
migration_cost=629
NET: Registered protocol family 16
ACPI: Subsystem revision 20060127
ACPI: Interpreter disabled.
Linux Plug and Play Support v0.97 (c) Adam Belay
pnp: PnP ACPI: disabled
SCSI subsystem initialized
PCI: System does not support PCI
PCI: System does not support PCI
PCI-DMA: Disabling AGP.
PCI-DMA: More than 4GB of RAM and no IOMMU
PCI-DMA: 32bit PCI IO may malfunction.
PCI-DMA: Disabling IOMMU.
WARNING more than 4GB of memory but IOMMU not available.
WARNING 32bit PCI may malfunction.
NET: Registered protocol family 2
IP route cache hash table entries: 524288 (order: 10, 4194304 bytes)
TCP established hash table entries: 262144 (order: 10, 4194304 bytes)
TCP bind hash table entries: 65536 (order: 8, 1048576 bytes)
TCP: Hash tables configured (established 262144 bind 65536)
TCP reno registered
IA32 emulation $Id: sys_ia32.c,v 1.32 2002/03/24 13:02:28 ak Exp $
VFS: Disk quotas dquot_6.5.1
Dquot-cache hash table entries: 512 (order 0, 4096 bytes)
Initializing Cryptographic API
io scheduler noop registered
io scheduler anticipatory registered (default)
io scheduler deadline registered
io scheduler cfq registered
vga16fb: mapped to 0xffff8100000a0000
Console: switching to colour frame buffer device 80x30
fb0: VGA16 VGA frame buffer device
Linux agpgart interface v0.101 (c) Dave Jones
Serial: 8250/16550 driver $Revision: 1.90 $ 4 ports, IRQ sharing enabled
serial8250: ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
serial8250: ttyS1 at I/O 0x2f8 (irq = 3) is a 16550A
RAMDISK driver initialized: 16 RAM disks of 8192K size 1024 blocksize
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 50MHz system bus speed for PIO modes; override with idebus=xx
Adaptec aacraid driver (1.1-5[2409]-mh1)
3ware Storage Controller device driver for Linux v1.26.02.001.
3ware 9000 Storage Controller device driver for Linux v2.26.02.007.
PNP: No PS/2 controller found. Probing ports directly.
serio: i8042 AUX port at 0x60,0x64 irq 12
serio: i8042 KBD port at 0x60,0x64 irq 1
ip_tables: (C) 2000-2006 Netfilter Core Team
TCP bic registered
NET: Registered protocol family 8
NET: Registered protocol family 20
VFS: Cannot open root device "sda2" or unknown-block(0,0)
Please append a correct "root=" boot option
Kernel panic - not syncing: VFS: Unable to mount root fs on unknown-block(0,0)

- ------------------------

> 	pci=nommconf

No effect.

> 	pci=nomsi

No effect.

> have and report back.
> 
> What drivers do you have enabled 

I'm not completely certain I know what you're asking there, but I
think this answers it:

http://teddyb.org/~rlpowell/media/regular/lkml/2.6.8.11.non-bi.config.txt

> and what pci devices are present ?

http://teddyb.org/~rlpowell/media/regular/lkml/lspci_v.txt

-Robin

-- 
http://www.digitalkingdom.org/~rlpowell/ *** http://www.lojban.org/
Reason #237 To Learn Lojban: "Homonyms: Their Grate!"
Proud Supporter of the Singularity Institute - http://singinst.org/
