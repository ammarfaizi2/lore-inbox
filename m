Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262569AbUAMABH (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Jan 2004 19:01:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262580AbUAMABH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Jan 2004 19:01:07 -0500
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:58067 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id S262569AbUAMABE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Jan 2004 19:01:04 -0500
Date: Tue, 13 Jan 2004 01:00:56 +0100
From: Adrian Bunk <bunk@fs.tum.de>
To: linux-kernel@vger.kernel.org
Subject: [2.6 patch] fix a drivers/char/isicom.c compile warning
Message-ID: <20040113000055.GU9677@fs.tum.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I got the following compile warning in 2.6.1-mm2 (but it doesn't seem to 
be specific to -mm):


<--  snip  -->

...
  CC [M]  drivers/char/isicom.o
...
drivers/char/isicom.c: In function `unregister_drivers':
drivers/char/isicom.c:1677: warning: `error' might be used uninitialized in this function
...

<--  snip  -->


The following patch fixes this issue:


--- linux-2.6.1-mm2-modular-no-smp/drivers/char/isicom.c.old	2004-01-13 00:40:02.000000000 +0100
+++ linux-2.6.1-mm2-modular-no-smp/drivers/char/isicom.c	2004-01-13 00:49:00.000000000 +0100
@@ -1675,7 +1675,7 @@
 static void unregister_drivers(void)
 {
 	int error;
-	if (tty_unregister_driver(isicom_normal))
+	if ((error=tty_unregister_driver(isicom_normal)))
 		printk(KERN_DEBUG "ISICOM: couldn't unregister normal driver error=%d.\n",error);
 	put_tty_driver(isicom_normal);
 }



cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

