Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263147AbRE1Uxb>; Mon, 28 May 2001 16:53:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263144AbRE1UxV>; Mon, 28 May 2001 16:53:21 -0400
Received: from 213.237.12.194.adsl.brh.worldonline.dk ([213.237.12.194]:5715
	"HELO firewall.jaquet.dk") by vger.kernel.org with SMTP
	id <S263143AbRE1UxQ>; Mon, 28 May 2001 16:53:16 -0400
Date: Mon, 28 May 2001 22:53:05 +0200
From: Rasmus Andersen <rasmus@jaquet.dk>
To: werner@titro.de
Cc: isdn4linux@listserv.isdn4linux.de, linux-kernel@vger.kernel.org
Subject: [PATCH] make kmalloc error return unconditional in hysdn_net.c (245ac1)
Message-ID: <20010528225305.M846@jaquet.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

The patch below fixes what I believe is a bug in hysdn_net.c.
I cannot see how we can proceed under _any_ circumstances
after the kmalloc fails. Applies against 245ac1.


--- linux-245-ac1-clean/drivers/isdn/hysdn/hysdn_net.c	Sun May 27 22:15:22 2001
+++ linux-245-ac1/drivers/isdn/hysdn/hysdn_net.c	Mon May 28 22:44:16 2001
@@ -304,8 +304,7 @@
 	hysdn_net_release(card);	/* release an existing net device */
 	if ((dev = kmalloc(sizeof(struct net_local), GFP_KERNEL)) == NULL) {
 		printk(KERN_WARNING "HYSDN: unable to allocate mem\n");
-		if (card->debug_flags & LOG_NET_INIT)
-			return (-ENOMEM);
+		return (-ENOMEM);
 	}
 	memset(dev, 0, sizeof(struct net_local));	/* clean the structure */
 
-- 
Regards,
        Rasmus(rasmus@jaquet.dk)

It has just been discovered that research causes cancer in rats. 
