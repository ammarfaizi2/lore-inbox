Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261506AbTLHUA4 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Dec 2003 15:00:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261522AbTLHUAz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Dec 2003 15:00:55 -0500
Received: from ppp-62-245-161-4.mnet-online.de ([62.245.161.4]:63873 "EHLO
	frodo.midearth.frodoid.org") by vger.kernel.org with ESMTP
	id S261506AbTLHUAw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Dec 2003 15:00:52 -0500
To: Len Brown <len.brown@intel.com>
Cc: Julien Oster <lkml-2315@mc.frodoid.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: balance interrupts
References: <BF1FE1855350A0479097B3A0D2A80EE00184D619@hdsmsx402.hd.intel.com>
	<1070911748.2408.39.camel@dhcppc4>
From: Julien Oster <lkml-2315@mc.frodoid.org>
Organization: FRODOID.ORG
X-Face: #C"_SRmka_V!KOD9IoD~=}8-P'ekRGm,8qOM6%?gaT(k:%{Y+\Cbt.$Zs<[X|e)<BNuB($kI"KIs)dw,YmS@vA_67nR]^AQC<w;6'Y2Uxo_DT.yGXKkr/s/n'Th!P-O"XDK4Et{`Di:l2e!d|rQoo+C6)96S#E)fNj=T/rGqUo$^vL_'wNY\V,:0$q@,i2E<w[_l{*VQPD8/h5Y^>?:O++jHKTA(
Date: Mon, 08 Dec 2003 21:00:52 +0100
In-Reply-To: <1070911748.2408.39.camel@dhcppc4> (Len Brown's message of "08
 Dec 2003 14:29:08 -0500")
Message-ID: <frodoid.frodo.8765grkrkb.fsf@usenet.frodoid.org>
User-Agent: Gnus/5.1002 (Gnus v5.10.2) Emacs/21.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Len Brown <len.brown@intel.com> writes:

Hello Len,

> Most IO-APIC systems have PCI interrupt lines hard-wired directly to
> IO-APIC interrupt pins.  If an interrupt isn't where you want it to be,
> you need to physically move a card to another slot so that it gets a
> different wire.  A board with decent documentation will tell you what
> slots get which interrupt wires.

Ah, my board has that kind of documentation. Well, then I might do
just this - or see if my board can do that for me. Also, I'd really
want to know if maybe I can split apart the two SATA channels.

> Today basically all boards have also a PIRQ router that is used to map
> these PCI interrupt wires down into PIC interrupt inputs for when the
> system is in PIC compatibility mode (eg. when running the booter). 
> Sometimes they can also re-map interrupt lines in IO-APIC mode.

Ah, that sounds interesting.

> Since your system is running in ACPI mode, the output of acpidmp is
> needed to figure out exactly that the BIOS is saying the board can do.
> The output of lspci -l with this will tell us if we can split apart the
> SATA interrupts, or if they're wired together.

Hmm. I got pciutils 2.1.11 (those claim to be the latest), but my
lspci doesn't know "-l". I attached the output of lspci -vvv to this
mail, however. Maybe it's of any use.

I attached the output of acpidmp to this mail as well. It's a
collection of hexdumps. Since I have no internal knowledge about ACPI
or IO-APICs, I can't do anything with it...

> Another twist is that sometimes enabling/disabling devices in the BIOS
> SETUP will change how the BIOS configures the hardware and make more
> interrupts available.  Here, for example, USB seems to be low hanging
> fruit on a high-rent >= 16 IRQ.

Sorry, I didn't quite understand your last sentence with the fruits
and the rent. I suppose it's some expression, but I'm not a native
english speaker.

But I already disabled everything I don't need in the BIOS (I need
USB, however) and the situation didn't improve very dramatically. At
least I can't see of any devices having changed place in the IRQ list,
only that the devices I deactivated have gone. I also enable "Reset
ESCD data" in the BIOS to encourage things getting rearranged.

> If you're not using ACPI features, you might also try booting with
> "acpi=off" and see if the chip-set PIRQ router does a better job for
> you.

Hmm. If I remember correctly the IRQs stay XT-PIC if I don't enable
ACPI, regardless wether IO-APIC is enabled or not. And the old style
PIC of course leads to the result of my interrupts being very
crowded...

Thanks for your help!
Julien
