Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315985AbSENSgq>; Tue, 14 May 2002 14:36:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315977AbSENSgo>; Tue, 14 May 2002 14:36:44 -0400
Received: from brooklyn-bridge.emea.veritas.com ([62.172.234.2]:17967 "EHLO
	einstein.homenet") by vger.kernel.org with ESMTP id <S315984AbSENSfs>;
	Tue, 14 May 2002 14:35:48 -0400
Date: Tue, 14 May 2002 19:35:54 +0100 (BST)
From: Tigran Aivazian <tigran@veritas.com>
X-X-Sender: <tigran@einstein.homenet>
To: Dead2 <dead2@circlestorm.org>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: Initrd or Cdrom as root
In-Reply-To: <00d101c1fb73$8b0165e0$0d01a8c0@studio2pw0bzm4>
Message-ID: <Pine.LNX.4.33.0205141930430.1577-100000@einstein.homenet>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 14 May 2002, Dead2 wrote:
> This CDROM is supposed to be able to be inserted into a fresh
> server with no partitions on the HDD's. When booted, it will detect
> the HDD, partition it and then install some rpm packages to get a
> basic setup running.

Hmmm, that is called a Linux distribution btw :)

> I have also tested this cdrom in a few other computers with the
> same error messages.
>
> "enableapic"? I just assumed it existed.

perhaps it _should_ exist to enable the user the override a hardcoded
"noapic" option in the image. I.e. you may build a floppy/cd with "noapic"
hardcoded in lilo.conf but it is convenient to be able to override it.
When I added "noapic" option this didn't occur to me... Or, perhaps a
better syntax is "ioapics=0" and "ioapics=1" but this gives an impression
that one can also say "ioapics=2" which is not the same as the easy
solution above.

Regards
Tigran

>
> ----- Original Message -----
> From: "Tigran Aivazian" <tigran@veritas.com>
>
>
> > ok, what's your CD-ROM attached to?
> > is it an IDE or a SCSI CD-ROM?
> > If scsi, which HBA is it connected to?
> > And have you compiled kernel support for that HBA?
> >
> > The major=0x48 is really 72 which is some exotic hardware called
> > "Compaq Intelligent Drive Array". Do you have an instance of such hardware
> > in your machine?
> >
> > And why are you passing "enableapic" boot parameter if it doesn't exist?
> > (unless it is some new 2.5.x thing)
> >
> > I assume you are booting Linux 2.4.18, because that is what the patch was
> > supposed to apply to.
> >
> > On Tue, 14 May 2002, Dead2 wrote:
> >
> > > Unfortunately it boots too fast for me to see that message..
> > >
> > > This is my isolinux.cfg file:
> > > ---
> > > DEFAULT zoac
> > >
> > > LABEL zoac
> > >     KERNEL /boot/bzImage
> > >     APPEND "enableapic rootcd=1"
> > > ---
> > > >From what I know, that should work.. right?
> > >
> > > -=Dead2=-
> > >
> > > ----- Original Message -----
> > > From: "Tigran Aivazian" <tigran@veritas.com>
> > > To: "Dead2" <dead2@circlestorm.org>
> > > Cc: <linux-kernel@vger.kernel.org>
> > > Sent: Tuesday, May 14, 2002 7:41 PM
> > > Subject: Re: Initrd or Cdrom as root
> > >
> > >
> > > > did you forget to pass "rootcd=1" in the boot command line?
> > > >
> > > > When the kernel boots it shows the command line like this:
> > > >
> > > >   Kernel command line: BOOT_IMAGE=linux-nopae ro root=305
> > > BOOT_FILE=/boot/vmlinuz-2.4.18 rootcd=1
> > > >
> > > > What does it look like in your case?
> > > >
> > > > On Tue, 14 May 2002, Dead2 wrote:
> > > >
> > > > > I tested the patch, but it still does not work..
> > > > >
> > > > > These are the error messages I get:
> > > > > (lines 1,2,3,6 and 7 are prolly not relevant)
> > > > >
> > > > > ---
> > > > > SCSI subsystem driver Revision: 1.00
> > > > > 3ware Storage Controller device driver for Linux v1.02.00.016.
> > > > > 3w-xxxx: No cards with valid units found.
> > > > > request_module[scsi_hostadapter]: Root fs not mounted
> > > > > request_module[scsi_hostadapter]: Root fs not mounted
> > > > > pci_hotplug: PCI Hot Plug PCI Core version: 0.3
> > > > > cpqphp.o: Compaq Hot Plug PCI Controller Driver version 0.9.6
> > > > > VFS: Cannot open root device "" or 48:03
> > > > > Please append a correct "root=" boot option
> > > > > Kernel panic: VFS: Unable to mount root fs on 48:03
> > > > > ---
> > > > >
> > > > > I have compiled in a lot of scsi drivers that are not used, so
> > > > > the kernel will be able to boot on just about any system.
> > > > > The cdrom on the test computer is on /dev/hdc. But I have
> > > > > also tested it on several other computers with no luck.
> > > > >
> > > > > Attached: My kernel .config
> > > > >
> > > > > -=Dead2=-
> > > > >
> > > >
> > > >
> > >
> > >
> >
> >
>
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>

