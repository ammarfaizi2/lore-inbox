Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1424165AbWKIRdM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1424165AbWKIRdM (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Nov 2006 12:33:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1424166AbWKIRdL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Nov 2006 12:33:11 -0500
Received: from smtpout08-04.prod.mesa1.secureserver.net ([64.202.165.12]:34199
	"HELO smtpout08-04.prod.mesa1.secureserver.net") by vger.kernel.org
	with SMTP id S1424165AbWKIRdK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Nov 2006 12:33:10 -0500
Message-ID: <45536653.50006@seclark.us>
Date: Thu, 09 Nov 2006 12:33:07 -0500
From: Stephen Clark <Stephen.Clark@seclark.us>
Reply-To: Stephen.Clark@seclark.us
User-Agent: Mozilla/5.0 (X11; U; Linux 2.2.16-22smp i686; en-US; m18) Gecko/20010110 Netscape6/6.5
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Arjan van de Ven <arjan@infradead.org>
CC: =?ISO-8859-1?Q?=22=5C=22J=2EA=2E=5C=22_Magall=F3n=22?= 
	<jamagallon@ono.com>,
       =?ISO-8859-1?Q?Bj=F6rn_Steinbrink?= <B.Steinbrink@gmx.de>,
       Mark Lord <lkml@rtr.ca>, linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: Abysmal PATA IDE performance
References: <455206E7.2050104@seclark.us> <45526D50.5020105@rtr.ca>	 <455277E1.3040803@seclark.us> <20061109020758.GA21537@atjola.homenet>	 <4552A638.4010207@seclark.us>  <20061109094014.1c8b6bed@werewolf-wl>	 <1163062700.3138.467.camel@laptopd505.fenrus.org>	 <45533DB9.4000405@seclark.us> <1163084045.3138.502.camel@laptopd505.fenrus.org>
In-Reply-To: <1163084045.3138.502.camel@laptopd505.fenrus.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Arjan van de Ven wrote:

>>> 
>>>
>>>      
>>>
>>Thanks all.
>>
>>Arjan, using combined_mode=libata and making a new ramdisk increased my 
>>xfer rate from 1.xx mb/sec to 28.xx mb/sec.
>>
>>    
>>
>
>ok that's getting somewhere
>
>  
>
>>I am curious as to why my friends dell inspiron 8200 with a 1.8ghz p4 
>>and the same drive using the same drive with FC6 and the standard ide 
>>module gets 44 to 45 mb/sec.
>>    
>>
>
>now it is going to come down to how you measure this....
>
>don't use hdparm, use something like tiobench (tiobench.sf.net);
>another setting that might be different is that scsi normally turns the
>write back cache off (safer for your data but slower) while IDE normally
>leaves at at factory default (on for cheating on benchmarks).
>For writes, this can easily explain the difference...
>
>
>  
>
Looking at the dmesg output I am a little confused, see comments below:
partial dmesg output follows:

SCSI subsystem initialized
libata version 2.00 loaded.
ata_piix 0000:00:1f.2: version 2.00
ata_piix 0000:00:1f.2: MAP [ P0 P2 IDE IDE ]
ACPI: PCI Interrupt 0000:00:1f.2[B] -> GSI 19 (level, low) -> IRQ 233
PCI: Setting latency timer of device 0000:00:1f.2 to 64
ata1: SATA max UDMA/133 cmd 0x1F0 ctl 0x3F6 bmdma 0xFFA0 irq 14
scsi0 : ata_piix
Synaptics Touchpad, model: 1, fw: 6.1, id: 0xa3a0b3, caps: 0xa04713/0x10008
input: SynPS/2 Synaptics TouchPad as /class/input/input1
ATA: abnormal status 0x7F on port 0x1F7
ata2: PATA max UDMA/100 cmd 0x170 ctl 0x376 bmdma 0xFFA8 irq 15
scsi1 : ata_piix
ata2.00: ATA-6, max UDMA/100, 117210240 sectors: LBA48
ata2.00: ata2: dev 0 multi count 16
usb 2-2: new low speed USB device using uhci_hcd and address 3
ata2.01: ATAPI, max UDMA/33
ata2.00: configured for UDMA/33 <==== why isn't this 66 or 100 ?
===============****
usb 2-2: configuration #1 chosen from 1 choice
input: Logitech USB-PS/2 Trackball as /class/input/input2
input: USB HID v1.00 Mouse [Logitech USB-PS/2 Trackball] on
usb-0000:00:1d.1-2
ata2.01: configured for UDMA/33 <=========== is this related to the
following 2 lines? ====
   Vendor: ATA       Model: HTS721060G9AT00   Rev: MC3O
   Type:   Direct-Access                      ANSI SCSI revision: 05
SCSI device sda: 117210240 512-byte hdwr sectors (60012 MB)
sda: Write Protect is off
sda: Mode Sense: 00 3a 00 00
SCSI device sda: drive cache: write back
SCSI device sda: 117210240 512-byte hdwr sectors (60012 MB)
sda: Write Protect is off
sda: Mode Sense: 00 3a 00 00
SCSI device sda: drive cache: write back
  sda: sda1 sda2
sd 1:0:0:0: Attached scsi disk sda
   Vendor: HL-DT-ST  Model: DVDRAM GMA-4082N  Rev: HJ02
   Type:   CD-ROM                             ANSI SCSI revision: 05
device-mapper: ioctl: 4.7.0-ioctl (2006-06-24) initialised:
dm-devel@redhat.com
kjournald starting.  Commit interval 5 seconds

-- 

"They that give up essential liberty to obtain temporary safety,
deserve neither liberty nor safety."  (Ben Franklin)

"The course of history shows that as a government grows, liberty
decreases."  (Thomas Jefferson)




