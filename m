Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132099AbQKQMWG>; Fri, 17 Nov 2000 07:22:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132004AbQKQMV5>; Fri, 17 Nov 2000 07:21:57 -0500
Received: from 62-6-231-42.btconnect.com ([62.6.231.42]:46474 "EHLO
	saturn.homenet") by vger.kernel.org with ESMTP id <S132099AbQKQMVs>;
	Fri, 17 Nov 2000 07:21:48 -0500
Date: Fri, 17 Nov 2000 11:51:03 +0000 (GMT)
From: Tigran Aivazian <tigran@veritas.com>
To: Linus Torvalds <torvalds@transmeta.com>
cc: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [patch] hotplug fixes Re: test11-pre6
In-Reply-To: <Pine.LNX.4.10.10011161832460.803-100000@penguin.transmeta.com>
Message-ID: <Pine.LNX.4.21.0011171148310.8176-100000@saturn.homenet>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 16 Nov 2000, Linus Torvalds wrote:

> 
> The log-file says it all..
> 
> 		Linus

No, I am sorry but it does not mention hotplug things in net/core/dev.c
and they are broken. The fix below.

Regards,
Tigran

diff -urN -X dontdiff linux/init/main.c work/init/main.c
--- linux/init/main.c	Fri Nov 17 10:29:34 2000
+++ work/init/main.c	Fri Nov 17 11:27:27 2000
@@ -712,11 +712,13 @@
 	init_pcmcia_ds();		/* Do this last */
 #endif
 
+#ifdef CONFIG_HOTPLUG
 	/* do this after other 'do this last' stuff, because we want
 	 * to minimize spurious executions of /sbin/hotplug
 	 * during boot-up
 	 */
 	net_notifier_init();
+#endif
 
 	/* Mount the root filesystem.. */
 	mount_root();
diff -urN -X dontdiff linux/net/core/dev.c work/net/core/dev.c
--- linux/net/core/dev.c	Fri Nov 17 10:29:34 2000
+++ work/net/core/dev.c	Fri Nov 17 11:27:15 2000
@@ -2704,6 +2704,7 @@
 	return 0;
 }
 
+#ifdef CONFIG_HOTPLUG
 
 /* Notify userspace when a netdevice event occurs,
  * by running '/sbin/hotplug net' with certain
@@ -2765,3 +2766,4 @@
 		printk (KERN_WARNING "unable to register netdev notifier\n"
 			KERN_WARNING "/sbin/hotplug will not be run.\n");
 }
+#endif


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
