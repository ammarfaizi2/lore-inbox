Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261881AbRFWNWh>; Sat, 23 Jun 2001 09:22:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263931AbRFWNW1>; Sat, 23 Jun 2001 09:22:27 -0400
Received: from 213.237.12.194.adsl.brh.worldonline.dk ([213.237.12.194]:33854
	"HELO firewall.jaquet.dk") by vger.kernel.org with SMTP
	id <S261881AbRFWNWL>; Sat, 23 Jun 2001 09:22:11 -0400
Date: Sat, 23 Jun 2001 15:22:02 +0200
From: Rasmus Andersen <rasmus@jaquet.dk>
To: dhinds@zen.stanford.edu
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] add kmalloc check in drviers/pcmcia/rsrc_mgr.c (245-ac16)
Message-ID: <20010623152202.B840@jaquet.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

The patch below adds a kmalloc check to drivers/pcmcmia/rsrc_mgr.c.
Against 245-ac16 but aplies to 256p6 also. Reported a while back 
by the stanford team.


--- linux-245-ac16-clean/drivers/pcmcia/rsrc_mgr.c	Sat May 19 20:59:21 2001
+++ linux-245-ac16/drivers/pcmcia/rsrc_mgr.c	Sat Jun 23 15:06:54 2001
@@ -189,6 +189,11 @@
     
     /* First, what does a floating port look like? */
     b = kmalloc(256, GFP_KERNEL);
+    if (!b) {
+	printk(" -- aborting.\n");
+	printk(KERN_ERR "Out of memory.");
+	return;
+    }
     memset(b, 0, 256);
     for (i = base, most = 0; i < base+num; i += 8) {
 	if (check_io_resource(i, 8))
-- 
Regards,
        Rasmus(rasmus@jaquet.dk)

"The obvious mathematical breakthrough would be development of an easy way
to factor large prime numbers." 
  -- Bill Gates, The Road Ahead, Viking Penguin (1995)
