Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265069AbTLFI5p (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 6 Dec 2003 03:57:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265081AbTLFI5p
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 6 Dec 2003 03:57:45 -0500
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:4056 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id S265069AbTLFI5n (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 6 Dec 2003 03:57:43 -0500
Date: Sat, 6 Dec 2003 09:57:36 +0100
From: Adrian Bunk <bunk@fs.tum.de>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: netdev@oss.sgi.com, torvalds@osdl.org, linux-kernel@vger.kernel.org
Subject: [patch] remove com20020-isa.c unused variables
Message-ID: <20031206085736.GQ20739@fs.tum.de>
References: <20031205192828.GA15907@gtf.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031205192828.GA15907@gtf.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jeff,

your experimental net driver queue patch introduced the following
compile warnings when compiling com20020-isa statically into the kernel:

<--  snip  -->

...
  CC      drivers/net/arcnet/com20020-isa.o
drivers/net/arcnet/com20020-isa.c: In function `com20020isa_setup':
drivers/net/arcnet/com20020-isa.c:189: warning: unused variable `lp'
drivers/net/arcnet/com20020-isa.c:188: warning: unused variable `dev'
...

<--  snip  -->


The fix is trivial (the net driver queue patch removes all uses of 
these variables):


--- linux-2.6.0-test11-full-no-smp/drivers/net/arcnet/com20020-isa.c.old	2003-12-06 09:51:10.000000000 +0100
+++ linux-2.6.0-test11-full-no-smp/drivers/net/arcnet/com20020-isa.c	2003-12-06 09:53:41.000000000 +0100
@@ -185,8 +185,6 @@
 #ifndef MODULE
 static int __init com20020isa_setup(char *s)
 {
-	struct net_device *dev;
-	struct arcnet_local *lp;
 	int ints[8];
 
 	s = get_options(s, 8, ints);



cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

