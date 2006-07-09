Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932455AbWGIOVW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932455AbWGIOVW (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 9 Jul 2006 10:21:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932454AbWGIOVW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 9 Jul 2006 10:21:22 -0400
Received: from tornado.reub.net ([202.89.145.182]:29868 "EHLO tornado.reub.net")
	by vger.kernel.org with ESMTP id S932452AbWGIOVV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 9 Jul 2006 10:21:21 -0400
Message-ID: <44B110DF.1060703@reub.net>
Date: Mon, 10 Jul 2006 02:21:19 +1200
From: Reuben Farrelly <reuben-lkml@reub.net>
User-Agent: Thunderbird 3.0a1 (Windows/20060709)
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
CC: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       linux-acpi@vger.kernel.org, rdunlap@xenotime.net, greg@kroah.com,
       john stultz <johnstul@us.ibm.com>, Andi Kleen <ak@muc.de>
Subject: Re: 2.6.18-rc1-mm1
References: <20060709021106.9310d4d1.akpm@osdl.org>	 <44B0E6E6.6070904@reub.net>  <20060709052252.8c95202a.akpm@osdl.org> <1152449805.27368.57.camel@localhost.localdomain>
In-Reply-To: <1152449805.27368.57.camel@localhost.localdomain>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/07/2006 12:56 a.m., Alan Cox wrote:
> Ar Sul, 2006-07-09 am 05:22 -0700, ysgrifennodd Andrew Morton:
>>> ata5: PATA max UDMA/133 cmd 0x1F0 ctl 0x3F6 bmdma 0x30B0 irq 14
>>> scsi4 : ata_piix
>>> ata5.00: ATAPI, max UDMA/66
>>> ata5.00: configured for UDMA/66
> 
> More ATAPI devices getting uppity about mode setting.
> 
>> John stuff.  I suspect it's natural and normal, if the IDE error handling
>> did something rude with interrupt holdoff.
> 
> The new libata should be more polite than that, although since the ATA
> drive can stall the CPU indefinitely you lose anyway 8(

It may not be related to ATA.  I just reloaded into 2.6.17-mm6 to get the info 
for Alan and saw it when booting up on that too:

PCI: Setting latency timer of device 0000:00:1d.7 to 64
ehci_hcd 0000:00:1d.7: EHCI Host Controller
ehci_hcd 0000:00:1d.7: new USB bus registered, assigned bus number 1
Losing some ticks... checking if CPU frequency changed.
ehci_hcd 0000:00:1d.7: debug port 1
PCI: cache line size of 128 is not supported by device 0000:00:1d.7

Note it was in a different place in here than in -rc1-mm1 (slightly later in the 
bootup).

I'm fairly sure it's not new to this release.

>>> Jul  2 12:03:28 tornado kernel: hda: ATAPI 40X DVD-ROM DVD-R CD-R/RW drive, 
>>> 2000kB Cache, UDMA(66)
> 
> Can you send me the full hdparm identify stuff for this ?

sh-3.1# hdparm -I /dev/hda

/dev/hda:

ATAPI CD-ROM, with removable media
         Model Number:       PIONEER DVD-RW  DVR-111D
         Serial Number:      FADC005671WL
         Firmware Revision:  1.23
Standards:
         Likely used CD-ROM ATAPI-1
Configuration:
         DRQ response: 50us.
         Packet size: 12 bytes
Capabilities:
         LBA, IORDY(can be disabled)
         Buffer size: 64.0kB
         DMA: mdma0 mdma1 mdma2 udma0 udma1 udma2 udma3 *udma4
              Cycle time: min=120ns recommended=120ns
         PIO: pio0 pio1 pio2 pio3 pio4
              Cycle time: no flow control=240ns  IORDY flow control=120ns
Commands/features:
         Enabled Supported:
            *    Power Management feature set
            *    PACKET command feature set
            *    DEVICE_RESET command
HW reset results:
         CBLID- above Vih
         Device num = 0 determined by the jumper
sh-3.1#
sh-3.1# hdparm -i /dev/hda

/dev/hda:

  Model=PIONEER DVD-RW DVR-111D, FwRev=1.23, SerialNo=
  Config={ Fixed Removeable DTR<=5Mbs DTR>10Mbs nonMagnetic }
  RawCHS=0/0/0, TrkSize=0, SectSize=0, ECCbytes=0
  BuffType=13395, BuffSize=64kB, MaxMultSect=0
  (maybe): CurCHS=0/0/0, CurSects=0, LBA=yes, LBAsects=0
  IORDY=on/off, tPIO={min:240,w/IORDY:120}, tDMA={min:120,rec:120}
  PIO modes:  pio0 pio1 pio2 pio3 pio4
  DMA modes:  mdma0 mdma1 mdma2
  UDMA modes: udma0 udma1 udma2 udma3 *udma4
  AdvancedPM=no
  Drive conforms to: Unspecified:  ATA/ATAPI-2 ATA/ATAPI-3 ATA/ATAPI-4 ATA/ATAPI-5

  * signifies the current active mode

sh-3.1#


Reuben
