Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129523AbQLKVZ7>; Mon, 11 Dec 2000 16:25:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129614AbQLKVZt>; Mon, 11 Dec 2000 16:25:49 -0500
Received: from jabberwock.ucw.cz ([62.168.0.131]:55812 "EHLO jabberwock.ucw.cz")
	by vger.kernel.org with ESMTP id <S129523AbQLKVZi>;
	Mon, 11 Dec 2000 16:25:38 -0500
Date: Mon, 11 Dec 2000 21:55:01 +0100
From: Martin Mares <mj@suse.cz>
To: Gérard Roudier <groudier@club-internet.fr>
Cc: Jamie Lokier <lk@tantalophile.demon.co.uk>, davej@suse.de,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: pdev_enable_device no longer used ?
Message-ID: <20001211215501.A390@albireo.ucw.cz>
In-Reply-To: <20001211002850.A14393@pcep-jamie.cern.ch> <Pine.LNX.4.10.10012111956510.1805-100000@linux.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.4.10.10012111956510.1805-100000@linux.local>; from groudier@club-internet.fr on Mon, Dec 11, 2000 at 08:20:20PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Gerard!

> Having to call some pdev_enable_device() to have the cache line size
> configured looks like shit to me. After all, the BARs, INT, LATENCY TIMER,
> etc.. are configured prior to entering driver probe.

Once upon a time, they used to be, but they no longer are. Unfortunately, there
are lots of bogus devices which must be never assigned BARs nor routed
interrupts. You need to call pci_enable_device() after you recognize the device
as handled by your driver to get BARs and interrupts set up. Also, if your
driver uses bus mastering, it should call pci_set_master().

> Why should the cache line size be deferred to some call to some obscure
> mismaned thing ?

See above.  I'm also not joyfully jumping when I think of it, but consider
it being a tax on being compatible with the rough world of buggy PCI devices.
Anyway, it's still zillion times better than random drivers modifying such
configuration registers in random manner, knowing nothing about the host
bridge and other such stuff.

(Side note: I'm not saying the method your driver uses was bad at the time
it was designed, I'm only saying that it's wrong wrt. the rest of the kernel
and it should be gone.)

				Have a nice fortnight
-- 
Martin `MJ' Mares <mj@ucw.cz> <mj@suse.cz> http://atrey.karlin.mff.cuni.cz/~mj/
CChheecckk yyoouurr dduupplleexx sswwiittcchh..
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
