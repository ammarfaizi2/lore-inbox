Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268798AbUHLVbf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268798AbUHLVbf (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Aug 2004 17:31:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268811AbUHLV27
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Aug 2004 17:28:59 -0400
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:58594 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id S268812AbUHLV0s (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Aug 2004 17:26:48 -0400
Date: Thu, 12 Aug 2004 23:26:39 +0200
From: Adrian Bunk <bunk@fs.tum.de>
To: James.Bottomley@SteelEye.com
Cc: linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [2.6 patch] fix NCR53C9x.c compile warning (fwd)
Message-ID: <20040812212639.GP13377@fs.tum.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


The trivial patch forwarded below still applies and compiles against 
2.6.8-rc4-mm1.

Please apply.


----- Forwarded message from Adrian Bunk <bunk@fs.tum.de> -----

Date:	Sat, 20 Dec 2003 00:13:21 +0100
From: Adrian Bunk <bunk@fs.tum.de>
To: James.Bottomley@SteelEye.com, linux-scsi@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Subject: [2.6 patch] fix NCR53C9x.c compile warning

I got the following compile warning in 2.6.0-test11-mm1:

<--  snip  -->

...
  CC [M]  drivers/scsi/NCR53C9x.o
drivers/scsi/NCR53C9x.c: In function `esp_do_data':
drivers/scsi/NCR53C9x.c:1838: warning: unused variable `flags'
...

<--  snip  -->


The following patch fixes this warning:


Signed-off-by: Adrian Bunk <bunk@fs.tum.de>

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

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/

----- End forwarded message -----

