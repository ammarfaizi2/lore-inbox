Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130540AbQKQDi5>; Thu, 16 Nov 2000 22:38:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129145AbQKQDis>; Thu, 16 Nov 2000 22:38:48 -0500
Received: from note.orchestra.cse.unsw.EDU.AU ([129.94.242.29]:54282 "HELO
	note.orchestra.cse.unsw.EDU.AU") by vger.kernel.org with SMTP
	id <S129314AbQKQDig>; Thu, 16 Nov 2000 22:38:36 -0500
From: Neil Brown <neilb@cse.unsw.edu.au>
To: Pete Clements <clem@clem.digital.net>
Date: Fri, 17 Nov 2000 14:08:02 +1100 (EST)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <14868.41234.444045.421346@notabene.cse.unsw.edu.au>
Cc: linux-kernel@vger.kernel.org (linux-kernel),
        Linus Torvalds <torvalds@transmeta.com>
Subject: Re: 2.4.0-test11-pre6 fails compile (dev.c)
In-Reply-To: message from Pete Clements on Thursday November 16
In-Reply-To: <200011170256.VAA10669@clem.digital.net>
X-Mailer: VM 6.72 under Emacs 20.7.2
X-face: [Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday November 16, clem@clem.digital.net wrote:
> FYI:
> 
> gcc -D__KERNEL__ -I/usr/src/linux-2.4.0-test11/include -Wall -Wstrict-prototypes -O2 -fomit-frame-pointer -fno-strict-aliasing -pipe -mpreferred-stack-boundary=2 -march=i686    -c -o dev.o dev.c
> dev.c: In function `run_sbin_hotplug':
> dev.c:2736: `hotplug_path' undeclared (first use in this function)
> dev.c:2736: (Each undeclared identifier is reported only once
> dev.c:2736: for each function it appears in.)
> make[3]: *** [dev.o] Error 1
> make[3]: Leaving directory `/sda3/usr/src/linux-2.4.0-test11/net/core'
> make[2]: *** [first_rule] Error 2
> 
> -- 
> Pete Clements 
> clem@clem.digital.net
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> Please read the FAQ at http://www.tux.org/lkml/

The following works for me.... and even looks right.

NeilBrown


--- ./init/main.c	2000/11/17 03:03:23	1.1
+++ ./init/main.c	2000/11/17 03:03:33
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
--- ./net/core/dev.c	2000/11/17 03:00:42	1.1
+++ ./net/core/dev.c	2000/11/17 03:03:53
@@ -2704,7 +2704,7 @@
 	return 0;
 }
 
-
+#ifdef CONFIG_HOTPLUG
 /* Notify userspace when a netdevice event occurs,
  * by running '/sbin/hotplug net' with certain
  * environment variables set.
@@ -2765,3 +2765,5 @@
 		printk (KERN_WARNING "unable to register netdev notifier\n"
 			KERN_WARNING "/sbin/hotplug will not be run.\n");
 }
+
+#endif
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
