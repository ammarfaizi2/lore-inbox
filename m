Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311346AbSCLVUQ>; Tue, 12 Mar 2002 16:20:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311352AbSCLVUB>; Tue, 12 Mar 2002 16:20:01 -0500
Received: from mail.pha.ha-vel.cz ([195.39.72.3]:13576 "HELO
	mail.pha.ha-vel.cz") by vger.kernel.org with SMTP
	id <S311346AbSCLVTp>; Tue, 12 Mar 2002 16:19:45 -0500
Date: Tue, 12 Mar 2002 22:19:40 +0100
From: Vojtech Pavlik <vojtech@suse.cz>
To: Sebastian Droege <sebastian.droege@gmx.de>
Cc: Vojtech Pavlik <vojtech@suse.cz>, martin@dalecki.de,
        linux-kernel@vger.kernel.org
Subject: Re: [patch] PIIX driver rewrite
Message-ID: <20020312221940.A15614@ucw.cz>
In-Reply-To: <E16kYXz-0001z3-00@the-village.bc.nu> <Pine.LNX.4.33.0203111431340.15427-100000@penguin.transmeta.com> <20020311234553.A3490@ucw.cz> <3C8DDFC8.5080501@evision-ventures.com> <20020312210035.A15175@ucw.cz> <20020312213505.1d229d95.sebastian.droege@gmx.de> <20020312213428.A15278@ucw.cz> <20020312220701.348217d8.sebastian.droege@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20020312220701.348217d8.sebastian.droege@gmx.de>; from sebastian.droege@gmx.de on Tue, Mar 12, 2002 at 10:07:01PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

Thanks a lot, the /proc stuff indeed seems to be wrong. I'll fix that
tomorrow.

On Tue, Mar 12, 2002 at 10:07:01PM +0100, Sebastian Droege wrote:
> On Tue, 12 Mar 2002 21:34:28 +0100
> Vojtech Pavlik <vojtech@suse.cz> wrote:
> 
> > On Tue, Mar 12, 2002 at 09:35:05PM +0100, Sebastian Droege wrote:
> > > On Tue, 12 Mar 2002 21:00:35 +0100
> > > Vojtech Pavlik <vojtech@suse.cz> wrote:
> > > 
> > > > On Tue, Mar 12, 2002 at 12:00:24PM +0100, Martin Dalecki wrote:
> > > > > Hello Vojtech.
> > > > > 
> > > > > I have noticed that the ide-timings.h and ide_modules.h are running
> > > > > much in aprallel in the purpose they serve. Are the any
> > > > > chances you could dare to care about propagating the
> > > > > fairly nice ide-timings.h stuff in favour of
> > > > > ide_modules.h more.
> > > > > 
> > > > > BTW.> I think some stuff from ide-timings.h just belongs
> > > > > as generic functions intro ide.c, and right now there is
> > > > > nobody who you need to work from behind ;-).
> > > > > 
> > > > > So please feel free to do the changes you apparently desired
> > > > > to do a long time ago...
> > > > 
> > > > Oh, by the way, here goes the PIIX rewrite ... unlike the AMD one, this
> > > > is completely untested, and may not work at all - I only have the
> > > > datasheets at hand, no PIIX hardware.
> > > > 
> > > > Differences from the previous PIIX driver:
> > > > 
> > > > * 82451NX MIOC isn't supported anymore. It's not an ATA controller, anyway ;)
> > > > * 82371FB_0 PIIX ISA bridge isn't an ATA controller either.
> > > > * 82801CA ICH3 support added. Only ICH3-M is supported by the original driver.
> > > > * 82371MX MPIIX is not supported anymore. Too weird beast and doesn't do
> > > >   DMA anyway, better handled by the generic PCI ATA routines.
> > > > 
> > > > * Cleaner, converted to ide-timing.[ch]
> > > > 
> > > > * May not work. ;)
> > > But does work with an Intel Corp. 82371AB PIIX4 IDE (rev 01) IDE controller...
> > 
> > Thanks a lot for the testing!
> > 
> > > I'll do some more stress testing but it boots, works in DMA and the data transfer rates haven't decreased ;)
> > > *playingwithhdparmanddbench* ;)
> > 
> > If you can (in addition to the benchmark numbers) also send me the
> > output of 'cat /proc/ide/piix' and 'dmesg' and 'lspci -vvxxx'both my and
> > the original version ... that'd help a lot too.
> OK here they are ;)
> The only thing which confuses me is the line
> PCI clock:                          33333MHz
> in /proc/ide/piix
> It should be 33 MHz I think
> I think the mistake is in line 199 of piix.c:
> piix_print("PCI clock:                          %dMHz", piix_clock);
> has to be
> piix_print("PCI clock:                          %dMHz", piix_clock / 1000);
> 
> or
> the whole piix_clock stuff after line 432 is wrong
> 
> BTW: in /proc/ide/piix are sometimes wrong values for transfer rate and cycle time... I think they can't get negative ;)
> 
> Benchmark results come tomorrow
> 
> Bye









-- 
Vojtech Pavlik
SuSE Labs
