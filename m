Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271883AbTHHUSn (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Aug 2003 16:18:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271890AbTHHUSn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Aug 2003 16:18:43 -0400
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:52963 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id S271883AbTHHUSj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Aug 2003 16:18:39 -0400
Date: Fri, 8 Aug 2003 22:18:23 +0200
From: Adrian Bunk <bunk@fs.tum.de>
To: linux@syskonnect.de
Cc: linux-net@vger.kernel.org, linux-kernel@vger.kernel.org,
       trivial@rustcorp.com.au
Subject: [2.6 patch] fix net/sk98lin/skge.c for !PROC_FS
Message-ID: <20030808201823.GE16091@fs.tum.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I got the following compile error compiling 2.6.0-test2-mm5 with 
!CONFIG_PROC_FS:

<--  snip  -->

...
  CC      drivers/net/sk98lin/skge.o
...
drivers/net/sk98lin/skge.c:730: error: `proc_net' undeclared (first use 
in this function)
drivers/net/sk98lin/skge.c:730: error: (Each undeclared identifier is 
reported only once
drivers/net/sk98lin/skge.c:730: error: for each function it appears in.)
make[3]: *** [drivers/net/sk98lin/skge.o] Error 1

<--  snip  -->

The following patch fixes it:

--- linux-2.6.0-test2-mm5/drivers/net/sk98lin/skge.c.old	2003-08-08 20:24:50.000000000 +0200
+++ linux-2.6.0-test2-mm5/drivers/net/sk98lin/skge.c	2003-08-08 20:25:22.000000000 +0200
@@ -724,6 +724,7 @@
 			SK_MEMCPY(&SK_Root_Dir_entry, BootString,
 				sizeof(SK_Root_Dir_entry) - 1);
 
+#ifdef CONFIG_PROC_FS
 			/*Create proc (directory)*/
 			if(!proc_root_initialized) {
 				pSkRootDir = create_proc_entry(SK_Root_Dir_entry,
@@ -731,6 +732,7 @@
 				pSkRootDir->owner = THIS_MODULE;
 				proc_root_initialized = 1;
 			}
+#endif  /*  CONFIG_PROC_FS  */
 
 		}
 


Please apply
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

