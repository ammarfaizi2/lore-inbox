Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S283836AbRLEItj>; Wed, 5 Dec 2001 03:49:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S283834AbRLEIt2>; Wed, 5 Dec 2001 03:49:28 -0500
Received: from mtiwmhc23.worldnet.att.net ([204.127.131.48]:13257 "EHLO
	mtiwmhc23.worldnet.att.net") by vger.kernel.org with ESMTP
	id <S283832AbRLEItQ>; Wed, 5 Dec 2001 03:49:16 -0500
Subject: Re: IRQ Routing Problem on ALi Chipset Laptop (HP Pavilion N5425)
From: Cory Bell <cory.bell@usa.net>
To: John Clemens <john@deater.net>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.33.0112050036440.25305-100000@pianoman.cluster.toy>
In-Reply-To: <Pine.LNX.4.33.0112050036440.25305-100000@pianoman.cluster.toy>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/0.99.0 (Preview Release)
Date: 05 Dec 2001 00:40:18 -0800
Message-Id: <1007541620.2340.2.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2001-12-04 at 21:58, John Clemens wrote:
> someone noticed! ;) Glad to see you also noticed my minor oversight in
> using INTERRUPT_PIN instead of the correct INTERRUPT_LINE.  Glad someone
> found the work useful... A few people have asked me separately for my
> patch and are using it successfully on thier laptops with no failure
> reports.

Actually, I checked your homepage before buying the laptop. In that
price/feature range, it was that or the Compaq, and the Compaq had a SMA
video chipset (blech). Would you consider putting the patch on your
website? I got the k7/sse patch, but the irq patch isn't actually
linked, I just happened across it while doing my research. I now know
WAY more about PCI interrupt routing than I ever wanted to, and I STILL
don't understand it!

> Most probably.. that in combination with number 3.. And, to top it all
> off, ACPI is thrown in there too as a non-PCI device on IRQ9.  All in all,
> quite a quirky laptop (for reference, I own an N5430, an earlier version
> of your notebook).

Does ACPI work on your laptop? I wonder if XP Home Ed. works because
it's getting config info from there instead of PCIBIOS or PnPBIOS
tables? ACPI seems to work on my laptop (detects ACPI resources, thermal
zone, etc), but if I "cat /proc/acpi/events" and press the suspend or
power buttons, I don't get anything. On my old NEC Versa LX, I'd get a
few junk chars for each press (been a while since I tried it, though). I
don't see any interrupts on IRQ 9, either.

> > 2) Bad Linux interperetation of ALi IRQ router? (comments in
> > linux/arch/i386/kernel/pci-irq.c seem to suggest it's possible)
> 
> Doubtful, as I have an Ali Aladdin7 board in my desktop (don't get much
> more obscure than that one), and the Router works fine, as well as in a
> Magik1 based motherboard I've used.

About interrupt routing: Does the PIRQ table actually contain the IRQ a
device is assigned to, or just a "link number" and a mask of acceptible
IRQs. I see on your laptop, the audio is on irq 5, which matches the
mask, but there seems to be no PIRQ link for 5, just like there's none
for IRQ 9 on yours or mine, yet the audio device still gets 5. Perhaps
the setup code is interpereting the "link" to mean a particular IRQ, but
is failing to validate the IRQ against the mask? Any idea how the setup
code gets from PIRQ 0x59 to IRQ 9, or PIRQ 0x48 to IRQ 11? Would you
mind emailing me a dump_pirq from your desktop ALi?

I imagine it doesn't help that the link numbers vary between machines of
the same chipset (ie, you have 0x00, 0x48-0x49, and 0x59, and I have
0x00, 0x01-0x03, and 0x59 - interesting that the "troublemaker" link #
is the same for both of us). Have you heard from anyone else with
ALi-chipset laptops having similar problems? I think the compaq I was
looking at had the same core chipset.

> I've been wondering this one myself... one thing these laptops do
> implement is a complete DMI table.. maybe we can do some sort of fixup
> through there... does anyone know of any way to use the "DMI workarounds"
> to effect PCI IRQ mapping -without- modifying the generic pci code?
Does the standard kernel have DMI? I thought that was an -ac thing... I
know I don't see any DMI messages on boot.

> And I like you patch, it's a slightly cleaner for of ugly than mine :).
Thanks! I'm still trying to find a way to move it out of generic PCI
code and at least into ALi-specific territory...

-Cory

