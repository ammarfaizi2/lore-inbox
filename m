Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135499AbRAQSsf>; Wed, 17 Jan 2001 13:48:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135512AbRAQSsP>; Wed, 17 Jan 2001 13:48:15 -0500
Received: from styx.suse.cz ([195.70.145.226]:20219 "EHLO kerberos.suse.cz")
	by vger.kernel.org with ESMTP id <S135499AbRAQSsN>;
	Wed, 17 Jan 2001 13:48:13 -0500
Date: Wed, 17 Jan 2001 19:46:06 +0100
From: Vojtech Pavlik <vojtech@suse.cz>
To: Andre Hedrick <andre@linux-ide.org>
Cc: Terrence Martin <tmartin@cal.montage.ca>, linux-kernel@vger.kernel.org
Subject: Re: File System Corruption with 2.2.18
Message-ID: <20010117194606.A2954@suse.cz>
In-Reply-To: <20010117193211.B2784@suse.cz> <Pine.LNX.4.10.10101171037290.18638-100000@master.linux-ide.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.4.10.10101171037290.18638-100000@master.linux-ide.org>; from andre@linux-ide.org on Wed, Jan 17, 2001 at 10:40:13AM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

Cute. Can it be run on say a swap partition?

Vojtech

On Wed, Jan 17, 2001 at 10:40:13AM -0800, Andre Hedrick wrote:

> I may have a new test tool but it is completely destructive the content on
> the drives.  It walks the drives and fills every sector with a unique
> pattern and then you can read it back and checksum the contents.
> 
> It does destroy the content on the drive, this is no worse than a random
> "File System Corruption " because it absolutely destroys or corrupts the
> original content for testing purposes.
> 
> 
> On Wed, 17 Jan 2001, Vojtech Pavlik wrote:
> 
> > Hi!
> > 
> > Ok, just for a test, before I finish the 2.2 version of the new VIA IDE
> > driver, could you try with the 2.4.0 kernel if it fixes the behavior?
> > 
> > By the way, what motherboard is this?
> > 
> > Andre: Thanks for sending this to me, this is the case I was looking for
> > - true data corruption on 2.2 kernel. Now I hope my new driver fixes
> > this.
> > 
> > Vojtech
> > 
> > On Wed, Jan 17, 2001 at 10:06:38AM -0800, Andre Hedrick wrote:
> > > 
> > > Good Morning Vojtech!
> > > 
> > > On Wed, 17 Jan 2001, Terrence Martin wrote:
> > > 
> > > > I am having all sorts of nasty file corruption problems with 2.2.18
> > > > patched with
> > > > ide.2.2.18.1221.patch.gz
> > > > linux-2.2.18-reiserfs-3.5.29-patch.gz
> > > > raid-2.2.18-B0
> > > > 
> > > > The corruption is occuring on my WDC AC28400R(I also had a problem with
> > > > a 13GB WDC as well which I swapped out last night). This is the only
> > > > hard drive that is on the onboard controller which is a VIA Technologies
> > > > VT 82C586 Apollo IDE (rev 6) chipset. The drive does share the IDE bus
> > > > with a internal ATAPI Zip drive. The cable I am using to connect the WDC
> > > > is a UDMA66 40pin 80 wire cable. I realize I do not have a UDMA66
> > > > controller, or disk, but I was having problems installing with a
> > > > standard 40 pin, 40 wire cable that the 80 wire seemed to alleviate.
> > > > 
> > > > The other drives are my software RAID setup on 2 Promise PDC20262
> > > > controllers with 1 drive per interface for a total of 4 drives. These
> > > > drives are Quantum 13X(?) 13GB drives. I am running the default RH6.2
> > > > kernel right now for stability with no support for my promise
> > > > controllers and I am writing this from a remote site so not sure of
> > > > other distinguishing marks of the quantum HD's.
> > > > 
> > > > So my question is does anyone have any idea what might cause ide dma
> > > > errors to occur when I use this kernel? As I mentioned file corruption
> > > > seems to only occur on the WDC drive(s) and manisfest itself as
> > > > executables suddenly becoming unreadable binary files, strange file
> > > > permissions on new files, and X windows going completely nuts when it
> > > > tries to start. I reboot back to the stock 2.2.14 with RH and everything
> > > > seems to work fine, excepting that I cannot access my RAID device of
> > > > course. :)
> > > > 
> > > > I have had this problem across two mother boards(both VIA chipsets), two
> > > > CPU's, two WDC Hard drives and the cable swap. I have not swapped RAM.
> > > > 
> > > > Thanks for any assistance/suggestions that you might be able to render.
> > > > 
> > > > Regards
> > > > Terrence Martin
> > > > 
> > > > P.S. More specific system information follows
> > > > 
> > > > hdparm /dev/hda
> > > > 
> > > > /dev/hda:
> > > >  multcount    =  0 (off)
> > > >  I/O support  =  0 (default 16-bit)
> > > >  unmaskirq    =  0 (off)
> > > >  using_dma    =  0 (off)
> > > >  keepsettings =  0 (off)
> > > >  nowerr       =  0 (off)
> > > >  readonly     =  0 (off)
> > > >  readahead    =  8 (on)
> > > >  geometry     = 16383/16/63, sectors = 16514064, start = 0
> > > > 
> > > > hdparm -i /dev/hda
> > > > 
> > > > /dev/hda:
> > > > 
> > > >  Model=WDC AC28400R, FwRev=15.01J55, SerialNo=WD-WM6280172815
> > > >  Config={ HardSect NotMFM HdSw>15uSec SpinMotCtl Fixed DTR>5Mbs
> > > > FmtGapReq }
> > > >  RawCHS=16383/16/63, TrkSize=57600, SectSize=600, ECCbytes=40
> > > >  BuffType=3(DualPortCache), BuffSize=512kB, MaxMultSect=16, MultSect=off
> > > > 
> > > >  DblWordIO=no, OldPIO=2, DMA=yes, OldDMA=0
> > > >  CurCHS=16383/16/63, CurSects=-66060037, LBA=yes, LBAsects=16514064
> > > >  tDMA={min:120,rec:120}, DMA modes: mword0 mword1 mword2
> > > >  IORDY=on/off, tPIO={min:160,w/IORDY:120}, PIO modes: mode3 mode4
> > > >  UDMA modes: mode0 mode1 *mode2
> > > > 
> > > > cat /proc/pci
> > > > PCI devices found:
> > > >   Bus  0, device   0, function  0:
> > > >     Host bridge: VIA Technologies VT 82C597 Apollo VP3 (rev 4).
> > > >       Medium devsel.  Fast back-to-back capable.  Master Capable.
> > > > Latency=16.
> > > >       Prefetchable 32 bit memory at 0xe0000000 [0xe0000008].
> > > >   Bus  0, device   1, function  0:
> > > >     PCI bridge: VIA Technologies VT 82C598 Apollo MVP3 AGP (rev 0).
> > > >       Medium devsel.  Master Capable.  No bursts.  Min Gnt=12.
> > > >   Bus  0, device   7, function  0:
> > > >     ISA bridge: VIA Technologies VT 82C586 Apollo ISA (rev 71).
> > > >       Medium devsel.  Master Capable.  No bursts.
> > > >   Bus  0, device   7, function  1:
> > > >     IDE interface: VIA Technologies VT 82C586 Apollo IDE (rev 6).
> > > >       Medium devsel.  Fast back-to-back capable.  Master Capable.
> > > > Latency=64.
> > > >       I/O at 0xb400 [0xb401].
> > > >   Bus  0, device   8, function  0:
> > > >     Unknown mass storage controller: Promise Technology Unknown device
> > > > (rev 1).
> > > >       Vendor id=105a. Device id=4d38.
> > > >       Medium devsel.  IRQ 5.  Master Capable.  Latency=64.
> > > >       I/O at 0xb800 [0xb801].
> > > >       I/O at 0xbc00 [0xbc01].
> > > >       I/O at 0xc000 [0xc001].
> > > >       I/O at 0xc400 [0xc401].
> > > >       I/O at 0xc800 [0xc801].
> > > >       Non-prefetchable 32 bit memory at 0xea000000 [0xea000000].
> > > >   Bus  0, device   9, function  0:
> > > >     Unknown mass storage controller: Promise Technology Unknown device
> > > > (rev 1).
> > > >       Vendor id=105a. Device id=4d38.
> > > >       Medium devsel.  IRQ 10.  Master Capable.  Latency=64.
> > > >       I/O at 0xcc00 [0xcc01].
> > > >       I/O at 0xd000 [0xd001].
> > > >       I/O at 0xd400 [0xd401].
> > > >       I/O at 0xd800 [0xd801].
> > > >       I/O at 0xdc00 [0xdc01].
> > > >       Non-prefetchable 32 bit memory at 0xea020000 [0xea020000].
> > > >   Bus  0, device  10, function  0:
> > > >     Ethernet controller: 3Com 3C905B 100bTX (rev 36).
> > > >       Medium devsel.  IRQ 11.  Master Capable.  Latency=64.  Min
> > > > Gnt=10.Max Lat=10.
> > > >       I/O at 0xe000 [0xe001].
> > > >       Non-prefetchable 32 bit memory at 0xea040000 [0xea040000].
> > > >   Bus  1, device   0, function  0:
> > > >     VGA compatible controller: NVidia/SGS Thomson Riva 128 (rev 16).
> > > >       Medium devsel.  Fast back-to-back capable.  IRQ 5.  Master
> > > > Capable.  Latency=64.  Min Gnt=3.Max Lat=1.
> > > >       Non-prefetchable 32 bit memory at 0xe4000000 [0xe4000000].
> > > >       Prefetchable 32 bit memory at 0xe6000000 [0xe6000008].
> > > > 
> > > > 
> > > > 
> > > > -
> > > > To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> > > > the body of a message to majordomo@vger.kernel.org
> > > > Please read the FAQ at http://www.tux.org/lkml/
> > > > 
> > > 
> > > Andre Hedrick
> > > Linux ATA Development
> > 
> > -- 
> > Vojtech Pavlik
> > SuSE Labs
> > 
> 
> Andre Hedrick
> Linux ATA Development

-- 
Vojtech Pavlik
SuSE Labs
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
