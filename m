Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132387AbRDALP3>; Sun, 1 Apr 2001 07:15:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132352AbRDALPU>; Sun, 1 Apr 2001 07:15:20 -0400
Received: from [202.77.223.60] ([202.77.223.60]:5381 "HELO server.achan.com")
	by vger.kernel.org with SMTP id <S132324AbRDALPC>;
	Sun, 1 Apr 2001 07:15:02 -0400
Message-ID: <00d601c0ba9c$d60cc700$3700a8c0@pluto>
From: "Andrew Chan" <achan@achan.com>
To: <linux-kernel@vger.kernel.org>
Subject: Promise 20267 "working" but no UDMA
Date: Sun, 1 Apr 2001 19:13:53 +0800
MIME-Version: 1.0
Content-Type: text/plain;
	charset="Windows-1252"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.50.4522.1200
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4522.1200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Anybody manage to get UDMA 66/100 working with an on-board Promise 20267
chip?

Hardware: Tyan Tiger LE (with ServerWorks OSB4 _and_ Promise 20267 on-board)

Kernel: 2.4.3 with ide.2.4.3-p8.all.03242001.patch by Andre Hedrick (or
stock 2.4.3 with more or less same results)

FastTrack config: only 1 drive, configured as a SPAN volume consisting of 1
drive

I don't quite care about the Promise RAID features. I will use Linux
software RAID. The problem is that I cannot seem to be able to get the
controller into UDMA 4 (66 Mhz) mode!

I have enabled all the relevant DMA related kernel options. I have also
checked using the Seagate disk utility to make sure that the drive is
recognized (and configured) as UDMA 66 capable.

The following is from dmesg:

PCI: Found IRQ 10 for device 00:03.0
PDC20267: chipset revision 2
PDC20267: not 100% native mode: will probe irqs later
PDC20267: ROM enabled at 0xfeae0000
PDC20267: (U)DMA Burst Bit ENABLED Primary MASTER Mode Secondary MASTER
Mode.
PDC20267: neither IDE port enabled (BIOS)

I wonder what the last line meant by saying neither port is enabled?

# /sbin/hdparm -Tt /dev/hde

/dev/hde:
 Timing buffer-cache reads:   128 MB in  0.74 seconds =172.97 MB/sec
 Timing buffered disk reads:  64 MB in 12.82 seconds =  4.99 MB/sec [should
be much much faster here]

# cat /proc/ide/pdc202xx

                                PDC20267 Chipset.
------------------------------- General
Status ---------------------------------
Burst Mode                           : enabled
Host Mode                            : Normal
Bus Clocking                         : 33 PCI Internal
IO pad select                        : 10 mA
Status Polling Period                : 0
Interrupt Check Status Polling Delay : 0
--------------- Primary Channel ---------------- Secondary
Channel -------------
                enabled                          enabled
66 Clocking     enabled                          disabled
           Mode MASTER                      Mode MASTER
                FIFO Empty                       FIFO Empty
--------------- drive0 --------- drive1 -------- drive0 ----------
drive1 ------
DMA enabled:    no               no              yes               no
DMA Mode:       UDMA 4           NOTSET          NOTSET            NOTSET
PIO Mode:       PIO 4            NOTSET           NOTSET            NOTSET

# hdparm -d1 /dev/hde

/dev/hde:
 setting using_dma to 1 (on)
 HDIO_SET_DMA failed: Operation not permitted
 using_dma    =  0 (off)

# hdparm -X68 /dev/hde

[resulted in the following message in /var/log/messages]

Apr  1 19:03:21 promise kernel: ide2: Speed warnings UDMA 3/4/5 is not
functional.

# hdparm -i /dev/hde

/dev/hde:

 Model=ST36421A, FwRev=6.01, SerialNo=5BE064AN
 Config={ HardSect NotMFM HdSw>15uSec Fixed DTR>10Mbs RotSpdTol>.5% }
 RawCHS=13330/15/63, TrkSize=0, SectSize=0, ECCbytes=4
 BuffType=unknown, BuffSize=256kB, MaxMultSect=16, MultSect=off
 CurCHS=13330/15/63, CurSects=913440960, LBA=yes, LBAsects=12596850
 IORDY=on/off, tPIO={min:240,w/IORDY:120}, tDMA={min:120,rec:120}
 PIO modes: pio0 pio1 pio2 pio3 pio4
 DMA modes: mdma0 mdma1 *mdma2 udma0 udma1 udma2 udma3 *udma4

Many thanks for pointers!

Andrew Chan

