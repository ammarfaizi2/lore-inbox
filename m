Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319436AbSH3Frm>; Fri, 30 Aug 2002 01:47:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319437AbSH3Frm>; Fri, 30 Aug 2002 01:47:42 -0400
Received: from twilight.ucw.cz ([195.39.74.230]:21138 "EHLO twilight.ucw.cz")
	by vger.kernel.org with ESMTP id <S319436AbSH3Frl>;
	Fri, 30 Aug 2002 01:47:41 -0400
Date: Fri, 30 Aug 2002 07:51:47 +0200
From: Vojtech Pavlik <vojtech@suse.cz>
To: Andre Hedrick <andre@linux-ide.org>
Cc: Vojtech Pavlik <vojtech@suse.cz>, Meelis Roos <mroos@tartu.cyber.ee>,
       linux-kernel@vger.kernel.org
Subject: Re: Hangs in 2.4.19 and 2.4.20-pre5 (IDE-related?)
Message-ID: <20020830075147.D18904@ucw.cz>
References: <20020829224621.A4175@ucw.cz> <Pine.LNX.4.10.10208292003080.24156-100000@master.linux-ide.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.4.10.10208292003080.24156-100000@master.linux-ide.org>; from andre@linux-ide.org on Thu, Aug 29, 2002 at 08:04:58PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 29, 2002 at 08:04:58PM -0700, Andre Hedrick wrote:
> 
> Good cause then I take responsiblity for it.
> 
> On Thu, 29 Aug 2002, Vojtech Pavlik wrote:
> 
> > On Thu, Aug 29, 2002 at 12:37:19PM -0700, Andre Hedrick wrote:
> > 
> > > On Thu, 29 Aug 2002, Meelis Roos wrote:
> > > 
> > > > pcibus = 33333
> > > > 00:07.1 vendor=8086 device=7111 class=0101 irq=0 base4=f001
> > > > ----------PIIX BusMastering IDE Configuration---------------
> > > > Driver Version:                     1.3
> > > > South Bridge:                       28945
> > > > Revision:                           IDE 0x1
> > > > Highest DMA rate:                   UDMA33
> > > > BM-DMA base:                        0xf000
> > > > PCI clock:                          33.3MHz
> > > > -----------------------Primary IDE-------Secondary IDE------
> > > > Enabled:                      yes                 yes
> > > > Simplex only:                  no                  no
> > > > Cable Type:                   40w                 40w
> > > > -------------------drive0----drive1----drive2----drive3-----
> > > > Prefetch+Post:        yes       yes       yes       yes
> > > > Transfer Mode:        PIO       PIO       PIO       PIO
> > > > Address Setup:       90ns      90ns      90ns      90ns
> > > > Cmd Active:         360ns     360ns     360ns     360ns
> > > > Cmd Recovery:       540ns     540ns     540ns     540ns
> > > > Data Active:         90ns      90ns      90ns      90ns
> > > > Data Recovery:       30ns      30ns      90ns      30ns
> > > > Cycle Time:         120ns     120ns     180ns     120ns
> > > > Transfer Rate:   16.6MB/s  16.6MB/s  11.1MB/s  16.6MB/s
> > > 
> > > That is not my work and you are on your own for that mess.
> > > That looks straight out of 2.5.30.
> > 
> > Don't be so quick with shooing people away - this is the output of the
> > 'atapci' userspace program. It only reads the PCI config registers and
> 
> Well if atapci is that complete then I see no reason to keep proc about.
> So if it needs to go we delete it.

I think you can drop the chipset specific /proc code. It'll simplify the
drivers a lot as well as making them smaller.

On the other hand, I'd suggest that some generic /proc code is put in
place instead of the chipset-specific one - the values that cannot be
read from PCI config registers, like:

The PIO/MMIO/(U)DMA mode (and transfer rate) the IDE driver is operating
the in. The bus speed the driver thinks is running at. Whether the IDE
driver has detected a 80 or 40 wire cable. Etc, etc. This would be very
useful, can be done by a single common routine, and most users actually
don't need the exact timings.

-- 
Vojtech Pavlik
SuSE Labs
