Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263880AbTJEVz2 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 5 Oct 2003 17:55:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263884AbTJEVz2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 5 Oct 2003 17:55:28 -0400
Received: from htklx2.htk.fi ([195.156.245.118]:183 "EHLO htklx2.htk.fi")
	by vger.kernel.org with ESMTP id S263880AbTJEVzW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 5 Oct 2003 17:55:22 -0400
Message-ID: <3F809382.3060201@fixel.org>
Date: Mon, 06 Oct 2003 00:56:18 +0300
From: Pauli Borodulin <boro@fixel.org>
Organization: Fixel Networking Org.
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.0; en-US; rv:1.4) Gecko/20030624
X-Accept-Language: en-us, en, fi
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: SiI3112 DMA? (2.6.0-test6)
References: <1065347429.1441.17.camel@paragon.slim> <20031005170716.GG9052@carfax.org.uk>
In-Reply-To: <20031005170716.GG9052@carfax.org.uk>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> On Sun, Oct 05, 2003 at 11:50:29AM +0200, Jurgen Kramer wrote:
>>I am currently running 2.6.0-test6 on an old PII which has a SiI3112
>>SATA PCI card in one of its PCI slots. It seems that the SiI3112 is not
>>using DMA so now it is even running slower then the onboard PIIX4 IDE
>>controller.
>>
>>Is DMA supported on the Si3112? DMA is not being enabled by the SiI3112
>>card's BIOS (this is a cheap PCI card):
 >> [...]

Hugo Mills wrote:
>    I get this, too, on 2.4.22-ac2, and I've had someone else tell me
> about the same issue with their card (don't know what kernel he's
> running).
 > [...]

Same problems here. My kernel version is 2.4.22, but more important is 
that the driver version is 1.06. My card is manufactured by "VScom" and 
it looks almost identical compared to the evaluation card made my 
Silicon Image.

Here are my snippets:

dmesg:
[snip]
SiI3112 Serial ATA: IDE controller at PCI slot 00:09.0
PCI: Found IRQ 11 for device 00:09.0
SiI3112 Serial ATA: chipset revision 1
SiI3112 Serial ATA: not 100% native mode: will probe irqs later
ide2: MMIO-DMA , BIOS settings: hde:pio, hdf:pio
ide3: MMIO-DMA , BIOS settings: hdg:pio, hdh:pio
hde: Maxtor 6Y120M0, ATA DISK drive
blk: queue c03426a8, I/O limit 4095Mb (mask 0xffffffff)
hdg: Maxtor 6Y120M0, ATA DISK drive
blk: queue c0342afc, I/O limit 4095Mb (mask 0xffffffff)
[/snip]

server:/var/log# cat /proc/ide/siimage
Controller: 0
SiI3112 Chipset.
MMIO Base 0xec003000
MMIO-DMA Base 0xec003000
MMIO-DMA Base 0xec003008

server:/var/log# hdparm /dev/hde

/dev/hde:
  multcount    = 16 (on)
  IO_support   =  0 (default 16-bit)
  unmaskirq    =  0 (off)
  using_dma    =  1 (on)
  keepsettings =  0 (off)
  readonly     =  0 (off)
  readahead    =  8 (on)
  geometry     = 238216/16/63, sectors = 240121728, start = 0

server:/var/log# hdparm -I /dev/hde

[snip]
/dev/hde:

ATA device, with non-removable media
     Model Number:       Maxtor 6Y120M0
     Serial Number:      Y3JZGQYE
     Firmware Revision:  YAR51BW0
Standards:
     Supported: 7 6 5 4
     Likely used: 7
Configuration:
     Logical         max     current
     cylinders       16383   16383
     heads           16      16
     sectors/track   63      63
     --
     CHS current addressable sectors:   16514064
     LBA    user addressable sectors:  240121728
     device size with M = 1024*1024:      117246 MBytes
     device size with M = 1000*1000:      122942 MBytes (122 GB)
Capabilities:
     LBA, IORDY(can be disabled)
     Queue depth: 1
     Standby timer values: spec'd by Standard, no device specific minimum
     R/W multiple sector transfer: Max = 16  Current = 16
     Advanced power management level: unknown setting (0x0000)
     Recommended acoustic management value: 192, current value: 254
     DMA: mdma0 mdma1 mdma2 udma0 udma1 udma2 udma3 udma4 *udma5 udma6
          Cycle time: min=120ns recommended=120ns
     PIO: pio0 pio1 pio2 pio3 pio4
          Cycle time: no flow control=120ns  IORDY flow control=120ns
[/snip]

server:/var/log# hdparm -i /dev/hde

/dev/hde:

  Model=Maxtor 6Y120M0, FwRev=YAR51BW0, SerialNo=Y3JZGQYE
  Config={ Fixed }
  RawCHS=16383/16/63, TrkSize=0, SectSize=0, ECCbytes=4
  BuffType=DualPortCache, BuffSize=7936kB, MaxMultSect=16, MultSect=16
  CurCHS=16383/16/63, CurSects=16514064, LBA=yes, LBAsects=240121728
  IORDY=on/off, tPIO={min:120,w/IORDY:120}, tDMA={min:120,rec:120}
  PIO modes:  pio0 pio1 pio2 pio3 pio4
  DMA modes:  mdma0 mdma1 mdma2
  UDMA modes: udma0 udma1 udma2
  AdvancedPM=yes: disabled (255) WriteCache=enabled
  Drive conforms to: (null):  1 2 3 4 5 6 7


Oh, and running 'hdparm -X[anything here] -d1 -c1 -K1' makes my system 
get stuck and I have to reset.

-- 
Pauli Borodulin <boro \@/ fixel.org>

