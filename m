Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264673AbTBOJ2o>; Sat, 15 Feb 2003 04:28:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264724AbTBOJ2o>; Sat, 15 Feb 2003 04:28:44 -0500
Received: from mail.scram.de ([195.226.127.117]:20425 "EHLO mail.scram.de")
	by vger.kernel.org with ESMTP id <S264673AbTBOJ2n>;
	Sat, 15 Feb 2003 04:28:43 -0500
Date: Sat, 15 Feb 2003 10:35:33 +0100 (CET)
From: Jochen Friedrich <jochen@scram.de>
X-X-Sender: jochen@gfrw1044.bocc.de
To: Adrian Bunk <bunk@fs.tum.de>
cc: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: 2.5.61: tms380tr.c no longer compiles
In-Reply-To: <20030215090733.GV20159@fs.tum.de>
Message-ID: <Pine.LNX.4.44.0302151034060.1719-100000@gfrw1044.bocc.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Adrian,

> drivers/net/tokenring/tms380tr.c:260: invalid type argument of `->'
> drivers/net/tokenring/tms380tr.c:260: invalid type argument of `->'
> drivers/net/tokenring/tms380tr.c:260: invalid type argument of `->'
> drivers/net/tokenring/tms380tr.c:260: invalid type argument of `->'
> drivers/net/tokenring/tms380tr.c:260: invalid type argument of `->'
> drivers/net/tokenring/tms380tr.c:260: invalid type argument of `->'
> drivers/net/tokenring/tms380tr.c: In function `tms380tr_init_adapter':
> drivers/net/tokenring/tms380tr.c:1461: warning: long unsigned int

I wonder why my version of gcc didn't catch that one on my Alpha...

Please try this one:

--- tms380tr.c.orig     2003-02-15 09:28:42.000000000 +0100
+++ tms380tr.c  2003-02-15 10:35:16.000000000 +0100
@@ -257,7 +257,7 @@
        int err;

        /* init the spinlock */
-       spin_lock_init(tp->lock);
+       spin_lock_init(&tp->lock);

        /* Reset the hardware here. Don't forget to set the station address. */

@@ -1458,7 +1458,7 @@
        if(tms380tr_debug > 3)
        {
                printk(KERN_DEBUG "%s: buffer (real): %lx\n", dev->name, (long) &tp->scb);
-               printk(KERN_DEBUG "%s: buffer (virt): %lx\n", dev->name, (long) ((char *)&tp->scb - (char *)tp) + tp->dmabuffer);
+               printk(KERN_DEBUG "%s: buffer (virt): %lx\n", dev->name, (long) ((char *)&tp->scb - (char *)tp) + (long) tp->dmabuffer);
                printk(KERN_DEBUG "%s: buffer (DMA) : %lx\n", dev->name, (long) tp->dmabuffer);
                printk(KERN_DEBUG "%s: buffer (tp)  : %lx\n", dev->name, (long) tp);
        }

Thanks,
--jochen

