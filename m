Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263388AbTLDVp2 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Dec 2003 16:45:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263523AbTLDVp2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Dec 2003 16:45:28 -0500
Received: from k-kdom.nishanet.com ([65.125.12.2]:38673 "EHLO
	mail2k.k-kdom.nishanet.com") by vger.kernel.org with ESMTP
	id S263388AbTLDVpH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Dec 2003 16:45:07 -0500
Message-ID: <3FCFAF3E.7060901@nishanet.com>
Date: Thu, 04 Dec 2003 17:03:42 -0500
From: Bob <recbo@nishanet.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.5) Gecko/20031014 Thunderbird/0.3
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: NForce2 pseudoscience stability testing (2.6.0-test11)
References: <DCB9B7AA2CAB7F418919D7B59EE45BAF49F874@mail-sc-6.nvidia.com>	 <20031204200415.GA183@tesore.local>	 <1070570505.6571.36.camel@athlonxp.bradney.info> <1070571336.4079.0.camel@athlonxp.bradney.info>
In-Reply-To: <1070571336.4079.0.camel@athlonxp.bradney.info>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Craig Bradney wrote:

>Then again.. returned to konsole to run dmesg.. bang.. dead.
>
>This is ALL over the place
>
>Craig
>
>On Thu, 2003-12-04 at 21:41, Craig Bradney wrote:
>  
>
>>The biggest problem is we are getting very different results here
>>(understatement!).
>>
>>I'm running UDMA 133 on round 80w cables
>>    
>>
Pre-emptive kernel, apic lapic, anticipatory scheduling,
udma133 on round cables, four ide drives linux softw
raid0 on a 3ware card, two cd's on the onboard
amd controller. I can copy from my cd to my cdr
(through pipes) with no loopback file, compile kernel
while copying /usr/src/linux between partitions, htdig
index hundreds of megs while slicing and dicing
something else. The sound works.

Before a bios flash I had problems with anything
involving the pci bus(fsck, cp, compile, wav to mp3)
though not necessarily ide, and onboard amd ide was
much more stable. Now I am only lacking the usb and
onboard ethernet. Even though I have a dozen unused
interrupts, bios stupidly puts two or three things on one
interrupt and says "IRQ7 Disabled" if I turn on the ethernet
onboard chip. nforce2 ethernet is actually an intel chip, and
linux has a driver, but it doesn't work for me.

1) Bios update made cmos apic kernel ioapic lapic work,
probably due to new id info but the bios site doc does
not say ANYTHING, sorry!

2) Despite a dozen unused interrupts, two or more
agp and pci cards are assigned to the same interrupt,
which might cause problems. Stubborn-ness displayed
in assigning two or three cards including agp to the
same interrupt when a dozen irq's are free just might
be a sign of pseudo-idealogy displacing logic. Why
push it with agp8 and four hard drives on one irq,
or four hard drives and 802.11 and ethernet on one?
Why have 21 irq's but foot-binding to size 5 fits all?

>>I can do a grep on kernel source, eg from /usr/src/linux
>>grep -R linus *
>>grep -R kernel *
>>and it happily returns all information I asked for.
>>
>>Right now, I am also running grep over a 4gb dvd I recently wrote from
>>within 2.6. No crash.. in fact.. its still going as I type this. I can
>>run hdparm -I while its grepping and see its on udma2.
>>
>>
>>The one thing I DID notice when I was testing with preempt on was the
>>something similar to the following from the dmesg that Ross Alexander
>>sent (dont have the dmesg output anymore :( ):
>>
>>hda: IRQ probe failed (0xfffffffa)
>>hdb: IRQ probe failed (0xfffffffa)
>>hdb: IRQ probe failed (0xfffffffa)
>>
>>
>>Now it all runs through ok as shown below.
>>
>>NFORCE2: IDE controller at PCI slot 0000:00:09.0
>>NFORCE2: chipset revision 162
>>NFORCE2: not 100% native mode: will probe irqs later
>>NFORCE2: BIOS didn't set cable bits correctly. Enabling workaround.
>>ide: Assuming 33MHz system bus speed for PIO modes; override with
>>idebus=xx
>>NFORCE2: 0000:00:09.0 (rev a2) UDMA133 controller
>>    ide0: BM-DMA at 0xf000-0xf007, BIOS settings: hda:DMA, hdb:DMA
>>    ide1: BM-DMA at 0xf008-0xf00f, BIOS settings: hdc:DMA, hdd:DMA
>>hda: Maxtor 6Y080P0, ATA DISK drive
>>ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
>>hdc: SONY DVD RW DRU-510A, ATAPI CD/DVD-ROM drive
>>hdd: SAMSUNG CD-ROM SC-152C, ATAPI CD/DVD-ROM drive
>>ide1 at 0x170-0x177,0x376 on irq 15
>>hda: max request size: 128KiB
>>hda: 160086528 sectors (81964 MB) w/7936KiB Cache, CHS=65535/16/63,
>>UDMA(133)
>> /dev/ide/host0/bus0/target0/lun0: p1 p2 < p5 p6 p7 p8 >
>>hdc: ATAPI 32X DVD-ROM DVD-R CD-R/RW drive, 8192kB Cache, UDMA(33)
>>Uniform CD-ROM driver Revision: 3.12
>>hdd: ATAPI 52X CD-ROM drive, 128kB Cache, DMA
>>
>>In answer to Bob's email that has just come in.. I see no IRQ7 disabled
>>messages.. just IRQ7 -> 0:7
>>
>>Uptime is now over 5 hours with a decent amount of time idling and being
>>busy. 
>>
>>Craig
>>
>>PS.
>>cat /proc/interrupts
>>           CPU0
>>  0:   20104881          XT-PIC  timer
>>  1:      21139    IO-APIC-edge  i8042
>>  2:          0          XT-PIC  cascade
>>  8:          2    IO-APIC-edge  rtc
>>  9:          0   IO-APIC-level  acpi
>> 12:     192779    IO-APIC-edge  i8042
>> 14:     171638    IO-APIC-edge  ide0
>> 15:     101036    IO-APIC-edge  ide1
>> 19:    1507163   IO-APIC-level  radeon@PCI:3:0:0
>> 21:     276278   IO-APIC-level  ehci_hcd, NVidia nForce2, eth0
>> 22:          3   IO-APIC-level  ohci1394
>>NMI:          0
>>LOC:   20104718
>>ERR:          0
>>MIS:          0
>>
>>
>>On Thu, 2003-12-04 at 21:04, Jesse Allen wrote:
>>    
>>
>>>On Wed, Dec 03, 2003 at 09:11:37PM -0800, Allen Martin wrote:
>>>      
>>>
>>>>I don't think there's any faulty nForce IDE hardware or we would have heard
>>>>about it from windows users (and we haven't).  
>>>>        
>>>>
>>>Ok.  I have never tested a motherboard driver for a problem like this.  But I'm starting to understand more.
>>>
>>>I went ahead and tried more configurations.  I wish I had a pci ide card with 
>>>udma 100, but the one I have is being used =(.  So I just had to make do with 
>>>what I have.  The test is very simple, because it is very simple to trigger it. 
>>>I just grep something very large.  It locks up almost immediately with 2.6 + 
>>>apic + nvidia ide with dma enabled.
>>>
>>>I ran grep on these devices:
>>>IDE hard disk at UDMA 100, 100 MB/s, flat cable, 80w.  grep on kernel source.
>>>same IDE hard disk with DMA disabled, 16 MB/s. grep on kernel source.
>>>SCSI hard disk at 20 MB/s. grep on kernel source.
>>>IDE 24x cdrom, 11 MB/s.  grepped whole cd-rom fs, about 300 MB.
>>>
>>>During the test runs, I tried:
>>>bios update -- no difference (same results no matter what)
>>>preempt on/off -- no difference (same results)
>>>
>>>The results (uniprocessor system):
>>>1. under 2.6.0-test11 with nvidia ide, dma enabled, apic
>>>grep on IDE hard disk at UDMA 100 -- locks nearly immediately
>>>and later attempt, grep on cdrom -- doesn't lock up (still will lock up with 
>>>hard disk though)
>>>
>>>2. under 2.6.0-test11 with nvidia ide, dma, pic
>>>grep on IDE hard disk at UDMA 100 -- doesn't lock up
>>>
>>>3. under 2.4.23, with nvidia ide, dma enabled, apic
>>>grep on IDE hard disk at UDMA 100 -- doesn't lock up
>>>
>>>4. under 2.6.0-test11 with aic7xxx, ide completely disabled, apic
>>>grep on SCSI disk -- doesn't lock up
>>>
>>>5. under 2.6.0-test11 with nvidia ide, dma disabled, apic
>>>grep on IDE hard disk at 16 MB/s -- doesn't lock up
>>>
>>>
>>>So basically, I conclude that UDMA 100 will cause a lockup nearly immediately. 
>>>The slower interfaces speeds don't cause a lockup during the test, but that 
>>>doesn't mean the kernel will never lock up.  So DMA does produce a lockup 
>>>faster.  Either longer stresses are required (which means spending more time =( 
>>>I've only had the board for two days - heh heh), or more preferably, I need to
>>>test with another pci ide controller.  Whatever it is, it seems to be the high
>>>speeds like UDMA 100 or perhaps similarly stressing pci devices that will do it.
>>>
>>>
>>>      
>>>
>>>>The problem with comparing the nForce IDE driver against the generic IDE
>>>>driver is that the generic IDE driver won't enable DMA, so the interrupt
>>>>rate will be much different.  If there's some interrupt race condition in
>>>>APIC mode, disabling DMA may mask it.
>>>>
>>>>        
>>>>
>>>Yep, you're right.
>>>
>>>
>>>Jesse
>>>-
>>>To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
>>>the body of a message to majordomo@vger.kernel.org
>>>More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>>Please read the FAQ at  http://www.tux.org/lkml/
>>>
>>>      
>>>
>>-
>>To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
>>the body of a message to majordomo@vger.kernel.org
>>More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>Please read the FAQ at  http://www.tux.org/lkml/
>>
>>    
>>
>
>-
>To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
>the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html
>Please read the FAQ at  http://www.tux.org/lkml/
>
>  
>


