Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267186AbSK3AFR>; Fri, 29 Nov 2002 19:05:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267187AbSK3AFR>; Fri, 29 Nov 2002 19:05:17 -0500
Received: from main.gmane.org ([80.91.224.249]:22248 "EHLO main.gmane.org")
	by vger.kernel.org with ESMTP id <S267186AbSK3AFQ>;
	Fri, 29 Nov 2002 19:05:16 -0500
To: linux-kernel@vger.kernel.org
X-Injected-Via-Gmane: http://gmane.org/
Path: not-for-mail
From: "Adam Warner" <lists@consulting.net.nz>
Subject: 2.4.20: ALI 15X3 IDE partition check lockup
Date: Sat, 30 Nov 2002 13:10:31 +1300
Message-ID: <pan.2002.11.30.00.10.30.340972@consulting.net.nz>
NNTP-Posting-Host: ip210-55-214-182.ip.win.co.nz
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Trace: main.gmane.org 1038614847 7275 210.55.214.182 (30 Nov 2002 00:07:27 GMT)
X-Complaints-To: usenet@main.gmane.org
NNTP-Posting-Date: Sat, 30 Nov 2002 00:07:27 +0000 (UTC)
User-Agent: Pan/0.13.1 (It's always funny until somebody immanentizes the eschaton (Debian GNU/Linux))
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

Alan's tree already fixes this hardware bug. I can boot a Compaq Presario
905 notebook with 2.4.20-rc4-ac1. This lockup also occurs with 2.4.19. I'd
like to test a patch so the fix can be merged into Marcelo's kernel.

ALI15X3: chipset revision 196
ALI15X3: not 100% native mode: will probe irqs later
   ide0: BM-DMA at 0x8080-0x8087, BIOS settings: hda:DMA, hdb:pio
   ...
hda: FUJITSU MHR2030AT, ATA DISK drive
...
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
...
blk: queue c030e804, I/O limit 4095Mb (mask 0xffffffff)
hda: 58605120 sectors (30006 MB) w/2048KiB Cache, CHS=3648/255/63, UDMA(33)
Partition check:
 hda:

The hard disk details are:

/dev/hda:

 Model=FUJITSU MHR2030AT, FwRev=53BB, SerialNo= ...
 Config={ HardSect NotMFM HdSw>15uSec Fixed DTR>10Mbs }
 RawCHS=16383/16/63, TrkSize=0, SectSize=0, ECCbytes=4
 BuffType=DualPortCache, BuffSize=2048kB, MaxMultSect=16, MultSect=off
 CurCHS=16383/16/63, CurSects=16514064, LBA=yes, LBAsects=58605120
 IORDY=yes, tPIO={min:240,w/IORDY:120}, tDMA={min:120,rec:120}
 PIO modes:  pio0 pio1 pio2 pio3 pio4 
 DMA modes:  mdma0 mdma1 mdma2 
 UDMA modes: udma0 udma1 udma2 udma3 udma4 *udma5 
 AdvancedPM=yes: mode=0x80 (128) WriteCache=enabled
 Drive conforms to: ATA/ATAPI-6 T13 1410D revision 1:  2 3 4 5 6

It seems to be the same issue that Alan confirmed and fixed in August:
http://www.cs.helsinki.fi/linux/linux-kernel/2002-32/0112.html

Debian's 2.2.20 kernel is OK and it's also possible to get a stock 2.4
kernel working by NOT compiling in ALI 15X3 driver support (PIO mode is
used instead).

Regards,
Adam


