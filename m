Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263711AbTLSXNc (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 Dec 2003 18:13:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263698AbTLSXNc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Dec 2003 18:13:32 -0500
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:18418 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id S263711AbTLSXN3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Dec 2003 18:13:29 -0500
Date: Sat, 20 Dec 2003 00:13:21 +0100
From: Adrian Bunk <bunk@fs.tum.de>
To: James.Bottomley@SteelEye.com, linux-scsi@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Subject: [2.6 patch] fix NCR53C9x.c compile warning
Message-ID: <20031219231321.GA12750@fs.tum.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I got the following compile warning in 2.6.0-test11-mm1:

<--  snip  -->

...
  CC [M]  drivers/scsi/NCR53C9x.o
drivers/scsi/NCR53C9x.c: In function `esp_do_data':
drivers/scsi/NCR53C9x.c:1838: warning: unused variable `flags'
...

<--  snip  -->


The following patch fixes this warning:


--- linux-2.6.0-test11-mm1-modular-no-smp/drivers/scsi/NCR53C9x.c.old	2003-12-19 23:26:15.000000000 +0100
+++ linux-2.6.0-test11-mm1-modular-no-smp/drivers/scsi/NCR53C9x.c	2003-12-19 23:27:10.000000000 +0100
@@ -1835,7 +1835,10 @@
 		/* loop */
 		while (hmuch) {
 			int j, fifo_stuck = 0, newphase;
-			unsigned long flags, timeout;
+			unsigned long timeout;
+#if 0
+			unsigned long flags;
+#endif
 #if 0
 			if ( i % 10 )
 				ESPDATA(("\r"));



Please apply
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

