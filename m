Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263412AbTKWTMx (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 23 Nov 2003 14:12:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263415AbTKWTMx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 23 Nov 2003 14:12:53 -0500
Received: from fw.osdl.org ([65.172.181.6]:32168 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S263412AbTKWTMw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 23 Nov 2003 14:12:52 -0500
Date: Sun, 23 Nov 2003 11:12:47 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: "Marco d'Itri" <md@Linux.IT>
cc: Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>,
       Len Brown <len.brown@intel.com>, Andi Kleen <ak@muc.de>
Subject: Re: irq 15: nobody cared! with KT600 chipset and 2.6.0-test9
In-Reply-To: <20031123185253.GA1986@wonderland.linux.it>
Message-ID: <Pine.LNX.4.44.0311231056070.17378-100000@home.osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Sun, 23 Nov 2003, Marco d'Itri wrote:
>  >Does this one make a difference?
> No:

Actually, it _does_ seem to make a difference. The irq probe doesn't 
report failure any more:

> ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
> hdc: CD-ROM 50X, ATAPI CD/DVD-ROM drive
> hdd: 32X10, ATAPI CD/DVD-ROM drive
> Badness in request_irq at arch/i386/kernel/irq.c:572

so now we have happily apparently probed the irq, but the problem is that 
it continues to scream afterwards. So we're still unhappy, but something 
did actually change. 

I wonder why ACPI matters. It must be changing the polarity or trigger of 
the irq somehow - but your earlier dmesg output seems to imply that it 
only changes ELCR for irq9, so it must be somewhere else. Len, ideas?

Also, Marco, it might actually be a VIA IDE driver bug, that leaves the 
interrupt on during setup somewhere (and the bug just doesn't matter when 
the IRQ is edge-triggered). So it would be interesting to know what 
happens if you disable the VIA-specific IDE support...

(Btw, thanks for being so good at testing, despite the lack of major 
progress).

		Linus

