Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129387AbQLKWVB>; Mon, 11 Dec 2000 17:21:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130229AbQLKWUv>; Mon, 11 Dec 2000 17:20:51 -0500
Received: from front4m.grolier.fr ([195.36.216.54]:14331 "EHLO
	front4m.grolier.fr") by vger.kernel.org with ESMTP
	id <S129383AbQLKWUf> convert rfc822-to-8bit; Mon, 11 Dec 2000 17:20:35 -0500
Date: Mon, 11 Dec 2000 21:49:52 +0100 (CET)
From: Gérard Roudier <groudier@club-internet.fr>
To: Martin Mares <mj@suse.cz>
cc: Jamie Lokier <lk@tantalophile.demon.co.uk>, davej@suse.de,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: pdev_enable_device no longer used ?
In-Reply-To: <20001211215501.A390@albireo.ucw.cz>
Message-ID: <Pine.LNX.4.10.10012112116250.2023-100000@linux.local>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 11 Dec 2000, Martin Mares wrote:

> Hello Gerard!
> 
> > Having to call some pdev_enable_device() to have the cache line size
> > configured looks like shit to me. After all, the BARs, INT, LATENCY TIMER,
> > etc.. are configured prior to entering driver probe.
> 
> Once upon a time, they used to be, but they no longer are. Unfortunately, there
> are lots of bogus devices which must be never assigned BARs nor routed
> interrupts.

Hmmm... Because of broken devices you move the burden to fine ones. Let me
disagree here.

> You need to call pci_enable_device() after you recognize the device
> as handled by your driver to get BARs and interrupts set up. Also, if your
> driver uses bus mastering, it should call pci_set_master().

I donnot see in what pci_enable_device() knows better than the tailored
software driver about what is to enable for the device and what must not
or should not. And, btw, when pci_enable_device() was born, it just
shoe-horned latency timer 64 if it was lower that 16 and I didn't want to
use so obviously loose in the first place interface.


> > Why should the cache line size be deferred to some call to some obscure
> > mismaned thing ?
> 
> See above.  I'm also not joyfully jumping when I think of it, but consider
> it being a tax on being compatible with the rough world of buggy PCI devices.

Blacklists are there to preserve simplicity and genericity for compliant
devices and it has the advantage of showing in a single place what and how
these devices are broken.

On the other hand, I donnot see `pci_enable_device()' in latest 2.2
kernels. It seem to beleive that the millions Linux used around the world
are rather 2.2 that 2.4. All these buggy PCI devices breaking millions of
Linux 2.2 kernels should make some noise. What did I miss here?

> Anyway, it's still zillion times better than random drivers modifying such
> configuration registers in random manner, knowing nothing about the host
> bridge and other such stuff.

Making driver for Linux work has been a nightmare for years, especially
PCI-SCSI, due to limitations and brokenness of related kernel services.

> (Side note: I'm not saying the method your driver uses was bad at the time
> it was designed, I'm only saying that it's wrong wrt. the rest of the kernel
> and it should be gone.)

The driver is not calling pci_enable_device() but is does not change
anything by default for Intel (the only one I support personnaly) if it is
provided with a correct configuration. I have used it on various Intel
platforms, even without SDMS BIOS and the only configuration item I have
seen missing sometimes has been the offending PCI cache line size.

When the driver has been tinked (not by me) in order to run on non Intel
platforms, I am been provided with various ugly PCI-related hacks that I
have incorporated with appropriate #ifdef(s), since I couldn't even test
them.

If now, the PCI stuff is claimed to be cleaned up, then _all_ the hacks
have to be removed definitely.
As a result, the driver will not work anymore on Sparc64, neither on PPC
and I am not sure it will still work on Alpha, in my opinion.

  Gérard.

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
