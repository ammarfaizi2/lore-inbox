Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132744AbRDNFuY>; Sat, 14 Apr 2001 01:50:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132753AbRDNFuO>; Sat, 14 Apr 2001 01:50:14 -0400
Received: from zeus.kernel.org ([209.10.41.242]:32728 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id <S132767AbRDNFuK>;
	Sat, 14 Apr 2001 01:50:10 -0400
Date: Sat, 14 Apr 2001 07:38:00 +0300 (EEST)
From: Dan Podeanu <pdan@spiral.extreme.ro>
To: Doug McNaught <doug@wireboard.com>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: Data-corruption bug in VIA chipsets
In-Reply-To: <m38zl5exm0.fsf@belphigor.mcnaught.org>
Message-ID: <Pine.LNX.4.30.0104140727310.956-100000@spiral.extreme.ro>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 13 Apr 2001, Doug McNaught wrote:

> Alan Cox <alan@lxorguk.ukuu.org.uk> writes:
>
> > > Here might be one of the resons for the trouble with VIA chipsets:
> > >
> > > http://www.theregister.co.uk/content/3/18267.html
> > >
> > > Some DMA error corrupting data, sounds like a really nasty bug. The
> > > information is minimal on that page.
> >
> > What annoys me is that we've known about the problem for _ages_. If you look
> > the 2.4 kernel has experimental workarounds for this problem. VIA never once
> > even returned an email to say 'we are looking into this'. Instead people sat
> > there flashing multiple BIOS images and seeing what made the difference.
>
> Is this problem likely to affect 2.2.X?  I have a VIA-based board on
> order (Tyan Trinity) and I don't plan to run 2.4 on it anytime soon
> (it's upgrading a stock RH6.2 box).
>

We've had HUGE problems with 2.4.x kernels and VIA based boards. We have
here 3 VIA boards with Athlon/850 and Duron/900 CPUs. The problem goes
like this:

Compile 2.4.3 with VIA and Athlon support.
Reboot.
Ooopses (between 1 and continuously scrolling of them) occur at random
periods of time, between mounting the root filesystem and 2-3 minutes of
functionality.

Note that the problem occurs with all versions of 2.4 but not with
2.2.17-2.2.19. Also, enabling or disabling DMA doesn't help fix the
problem.

After several compiles, it appears that compiling with 586 cpu support
instead of Athlon resulted in a working, stable kernel (which is rather
strange imo, given there are different CPUs but the same board model).
However, compiling with 386 support didn't (which was my first guess of a
stable system).

I was a bit lazy and didn't save/ksymoops any of the oopses, but will do
if this is not a well-known problem (and it appears that more or less it
is).

My lspci:
00:00.0 Host bridge: VIA Technologies, Inc.: Unknown device 0305 (rev 03)
00:01.0 PCI bridge: VIA Technologies, Inc.: Unknown device 8305
00:07.0 ISA bridge: VIA Technologies, Inc. VT82C686 [Apollo Super] (rev
40)
00:07.1 IDE interface: VIA Technologies, Inc. VT82C586 IDE [Apollo] (rev
06)
00:07.2 USB Controller: VIA Technologies, Inc. VT82C586B USB (rev 16)
00:07.4 Bridge: VIA Technologies, Inc. VT82C686 [Apollo Super ACPI] (rev
40)
00:07.5 Multimedia audio controller: VIA Technologies, Inc. VT82C686
[Apollo Super AC97/Audio] (rev 50)
00:0b.0 Ethernet controller: Intel Corporation 82557 [Ethernet Pro 100]
(rev 08)01:00.0 VGA compatible controller: Matrox Graphics, Inc. MGA G400
AGP (rev 04)

(although the cards stuck in the PCIs aren't the same for all three
systems)

and /proc/cpuinfo (from the kernel with 586 support):
processor       : 0
vendor_id       : AuthenticAMD
cpu family      : 6
model           : 4
model name      : AMD Athlon(tm) Processor
stepping        : 2
cpu MHz         : 851.961
cache size      : 256 KB
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 1
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 sep mtrr pge mca cmov
pat pse36 mmx fxsr syscall mmxext 3dnowext 3dnow
bogomips        : 1697.38

I know that all in all this is rather irrelevant, but if further
information is needed, drop me a line and I'll try be a good boy (tm) :)

Yours, Dan.

