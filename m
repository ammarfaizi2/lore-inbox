Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129412AbQKQRLm>; Fri, 17 Nov 2000 12:11:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130450AbQKQRLW>; Fri, 17 Nov 2000 12:11:22 -0500
Received: from panic.ohr.gatech.edu ([130.207.47.194]:38665 "EHLO
	havoc.gtf.org") by vger.kernel.org with ESMTP id <S130126AbQKQRLP>;
	Fri, 17 Nov 2000 12:11:15 -0500
Message-ID: <3A155F6A.28783D4A@mandrakesoft.com>
Date: Fri, 17 Nov 2000 11:40:10 -0500
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
X-Mailer: Mozilla 4.75 [en] (X11; U; Linux 2.4.0-test11 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: David Woodhouse <dwmw2@infradead.org>
CC: Linus Torvalds <torvalds@transmeta.com>,
        Russell King <rmk@arm.linux.org.uk>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>, David Hinds <dhinds@valinux.com>,
        tytso@valinux.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] pcmcia event thread. (fwd)
In-Reply-To: <Pine.LNX.4.10.10011170814440.2272-100000@penguin.transmeta.com> <5178.974478881@redhat.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Woodhouse wrote:
> 
> torvalds@transmeta.com said:
> >  If somebody still has a problem with the in-kernel stuff, speak up.
> 
> I have an i82092AA evaluation board:
> 
> 00:06.0 PCMCIA bridge: Intel Corporation 82092AA_0 (rev 02)
>         Flags: slow devsel, IRQ 27
>         I/O ports at 8400 [size=4]
> 
> I have three problems:
> 
> 1. I have to specify the i365_base parameter when loading i82365,o
> 
> 2. Even when I specify cs_irq=27, it resorts to polling:
> 
>         Intel PCIC probe:
>           Intel i82365sl DF ISA-to-PCMCIA at port 0x8400 ofs 0x00, 2 sockets
>             host opts [0]: none
>             host opts [1]: none
>             ISA irqs (default) = none! polling interval = 1000 ms
>           Intel i82365sl DF ISA-to-PCMCIA at port 0x8400 ofs 0x80, 2 sockets
>             host opts [2]: none
>             host opts [3]: none
>             ISA irqs (default) = none! polling interval = 1000 ms

For these two, it sounds to me like you need to be doing a PCI probe,
and getting the irq and I/O port info from pci_dev.  And calling
pci_enable_device, which may or may not be a showstopper here...

	Jeff


-- 
Jeff Garzik             |
Building 1024           | The chief enemy of creativity is "good" sense
MandrakeSoft            |          -- Picasso
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
