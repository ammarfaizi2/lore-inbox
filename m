Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268034AbUHFAq1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268034AbUHFAq1 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Aug 2004 20:46:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268029AbUHFAq0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Aug 2004 20:46:26 -0400
Received: from mra04.ex.eclipse.net.uk ([212.104.129.139]:41682 "EHLO
	mra04.ex.eclipse.net.uk") by vger.kernel.org with ESMTP
	id S267558AbUHFApz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Aug 2004 20:45:55 -0400
From: Ian Hastie <ianh@iahastie.clara.net>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: PATCH: Add support for IT8212 IDE controllers
Date: Fri, 6 Aug 2004 01:45:49 +0100
User-Agent: KMail/1.6.2
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       linux-ide@vger.kernel.org
References: <20040731232227.GA28455@devserv.devel.redhat.com> <200408012022.42516.ianh@iahastie.local.net> <1091401522.31305.0.camel@localhost.localdomain>
In-Reply-To: <1091401522.31305.0.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200408060145.50380.ianh@iahastie.local.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 02 Aug 2004 00:05, Alan Cox wrote:
> Ok try this

OK, tried it now.  Sorry it took so long to get around to it.

It gets the ATA clock setting right, but that's the only obvious change.  
Everything else in the boot log seems the same.

The UDMA rate is still detected wrongly, but this is because the PCI reg 0x40 
contains the value 0xa000 which should mean 40 wire cables.  I am using 
rounded canbles, but I can't say if this would cause a misdetection or not.  
The ITE driver seems to suggest that cable detect can only be used if the 
chip is in "Firmware" mode.  I thought I saw a more definite reference to 
this, but I can't seem to find it now.  It's certainly true that I have not 
seen any data corruption on the connected drives even when running at hat 
should be UDMA133.

One other small point is that SMART doesn't work through this driver.  
smartctl -A says there is a checksum error and then says SMART is not active.

IT8212: IDE controller at PCI slot 0000:00:0c.0
ACPI: PCI interrupt 0000:00:0c.0[A] -> GSI 17 (level, low) -> IRQ 17
IT8212: chipset revision 17
IT8212: 100% native mode on irq 17
ide2: BM-DMA at 0xec00-0xec07, BIOS settings: hde:pio, hdf:pio
it8212: controller in smart mode.
it8212: BIOS seleted a 66MHz clock.
ide3: BM-DMA at 0xec08-0xec0f, BIOS settings: hdg:pio, hdh:pio
it8212: BIOS seleted a 66MHz clock.
hde: Maxtor 6Y120P0, ATA DISK drive
ide2 at 0xb000-0xb007,0xa802 on irq 17
hde: max request size: 128KiB
hde: recal_intr: status=0x51 { DriveReady SeekComplete Error }
hde: recal_intr: error=0x04 { DriveStatusError }
hde: 240121728 sectors (122942 MB) w/7936KiB Cache, CHS=65535/16/63, UDMA(33)
/dev/ide/host2/bus0/target0/lun0: p1 p2
hdg: Maxtor 6Y120P0, ATA DISK drive
ide3 at 0xa400-0xa407,0xa002 on irq 17
hdg: max request size: 128KiB
hdg: recal_intr: status=0x51 { DriveReady SeekComplete Error }
hdg: recal_intr: error=0x04 { DriveStatusError }
hdg: 240121728 sectors (122942 MB) w/7936KiB Cache, CHS=65535/16/63, UDMA(33)
/dev/ide/host2/bus1/target0/lun0: p1 p2

-- 
Ian.
