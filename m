Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161035AbVIOW4E@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161035AbVIOW4E (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Sep 2005 18:56:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161036AbVIOW4D
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Sep 2005 18:56:03 -0400
Received: from xenotime.net ([66.160.160.81]:47508 "HELO xenotime.net")
	by vger.kernel.org with SMTP id S1161035AbVIOW4B (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Sep 2005 18:56:01 -0400
Date: Thu, 15 Sep 2005 15:55:59 -0700 (PDT)
From: "Randy.Dunlap" <rdunlap@xenotime.net>
X-X-Sender: rddunlap@shark.he.net
To: Jesper Juhl <jesper.juhl@gmail.com>
cc: "Randy.Dunlap" <rdunlap@xenotime.net>, linux-kernel@vger.kernel.org
Subject: Re: early printk timings way off
In-Reply-To: <9a87484905091515495f435db7@mail.gmail.com>
Message-ID: <Pine.LNX.4.58.0509151554450.29737@shark.he.net>
References: <200509152342.24922.jesper.juhl@gmail.com> 
 <Pine.LNX.4.58.0509151458330.1800@shark.he.net>  <9a87484905091515072c7dd4a8@mail.gmail.com>
  <Pine.LNX.4.58.0509151537140.29737@shark.he.net> <9a87484905091515495f435db7@mail.gmail.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 16 Sep 2005, Jesper Juhl wrote:

> On 9/16/05, Randy.Dunlap <rdunlap@xenotime.net> wrote:
> > On Fri, 16 Sep 2005, Jesper Juhl wrote:
> >
> > > On 9/15/05, Randy.Dunlap <rdunlap@xenotime.net> wrote:
> > > > On Thu, 15 Sep 2005, Jesper Juhl wrote:
> > > >
> > > > > Early during boot the printk timings are way off :
> > > > >
> > > > > [4294667.296000] Linux version 2.6.14-rc1-git1 (juhl@dragon) (gcc version 3.3.6) #1 PREEMPT Thu Sep 15 22:25:37 CEST 2005
> > > > > [4294667.296000] BIOS-provided physical RAM map:
> > > > > [4294667.296000]  BIOS-e820: 0000000000000000 - 000000000009f800 (usable)
> > > > > [4294667.296000]  BIOS-e820: 000000000009f800 - 00000000000a0000 (reserved)
> > > > > [4294667.296000]  BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
> > > > > [4294667.296000]  BIOS-e820: 0000000000100000 - 000000001ffec000 (usable)
> > > > > [4294667.296000]  BIOS-e820: 000000001ffec000 - 000000001ffef000 (ACPI data)
> > > > > [4294667.296000]  BIOS-e820: 000000001ffef000 - 000000001ffff000 (reserved)
> > > > > [4294667.296000]  BIOS-e820: 000000001ffff000 - 0000000020000000 (ACPI NVS)
> > > > > [4294667.296000]  BIOS-e820: 00000000ffff0000 - 0000000100000000 (reserved)
> > > > > [4294667.296000] 511MB LOWMEM available.
> > > > > [4294667.296000] On node 0 totalpages: 131052
> > > > > [4294667.296000]   DMA zone: 4096 pages, LIFO batch:1
> > > > > [4294667.296000]   Normal zone: 126956 pages, LIFO batch:31
> > > > > [4294667.296000]   HighMem zone: 0 pages, LIFO batch:1
> > > > > [4294667.296000] DMI 2.3 present.
> > > > > [4294667.296000] ACPI: RSDP (v000 ASUS                                  ) @ 0x000f69e0
> > > > > [4294667.296000] ACPI: RSDT (v001 ASUS   A7M266   0x30303031 MSFT 0x31313031) @ 0x1ffec000
> > > > > [4294667.296000] ACPI: FADT (v001 ASUS   A7M266   0x30303031 MSFT 0x31313031) @ 0x1ffec080
> > > > > [4294667.296000] ACPI: BOOT (v001 ASUS   A7M266   0x30303031 MSFT 0x31313031) @ 0x1ffec040
> > > > > [4294667.296000] ACPI: DSDT (v001   ASUS A7M266   0x00001000 MSFT 0x0100000b) @ 0x00000000
> > > > > [4294667.296000] Allocating PCI resources starting at 30000000 (gap: 20000000:dfff0000)
> > > > > [4294667.296000] Built 1 zonelists
> > > > > [4294667.296000] Kernel command line: auto BOOT_IMAGE=2.6.14-rc1-git1 ro root=801 pci=usepirqmask
> > > > > [4294667.296000] Initializing CPU#0
> > > > > [4294667.296000] CPU 0 irqstacks, hard=c03d2000 soft=c03d1000
> > > > > [4294667.296000] PID hash table entries: 2048 (order: 11, 32768 bytes)
> > > > >
> > > > > ^^^^^ These I can buy as the result of an uninitialized variable. Why are
> > > > >       we not initializing this counter to zero?
> > > > >
> > > > > [    0.000000] Detected 1400.279 MHz processor.
> > > > >
> > > > > ^^^^^ Ok, we finally seem to have initialized the counter...
> > > > >
> > > > > [   27.121583] Using tsc for high-res timesource
> > > > >
> > > > > ^^^^^ 27 seconds??? Something is off here. It certainly doesn't take 27 sec
> > > > >       to get from the previous message to this one during the actual boot.
> > > > >       What's up with that?
> > > > >
> > > > > [   27.121620] Console: colour dummy device 80x25
> > > > > [   27.122909] Dentry cache hash table entries: 131072 (order: 7, 524288 bytes)
> > > > > ...
> > > > >
> > > > > No big deal, but it sure would look better (and be actually useful for the
> > > > > first few messages) if things started out at zero and then actually
> > > > > increased sanely from the very beginning.  :-)
> > > >
> > > > For purposes of testing rollover and/or finding broken drivers etc.,
> > > > jiffies is init to something like -5 seconds (or max_jiffies - 5)
> > > > and then it rolls over soon.
> > > >
> > >
> > > I'm aware of that fact, but I thought the printk timings were supposed
> > > to be releative to the kernel starting - surely the known initial
> > > value of jiffies could be accounted/corrected for when printing the
> > > timing values.  Also, that still doesn't explain why the first many
> > > lines seem to be just printing some fixed value (my guess is an
> > > uninitialized var, but I haven't actually looked). It also doesn't
> > > explain why two lines, the first with timing value 0.000, and the next
> > > with 27.121 don't seem to match reality - the *actual* delta between
> > > printing those two lines is far lower than 27 seconds.
> >
> > OK, thanks for the extended explanation.  Good luck.  8:)
> >
>
> Ok, I don't quite know how to interpret that comment, but I'm going to
> read it as "if you think this is a problem then go find a solution
> yourself" - would that be fairly accurate?

Yes, that's close.  I have "bigger fish to fry" is another way.

> It doesn't really bother me much, I just find the behaviour odd. I
> haven't bothered to actually look at the code responsible for it yet
> (since it really is not that big of a deal), but I just wanted to
> point it out and hoped that maybe someone could give me a reason for
> why it is as it is...

ISTM that there have been a few other comments about it, but I'm
not sure.  Maybe Tim Bird (Sony, CELF) would recall.

-- 
~Randy
