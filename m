Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131625AbQLVU2r>; Fri, 22 Dec 2000 15:28:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131686AbQLVU2h>; Fri, 22 Dec 2000 15:28:37 -0500
Received: from zeus.kernel.org ([209.10.41.242]:47884 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id <S131625AbQLVU2V>;
	Fri, 22 Dec 2000 15:28:21 -0500
Date: Fri, 22 Dec 2000 20:56:01 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: linux-kernel@vger.kernel.org
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: Linux 2.2.19pre3
Message-ID: <20001222205601.A13546@athlon.random>
In-Reply-To: <E149GRm-0003sX-00@the-village.bc.nu> <20001222213358.A5829@elektroni.ee.tut.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20001222213358.A5829@elektroni.ee.tut.fi>; from kaukasoi@elektroni.ee.tut.fi on Fri, Dec 22, 2000 at 09:33:58PM +0200
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 22, 2000 at 09:33:58PM +0200, Petri Kaukasoina wrote:
> I think in case of BIOS-88 it now sees 1 Meg less than should. int 15, ah=88

Yes, you're right, sorry. Here a backout against 2.2.19pre3:

--- 2.2.19pre3-e820/arch/i386/kernel/setup.c.~1~	Fri Dec 22 14:51:26 2000
+++ 2.2.19pre3-e820/arch/i386/kernel/setup.c	Fri Dec 22 20:54:27 2000
@@ -376,8 +376,7 @@
 
                e820.nr_map = 0;
                add_memory_region(0, i386_endbase, E820_RAM);
-               add_memory_region(HIGH_MEMORY, (mem_size << 10)-HIGH_MEMORY,
-				 E820_RAM);
+               add_memory_region(HIGH_MEMORY, (mem_size << 10), E820_RAM);
        }
        printk("BIOS-provided physical RAM map:\n");
        print_memory_map(who);


The other part of the 2.4.x patch is still valid.

Thanks,
Andrea
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
