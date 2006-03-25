Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751962AbWCYXMz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751962AbWCYXMz (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 25 Mar 2006 18:12:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751965AbWCYXMz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 25 Mar 2006 18:12:55 -0500
Received: from ddsl-216-196-193-58.fuse.net ([216.196.193.58]:57739 "EHLO
	sarsen.nerdgod.com") by vger.kernel.org with ESMTP id S1751962AbWCYXMy
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 25 Mar 2006 18:12:54 -0500
Message-ID: <4425CE7E.2030806@societasilluminati.org>
Date: Sat, 25 Mar 2006 18:13:02 -0500
From: Ian Young <lkml@societasilluminati.org>
Reply-To: lkml@societasilluminati.org
User-Agent: Thunderbird 1.5 (Windows/20051201)
MIME-Version: 1.0
To: Samuel Masham <samuel.masham@gmail.com>
CC: Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org,
       Mauro Tassinari <mtassinari@cmanet.it>
Subject: Re: libata/sata errors on ich[?]/maxtor
References: <!~!UENERkVCMDkAAQACAAAAAAAAAAAAAAAAABgAAAAAAAAA//gP36uv0hG9NQDAJogAp8KAAAAQAAAAoSG5sanwXkG4qxYkj76rcgEAAAAA@cmanet.it>	 <93564eb70603162037g1856b7eey@mail.gmail.com>	 <1142595294.28614.3.camel@localhost.localdomain>	 <93564eb70603170635s4d3c8c3o@mail.gmail.com> <93564eb70603220159wd03a48du@mail.gmail.com>
In-Reply-To: <93564eb70603220159wd03a48du@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I think I may have figured out my problem (I hope). I had, a while ago, 
upgraded my BIOS, which reset the SATA mode for the controller. It's odd 
that the error didn't pop up until I upgraded my drives from dual maxtor 
6Y160M0's...

Originally I had the controller set up in the BIOS as "RAID" instead of 
IDE, so they didnt' show up on any of the BIOS IDE channels in the BIOS 
Setup screen. After the BIOS upgrade, this was overwritten with "Auto" 
mode. When I first started having problems it was on "Auto"... I've set 
it to "Combined" and "Enhanced", to no avail. (though I may set it to 
"Enhanced" and reboot just to see what the kernel messages say.... ) As 
of now, I've re-set it to "RAID", and now the kernel outputs the 
following on boot. I have not had any issues since making this change.


    kernel: Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
    kernel: ide: Assuming 33MHz system bus speed for PIO modes; override
    with idebus=xx
    kernel: ICH5: IDE controller at PCI slot 0000:00:1f.1
    kernel: ACPI: PCI Interrupt Link [LNKC] enabled at IRQ 11
    kernel: PCI: setting IRQ 11 as level-triggered
    kernel: ACPI: PCI Interrupt 0000:00:1f.1[A] -> Link [LNKC] -> GSI 11
    (level, low) -> IRQ 11
    kernel: ICH5: chipset revision 2
    kernel: ICH5: not 100% native mode: will probe irqs later
    kernel:     ide0: BM-DMA at 0xf000-0xf007, BIOS settings: hda:DMA,
    hdb:pio
    kernel:     ide1: BM-DMA at 0xf008-0xf00f, BIOS settings: hdc:DMA,
    hdd:pio
    kernel: hdd: SR244W, ATAPI CD/DVD-ROM drive
    kernel: ide1 at 0x170-0x177,0x376 on irq 15
    kernel: hdd: ATAPI 24X CD-ROM drive, 128kB Cache, UDMA(33)
    kernel: Uniform CD-ROM driver Revision: 3.20
    kernel: ide-floppy driver 0.99.newide
    [...]
    kernel: SCSI subsystem initialized
    kernel: ACPI: PCI Interrupt 0000:00:1f.2[A] -> Link [LNKC] -> GSI 11
    (level, low) -> IRQ 11
    kernel: ata1: SATA max UDMA/133 cmd 0xE200 ctl 0xE302 bmdma 0xE600
    irq 11
    kernel: ata2: SATA max UDMA/133 cmd 0xE400 ctl 0xE502 bmdma 0xE608
    irq 11
    kernel: ata1: dev 0 ATA-7, max UDMA/133, 586114704 sectors: LBA48
    kernel: ata1: dev 0 configured for UDMA/133
    kernel: scsi0 : ata_piix
    kernel: ata2: dev 0 ATA-7, max UDMA/133, 586072368 sectors: LBA48
    kernel: ata2: dev 0 configured for UDMA/133
    kernel: scsi1 : ata_piix
    kernel:   Vendor: ATA       Model: Maxtor 6V300F0    Rev: VA11
    kernel:   Type:   Direct-Access                      ANSI SCSI
    revision: 05
    kernel: SCSI device sda: 586114704 512-byte hdwr sectors (300091 MB)
    kernel: SCSI device sda: drive cache: write back
    kernel: SCSI device sda: 586114704 512-byte hdwr sectors (300091 MB)
    kernel: SCSI device sda: drive cache: write back
    kernel:  sda: sda1
    kernel: sd 0:0:0:0: Attached scsi disk sda
    kernel:   Vendor: ATA       Model: ST3300831AS       Rev: 3.03
    kernel:   Type:   Direct-Access                      ANSI SCSI
    revision: 05
    kernel: SCSI device sdb: 586072368 512-byte hdwr sectors (300069 MB)
    kernel: SCSI device sdb: drive cache: write back
    kernel: SCSI device sdb: 586072368 512-byte hdwr sectors (300069 MB)
    kernel: SCSI device sdb: drive cache: write back
    kernel:  sdb: sdb1
    kernel: sd 1:0:0:0: Attached scsi disk sdb


Previously, on "Auto", this is what the kernel would output on boot:

    kernel: Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
    kernel: ide: Assuming 33MHz system bus speed for PIO modes; override
    with idebus=xx
    kernel: ide0: I/O resource 0x1F0-0x1F7 not free.
    kernel: ide0: ports already in use, skipping probe
    kernel: hdd: SR244W, ATAPI CD/DVD-ROM drive
    kernel: ide1 at 0x170-0x177,0x376 on irq 15
    kernel: hdd: ATAPI 24X CD-ROM drive, 128kB Cache
    kernel: Uniform CD-ROM driver Revision: 3.20
    kernel: ide-floppy driver 0.99.newide
    [...]
    kernel: SCSI subsystem initialized
    kernel: ata_piix: combined mode detected
    kernel: ACPI: PCI Interrupt Link [LNKC] enabled at IRQ 11
    kernel: PCI: setting IRQ 11 as level-triggered
    kernel: ACPI: PCI Interrupt 0000:00:1f.2[A] -> Link [LNKC] -> GSI 11
    (level, low) -> IRQ 11
    kernel: ata: 0x170 IDE port busy
    kernel: ata1: SATA max UDMA/133 cmd 0x1F0 ctl 0x3F6 bmdma 0xF000 irq 14
    kernel: input: AT Translated Set 2 keyboard on isa0060/serio0
    kernel: ata1: dev 0 ATA, max UDMA/133, 320173056 sectors: lba48
    kernel: ata1: dev 1 ATA, max UDMA/133, 320173056 sectors: lba48
    kernel: ata1: dev 0 configured for UDMA/133
    kernel: ata1: dev 1 configured for UDMA/133
    kernel: scsi0 : ata_piix
    kernel:   Vendor: ATA       Model: Maxtor 6Y160M0    Rev: YAR5
    kernel:   Type:   Direct-Access                      ANSI SCSI
    revision: 05
    kernel: SCSI device sda: 320173056 512-byte hdwr sectors (163929 MB)
    kernel: SCSI device sda: drive cache: write back
    kernel: SCSI device sda: 320173056 512-byte hdwr sectors (163929 MB)
    kernel: SCSI device sda: drive cache: write back
    kernel:  sda: sda1
    kernel: Attached scsi disk sda at scsi0, channel 0, id 0, lun 0
    kernel:   Vendor: ATA       Model: Maxtor 6Y160M0    Rev: YAR5
    kernel:   Type:   Direct-Access                      ANSI SCSI
    revision: 05
    kernel: SCSI device sdb: 320173056 512-byte hdwr sectors (163929 MB)
    kernel: SCSI device sdb: drive cache: write back
    kernel: SCSI device sdb: 320173056 512-byte hdwr sectors (163929 MB)
    kernel: SCSI device sdb: drive cache: write back
    kernel:  sdb: sdb1
    kernel: Attached scsi disk sdb at scsi0, channel 0, id 1, lun 0


lshw also shows the bus and IO memory organized differently, with these 
two options:

http://www.societasilluminati.org/hinv2.html : "RAID" mode set in the bios
http://www.societasilluminati.org/hinv.html: "Enhanced" mode set in the bios

Unfortunately, my boot logs have rolled since I got the "Enhanced" listing.


Samuel Masham wrote:
> Hi Again All, Alan,
>
> On 17/03/06, Samuel Masham <samuel.masham@gmail.com> wrote:
>   
>> Hi Alan,
>>
>> On 17/03/06, Alan Cox <alan@lxorguk.ukuu.org.uk> wrote:
>>     
>>> On Gwe, 2006-03-17 at 13:37 +0900, Samuel Masham wrote:
>>>       
>>>> As you can see from the printk's here this error continues and the for
>>>> every access (write?) to the drive you just have to wait for a
>>>> timeout.
>>>>         
>>> Eventually the drive will be offlined.
>>>       
>> really? I can test that easily enough if nothing else :)
>>     
>
> When is it (should it) going to offline the drive? its been spitting
> out these messages (about set per min?) for 4 hours at the moment with
> no change bar the sector number increasing by 2 each time...
>
>   
>>>> ata1: command 0x35 timeout, stat 0xd1 host_stat 0x61
>>>> ata1: translated ATA stat/err 0xd1/00 to SCSI SK/ASC/ASCQ 0xb/47/00
>>>> ata1: status=0xd1 { Busy }
>>>> SCSI disk error : host 0 channel 0 id 1 lun 0 return code = 8000002
>>>> Current sd08:12: sense key Aborted Command
>>>> Additional sense indicates Scsi parity error
>>>>         
>>> It thinks there is a communication (eg cable problem), at least that is
>>> how it has mapped the error report. Not something I'd expect to see in
>>> the SATA case on several machines so it could be some kind of setup
>>> error or timing incompatibility in the driver.
>>>       
>> Well Its cheep enough to get another cable and test that.
>>     
>
> Done. The new short cable showed no difference in behavior.
>
> So left with the timing/setup error... Anyone with any ideas?
>
>   
>>> What is attached to that controller (SATA and PATA items)
>>>       
>
> as I said before there are two hardisks
>
>   
>> Ata Maxtor 6Y080M0  SCSI  sda 0
>> Ata Maxtor 6V250F0   SCSI  sdb 0
>>     
>
> (Remember the problem is ONLY with the second drive... and according
> to others any in the 6Vxxx series shows this same issue?)
>
>   ...and there is a cdrom drive attached via pata
>
> (I think its on the same controller... the 6300ESB seems to do just
> about everything...)
>
> hdparm -I /dev/hda
>
> /dev/hda:
>
> ATAPI CD-ROM, with removable media
>         Model Number:       SAMSUNG CD-ROM SN-124
>         Serial Number:
>         Firmware Revision:  N103
> Standards:
>         Likely used CD-ROM ATAPI-1
> Configuration:
>         DRQ response: 50us.
>         Packet size: 12 bytes
> Capabilities:
>         LBA, IORDY(can be disabled)
>         DMA: sdma0 sdma1 sdma2 mdma0 mdma1 mdma2 udma0 udma1 *udma2
>              Cycle time: min=120ns recommended=120ns
>         PIO: pio0 pio1 pio2 pio3 pio4
>              Cycle time: no flow control=120ns  IORDY flow control=120ns
>
> As Ian mentioned maxtor have release a new version of the drive
> firmware ... but... The 6V250F0 drive that shows this lockup IS
> running the latest drive firmware  which I discovered after a rather
> long exchange with Maxtor...
>
> I have had a bit of a look at the sata spec and would just like to
> confirm that the drive is configured to disable the NCQ (as the Maxtor
> support seemed to stress this point). From what i can see this is done
> in the Device Configuration Overlay...
>
> From the spec
>
>   4.8. Device Configuration Overlay
>     4.8.1. Definition
>
> WORD 8: Serial ATA command / feature sets supported
>        This word enables configuration of command sets and feature sets.
>        Bit 0 indicates whether native command queuing shall be
> supported by the device. When
>        set to one, the drive shall support native command queuing.
> When cleared to zero, drive
>        support for native command queuing shall be disabled ....
>
> So anyone got any ideas how to read this?
>
> Or anything else to check / try...
>
> Samuel
>   
