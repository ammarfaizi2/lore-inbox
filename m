Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264321AbTEaNm5 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 31 May 2003 09:42:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264325AbTEaNm4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 31 May 2003 09:42:56 -0400
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:27371 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id S264321AbTEaNmy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 31 May 2003 09:42:54 -0400
Date: Sat, 31 May 2003 15:56:10 +0200
From: Adrian Bunk <bunk@fs.tum.de>
To: Andrew Morton <akpm@digeo.com>, Christoph Hellwig <hch@infradead.org>
Cc: linux-kernel@vger.kernel.org, linux-net@vger.kernel.org
Subject: [patch] 2.5.70-mm3: sdla.c doesn't compile
Message-ID: <20030531135610.GI2536@fs.tum.de>
References: <20030531013716.07d90773.akpm@digeo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030531013716.07d90773.akpm@digeo.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

It seems the following compile error when trying to compile sdla,c 
statically into the kernel comes from Linus' tree:

<--  snip  -->

...
  CC      drivers/net/wan/sdla.o
drivers/net/wan/sdla.c: In function `sdla_cmd':
drivers/net/wan/sdla.c:443: warning: comparison of distinct pointer 
types lacks a cast
drivers/net/wan/sdla.c: In function `exit_sdla':
drivers/net/wan/sdla.c:1685: `sdla0' undeclared (first use in this 
function)
drivers/net/wan/sdla.c:1685: (Each undeclared identifier is reported 
only once
drivers/net/wan/sdla.c:1685: for each function it appears in.)
make[3]: *** [drivers/net/wan/sdla.o] Error 1

<--  snip  -->


I'm not sure whether the following is the best solution but it fixes the 
problem:


--- linux-2.5.70-mm3/drivers/net/wan/sdla.c.old	2003-05-31 15:49:52.000000000 +0200
+++ linux-2.5.70-mm3/drivers/net/wan/sdla.c	2003-05-31 15:50:39.000000000 +0200
@@ -1662,12 +1662,10 @@
 	return 0;
 }
 
-#ifdef MODULE
 static struct net_device sdla0 = {
 	.name = "sdla0",
 	.init = sdla_init
 };
-#endif /* MODULE */
 
 static int __init init_sdla(void)
 {



cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

