Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264320AbTLYQjO (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 25 Dec 2003 11:39:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264322AbTLYQjO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 25 Dec 2003 11:39:14 -0500
Received: from fmx2.freemail.hu ([195.228.242.222]:5239 "HELO fmx2.freemail.hu")
	by vger.kernel.org with SMTP id S264320AbTLYQjK convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 25 Dec 2003 11:39:10 -0500
Date: Thu, 25 Dec 2003 17:39:08 +0100 (CET)
From: Max Payne <"max..payne"@freemail.hu>
Subject: Re: IDE performance drop between 2.4.23 and 2.6.0
To: jfontain@free.fr
cc: linux-kernel@vger.kernel.org
Message-ID: <freemail.20031125173908.53283@fm3.freemail.hu>
X-Originating-IP: [81.182.116.211]
X-HTTP-User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6b) Gecko/20031208
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; CHARSET=ISO-8859-2
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

IO scheduler issue? Please try repeating your tests with
'elevator=deadline' at boot. 


2003-12-23, k keltezéssel Jean-Luc Fontaine ezt írta:

> Using hdparm -Tt /dev/hdb:
> 
> on 2.4:
>   Timing buffer-cache reads:   168 MB in  2.01 seconds = 
83.58 MB/sec
>   Timing buffered disk reads:   44 MB in  3.12 seconds = 
14.10 MB/sec
> on 2.6:
>   Timing buffer-cache reads:   172 MB in  2.02 seconds = 
84.95 MB/sec
>   Timing buffered disk reads:   34 MB in  3.08 seconds = 
11.04 MB/sec
> 
> Note the big drop of of 3 MB/sec on disk reads.
> 
> dmesg (edited) gives:
> 
> on 2.4:
>   VP_IDE: VIA vt82c586b (rev 41) IDE UDMA33 controller on
pci00:07.1
>   hdb: IC35L040AVVN07-0, ATA DISK drive
>   hdb: 80418240 sectors (41174 MB) w/1863KiB Cache,
CHS=79780/16/63, 
> UDMA(33)
> on 2.6:
>   VP_IDE: VIA vt82c586b (rev 41) IDE UDMA33 controller on
pci0000:00:07.1
>   hdb: IC35L040AVVN07-0, ATA DISK drive
>   hdb: 80418240 sectors (41174 MB) w/1863KiB Cache,
CHS=65535/16/63, 
> UDMA(33)
> 
> hdparm -i output is identical between the 2 kernels and
hdparm settings 
> are identical as follows (except cylinders as above):
> 
>   Model=IC35L040AVVN07-0, FwRev=VA2OAG0A,
SerialNo=VNP210B2RAP0TB
>   Config={ HardSect NotMFM HdSw>15uSec Fixed DTR>10Mbs }
>   RawCHS=16383/16/63, TrkSize=0, SectSize=0, ECCbytes=52
>   BuffType=DualPortCache, BuffSize=1863kB, MaxMultSect=16,
MultSect=16
>   CurCHS=16383/16/63, CurSects=16514064, LBA=yes,
LBAsects=80418240
>   IORDY=on/off, tPIO={min:240,w/IORDY:120},
tDMA={min:120,rec:120}
>   PIO modes:  pio0 pio1 pio2 pio3 pio4
>   DMA modes:  mdma0 mdma1 mdma2
>   UDMA modes: udma0 udma1 *udma2 udma3 udma4 udma5
>   AdvancedPM=yes: disabled (255) WriteCache=enabled
>   Drive conforms to: ATA/ATAPI-5 T13 1321D revision 1:
> 
>   multcount    = 16 (on)
>   IO_support   =  1 (32-bit)
>   unmaskirq    =  1 (on)
>   using_dma    =  1 (on)
>   keepsettings =  0 (off)
>   readonly     =  0 (off)
>   readahead    =  8 (on)
>   geometry     = 79780/16/63, sectors = 80418240, start = 0
> 
> I noticed a difference in dmesg:
> on 2.4:
>   Uniform Multi-Platform E-IDE driver Revision: 7.00beta4-2.4
> on 2.6:
>   Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
> 
> Could that make a difference?
> 
> Please let me know if you'd like me to run more tests,
patch kernels, 
> ..., anything to regain the performance.
> 
> 
> Many thanks in advance,
> 
> -- 
> Jean-Luc Fontaine


