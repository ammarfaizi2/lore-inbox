Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264484AbUBEKDZ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Feb 2004 05:03:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263937AbUBEKDZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Feb 2004 05:03:25 -0500
Received: from [152.101.81.89] ([152.101.81.89]:28943 "HELO southa.com")
	by vger.kernel.org with SMTP id S264484AbUBEKDQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Feb 2004 05:03:16 -0500
Message-ID: <00cc01c3ebd0$5bdc6040$9c02a8c0@southa.com>
Reply-To: "fotop.net" <admin@fotop.net>
From: "fotop.net" <admin@fotop.net>
To: <linux-kernel@vger.kernel.org>
Subject: Poor IDE performance with ICH5 (kernel 2.6.1)?
Date: Thu, 5 Feb 2004 18:11:01 +0800
MIME-Version: 1.0
Content-Type: text/plain;
	charset="big5"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2800.1106
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1106
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have 2 machines running kernel 2.6.1, I found that system running with
i865G / 2GB / ICH5 / WD250GB / 7200rpm / 8M is slower than system with
SIS630 / 1GB/ 5513 / WD80GB / 7200rpm / 2M in Timing buffered disk reads!
Anything wrong?

I read the list web, so please CC my email, thanks.

Kernel 2.6.1 (smp), Pentium 4 2.6C, i865G with ICH5, WD250GB 7200rpm/8M x 2
(md raid 1, hda, hdc)

hdparm /dev/hda
/dev/hda:
multcount = 16 (on)
IO_support = 1 (32-bit)
unmaskirq = 1 (on)
using_dma = 1 (on)
keepsettings = 0 (off)
readonly = 0 (off)
readahead = 256 (on)
geometry = 30401/255/63, sectors = 488397168, start = 0

[root@s1 bin]# hdparm -i /dev/hda

/dev/hda:

Model=WDC WD2500JB-00EVA0, FwRev=15.05R15, SerialNo=WD-WMAEH1443980
Config={ HardSect NotMFM HdSw>15uSec SpinMotCtl Fixed DTR>5Mbs FmtGapReq }
RawCHS=16383/16/63, TrkSize=57600, SectSize=600, ECCbytes=74
BuffType=DualPortCache, BuffSize=8192kB, MaxMultSect=16, MultSect=16
CurCHS=16383/16/63, CurSects=16514064, LBA=yes, LBAsects=268435455
IORDY=on/off, tPIO={min:120,w/IORDY:120}, tDMA={min:120,rec:120}
PIO modes: pio0 pio1 pio2 pio3 pio4
DMA modes: mdma0 mdma1 mdma2
UDMA modes: udma0 udma1 udma2 udma3 udma4 *udma5
AdvancedPM=no WriteCache=enabled
Drive conforms to: device does not report version: 1 2 3 4 5 6

[root@s1 bin]# hdparm -tT /dev/hda
/dev/hda:
Timing buffer-cache reads: 128 MB in 0.14 seconds =895.24 MB/sec
Timing buffered disk reads: 64 MB in 2.30 seconds = 27.87 MB/sec
[root@s1 bin]# hdparm -tT /dev/hda

/dev/hda:
Timing buffer-cache reads: 128 MB in 0.14 seconds =882.89 MB/sec
Timing buffered disk reads: 64 MB in 2.14 seconds = 29.93 MB/sec
[root@s1 bin]# hdparm -tT /dev/hda

/dev/hda:
Timing buffer-cache reads: 128 MB in 0.14 seconds =895.24 MB/sec
Timing buffered disk reads: 64 MB in 2.73 seconds = 23.42 MB/sec
[root@s1 bin]# hdparm -tT /dev/hda

/dev/hda:
Timing buffer-cache reads: 128 MB in 0.14 seconds =895.24 MB/sec
Timing buffered disk reads: 64 MB in 2.18 seconds = 29.36 MB/sec

Kernel 2.6.1, Celeron 1.3T, SIS630/5513, WD80GB 7200rpm/8M x 2 (md raid 1,
hda, hdc)
/dev/hda:
 multcount    = 16 (on)
 IO_support   =  1 (32-bit)
 unmaskirq    =  1 (on)
 using_dma    =  1 (on)
 keepsettings =  0 (off)
 readonly     =  0 (off)
 readahead    = 256 (on)
 geometry     = 65535/16/63, sectors = 156301488, start = 0

[root@s1 root]# hdparm -i /dev/hda

/dev/hda:

 Model=WDC WD800BB-00CAA1, FwRev=17.07W17, SerialNo=WD-WMA8E5958753
 Config={ HardSect NotMFM HdSw>15uSec SpinMotCtl Fixed DTR>5Mbs FmtGapReq }
 RawCHS=16383/16/63, TrkSize=57600, SectSize=600, ECCbytes=40
 BuffType=DualPortCache, BuffSize=2048kB, MaxMultSect=16, MultSect=16
 CurCHS=16383/16/63, CurSects=16514064, LBA=yes, LBAsects=156301488
 IORDY=on/off, tPIO={min:120,w/IORDY:120}, tDMA={min:120,rec:120}
 PIO modes:  pio0 pio1 pio2 pio3 pio4
 DMA modes:  mdma0 mdma1 mdma2
 UDMA modes: udma0 udma1 udma2 udma3 udma4 *udma5
 AdvancedPM=no WriteCache=enabled
 Drive conforms to: device does not report version:  1 2 3 4 5

[root@s1 root]# hdparm -tT /dev/hda

/dev/hda:
 Timing buffer-cache reads:   128 MB in  1.25 seconds =102.25 MB/sec
 Timing buffered disk reads:  64 MB in  1.93 seconds = 33.17 MB/sec
[root@s1 root]# hdparm -tT /dev/hda

/dev/hda:
 Timing buffer-cache reads:   128 MB in  1.42 seconds = 89.96 MB/sec
 Timing buffered disk reads:  64 MB in  1.84 seconds = 34.86 MB/sec
[root@s1 root]# hdparm -tT /dev/hda

/dev/hda:
 Timing buffer-cache reads:   128 MB in  1.24 seconds =103.08 MB/sec
 Timing buffered disk reads:  64 MB in  1.83 seconds = 35.00 MB/sec

Kyle


