Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030579AbWBHIuL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030579AbWBHIuL (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Feb 2006 03:50:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030581AbWBHIuL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Feb 2006 03:50:11 -0500
Received: from keetweej.xs4all.nl ([213.84.46.114]:33496 "EHLO
	keetweej.vanheusden.com") by vger.kernel.org with ESMTP
	id S1030579AbWBHIuJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Feb 2006 03:50:09 -0500
Date: Wed, 8 Feb 2006 09:50:07 +0100
From: Folkert van Heusden <folkert@vanheusden.com>
To: Robert Hancock <hancockr@shaw.ca>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [2.6.15] frequent "BUG: soft lockup detected on CPU#0" in IDE
	subsystem
Message-ID: <20060208085004.GP4305@vanheusden.com>
References: <5DB5f-2uJ-21@gated-at.bofh.it> <43E93615.3080902@shaw.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <43E93615.3080902@shaw.ca>
Organization: www.unixexpert.nl
X-Chameleon-Return-To: folkert@vanheusden.com
X-Xfmail-Return-To: folkert@vanheusden.com
X-Phonenumber: +31-6-41278122
X-URL: http://www.vanheusden.com/
X-PGP-KeyID: 1F28D8AE
X-GPG-fingerprint: AC89 09CE 41F2 00B4 FCF2  B174 3019 0E8C 1F28 D8AE
X-Key: http://pgp.surfnet.nl:11371/pks/lookup?op=get&search=0x1F28D8AE
Reply-By: Tue Feb  7 12:52:36 CET 2006
X-Message-Flag: www.unixexpert.nl
User-Agent: Mutt/1.5.10i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> >kernel: 2.6.15
> >system: 3.2GHz P4 hyperthreading, 1xIDE, 2GB ram
> >it seems to happen (altough I'm really not sure!) when the system is
> >under heavily load: > 8.0, while running sa-learn (the spamassassin
> >bayes training tool)
> 
> Lots of PIO transfers.. Is DMA not getting enabled on your drives?

According to this, DMA is enabled:

0 root@muur:/usr/src/linux-2.6.15/Documentation$ hdparm  -i /dev/hda

/dev/hda:

 Model=QUANTUM FIREBALLP AS20.5, FwRev=A2R.0600, SerialNo=692124031358
 Config={ HardSect NotMFM HdSw>15uSec Fixed DTR>10Mbs }
 RawCHS=16383/16/63, TrkSize=32256, SectSize=21298, ECCbytes=4
 BuffType=DualPortCache, BuffSize=1902kB, MaxMultSect=16, MultSect=16
 CurCHS=16383/16/63, CurSects=16514064, LBA=yes, LBAsects=40132503
 IORDY=on/off, tPIO={min:120,w/IORDY:120}, tDMA={min:120,rec:120}
 PIO modes:  pio0 pio1 pio2 pio3 pio4
 DMA modes:  mdma0 mdma1 mdma2
 UDMA modes: udma0 udma1 udma2 udma3 udma4 *udma5
 AdvancedPM=no WriteCache=enabled
 Drive conforms to: ATA/ATAPI-5 T13 1321D revision 1:

 * signifies the current active mode

Also, I run this at startup:
/usr/sbin/hdparm -c 3 -d 1 -X 69 -u 1 /dev/hda

Oh and at bootup it says it uses DMA for that drive:
[    0.431334] Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
[    0.431375] ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
[    0.431440] ICH5: IDE controller at PCI slot 0000:00:1f.1
[    0.431482] PCI: Enabling device 0000:00:1f.1 (0005 -> 0007)
[    0.431524] ACPI: PCI Interrupt 0000:00:1f.1[A] -> GSI 18 (level, low) -> IRQ 17
[    0.431604] ICH5: chipset revision 2
[    0.431641] ICH5: not 100% native mode: will probe irqs later
[    0.431687]     ide0: BM-DMA at 0xfc00-0xfc07, BIOS settings: hda:DMA, hdb:pio
[    0.431799]     ide1: BM-DMA at 0xfc08-0xfc0f, BIOS settings: hdc:DMA, hdd:pio
[    0.431909] Probing IDE interface ide0...
[    0.749711] hda: QUANTUM FIREBALLP AS20.5, ATA DISK drive
[    1.479391] ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
[    1.479514] Probing IDE interface ide1...
[    2.268919] hdc: CREATIVEDVD6630E, ATAPI CD/DVD-ROM drive
[    2.638776] ide1 at 0x170-0x177,0x376 on irq 15
[    2.638996] hda: max request size: 128KiB
[    2.640382] hda: 40132503 sectors (20547 MB) w/1902KiB Cache, CHS=39813/16/63, UDMA(100)
[    2.640548] hda: cache flushes not supported
[    2.640625]  hda: hda1 hda2 hda3
[    2.645987] usbmon: debugfs is not available

A strange thing is, though, that I only get 5MB/s with hdparm -t.


Folkert van Heusden

-- 
Ever wonder what is out there? Any alien races? Then please support
the seti@home project: setiathome.ssl.berkeley.edu
----------------------------------------------------------------------
Phone: +31-6-41278122, PGP-key: 1F28D8AE, www.vanheusden.com
