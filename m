Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284945AbRLKKCq>; Tue, 11 Dec 2001 05:02:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284948AbRLKKCg>; Tue, 11 Dec 2001 05:02:36 -0500
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:57101 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id <S284945AbRLKKCV>; Tue, 11 Dec 2001 05:02:21 -0500
Date: Tue, 11 Dec 2001 11:02:17 +0100
From: Pavel Machek <pavel@suse.cz>
To: Cory Bell <cory.bell@usa.net>
Cc: kernel list <linux-kernel@vger.kernel.org>
Subject: Re: IRQ Routing Problem on ALi Chipset Laptop (HP Pavilion N5425)
Message-ID: <20011211110217.E10682@atrey.karlin.mff.cuni.cz>
In-Reply-To: <Pine.LNX.4.33.0112060938340.32381-100000@pianoman.cluster.toy> <1007685691.6675.1.camel@localhost.localdomain> <20011207213313.A176@elf.ucw.cz> <1007876254.17062.0.camel@localhost.localdomain> <20011210170147.A24663@atrey.karlin.mff.cuni.cz> <1008019490.17061.18.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1008019490.17061.18.camel@localhost.localdomain>
User-Agent: Mutt/1.3.20i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!
 
> > He told me there's updated bios, somewhere. Did you try that?
> 
> Latest BIOS for my machine is 1.03 - didn't help.
> 
> > What exactly is wrong? You said PIR tables are broken, but with patch
> > below, it seems to work. What's wrong?
> 
> Take a look at
> http://www.microsoft.com/hwdev/archive/BUSBIOS/pciirq.asp

That's ... really evil.

> for some background. Under linux, on an ALi chipset, the "link" numbers
> are used as an offset into the PCI config space of the ISA bridge, where
> the IRQ for that "link" is stored. On my machine, the link numbers are
> 0x01-0x03 (for everything but USB) and 0x59 (for USB). The value at the
> offset for link 0x59 translates to IRQ 9. The PCI configuration space of
> the USB controller indicates IRQ 9, as well. See pirq_ali_get() in

So their BIOS wrongly set irq in config space of USB controller, right?

> linux/arch/i386/kernel/pci-irq.c for details on how this works.
> 
> All the last patch does is match the IRQ being considered for the device
> against the IRQ mask for that device in the PIR table. If it doesn't
> match, the kernel assigns one that does match the mask.

Ahha. May that mean that our magic w.r.t. touching pci config space on
ALI chipsets is wrong?

> To be clear: with the last patch, USB works, but not the maestro-3,
> right?

Yes.

> The reason I keep asking you for the output of "lspci -vvvxxx" and
> "dump_pirq" is so I can look at your PIR table and PCI config space and
> try to determine if the same thing that happened to USB is happening to
> your maestro. It's possible your maestro problem is completely
> unrelated. If you're unwilling to provide that informataion for some
> reason, just let me know and I'll quit asking.

I thought I already mailed you lspci.... dump_pirq is not installed on
my machine, I'll try to install it and mail you that info. [Hmm, it
may be hard, because I'm now on modem link and behind nasty firewall;
perhaps you could just mail me dump_pirq binary if it does not need
special libraries?]
								Pavel
-- 
Casualities in World Trade Center: 6453 dead inside the building,
cryptography in U.S.A. and free speech in Czech Republic.
