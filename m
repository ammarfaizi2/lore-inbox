Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131308AbRAMS0T>; Sat, 13 Jan 2001 13:26:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131222AbRAMS0F>; Sat, 13 Jan 2001 13:26:05 -0500
Received: from zeus.kernel.org ([209.10.41.242]:59872 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id <S131317AbRAMSZt>;
	Sat, 13 Jan 2001 13:25:49 -0500
Date: Sat, 13 Jan 2001 15:35:22 +0100
From: Vojtech Pavlik <vojtech@suse.cz>
To: Tobias Ringstrom <tori@tellus.mine.nu>
Cc: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: 2.4 ate my filesystem on rw-mount
Message-ID: <20010113153522.A1495@suse.cz>
In-Reply-To: <20010112204932.B2740@suse.cz> <Pine.LNX.4.30.0101130854180.9152-100000@svea.tellus>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.4.30.0101130854180.9152-100000@svea.tellus>; from tori@tellus.mine.nu on Sat, Jan 13, 2001 at 09:12:27AM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 13, 2001 at 09:12:27AM +0100, Tobias Ringstrom wrote:

> > Wow. Ok, I'm maintaining the 2.4.0 VIA driver, so I'd like to know more
> > about this:
> >
> > 1) What's the ISA bridge revision?
> 
> 00:00.0 Host bridge: VIA Technologies, Inc. VT8501 (rev 02)
> 00:01.0 PCI bridge: VIA Technologies, Inc. VT8501
> 00:07.0 ISA bridge: VIA Technologies, Inc. VT82C686 [Apollo Super] (rev 1b)
> 00:07.1 IDE interface: VIA Technologies, Inc. VT82C586 IDE [Apollo] (rev 06)
> 00:07.2 USB Controller: VIA Technologies, Inc. VT82C586B USB (rev 0e)
> 00:07.4 Bridge: VIA Technologies, Inc. VT82C686 [Apollo Super ACPI] (rev 20)
> 00:07.5 Multimedia audio controller: VIA Technologies, Inc. VT82C686 [Apollo Super AC97/Audio] (rev 21)
> 00:0a.0 Ethernet controller: VIA Technologies, Inc. VT86C100A [Rhine 10/100] (rev 06)
> 01:00.0 VGA compatible controller: Trident Microsystems CyberBlade/i7 (rev 5b)

Ok, your IDE chip is a vt82c686a/ce.

> > 2) What's in /proc/ide/via?
> 
> It's not there since I disabled the VIA driver.

Ok. Could you send me this file when you boot with fs r-o?

> > 3) What says hdparm -i on your devices?
> 
> /dev/hda:
> 
>  Model=SAMSUNG VG34323A (4.32GB), FwRev=GQ200, SerialNo=dW1921060033c8
>  Config={ HardSect NotMFM HdSw>15uSec Fixed DTR>10Mbs }
>  RawCHS=14896/9/63, TrkSize=32256, SectSize=512, ECCbytes=21
>  BuffType=DualPortCache, BuffSize=496kB, MaxMultSect=16, MultSect=off
>  CurCHS=14896/9/63, CurSects=-531627904, LBA=yes, LBAsects=8446032
>  IORDY=on/off, tPIO={min:120,w/IORDY:120}, tDMA={min:120,rec:120}
>  PIO modes: pio0 pio1 pio2 pio3 pio4
>  DMA modes: sdma0 sdma1 sdma2 *mdma0 mdma1 mdma2 udma0 udma1 *udma2

Looks good, too. An UDMA33 drive.

> > 4) If you mount your filesystem read-only, does it read garbage?
> 
> Now here's a strange part, or possibly a crusial clue.  When I booted a
> 2.4.0 kernel (from floppy using the excellent syslinux) with "ro
> init=/bin/sh", I could access the filesystem just fine.  I could even
> remount the root filesystem rw, and there were no problems.  But I did not
> write anything to the disk, since I was convinced that the problem was
> gone (this was the second try).  After this I rebooted with
> ctrl-alt-delete, forgetting how bad an idea that is with init=/bin/sh,
> booted up the RH7 2.2.16 kernel, and fsck was run with no errors.

So far no problem. Rebooting with c-a-d with fs r-o is OK.

> Now I
> though all was well, rebooted from floppy again, but without the init=
> part, and poof, it hang.

Where? It could be a different reason than IDE setup ...

> More interesting may be that I had to turn the computer off and on again
> to get BIOS to find the hard drive. Repeated long reset button presses
> did not help.  It is possible that it hung during BIOS hd detection - I
> wish I could remember.

I fear this isn't much of a clue, sorry.

> I suspect that I could have hung the drive with init=/bin/sh if I would
> have done some reading and writing to the device, besides ls.

Please try it. Best mke2fs your swap partition and try reading & writing
to that. You can mkswap it back after you finish.

> I think I can spend some more time today trying it out some more.

Please do. 'lspci -vvxxx' data for the case without a driver, with 2.4.0
driver and with 3.11 driver would help me find the problem.

Make sure you *don't* have any hdparm -d1 or hdparm -X66 or similar
stuff in your init scripts.

> I will
> also try your 3.11 driver, which seems to be an enormous cleanup.

the 2.1e driver is an enormous cleanup of the original driver from the
2.2 kernels. the 3.11 is an enormous cleanup of 2.1e, yes.

> Btw, do
> you have a home page for the VIA driver?  A CVS perhaps?  If not, please
> consider using sourceforge or something similar.

No, not yet, but working on that.

-- 
Vojtech Pavlik
SuSE Labs
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
