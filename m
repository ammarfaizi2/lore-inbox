Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262387AbSJ0N1e>; Sun, 27 Oct 2002 08:27:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262389AbSJ0N1e>; Sun, 27 Oct 2002 08:27:34 -0500
Received: from chardonnay.math.bme.hu ([152.66.83.144]:39056 "HELO
	chardonnay.math.bme.hu") by vger.kernel.org with SMTP
	id <S262387AbSJ0N1b>; Sun, 27 Oct 2002 08:27:31 -0500
Date: Sun, 27 Oct 2002 14:33:47 +0100
From: KORN Andras <korn-linuxkernel@chardonnay.math.bme.hu>
To: linux-kernel@vger.kernel.org
Subject: Re: 2.4 very slow memory access on abit kd7raid (kt400); ten times slower than on kg7raid
Message-ID: <20021027133347.GO27554@nilus-2690.adsl.datanet.hu>
Reply-To: korn-linuxkernel@chardonnay.math.bme.hu
Mail-Followup-To: korn-linuxkernel@chardonnay.math.bme.hu
References: <20021027032811.GM27554@nilus-2690.adsl.datanet.hu> <20021027075346.GB29184@alpha.home.local> <20021027032811.GM27554@nilus-2690.adsl.datanet.hu> <Pine.LNX.4.33.0210270139530.22820-100000@coffee.psychology.mcmaster.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Disposition: inline
In-Reply-To: <20021027075346.GB29184@alpha.home.local> <Pine.LNX.4.33.0210270139530.22820-100000@coffee.psychology.mcmaster.ca>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 27, 2002 at 01:44:26AM -0400, Mark Hahn wrote:

> >  raid5: measuring checksumming speed
> > -   8regs     :  2343.600 MB/sec
...
> > -raid5: using function: pIII_sse (4163.600 MB/sec)
> > +   8regs     :   228.400 MB/sec
...
> > +raid5: using function: pIII_sse (352.000 MB/sec)
> caching is disabled.

That was what it looked like to me, but I read in the FAQ I shouldn't jump
to conclusions. :)

> > What could be causing this? I believe it is a kernel issue because
> > memtest86 reports realistic memory bandwidths (about 590MB/s).
> 590 MB/s is quite low.  but I believe memtest86 also explicitly manages
> cache and mtrr's.

It does. With 'realistic' I meant it's on the same order of magnitude as
with the other MB.

> > reg00: base=0x00000000 (   0MB), size=1024MB: write-back, count=1
> I wonder if it's lying.

How can I find out? (Well, it sure looks like it's lying, so there's little
point in going to great lengths to confirm it; but why does it lie?)

> > +ACPI: Thermal Zone found
> any idea whether the CPU is hot?  (ie, there's usually a temp monitoring
> screen in the bios.)

It's not. Never seen it go above 40 degrees Celsius (about 104 Fahrenheit).

On Sun, Oct 27, 2002 at 08:53:46AM +0100, Willy Tarreau wrote:
> > What could be causing this? I believe it is a kernel issue because
> > memtest86 reports realistic memory bandwidths (about 590MB/s).
> does memtest86 report high speeds for the L2 cache ?

Over 3000MB/s for L2 and over 9000MB/s for L1. (I can't check exactly right
now.)

> I don't know if a buggy bios can slow it down that much, but that could
> explain your problem.

To me, everything looks right in memtest86. The values are slightly higher
than with the old MB.

> you can also take a look at /proc/interrupts to see if one source (NMI,
> machine check...) is bombing (ie more than tens of thousands/sec), thus
> letting no more time for other operations.

Sorry, I meant to include that in my original post. Here goes (without APIC):

           CPU0
  0:    3657439          XT-PIC  timer
  1:          2          XT-PIC  keyboard
  2:          0          XT-PIC  cascade
  5:    1187394          XT-PIC  eth1, eth2
  8:          3          XT-PIC  rtc
  9:          0          XT-PIC  acpi
 10:     245852          XT-PIC  ide2, ide3
 11:     461019          XT-PIC  eth3
 12:      86306          XT-PIC  eth0
 14:          3          XT-PIC  ide0
NMI:          0
ERR:          0
 
This is after 10 hours of uptime (with load continually in excess of 20). It
doesn't look suspicious to me. I could probably shuffle eth1 and eth2 around
so they don't share IRQs, but that wouldn't make much of a difference, I
think.

Andrew

Ps. Please keep Cc:ing me with replies, if it's not too much trouble.

-- 
          Andrew Korn (Korn Andras) <korn at chardonnay.math.bme.hu>
           Finger korn at chardonnay.math.bme.hu for pgp key. QOTD:
                     Why did Kamikaze pilots wear helmets?
