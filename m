Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282870AbRK0I3f>; Tue, 27 Nov 2001 03:29:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282868AbRK0I3Q>; Tue, 27 Nov 2001 03:29:16 -0500
Received: from sunfish.linuxis.net ([64.71.162.66]:43463 "HELO
	sunfish.linuxis.net") by vger.kernel.org with SMTP
	id <S282873AbRK0I3L>; Tue, 27 Nov 2001 03:29:11 -0500
Date: Tue, 27 Nov 2001 00:25:05 -0800
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: DMA problem (?) w/ 2.4.6-xfs and ServerWorks OSB4 Chipset
Message-ID: <20011127002505.V252@flounder.net>
In-Reply-To: <20011113023029.A15075@flounder.net> <E163bNB-0000pS-00@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E163bNB-0000pS-00@the-village.bc.nu>
User-Agent: Mutt/1.3.21i
Mail-Copies-To: never
X-Delivery-Agent: TMDA v0.41/Python 2.1.1 (sunos5)
From: "Adam McKenna" <adam-dated-1007281507.c7177f@flounder.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 13, 2001 at 11:04:57AM +0000, Alan Cox wrote:
> > I am having problems with both UDMA and Multiword DMA.  The problem doesn't
> > go away unless I disable CONFIG_IDEDMA_PCI_AUTO.
> > 
> > I don't know if there is actual FS corruption with MWord DMA, but there is
> > definitely a "hang" for a few seconds accompanied by a DMA error.
> 
> I've no other reports from MWDMA other than the usual "CDROM that doesnt
> handle DMA" things

ops01:~# hdparm -Ii /dev/hda

/dev/hda:

 Model=IBM-DTLA-307075, FwRev=TXAOA50C, SerialNo=YSDYSG5S166
 Config={ HardSect NotMFM HdSw>15uSec Fixed DTR>10Mbs }
 RawCHS=16383/16/63, TrkSize=0, SectSize=0, ECCbytes=40
 BuffType=3(DualPortCache), BuffSize=1916kB, MaxMultSect=16, MultSect=16
 DblWordIO=no, OldPIO=2, DMA=yes, OldDMA=2
 CurCHS=16383/16/63, CurSects=16514064, LBA=yes, LBAsects=150136560
 tDMA={min:120,rec:120}, DMA modes: mword0 mword1 *mword2
 IORDY=on/off, tPIO={min:240,w/IORDY:120}, PIO modes: mode3 mode4
 UDMA modes: mode0 mode1 mode2 mode3 mode4 mode5


 Model=BI-MTDAL3-7070 5                        , FwRev=XTOA5AC0,
SerialNo=        Y DSSY5G1S66
 Config={ HardSect NotMFM HdSw>15uSec Fixed DTR>10Mbs }
 RawCHS=16383/16/63, TrkSize=0, SectSize=0, ECCbytes=40
 BuffType=3(DualPortCache), BuffSize=1916kB, MaxMultSect=16, MultSect=16
 DblWordIO=no, OldPIO=2, DMA=yes, OldDMA=2
 CurCHS=16383/16/63, CurSects=16514064, LBA=yes, LBAsects=150136560
 tDMA={min:120,rec:120}, DMA modes: mword0 mword1 *mword2
 IORDY=on/off, tPIO={min:240,w/IORDY:120}, PIO modes: mode3 mode4
 UDMA modes: mode0 mode1 mode2 mode3 mode4 mode5

ops01:~# hdparm -Ii /dev/hdb

/dev/hdb:

 Model=Maxtor 4W100H6, FwRev=AAH01310, SerialNo=W6H2JCRC
 Config={ Fixed }
 RawCHS=16383/16/63, TrkSize=0, SectSize=0, ECCbytes=57
 BuffType=3(DualPortCache), BuffSize=2048kB, MaxMultSect=16, MultSect=16
 DblWordIO=no, OldPIO=2, DMA=yes, OldDMA=0
 CurCHS=16383/16/63, CurSects=16514064, LBA=yes, LBAsects=195711264
 tDMA={min:120,rec:120}, DMA modes: mword0 mword1 *mword2
 IORDY=on/off, tPIO={min:120,w/IORDY:120}, PIO modes: mode3 mode4
 UDMA modes: mode0 mode1 mode2 mode3 mode4 mode5


 Model=aMtxro4 1W006H                          , FwRev=AA0H3101,
SerialNo=6W2HCJCR
 Config={ Fixed }
 RawCHS=16383/16/63, TrkSize=0, SectSize=0, ECCbytes=57
 BuffType=3(DualPortCache), BuffSize=2048kB, MaxMultSect=16, MultSect=16
 DblWordIO=no, OldPIO=2, DMA=yes, OldDMA=0
 CurCHS=16383/16/63, CurSects=16514064, LBA=yes, LBAsects=195711264
 tDMA={min:120,rec:120}, DMA modes: mword0 mword1 *mword2
 IORDY=on/off, tPIO={min:120,w/IORDY:120}, PIO modes: mode3 mode4
 UDMA modes: mode0 mode1 mode2 mode3 mode4 mode5

Here is a sample of the I/O errors:

hda: read_intr: status=0x59 { DriveReady SeekComplete DataRequest Error }
hda: read_intr: error=0x40 { UncorrectableError }, LBAsect=15220172,
sector=1548794
end_request: I/O error, dev 03:05 (hda), sector 1548794
hda: read_intr: status=0x59 { DriveReady SeekComplete DataRequest Error }
hda: read_intr: error=0x40 { UncorrectableError }, LBAsect=15220173,
sector=1548795
end_request: I/O error, dev 03:05 (hda), sector 1548795
hda: read_intr: status=0x59 { DriveReady SeekComplete DataRequest Error }
hda: read_intr: error=0x40 { UncorrectableError }, LBAsect=15220174,
sector=1548796
end_request: I/O error, dev 03:05 (hda), sector 1548796
hda: read_intr: status=0x59 { DriveReady SeekComplete DataRequest Error }
hda: read_intr: error=0x40 { UncorrectableError }, LBAsect=15220175,
sector=1548797
end_request: I/O error, dev 03:05 (hda), sector 1548797
hda: read_intr: status=0x59 { DriveReady SeekComplete DataRequest Error }
hda: read_intr: error=0x40 { UncorrectableError }, LBAsect=15220176,
sector=1548798
end_request: I/O error, dev 03:05 (hda), sector 1548798

--Adam

-- 
Adam McKenna <adam@flounder.net>   | GPG: 17A4 11F7 5E7E C2E7 08AA
http://flounder.net/publickey.html |      38B0 05D0 8BF7 2C6D 110A
