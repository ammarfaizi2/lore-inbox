Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S275579AbRIZU1m>; Wed, 26 Sep 2001 16:27:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S275580AbRIZU1c>; Wed, 26 Sep 2001 16:27:32 -0400
Received: from harpo.it.uu.se ([130.238.12.34]:5509 "EHLO harpo.it.uu.se")
	by vger.kernel.org with ESMTP id <S275579AbRIZU1U>;
	Wed, 26 Sep 2001 16:27:20 -0400
Date: Wed, 26 Sep 2001 22:27:45 +0200 (MET DST)
From: Mikael Pettersson <mikpe@csd.uu.se>
Message-Id: <200109262027.WAA05553@harpo.it.uu.se>
To: linux-kernel@vger.kernel.org, munnikes@cistron.nl
Subject: Re: PROBLEM: spurious 8259A interrupt: IRQ7. AND VM: killing process ..
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 26 Sep 2001 18:22:26 +0200, Alfred Munnikes wrote:

>With a new compiled kernel 2.4.10 I have the next problem's
>
>first is gives the message "spurious 8259A interrupt: IRQ7."
>...
>I have a Abit KT7-raid with KT133 chipset, may the problem a hardware
>...
>Local APIC disabled by BIOS -- reenabling.
>Found and enabled local APIC!
>...
>enabled ExtINT on CPU#0
>ESR value before enabling vector: 00000000
>ESR value after enabling vector: 00000000
>Using local APIC timer interrupts.
>calibrating APIC timer ...
>..... CPU clock speed is 900.0498 MHz.
>..... host bus clock speed is 200.0110 MHz.

You didn't include your .config, but it seems you have
CONFIG_X86_UP_IOAPIC=y.

Please try either 2.4.10 with CONFIG_X86_UP_IOAPIC=n (don't worry,
you don't need it and won't lose any performance) or 2.4.9-ac with
CONFIG_X86_UP_IOAPIC=n and CONFIG_X86_UP_APIC=y.

There seems to be something amiss with the merge of the UP local APIC
code from -ac (where it's brilliant, but I'm biased) in 2.4.10, but I
haven't had time to investigate. I'm almost certain that it was a mistake
to lump UP *local APIC* and UP *IO-APIC* together under the same config
option in 2.4.10 -- they're separate in 2.4-ac.

/Mikael
