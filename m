Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262180AbTHYVA2 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Aug 2003 17:00:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262216AbTHYVA2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Aug 2003 17:00:28 -0400
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:34782 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id S262180AbTHYVAZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Aug 2003 17:00:25 -0400
Date: Mon, 25 Aug 2003 23:00:12 +0200
From: Adrian Bunk <bunk@fs.tum.de>
To: kmliu@sis.com, Jeff Garzik <jgarzik@pobox.com>
Cc: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [patch] 2.6.0-test4: sis190 doesn't compile with gcc 2.95
Message-ID: <20030825210011.GU7038@fs.tum.de>
References: <Pine.LNX.4.44.0308221732170.4677-100000@home.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0308221732170.4677-100000@home.osdl.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 22, 2003 at 05:48:56PM -0700, Linus Torvalds wrote:
>...
> Summary of changes from v2.6.0-test3 to v2.6.0-test4
> ============================================
>...
> Jeff Garzik:
>...
>   o [netdrvr] add sis190 gigabit ethernet driver (note: needs work)
>...

The following is needed to fix the compilation of sis190 with gcc 2.95:

--- linux-2.6.0-test4-mm1/drivers/net/sis190.c.old	2003-08-25 20:03:04.000000000 +0200
+++ linux-2.6.0-test4-mm1/drivers/net/sis190.c	2003-08-25 20:03:45.000000000 +0200
@@ -536,6 +536,7 @@
 	static int printed_version = 0;
 	int i, rc;
 	u16 reg31;
+	int val;
 
 	assert(pdev != NULL);
 	assert(ent != NULL);
@@ -620,7 +621,7 @@
 	       dev->dev_addr[2], dev->dev_addr[3],
 	       dev->dev_addr[4], dev->dev_addr[5], dev->irq);
 
-	int val = smdio_read(ioaddr, PHY_AUTO_NEGO_REG);
+	val = smdio_read(ioaddr, PHY_AUTO_NEGO_REG);
 
 	printk(KERN_INFO "%s: Auto-negotiation Enabled.\n", dev->name);
 


cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

