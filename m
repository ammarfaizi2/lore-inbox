Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267712AbSLGCza>; Fri, 6 Dec 2002 21:55:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267713AbSLGCza>; Fri, 6 Dec 2002 21:55:30 -0500
Received: from imrelay-2.zambeel.com ([209.240.48.8]:32018 "EHLO
	imrelay-2.zambeel.com") by vger.kernel.org with ESMTP
	id <S267712AbSLGCz3>; Fri, 6 Dec 2002 21:55:29 -0500
Message-ID: <233C89823A37714D95B1A891DE3BCE5202AB1AD4@xch-a.win.zambeel.com>
From: Manish Lachwani <manish@Zambeel.com>
To: "'David Ashley'" <dash@xdr.com>, linux-kernel@vger.kernel.org
Subject: RE: 2.4.18 beats 2.5.50 in hard drive access????
Date: Fri, 6 Dec 2002 19:02:49 -0800 
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Can you also make sure that write cache is ON? hdparm -q -W 1 /dev/hdX. And
also the READ cache. hdparm -q -A 1 /dev/hdX. 

Also, from the IDENTIFY information below, it looks like no UDMA mode is set
for the device. It always is set to multiword dma 2. 

-----Original Message-----
From: David Ashley [mailto:dash@xdr.com]
Sent: Friday, December 06, 2002 6:49 PM
To: linux-kernel@vger.kernel.org
Subject: RE: 2.4.18 beats 2.5.50 in hard drive access????


Manish Lachwani (manish@Zambeel.com) Wrote:
>Try to set UDMA0 by 
>
>hdparm -X64 /dev/hda 
>
>or UDMA 2 by using: 
>
>hdparm -X66 /dev/hda 
>
>OSB4 should support UDMA 2. If anyting > UDMA2, then IDE warning should 
>appear in dmesg 

hda=a cdrom drive, so I'll apply your advice to hdb:

I tried X64, X66 and X67 and no change in performance, nor did any
warning message appear in dmesg. For some reason my dmesg has a lot of
these:
bio too big device ide0(3,64) (256 > 255)
bio too big device ide1(22,0) (256 > 255)
bio too big device ide1(22,64) (256 > 255)
bio too big device ide0(3,64) (256 > 255)
bio too big device ide1(22,0) (256 > 255)
bio too big device ide1(22,64) (256 > 255)
bio too big device ide0(3,64) (256 > 255)
bio too big device ide1(22,0) (256 > 255)
bio too big device ide1(22,64) (256 > 255)
bio too big device ide1(22,0) (256 > 255)
bio too big device ide1(22,64) (256 > 255)
bio too big device ide0(3,64) (256 > 255)
bio too big device ide1(22,0) (256 > 255)

>
>CHeck the IDENTIFY information using hdparm -I /dev/hda to determine the 
>UDMA mode supported or /proc/ide/hda/identify, word# 88 

root@test:/var/log# hdparm -I /dev/hdb

/dev/hdb:

 Model=DW CDW08B0-B00AC1A                      , FwRev=710.W771,
SerialNo=DWW-AME8943535
 Config={ HardSect NotMFM HdSw>15uSec SpinMotCtl Fixed DTR>5Mbs FmtGapReq }
 RawCHS=16383/16/63, TrkSize=57600, SectSize=600, ECCbytes=40
 BuffType=DualPortCache, BuffSize=2048kB, MaxMultSect=16, MultSect=16
 CurCHS=17475/15/63, CurSects=-78446341, LBA=yes, LBAsects=156301488
 IORDY=on/off, tPIO={min:120,w/IORDY:120}, tDMA={min:120,rec:120}
 PIO modes: pio0 pio1 pio2 pio3 pio4 
 DMA modes: mdma0 mdma1 *mdma2 udma0 udma1 udma2 udma3 udma4 udma5 
 AdvancedPM=no
 Drive Supports : Reserved : ATA-1 ATA-2 ATA-3 ATA-4 ATA-5 

root@test:/proc/ide/hdb# cat identify 
427a 3fff 0000 0010 e100 0258 003f 0010
0000 000e 5744 2d57 4d41 3845 3439 3533
3533 3900 0000 0000 0003 1000 0028 3137
2e30 3757 3137 5744 4320 5744 3830 3042
422d 3030 4341 4131 2020 2020 2020 2020
2020 2020 2020 2020 2020 2020 2020 8010
0000 2f00 4001 0280 0000 0007 4443 000f
003f fb53 00fb 0110 f8b0 0950 0000 0407
0003 0078 0078 0078 0078 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000
003e 0000 346b 4b01 4003 3469 0801 4003
003f 0000 0000 0000 0000 6d00 80fe 0000
0000 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000
0001 0000 0000 0000 0000 002d 0000 0000
0000 0000 0000 0000 0000 0000 0000 0001
0000 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 001e
0000 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 b7a5

-Dave
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/
