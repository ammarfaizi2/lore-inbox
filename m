Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269936AbRHEIkK>; Sun, 5 Aug 2001 04:40:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269937AbRHEIkB>; Sun, 5 Aug 2001 04:40:01 -0400
Received: from cx570538-a.elcjn1.sdca.home.com ([24.5.14.144]:24192 "EHLO
	keroon.dmz.dreampark.com") by vger.kernel.org with ESMTP
	id <S269936AbRHEIjr>; Sun, 5 Aug 2001 04:39:47 -0400
Message-ID: <3B6D055B.3A503D4@randomlogic.com>
Date: Sun, 05 Aug 2001 01:35:39 -0700
From: "Paul G. Allen" <pgallen@randomlogic.com>
Organization: Akamai Technologies, Inc.
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.2-2 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: "Linux kernel developer's mailing list" 
	<linux-kernel@vger.kernel.org>
Subject: Re: SMP Support for AMD Athlon MP motherboards
In-Reply-To: <002b01c11d62$73e65540$8405000a@slurv>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andre Tomt wrote:
> 
> I recently got my hands on a unreleased evaluation AthlonMP motherboard with
> two 1.1Ghz Athlon CPU's. First thing I tried was of course Linux. I ran into
> some problems, however.

First of all, I have a K7 Thunder with dual 1.4GHz Thunderbird CPUs, 1
ATA100 (IBM) drive, and 1 U160 (also IBM) drive. I have a friend with
the same board using dual 1.2GHz MP CPUs. They both work fine.

> 
> 1. the SCSI subsystem hung during loading. Before anything card-specefic
> driver loaded. SMP og non-SMP kernels, same thing. Modular loading of
> scsi-drivers did the same thing upon loading. Full lockup. Got it partly
> working on an IDE drive after a while.

Which release of Linux? I started with Red Hat 7.1 and it works with
both SMP and non-SMP kernels, Athlon and PIII compiled kernels, and with
a single CPU installed as well as both CPUs. I now have the original
2.4.2-2 SMP kernel, a UP 2.4.2-2 kernel, a 2.4.7 kernel, and a modified
2.4.x SMP kernel that all work fine.

>From what you say below, it sounds like it uses an onboard Adaptec 7899P
SCSI controller, so Linux 2.4.2-2 (Red Hat Seawolf) should work fine.
Make sure your termination and SCSI BIOS settings are correct (if BSD
works, they are probably OK).

> 
> 2. Linux did only see one CPU.

Both CPUs need to be configured the same as far as FSB speed. I don't
know what your board will do, or even if you can change the settings,
but mine would not even POST when the two CPUs were set for different
FSB speeds. (Tyan warns that setting the two differently can damage the
MoBo. What a nice thing to see when you find that yours is configured
wrong. I'm glad I only had a single CPU installed at the time. :)

> 
> 3. It were highly unstable, even in non-SMP mode.

Early versions of the AMD760MP chipset had serious problems. One of
these was a DMA issue that may cause this. If you can set the results of
lspci -x, we can tell you if your MP chipset may suffer from any (known)
anomalies.

My system has been running 24/7 for weeks and only gets rebooted to test
new kernel builds (about once or twice every night.)

> 
> Whats the degree of support in Linux for such an AMD mobo? Is the Athlon MP
> architecture supported at all yet?

More or less. The chipset works fine for the most part, but not all the
features are fully supported. It also depends upon the BIOS. My BIOS has
some problems, for example it does not set up the MTRRs on both CPUs
properly and there are no settings for AGP and PCI modes (unlike my Asus
A7V133, that seems to have just about everything, too bad the thing is
so unstable)

> 
> I managed to get FreeBSD running on it, and use the SCSI-controller
> (Adaptec, not sure about what board since I do not have physical access as I
> write this. Uses the aic7xxx driver, u160scsi). However, FreeBSD would not
> boot in SMP mode (scsi lockup like Linux did in both SMP and non-SMP
> kernels, it did see both CPU's however...).

Sounds like a hardware problem.

> 
> Now, shed some light on this. I tried kernels fram 2.0.3x to 2.4.7, 2.0 and
> 2.2 did alot of really strange stuff, like making user space apps saying
> "You do not exist"(?).
> 
> How is the support for AMD Athlon MP, really :-)

Start with Red Hat 7.1. I know it works out of the box. If that doesn't
work, I'd look at hardware, BIOS configuration, board jumpers (if any),
and the like.


That's about all that comes to mind at the moment.


PGA

-- 
Paul G. Allen
UNIX Admin II/Network Security
Akamai Technologies, Inc.
www.akamai.com
