Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932200AbVHLPUd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932200AbVHLPUd (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Aug 2005 11:20:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932208AbVHLPUc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Aug 2005 11:20:32 -0400
Received: from baldrick.bootc.net ([83.142.228.48]:37068 "EHLO
	baldrick.bootc.net") by vger.kernel.org with ESMTP id S932200AbVHLPUb
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Aug 2005 11:20:31 -0400
In-Reply-To: <EXCHG2003Y6YHkidcDj00000063@EXCHG2003.microtech-ks.com>
References: <EXCHG2003Y6YHkidcDj00000063@EXCHG2003.microtech-ks.com>
Mime-Version: 1.0 (Apple Message framework v733)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <416E9EA6-8427-4605-AF74-0EC1B19A1A79@bootc.net>
Cc: <linux-kernel@vger.kernel.org>, <linux-ide@vger.kernel.org>
Content-Transfer-Encoding: 7bit
From: Chris Boot <bootc@bootc.net>
Subject: Re: SiI 3112A + Seagate HDs = still no go?
Date: Fri, 12 Aug 2005 16:20:13 +0100
To: Roger Heflin <rheflin@atipa.com>
X-Mailer: Apple Mail (2.733)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi there,

I get very different symptoms indeed. My drive isn't in the  
blacklist, and adding it has little effect (status 0xd9 to 0xd8, no  
other differences). Once the controller hangs, I can't even kill dd  
or login at a different terminal, just a complete lockup. If I have 2  
drives plugged in, running the dd on one of them also hangs the  
other, thus I suspect the controller. Also, reading via dd is fine,  
only writing has trouble.

Chris

On 12 Aug 2005, at 16:19, Roger Heflin wrote:

>
> With the Segate sata's I worked with before, I had to
> actually remove them from the blacklist, this was a couple
> of months ago with the native sata seagate disks.
>
> With the drive in the blacklist the drive worked right
> under light conditions, but under a dd read from the boot
> seagate the entire machine appeared to block on any io
> going to that disk, it did not stop (verified by vmstat),
> but I could never get the 55-60MiB/second expected, and
> was getting around 15MiB/second, with enormous amounts
> of interrupts, after removing it from the blacklist,
> I got the 55-60MiB/second rate, and the interrupts were
> much more reasonable, and the response of the system
> was actually useable.    When the lockup occurred, stopping
> the dd resulting in all things unlocking and continuing
> on, I duplicated this several times with the latest kernel
> at the time.
>
>                    Roger
>
>
>> -----Original Message-----
>> From: linux-kernel-owner@vger.kernel.org
>> [mailto:linux-kernel-owner@vger.kernel.org] On Behalf Of Chris Boot
>> Sent: Thursday, August 11, 2005 4:55 PM
>> To: linux-kernel@vger.kernel.org
>> Subject: SiI 3112A + Seagate HDs = still no go?
>>
>> Hi all,
>>
>> I just recently took the plunge and bought 4 250 GB Seagate
>> drives and a 2 port Silicon Image 3112A controller card for
>> the 2 drives my motherboard doesn't handle. No matter how
>> hard I try, I can't get the hard drives to work: they are
>> detected correctly and work reasonably well under _very_
>> light load, but anything like building a RAID array is a bit
>> much and the whole controller seems to lock up.
>>
>> I've tried adding the drive to the blacklist in the
>> sata_sil.c driver and I still have the same trouble: as you
>> can see the messages below relate to my patched kernel with
>> the blacklist fix. I've seen that this was discussed just
>> yesterday, but that seemed to give nothing:
>> http://www.ussg.iu.edu/hypermail/linux/kernel/0508.1/0310.html
>>
>> Ready and willing to hack my kernel to pieces; this machine
>> is no use until I get all the drives working! Needless to say
>> the drives connected to the on-board VIA controller work
>> fine, as do the drives currently on the SiI controller if I
>> swap them around.
>>
>> Any ideas?
>>
>> TIA
>> Chris
>>
>> The following messages are sent to the log when everything goes mad:
>>
>> ata1: command 0x35 timeout, stat 0xd8 host_stat 0x0
>> ata1: status=0xd8 { Busy }
>> SCSI error : <0 0 0 0> return code = 0x80000002
>> sda: Current: sense key=0xb
>> ASC=0x47 ASCQ=0x0
>> end_request: I/O error, dev sda, sector 2990370
>> ATA: abnormal status 0xD8 on port E0802087
>> ATA: abnormal status 0xD8 on port E0802087
>> ATA: abnormal status 0xD8 on port E0802087 [ the above is
>> transcribed so may not be 100% accurate ]
>>
>> Dmesg log during boot (and detection):
>>
>> Aug 11 21:47:05 arcadia Linux version 2.6.12-gentoo-r6
>> (root@arcadia.bootc.net) (gcc version 3.3.5-20050130 (Gentoo
>> 3.3.5.20050130-r1, ssp-3.3.5.20050130-1, pie-8.7.7.1)) #2 Thu
>> Aug 11 20:19:00 BST 2005 ...
>> Aug 11 17:30:12 arcadia sata_sil version 0.9 Aug 11 17:30:12
>> arcadia ACPI: PCI Interrupt 0000:00:0a.0[A] -> GSI 18 (level,
>> low) -> IRQ 177 Aug 11 17:30:12 arcadia ata1: SATA max
>> UDMA/100 cmd 0xE0802080 ctl 0xE080208A bmdma 0xE0802000 irq
>> 177 Aug 11 17:30:12 arcadia ata2: SATA max UDMA/100 cmd
>> 0xE08020C0 ctl 0xE08020CA bmdma 0xE0802008 irq 177 Aug 11
>> 17:30:12 arcadia ata1: dev 0 cfg 49:2f00 82:346b 83:7d01
>> 84:4023 85:3469 86:3c01 87:4023 88:207f
>> Aug 11 17:30:12 arcadia ata1: dev 0 ATA, max UDMA/133, 488397168
>> sectors: lba48
>> Aug 11 17:30:12 arcadia ata1(0): applying Seagate errata fix
>> Aug 11 17:30:12 arcadia ata1: dev 0 configured for UDMA/100
>> Aug 11 17:30:12 arcadia scsi0 : sata_sil Aug 11 17:30:12
>> arcadia ata2: dev 0 cfg 49:2f00 82:346b 83:7d01
>> 84:4023 85:3469 86:3c01 87:4023 88:207f
>> Aug 11 17:30:12 arcadia ata2: dev 0 ATA, max UDMA/133, 488397168
>> sectors: lba48
>> Aug 11 17:30:12 arcadia ata2(0): applying Seagate errata fix
>> Aug 11 17:30:12 arcadia ata2: dev 0 configured for UDMA/100
>> Aug 11 17:30:12 arcadia scsi1 : sata_sil
>> Aug 11 17:30:12 arcadia Vendor: ATA       Model: ST3250823AS
>> Rev: 3.03
>> Aug 11 17:30:12 arcadia Type:   Direct-Access
>> ANSI SCSI revision: 05
>> Aug 11 17:30:12 arcadia Vendor: ATA       Model: ST3250823AS
>> Rev: 3.03
>> Aug 11 17:30:12 arcadia Type:   Direct-Access
>> ANSI SCSI revision: 05
>>
>> lspci:
>>
>> 0000:00:00.0 Host bridge: VIA Technologies, Inc. VT8377
>> [KT400/KT600 AGP] Host Bridge 0000:00:01.0 PCI bridge: VIA
>> Technologies, Inc. VT8235 PCI Bridge 0000:00:0a.0 Unknown
>> mass storage controller: Silicon Image, Inc. SiI
>> 3112 [SATALink/SATARaid] Serial ATA Controller (rev 02)
>> 0000:00:0c.0 FireWire (IEEE 1394): Agere Systems (former Lucent
>> Microelectronics) FW323 (rev 61)
>> 0000:00:0f.0 RAID bus controller: VIA Technologies, Inc. VIA
>> VT6420 SATA RAID Controller (rev 80)
>> 0000:00:0f.1 IDE interface: VIA Technologies, Inc.
>> VT82C586A/B/ VT82C686/A/B/VT823x/A/C PIPC Bus Master IDE (rev
>> 06) 0000:00:10.0 USB Controller: VIA Technologies, Inc.
>> VT82xxxxx UHCI USB 1.1 Controller (rev 81)
>> 0000:00:10.1 USB Controller: VIA Technologies, Inc. VT82xxxxx
>> UHCI USB 1.1 Controller (rev 81)
>> 0000:00:10.2 USB Controller: VIA Technologies, Inc. VT82xxxxx
>> UHCI USB 1.1 Controller (rev 81)
>> 0000:00:10.3 USB Controller: VIA Technologies, Inc. VT82xxxxx
>> UHCI USB 1.1 Controller (rev 81)
>> 0000:00:10.4 USB Controller: VIA Technologies, Inc. USB 2.0
>> (rev 86) 0000:00:11.0 ISA bridge: VIA Technologies, Inc.
>> VT8237 ISA bridge [KT600/K8T800/K8T890 South]
>> 0000:00:11.5 Multimedia audio controller: VIA Technologies, Inc.
>> VT8233/A/8235/8237 AC97 Audio Controller (rev 60)
>> 0000:00:12.0 Ethernet controller: VIA Technologies, Inc.
>> VT6102 [Rhine-II] (rev 78) 0000:01:00.0 VGA compatible
>> controller: nVidia Corporation NV11
>> [GeForce2 MX/MX 400] (rev b2)
>>
>> Many thanks,
>> Chris
>>
>> --
>> Chris Boot
>> bootc@bootc.net
>> http://www.bootc.net/
>>
>>
>>
>>
>> -
>> To unsubscribe from this list: send the line "unsubscribe
>> linux-kernel" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>> Please read the FAQ at  http://www.tux.org/lkml/
>>
>>
>
>

-- 
Chris Boot
bootc@bootc.net
http://www.bootc.net/


