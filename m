Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318562AbSIBX1s>; Mon, 2 Sep 2002 19:27:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318572AbSIBX1s>; Mon, 2 Sep 2002 19:27:48 -0400
Received: from pizda.ninka.net ([216.101.162.242]:28367 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S318562AbSIBX1r>;
	Mon, 2 Sep 2002 19:27:47 -0400
Date: Mon, 02 Sep 2002 16:25:42 -0700 (PDT)
Message-Id: <20020902.162542.95902127.davem@redhat.com>
To: cs@pixelwings.com
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.5.33 compile error in ipv6
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <Pine.LNX.4.44.0209021304590.2696-100000@lynx.piwi.intern>
References: <Pine.LNX.4.44.0209021304590.2696-100000@lynx.piwi.intern>
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Clemens Schwaighofer <cs@pixelwings.com>
   Date: Mon, 2 Sep 2002 13:06:13 +0200 (CEST)
   
   I saw no patch in ML yet for this ...

Actually, there was, lines 666 and 667 of net/ipv6/af_inet6.c
should read:

                printk(KERN_CRIT "%s: Can't create protocol sock SLAB "
                       "caches!\n", __FUNCTION__);

Here is the patch against 2.5.33 that James Morris posted.

diff -Nru a/net/ipv6/af_inet6.c b/net/ipv6/af_inet6.c
--- a/net/ipv6/af_inet6.c       Mon Sep  2 16:28:13 2002
+++ b/net/ipv6/af_inet6.c       Mon Sep  2 16:28:13 2002
@@ -663,8 +663,8 @@
                                           sizeof(struct raw6_sock), 0,
                                            SLAB_HWCACHE_ALIGN, 0, 0);
         if (!tcp6_sk_cachep || !udp6_sk_cachep || !raw6_sk_cachep)
-                printk(KERN_CRIT __FUNCTION__
-                        ": Can't create protocol sock SLAB caches!\n");
+                printk(KERN_CRIT "%s: Can't create protocol sock SLAB "
+                      "caches!\n", __FUNCTION__);

        /* Register the socket-side information for inet6_create.  */
        for(r = &inetsw6[0]; r < &inetsw6[SOCK_MAX]; ++r)
