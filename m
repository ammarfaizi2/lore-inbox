Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132380AbQLHVMX>; Fri, 8 Dec 2000 16:12:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132610AbQLHVMN>; Fri, 8 Dec 2000 16:12:13 -0500
Received: from 213.237.12.194.adsl.brh.worldonline.dk ([213.237.12.194]:55661
	"HELO firewall.jaquet.dk") by vger.kernel.org with SMTP
	id <S132380AbQLHVL7>; Fri, 8 Dec 2000 16:11:59 -0500
Date: Fri, 8 Dec 2000 21:41:24 +0100
From: Rasmus Andersen <rasmus@jaquet.dk>
To: tytso@mit.edu
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] remove warning from drivers/char/random.c
Message-ID: <20001208214124.H599@jaquet.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

The following patch makes a 'defined but not used' warning go away
when compiling drivers/char/random.c without sysctl support (240t12p3). 
(but should apply cleanly). I am aware that there is a sysctl section 
of this code, but the function seems to belong where it is. I would be
happy to move free_entropy_store to this section if you think this 
is cleaner.


--- linux-240-t12-pre3-clean/drivers/char/random.c	Wed Nov 22 22:41:39 2000
+++ linux/drivers/char/random.c	Wed Nov 29 18:25:31 2000
@@ -527,12 +527,14 @@
 	memset(r->pool, 0, r->poolinfo.poolwords*4);
 }
 
+#ifdef CONFIG_SYSCTL
 static void free_entropy_store(struct entropy_store *r)
 {
 	if (r->pool)
 		kfree(r->pool);
 	kfree(r);
 }
+#endif
 
 /*
  * This function adds a byte into the entropy "pool".  It does not

-- 
Regards,
        Rasmus(rasmus@jaquet.dk)

I have a very small mind and must live with it. -- E. Dijkstra 
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
