Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270816AbTG1UZc (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Jul 2003 16:25:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271030AbTG1UZc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Jul 2003 16:25:32 -0400
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:5851 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id S270816AbTG1UZK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Jul 2003 16:25:10 -0400
Date: Mon, 28 Jul 2003 22:25:01 +0200
From: Adrian Bunk <bunk@fs.tum.de>
To: roque@di.fc.ul.pt, isdn4linux@listserv.isdn4linux.de
Cc: linux-kernel@vger.kernel.org, trivial@rustcorp.com.au
Subject: [2.6 patch] ISDN PCBIT: #ifdef MODULE some code
Message-ID: <20030728202500.GM25402@fs.tum.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I got the following error at the final linkage of 2.6.0-test2 if 
CONFIG_ISDN_DRV_PCBIT is compiled statically:

<--  snip  -->

...
  LD      .tmp_vmlinux1
...
drivers/built-in.o(.exit.text+0xe183): In function `pcbit_exit':
: undefined reference to `pcbit_terminate'
make: *** [.tmp_vmlinux1] Error 1

<--  snip  -->


I don't know whether the following patch is the best solution, but it 
solves the problem:

--- linux-2.6.0-test2-full-no-smp/drivers/isdn/pcbit/module.c.tmp	2003-07-28 22:03:38.000000000 +0200
+++ linux-2.6.0-test2-full-no-smp/drivers/isdn/pcbit/module.c	2003-07-28 22:08:57.000000000 +0200
@@ -82,12 +82,14 @@
 
 static void __exit pcbit_exit(void)
 {
+#ifdef MODULE
 	int board;
 
 	for (board = 0; board < num_boards; board++)
 		pcbit_terminate(board);
 	printk(KERN_NOTICE 
 	       "PCBIT-D module unloaded\n");
+#endif
 }
 
 #ifndef MODULE



cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

