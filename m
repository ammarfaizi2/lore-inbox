Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129413AbRAaPmd>; Wed, 31 Jan 2001 10:42:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129725AbRAaPmX>; Wed, 31 Jan 2001 10:42:23 -0500
Received: from [64.160.188.242] ([64.160.188.242]:27667 "HELO
	mail.hislinuxbox.com") by vger.kernel.org with SMTP
	id <S129413AbRAaPmF>; Wed, 31 Jan 2001 10:42:05 -0500
Date: Wed, 31 Jan 2001 07:41:17 -0800 (PST)
From: "David D.W. Downey" <pgpkeys@hislinuxbox.com>
To: Vojtech Pavlik <vojtech@suse.cz>
Cc: linux-kernel@vger.kernel.org
Subject: Re: VT82C686A corruption with 2.4.x
In-Reply-To: <20010131123919.A1399@suse.cz>
Message-ID: <Pine.LNX.4.21.0101310704370.8313-100000@ns-01.hislinuxbox.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org




On Wed, 31 Jan 2001, Vojtech Pavlik wrote:

> > > 1) You don't seem to have any drives on the VIA controller. If this is
> > > true, I don't think this can be a VIA IDE driver problem.
> > >

Umm, since the only 2 controllers in the machine are the VIA Vt82C686A and
the Promise PDC20265, yes I AM running drives on the VIA controller.

I have NO drives on the ATA100 controller which is the Promise
controller. Everything is running off the VIA.

> 
> > > 2) In your original message you suggest bs=1024M, which isn't a very
> > > good idea, even on a 768 MB system. Here with bs=1024k it seems to run
> > > fine.
> > >

Yes, that was a typo. My apologies. It _should_ have been a k not an M.

> > > 3) You sent next to none VIA related debugging info. lspci -v itself
> > > isn't much valuable because I don't get the register contents. Also
> > > hdparm -i of the drives attached to the VIA chip would be useful. Plus
> > > also the contents of /proc/ide/via.
> > 

OK, here are quite a few outputs. 

lspci -n outputs

00:00.0 Class 0600: 1106:0691 (rev c4)
00:01.0 Class 0604: 1106:8598
00:07.0 Class 0601: 1106:0686 (rev 22)
00:07.1 Class 0101: 1106:0571 (rev 10)
00:07.4 Class 0600: 1106:3057 (rev 30)
00:07.5 Class 0401: 1106:3058 (rev 20)
00:0c.0 Class 0180: 105a:0d30 (rev 02)
00:0e.0 Class 0100: 10cd:2300
00:10.0 Class 0200: 11ad:0002 (rev 20)
01:00.0 Class 0300: 121a:0005 (rev 01)


lspci -H1 outputs

00:00.0 Host bridge: VIA Technologies, Inc. VT82C691 [Apollo PRO] (rev c4)
00:01.0 PCI bridge: VIA Technologies, Inc. VT82C598 [Apollo MVP3 AGP]
00:07.0 ISA bridge: VIA Technologies, Inc. VT82C686 [Apollo Super] (rev 22)
00:07.1 IDE interface: VIA Technologies, Inc. VT82C586 IDE [Apollo] (rev 10)
00:0c.0 Unknown mass storage controller: Promise Technology, Inc.: Unknown device 0d30 (rev 02)
00:0e.0 SCSI storage controller: Advanced System Products, Inc ABP940-UW
00:10.0 Ethernet controller: Lite-On Communications Inc LNE100TX (rev 20)
01:00.0 VGA compatible controller: 3Dfx Interactive, Inc. Voodoo 3 (rev 01)

lspci -m outputs

00:00.0 "Host bridge" "VIA Technologies, Inc." "VT82C691 [Apollo PRO]" -rc4 "" ""
00:01.0 "PCI bridge" "VIA Technologies, Inc." "VT82C598 [Apollo MVP3 AGP]" "" ""
00:07.0 "ISA bridge" "VIA Technologies, Inc." "VT82C686 [Apollo Super]" -r22 "VIA Technologies, Inc." "VT82C686/A PCI to ISA Bridge"
00:07.1 "IDE interface" "VIA Technologies, Inc." "VT82C586 IDE [Apollo]" -r10 -p8a "" ""
00:07.4 "Host bridge" "VIA Technologies, Inc." "VT82C686 [Apollo Super ACPI]" -r30 "" ""
00:07.5 "Multimedia audio controller" "VIA Technologies, Inc." "VT82C686 [Apollo Super AC97/Audio]" -r20 "VIA Technologies, Inc." "VT82C686 [Apollo Super AC97/Audio]"
00:0c.0 "Unknown mass storage controller" "Promise Technology, Inc." "0d30" -r02 "Promise Technology, Inc." "0d30"
00:0e.0 "SCSI storage controller" "Advanced System Products, Inc" "ABP940-UW" "" ""
00:10.0 "Ethernet controller" "Lite-On Communications Inc" "LNE100TX" -r20 "Netgear" "FA310TX"
01:00.0 "VGA compatible controller" "3Dfx Interactive, Inc." "Voodoo 3" -r01 "3Dfx Interactive, Inc." "Voodoo3 AGP"

lspci outputs

00:00.0 Host bridge: VIA Technologies, Inc. VT82C691 [Apollo PRO] (rev c4)
00:01.0 PCI bridge: VIA Technologies, Inc. VT82C598 [Apollo MVP3 AGP]
00:07.0 ISA bridge: VIA Technologies, Inc. VT82C686 [Apollo Super] (rev 22)
00:07.1 IDE interface: VIA Technologies, Inc. VT82C586 IDE [Apollo] (rev 10)
00:07.4 Host bridge: VIA Technologies, Inc. VT82C686 [Apollo Super ACPI] (rev 30)
00:07.5 Multimedia audio controller: VIA Technologies, Inc. VT82C686 [Apollo Super AC97/Audio] (rev 20)
00:0c.0 Unknown mass storage controller: Promise Technology, Inc.: Unknown device 0d30 (rev 02)
00:0e.0 SCSI storage controller: Advanced System Products, Inc ABP940-UW
00:10.0 Ethernet controller: Lite-On Communications Inc LNE100TX (rev 20)
01:00.0 VGA compatible controller: 3Dfx Interactive, Inc. Voodoo 3 (rev 01)


hdparm -i /dev/hda outputs


/dev/hda:

 Model=WDC WD300BB-00AUA1, FwRev=18.20D18, SerialNo=WD-WMA6W1132085
 Config={ HardSect NotMFM HdSw>15uSec SpinMotCtl Fixed DTR>5Mbs FmtGapReq }
 RawCHS=16383/16/63, TrkSize=57600, SectSize=600, ECCbytes=40
 BuffType=DualPortCache, BuffSize=2048kB, MaxMultSect=16, MultSect=16
 CurCHS=16383/16/63, CurSects=-66060037, LBA=yes, LBAsects=58633344
 IORDY=on/off, tPIO={min:120,w/IORDY:120}, tDMA={min:120,rec:120}
 PIO modes: pio0 pio1 pio2 pio3 pio4 
 DMA modes: mdma0 mdma1 mdma2 udma0 udma1 *udma2 udma3 udma4 udma5 

hdparm -i /dev/hdc outputs


/dev/hdc:

 Model=WDC WD153AA, FwRev=05.05B05, SerialNo=WD-WMA0R1258522
 Config={ HardSect NotMFM HdSw>15uSec SpinMotCtl Fixed DTR>5Mbs FmtGapReq }
 RawCHS=16383/16/63, TrkSize=57600, SectSize=600, ECCbytes=40
 BuffType=DualPortCache, BuffSize=2048kB, MaxMultSect=16, MultSect=16
 CurCHS=16383/16/63, CurSects=-66060037, LBA=yes, LBAsects=30064608
 IORDY=on/off, tPIO={min:120,w/IORDY:120}, tDMA={min:120,rec:120}
 PIO modes: pio0 pio1 pio2 pio3 pio4 
 DMA modes: mdma0 mdma1 mdma2 udma0 udma1 *udma2 udma3 udma4 

cat /proc/ide/via outputs

----------VIA BusMastering IDE Configuration----------------
Driver Version:                     3.20
South Bridge:                       VIA vt82c686a
Revision:                           ISA 0x22 IDE 0x10
BM-DMA base:                        0xb000
PCI clock:                          33MHz
Master Read  Cycle IRDY:            1ws
Master Write Cycle IRDY:            1ws
BM IDE Status Register Read Retry:  yes
Max DRDY Pulse Width:               No limit
-----------------------Primary IDE-------Secondary IDE------
Read DMA FIFO flush:          yes                 yes
End Sector FIFO flush:         no                  no
Prefetch Buffer:               no                  no
Post Write Buffer:             no                  no
Enabled:                      yes                 yes
Simplex only:                  no                  no
Cable Type:                   40w                 40w
-------------------drive0----drive1----drive2----drive3-----
Transfer Mode:       UDMA       PIO      UDMA       PIO
Address Setup:       30ns     120ns      30ns     120ns
Cmd Active:          90ns      90ns      90ns      90ns
Cmd Recovery:        30ns      30ns      30ns      30ns
Data Active:         90ns     330ns      90ns     330ns
Data Recovery:       30ns     270ns      30ns     270ns
Cycle Time:          60ns     600ns      60ns     600ns
Transfer Rate:   33.0MB/s   3.3MB/s  33.0MB/s   3.3MB/s


Other than this I don't know what else to give you.

David D.W. Downey


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
