Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288154AbSAHPsm>; Tue, 8 Jan 2002 10:48:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288155AbSAHPsg>; Tue, 8 Jan 2002 10:48:36 -0500
Received: from mail.merconic.com ([62.96.220.180]:11906 "HELO
	mail.merconic.com") by vger.kernel.org with SMTP id <S288154AbSAHPsX>;
	Tue, 8 Jan 2002 10:48:23 -0500
Date: Tue, 8 Jan 2002 16:48:17 +0100
From: "marc. h." <heckmann@hbe.ca>
To: Marcelo Tosatti <marcelo@conectiva.com.br>
Cc: linux-kernel@vger.kernel.org
Subject: [problem captured] Re: cerberus on 2.4.17-rc2 UP
Message-ID: <20020108164816.A5453@hbe.ca>
In-Reply-To: <20011220135904.B32516@hbe.ca> <Pine.LNX.4.21.0112211454140.7313-100000@freak.distro.conectiva> <20020107121423.A4345@hbe.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20020107121423.A4345@hbe.ca>; from heckmann@hbe.ca on Mon, Jan 07, 2002 at 12:14:24PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ok,

I managed to get it to do it again. Captured the problem on serial console:

--------------------------------------------

end_request: buffer-list destroyed
hda1: bad access: block=12440, count=-8
end_request: I/O error, dev 03:01 (hda), sector 12440
hda1: bad access: block=12448, count=-16
end_request: I/O error, dev 03:01 (hda), sector 12448
hda: timeout waiting for DMA
ide_dmaproc: chipset supported ide_dma_timeout func only: 14
hda: status error: status=0x58 { DriveReady SeekComplete DataRequest }
hda: drive not ready for command
hda: lost interrupt
hda: lost interrupt
hda: lost interrupt
hda: lost interrupt
hda: lost interrupt
hda: lost interrupt <-- they never stop appearing
[..more of the same..]

------------------------------------------

Is this a bug or could it be the hardware's fault? The hardware is new lspci
and hdparm -iv follows (I also have the output of sysrq T+M+P is that would be
useful to anyone just ask, I'd rather save the bandwidth and not send it over
the list):


/dev/hda:
 multcount    = 16 (on)
 I/O support  =  0 (default 16-bit)
 unmaskirq    =  0 (off)
 using_dma    =  1 (on)
 keepsettings =  0 (off)
 nowerr       =  0 (off)
 readonly     =  0 (off)
 readahead    =  8 (on)
 geometry     = 2501/255/63, sectors = 40188960, start = 0

 Model=IC35L020AVER07-0, FwRev=ER2OA45A, SerialNo=SVPTVFQ8610
 Config={ HardSect NotMFM HdSw>15uSec Fixed DTR>10Mbs }
 RawCHS=16383/16/63, TrkSize=0, SectSize=0, ECCbytes=40
 BuffType=DualPortCache, BuffSize=1916kB, MaxMultSect=16, MultSect=16
 CurCHS=16383/16/63, CurSects=-66060037, LBA=yes, LBAsects=40188960
 IORDY=on/off, tPIO={min:240,w/IORDY:120}, tDMA={min:120,rec:120}
 PIO modes: pio0 pio1 pio2 pio3 pio4
 DMA modes: mdma0 mdma1 mdma2 udma0 udma1 udma2 udma3 udma4 *udma5
 AdvancedPM=yes: disabled (255)
 Drive Supports : ATA/ATAPI-5 T13 1321D revision 1 : ATA-2 ATA-3 ATA-4 ATA-5

ontroller Hub (rev 02)
00:02.0 VGA compatible controller: Intel Corporation 82815 CGC [Chipset Graphics Controller]  (rev 02)
00:1e.0 PCI bridge: Intel Corporation 82801BAM PCI (rev 11)
00:1f.0 ISA bridge: Intel Corporation 82801BA ISA Bridge (ICH2) (rev 11)
00:1f.1 IDE interface: Intel Corporation 82801BA IDE U100 (rev 11)
00:1f.2 USB Controller: Intel Corporation 82801BA(M) USB (Hub A) (rev 11)
00:1f.3 SMBus: Intel Corporation 82801BA(M) SMBus (rev 11)
00:1f.4 USB Controller: Intel Corporation 82801BA(M) USB (Hub B) (rev 11)
01:00.0 Ethernet controller: 3Com Corporation 3c905C-TX [Fast Etherlink] (rev 74)
01:04.0 Ethernet controller: Intel Corporation 82557 [Ethernet Pro 100] (rev 08)01:08.0 Ethernet controller: Intel Corporation 82801BA(M) Ethernet (rev 03)

-m


On Mon, Jan 07, 2002 at 12:14:24PM +0100, marc. h. wrote:
> On Fri, Dec 21, 2001 at 02:56:34PM -0200, Marcelo Tosatti wrote:
> > 
> > Can you please run Cerberus again and give me more information ?
> 
> ok, I *finally* got it to deadlock again.. trick is to run 2 simultaneous
> cerberus runs.. same symptoms, pings, can change VC's, hard drive light
> constantly on but silent and no blinks. I had sysrq turned on this time (tested
> before the run), but once deadlocked, doing Alt+SysRQ+8, Alt+SysRQ+T, etc would
> print nothing at all.. 
> 
> -m
> 
> > 
> > I want Alt+SysRQ+T, Alt+SysRQ+M and Alt+SysRQ+P output.
> > 
> > If those keys simply print the sysrq header, please try Alt+SysRQ+8 then
> > the above again.
> > 
> > Thanks
> > 
> > On Thu, 20 Dec 2001, marc. h. wrote:
> > 
> > > I tried out the latest cerberus from
> > > http://people.redhat.com/bmatthews/cerberus/ on a UP redhat-7.2 box. I ran the
> > > standard non-destructive RedHat tests.
> > > 
> > > It ran for about 14 hours and then became unresponsive..  machine still ping'ed
> > > , I could switch VC's scroll up on console, but that's it. Could not log in,
> > > etc.. Another point is that the hard drive light remained on but it was not
> > > seeking, it seemed dead silent.
> > 
> 
> -- 
> 	C3C5 9226 3C03 CDF7 2EF1  029F 4CAD FBA4 F5ED 68EB
> 	key: http://people.hbesoftware.com/~heckmann/

-- 
	C3C5 9226 3C03 CDF7 2EF1  029F 4CAD FBA4 F5ED 68EB
	key: http://people.hbesoftware.com/~heckmann/
