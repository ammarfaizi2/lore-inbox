Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265187AbTALL34>; Sun, 12 Jan 2003 06:29:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266307AbTALL34>; Sun, 12 Jan 2003 06:29:56 -0500
Received: from tag.witbe.net ([81.88.96.48]:5139 "EHLO tag.witbe.net")
	by vger.kernel.org with ESMTP id <S265187AbTALL3z>;
	Sun, 12 Jan 2003 06:29:55 -0500
From: "Paul Rolland" <rol@as2917.net>
To: <linux-kernel@vger.kernel.org>, "'Dominik Brodowski'" <linux@brodo.de>
Cc: <rol@as2917.net>
Subject: [PATCH 2.5.56] cpufreq not compiling without /proc
Date: Sun, 12 Jan 2003 12:38:37 +0100
Message-ID: <008e01c2ba2f$25df84f0$2101a8c0@witbe>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook, Build 10.0.3416
Importance: Normal
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

This is a quick patch to ensure that functions used to create
and remove entries in /proc are not compiled in support for /proc
is not enabled.

Regards,
Paul Rolland, rol@as2917.net

--- linux-2.5.56/net/ipv4/route.c       2003-01-10 21:12:25.000000000
+0100
+++ linux-2.5.56-work/net/ipv4/route.c  2003-01-12 12:11:30.000000000
+0100
@@ -2672,12 +2672,14 @@
                                        ip_rt_gc_interval;
        add_timer(&rt_periodic_timer);
 
+#ifdef CONFIG_PROC_FS
        if (rt_cache_proc_init())
                goto out_enomem;
        proc_net_create ("rt_cache_stat", 0, rt_cache_stat_get_info);
 #ifdef CONFIG_NET_CLS_ROUTE
        create_proc_read_entry("net/rt_acct", 0, 0, ip_rt_acct_read,
NULL);
 #endif
+#endif
        xfrm_init();
 out:
        return rc;


