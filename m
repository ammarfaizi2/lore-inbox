Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131618AbRCSUSn>; Mon, 19 Mar 2001 15:18:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131619AbRCSUSe>; Mon, 19 Mar 2001 15:18:34 -0500
Received: from dfw-smtpout3.email.verio.net ([129.250.36.43]:33762 "EHLO
	dfw-smtpout3.email.verio.net") by vger.kernel.org with ESMTP
	id <S131618AbRCSUSX>; Mon, 19 Mar 2001 15:18:23 -0500
Message-ID: <3AB66962.2345BFB7@bigfoot.com>
Date: Mon, 19 Mar 2001 12:17:38 -0800
From: Tim Moore <timothymoore@bigfoot.com>
Organization: Yoyodyne Propulsion Systems, Inc.
X-Mailer: Mozilla 4.75 [en] (X11; U; Linux 2.2.19pre17 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: UDMA 100 / PIIX4 question
In-Reply-To: <20010318165246Z131240-406+1417@vger.kernel.org> <3AB65C51.3DF150E5@bigfoot.com> <3AB65F14.26628BEF@coplanar.net>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeremy Jackson wrote:
> 
> Tim Moore wrote:
> > 15MB/s for hdparm is about right.
> 
> Yes, since hdparm -t measures *SUSTAINED* transfers... the actual "head rate" of data reads from
> disk surface.  Only if you read *only* data that is alread in harddrive's cache will you get a speed
> close to the UDMA mode of the drive/controller.  The cache is around 1Mbyte, so for a split-second
> re-read of some data....

Apologies for the too brief answer.  Sustained real world transfer rates for the PIIX4 under ideal
setup conditions and a quiet bus are 14-18MB/s.  Faster disk architecture and forcing ide driver
parameters will not change this.

Here's what you might expect from this disk family with an ATA-66 capable chipset:

[tim@abit tim]# hdparm -i /dev/hda; hdparm -tT /dev/hda

/dev/hda:

 Model=IBM-DTLA-307020, FwRev=TX3OA50C, SerialNo=YH0YHF45553
 Config={ HardSect NotMFM HdSw>15uSec Fixed DTR>10Mbs }
 RawCHS=16383/16/63, TrkSize=0, SectSize=0, ECCbytes=40
 BuffType=DualPortCache, BuffSize=1916kB, MaxMultSect=16, MultSect=off
 CurCHS=16383/16/63, CurSects=16514064, LBA=yes, LBAsects=40188960
 IORDY=on/off, tPIO={min:240,w/IORDY:120}, tDMA={min:120,rec:120}
 PIO modes: pio0 pio1 pio2 pio3 pio4 
 DMA modes: mdma0 mdma1 mdma2 udma0 udma1 udma2 udma3 *udma4 udma5 

/dev/hda:
 Timing buffer-cache reads:   128 MB in  0.81 seconds =158.02 MB/sec
 Timing buffered disk reads:  64 MB in  1.85 seconds = 34.59 MB/sec

Larger sustained transfers are about 75% of the burst/cache influenced hdparm timings.

[tim@abit tim]# time dd if=/dev/hda of=/dev/null bs=1k count=500k
512000+0 records in
512000+0 records out
0.340u 6.780s 0:19.68 36.1%     0+0k 0+0io 115pf+0w
[tim@abit tim]# echo "512000/19.68" | bc -q
26016

-- 
  |  650.390.9613  |  6502247437@messaging.cellone-sf.com
