Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129319AbQLKDKA>; Sun, 10 Dec 2000 22:10:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129392AbQLKDJu>; Sun, 10 Dec 2000 22:09:50 -0500
Received: from [194.73.73.138] ([194.73.73.138]:60091 "EHLO ruthenium")
	by vger.kernel.org with ESMTP id <S129319AbQLKDJn>;
	Sun, 10 Dec 2000 22:09:43 -0500
Date: Mon, 11 Dec 2000 00:34:54 +0000 (GMT)
From: davej@suse.de
To: Jamie Lokier <lk@tantalophile.demon.co.uk>
cc: Martin Mares <mj@suse.cz>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: pdev_enable_device no longer used ?
In-Reply-To: <20001211002850.A14393@pcep-jamie.cern.ch>
Message-ID: <Pine.LNX.4.21.0012110018180.19534-100000@neo.local>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 11 Dec 2000, Jamie Lokier wrote:

> Here are a few more:
> 
>  net/acenic.c: pci_write_config_byte(ap->pdev, PCI_CACHE_LINE_SIZE,

Acenic is at least setting it to the correct values, not hardcoding it.

>  net/gmac.c: PCI_CACHE_LINE_SIZE, 8);

Ick.

>  scsi/sym53c8xx.c: printk(NAME53C8XX ": PCI_CACHE_LINE_SIZE set to %d (fix-up).\n",

**vomit**
On the plus side, they made it arch independant. Shame it's incomplete.
If you look at the x86 path, its missing Pentium 4 support (x86==15).
It also screws up on Athlon where it should be set to 16, but gets 8.
I wouldn't be surprised if the other arch's were missing some definitions
too.  The fact that this driver is a port of FreeBSD driver may be the
reason why SMP_CACHE_BYTES wasn't used instead, and the author opted
for that monster. But still, the whole thing is completely unnecessary.

>  video/pm2fb.c: WR32(p->pci_config, PCI_CACHE_LINE_SIZE, 0xff00);

Icky.

IMO, these fixups should all get nuked. In a majority of cases, we have
half-arsed solutions that are doing just as much badness on some archs
as the goodness they were intending to provide on others.

Let the PCI layer handle all of these quirks on startup, and be done.

regards,

Davej.

-- 
| Dave Jones <davej@suse.de>  http://www.suse.de/~davej
| SuSE Labs

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
