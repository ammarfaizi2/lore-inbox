Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262442AbTEMRMH (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 May 2003 13:12:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262439AbTEMRMH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 May 2003 13:12:07 -0400
Received: from Mail1.KONTENT.De ([81.88.34.36]:21192 "EHLO Mail1.KONTENT.De")
	by vger.kernel.org with ESMTP id S262442AbTEMRMD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 May 2003 13:12:03 -0400
From: Oliver Neukum <oliver@neukum.org>
To: Jens Axboe <axboe@suse.de>,
       Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
Subject: Re: 2.5.69, IDE TCQ can't be enabled
Date: Tue, 13 May 2003 19:25:25 +0200
User-Agent: KMail/1.5.1
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Oleg Drokin <green@namesys.com>,
       lkhelp@rekl.yi.org, linux-kernel@vger.kernel.org
References: <200305121455.58022.oliver@neukum.org> <Pine.SOL.4.30.0305121513270.18058-100000@mion.elka.pw.edu.pl> <20030513153236.GB17033@suse.de>
In-Reply-To: <20030513153236.GB17033@suse.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200305131925.25121.oliver@neukum.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Am Dienstag, 13. Mai 2003 17:32 schrieb Jens Axboe:
> On Mon, May 12 2003, Bartlomiej Zolnierkiewicz wrote:
> > On Mon, 12 May 2003, Oliver Neukum wrote:
> > > > Just a note that we have found TCQ unusable on our IBM drives and we
> > > > had some reports about TCQ unusable on some WD drives.
> > > >
> > > > Unusable means severe FS corruptions starting from mount.
> > > > So if your FSs will suddenly start to break, start looking for cause
> > > > with disabling TCQ, please.
> > >
> > > I can confirm that. This drive Model=IBM-DTLA-307045, FwRev=TX6OA60A,
> > > SerialNo=YMCYMT3Y229 has eaten my filesystem with TCQ on 2.5.69
>
> Oliver, what hardware are you reproducing this on? The DTLA should work.

Athlon XP1600. But I am not reproducing this. I dare not. Is it important 
enough to set up a scratch monkey? hdb did not show corruption. The raid
controller of the motherboard isn't used. APIC was enabled, ACPI wasn't.
The exact configuration died with the filesystem, sorry.

	Regards
		Oliver

oenone:/home/oliver # lspci
00:00.0 Host bridge: VIA Technologies, Inc. VT8366/A/7 [Apollo KT266/A/333]
00:01.0 PCI bridge: VIA Technologies, Inc. VT8366/A/7 [Apollo KT266/A/333 AGP]
00:05.0 Multimedia audio controller: C-Media Electronics Inc CM8738 (rev 10)
00:06.0 RAID bus controller: Promise Technology, Inc. PDC20276 IDE (rev 01)
00:07.0 FireWire (IEEE 1394): Texas Instruments TSB43AB22/A IEEE-1394a-2000 
Controller (PHY/Link)
00:09.0 USB Controller: VIA Technologies, Inc. USB (rev 50)
00:09.1 USB Controller: VIA Technologies, Inc. USB (rev 50)
00:09.2 USB Controller: VIA Technologies, Inc. USB 2.0 (rev 51)
00:0d.0 SCSI storage controller: Tekram Technology Co.,Ltd. TRM-S1040 (rev 01)
00:0e.0 Network controller: AVM Audiovisuelles MKTG & Computer System GmbH 
Fritz!PCI v2.0 ISDN (rev 01)
00:0f.0 Multimedia video controller: Brooktree Corporation Bt878 Video Capture 
(rev 11)
00:0f.1 Multimedia controller: Brooktree Corporation Bt878 Audio Capture (rev 
11)
00:10.0 Ethernet controller: Realtek Semiconductor Co., Ltd. 
RTL-8139/8139C/8139C+ (rev 10)
00:11.0 ISA bridge: VIA Technologies, Inc. VT8233A ISA Bridge
00:11.1 IDE interface: VIA Technologies, Inc. VT82C586/B/686A/B PIPC Bus 
Master IDE (rev 06)
00:11.2 USB Controller: VIA Technologies, Inc. USB (rev 23)
00:11.3 USB Controller: VIA Technologies, Inc. USB (rev 23)
01:00.0 VGA compatible controller: ATI Technologies Inc Radeon VE QY

oenone:/home/oliver # hdparm -i /dev/hda

/dev/hda:

 Model=IBM-DTLA-307045, FwRev=TX6OA60A, SerialNo=YMCYMT3Y229
 Config={ HardSect NotMFM HdSw>15uSec Fixed DTR>10Mbs }
 RawCHS=16383/16/63, TrkSize=0, SectSize=0, ECCbytes=40
 BuffType=DualPortCache, BuffSize=1916kB, MaxMultSect=16, MultSect=16
 CurCHS=16383/16/63, CurSects=16514064, LBA=yes, LBAsects=90069840
 IORDY=on/off, tPIO={min:240,w/IORDY:120}, tDMA={min:120,rec:120}
 PIO modes:  pio0 pio1 pio2 pio3 pio4
 DMA modes:  mdma0 mdma1 mdma2
 UDMA modes: udma0 udma1 udma2 udma3 udma4 *udma5
 AdvancedPM=yes: disabled (255) WriteCache=enabled
 Drive conforms to: ATA/ATAPI-5 T13 1321D revision 1:  2 3 4 5

oenone:/home/oliver # hdparm -i /dev/hdb

/dev/hdb:

 Model=IBM-DTTA-351010, FwRev=T56OA73A, SerialNo=WF0KFV79157
 Config={ HardSect NotMFM HdSw>15uSec Fixed DTR>10Mbs }
 RawCHS=16383/16/63, TrkSize=0, SectSize=0, ECCbytes=34
 BuffType=DualPortCache, BuffSize=466kB, MaxMultSect=16, MultSect=16
 CurCHS=16383/16/63, CurSects=16514064, LBA=yes, LBAsects=19807200
 IORDY=on/off, tPIO={min:240,w/IORDY:120}, tDMA={min:120,rec:120}
 PIO modes:  pio0 pio1 pio2 pio3 pio4
 DMA modes:  sdma0 sdma1 sdma2 mdma0 mdma1 mdma2
 UDMA modes: udma0 udma1 *udma2
 AdvancedPM=no WriteCache=enabled
 Drive conforms to: ATA/ATAPI-4 T13 1153D revision 17:  1 2 3 4

oenone:/home/oliver # cat /proc/cpuinfo
processor       : 0
vendor_id       : AuthenticAMD
cpu family      : 6
model           : 6
model name      : AMD Athlon(TM) XP 1600+
stepping        : 2
cpu MHz         : 1059.468
cache size      : 256 KB
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 1
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca 
cmov pat pse36 mmx fxsr sse syscall mmxext 3dnowext 3dnow
bogomips        : 2110.25

