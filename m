Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263174AbTJUQ7h (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Oct 2003 12:59:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263189AbTJUQ7h
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Oct 2003 12:59:37 -0400
Received: from ncircle.nullnet.fi ([62.236.96.207]:18304 "EHLO
	ncircle.nullnet.fi") by vger.kernel.org with ESMTP id S263174AbTJUQ7e
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Oct 2003 12:59:34 -0400
Message-ID: <32836.192.168.9.10.1066755572.squirrel@ncircle.nullnet.fi>
In-Reply-To: <3F94FB1B.9000803@kmlinux.fjfi.cvut.cz>
References: <3F94FB1B.9000803@kmlinux.fjfi.cvut.cz>
Date: Tue, 21 Oct 2003 19:59:32 +0300 (EEST)
Subject: Re: HighPoint 374
From: "Tomi Orava" <Tomi.Orava@ncircle.nullnet.fi>
To: "Jindrich Makovicka" <makovick@kmlinux.fjfi.cvut.cz>
Cc: linux-kernel@vger.kernel.org
User-Agent: SquirrelMail/1.4.2
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Priority: 3
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> With my EPoX 8K9A3+, I had to hack the kernel to get the HPT374 running
> at all, as it reported slightly higher PCI clock than 33MHz, although
> the machine wasn't overclocked, but it seems to run fine. The current
> driver supports only 33MHz clock, which is probably the reason HPT374
> isn't even initialized in some cases.

Hmm, it looks like my motherboard doesn't suffer from the same problem.
I see that in my machine the correct frequency is selected:

------------------------------------------------------------
HPT374: IDE controller at PCI slot 00:0e.0
HPT374: chipset revision 7
HPT374: not 100% native mode: will probe irqs later
HPT37X: using 33MHz PCI clock
    ide2: BM-DMA at 0xb800-0xb807, BIOS settings: hde:DMA, hdf:pio
    ide3: BM-DMA at 0xb808-0xb80f, BIOS settings: hdg:DMA, hdh:pio
HPT37X: using 33MHz PCI clock
    ide4: BM-DMA at 0xcc00-0xcc07, BIOS settings: hdi:DMA, hdj:pio
    ide5: BM-DMA at 0xcc08-0xcc0f, BIOS settings: hdk:DMA, hdl:pio
SiI680: IDE controller at PCI slot 00:09.0
SiI680: chipset revision 1
SiI680: not 100% native mode: will probe irqs later
SiI680: BASE CLOCK == 133
    ide6: MMIO-DMA , BIOS settings: hdm:pio, hdn:pio
    ide7: MMIO-DMA , BIOS settings: hdo:pio, hdp:pio
------------------------------------------------------------

However, with the latest 2.4.23-pre7 kernel I get the following error
messages and I think the hdparm -i output looks wierd ...
Perhaps the display is incorrect as I have disabled for testing
purposes the CONFIG_IDEDMA_PCI_AUTO-option so that I'm able to
boot up even if raid1 resync is started at boot without hang.
(I use the hdparm -d1 to enabled dma-mode later)

---------------------------------------------------------------
hde: SAMSUNG SV8004H, ATA DISK drive
hde: set_drive_speed_status: status=0x51 { DriveReady SeekComplete Error }
hde: set_drive_speed_status: error=0x04 { DriveStatusError }
hdg: SAMSUNG SV8004H, ATA DISK drive
hdg: set_drive_speed_status: status=0x51 { DriveReady SeekComplete Error }
hdg: set_drive_speed_status: error=0x04 { DriveStatusError }
hdi: SAMSUNG SV1604N, ATA DISK drive
hdi: set_drive_speed_status: status=0x51 { DriveReady SeekComplete Error }
hdi: set_drive_speed_status: error=0x04 { DriveStatusError }
hdk: SAMSUNG SV1604N, ATA DISK drive
hdk: set_drive_speed_status: status=0x51 { DriveReady SeekComplete Error }
hdk: set_drive_speed_status: error=0x04 { DriveStatusError }

---> Drives connected to Sil680 don't complain below -------------
hdm: MAXTOR 6L060J3, ATA DISK drive
blk: queue c04992f8, I/O limit 4095Mb (mask 0xffffffff)
hdo: MAXTOR 6L060J3, ATA DISK drive
blk: queue c049974c, I/O limit 4095Mb (mask 0xffffffff)
---------------------------------------------------------------

The output of hdparm -i /dev/hde (first drive connected to HPT374,
note the mode selection asterisk is missing as well as faster modes):

/dev/hde:

 Model=SAMSUNG SV8004H, FwRev=QR100-12, SerialNo=0357J1AT803561
 Config={ HardSect NotMFM HdSw>15uSec Fixed DTR>10Mbs }
 RawCHS=16383/16/63, TrkSize=38997, SectSize=619, ECCbytes=4
 BuffType=DualPortCache, BuffSize=2048kB, MaxMultSect=16, MultSect=16
 CurCHS=16383/16/63, CurSects=16514064, LBA=yes, LBAsects=156368016
 IORDY=yes, tPIO={min:120,w/IORDY:120}, tDMA={min:120,rec:120}
 PIO modes:  pio0 pio1 pio2 pio3 pio4
 DMA modes:  mdma0 mdma1 mdma2
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
 UDMA modes: udma0 udma1 udma2
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
 AdvancedPM=no WriteCache=enabled
 Drive conforms to: ATA/ATAPI-6 T13 1410D revision 1:

 * signifies the current active mode


Does this tell anything to the IDE-guys ?

Regards,
Tomi Orava

PS. All the drives have been set with explicit hdparm -m 16 setting
    in order to see if it changes anything regarding the interrupt
    problem described previously.

-- 
Tomi.Orava@ncircle.nullnet.fi

