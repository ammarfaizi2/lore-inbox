Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131935AbRAJUWz>; Wed, 10 Jan 2001 15:22:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132340AbRAJUWp>; Wed, 10 Jan 2001 15:22:45 -0500
Received: from [213.8.206.36] ([213.8.206.36]:4114 "EHLO callisto.yi.org")
	by vger.kernel.org with ESMTP id <S131935AbRAJUW3>;
	Wed, 10 Jan 2001 15:22:29 -0500
Date: Wed, 10 Jan 2001 22:16:44 +0200 (IST)
From: Dan Aloni <karrde@callisto.yi.org>
To: Chris Rankin <rankinc@zipworld.com.au>
cc: perex@suse.cz, linux-kernel <linux-kernel@vger.kernel.org>
Subject: [IBPATCH] Re: [PATCH] : Mark read-only ISA-PNP function parameters
 as "const"
In-Reply-To: <200101101738.f0AHciY09066@wittsend.ukgateway.net>
Message-ID: <Pine.LNX.4.21.0101102159180.27098-100000@callisto.yi.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 10 Jan 2001, Chris Rankin wrote:

> Hi,
> 
> This is an incredibly boring patch that just adds "const" to some of
> the ISA-PNP function prototypes. It compiles cleanly with gcc-2.95.2.
> 

Talking about the ISA-PNP code, this is also an Incredibly Boring Patch,
though small, it prevents unneeded exportion of some functions. I don't
even bother CC'ing it to Linus right now. I'm not sure if the AC tree
already contains it. 


--- linux/drivers/net/ppp_generic.c	Sun Dec  3 08:17:26 2000
+++ linux/drivers/net/ppp_generic.c	Wed Dec 13 20:05:45 2000
@@ -2408,7 +2408,7 @@
 	kfree(pch);
 }
 
-void __exit ppp_cleanup(void)
+static void __exit ppp_cleanup(void)
 {
 	/* should never happen */
 	if (!list_empty(&all_ppp_units) || !list_empty(&all_channels))
--- linux/drivers/net/ppp_synctty.c	Wed Dec 13 20:07:11 2000
+++ linux/drivers/net/ppp_synctty.c	Wed Dec 13 20:06:45 2000
@@ -738,7 +738,7 @@
 	}
 }
 
-void __exit
+static void __exit
 ppp_sync_cleanup(void)
 {
 	if (tty_register_ldisc(N_SYNC_PPP, NULL) != 0)
--- linux/drivers/net/ppp_async.c	Fri Apr 21 23:31:10 2000
+++ linux/drivers/net/ppp_async.c	Wed Dec 13 20:08:38 2000
@@ -965,7 +965,7 @@
 	}
 }
 
-void __exit ppp_async_cleanup(void)
+static void __exit ppp_async_cleanup(void)
 {
 	if (tty_register_ldisc(N_PPP, NULL) != 0)
 		printk(KERN_ERR "failed to unregister PPP line discipline\n");
--- linux/drivers/char/agp/agpgart_fe.c	Thu Jul 13 07:58:42 2000
+++ linux/drivers/char/agp/agpgart_fe.c	Wed Dec 13 20:11:58 2000
@@ -1105,7 +1105,7 @@
 	return 0;
 }
 
-void __exit agp_frontend_cleanup(void)
+static void __exit agp_frontend_cleanup(void)
 {
 	misc_deregister(&agp_miscdev);
 }



-- 
Dan Aloni 
dax@karrde.org

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
