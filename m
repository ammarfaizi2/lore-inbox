Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267365AbTALLKN>; Sun, 12 Jan 2003 06:10:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267423AbTALLKN>; Sun, 12 Jan 2003 06:10:13 -0500
Received: from tag.witbe.net ([81.88.96.48]:33042 "EHLO tag.witbe.net")
	by vger.kernel.org with ESMTP id <S267365AbTALLKM>;
	Sun, 12 Jan 2003 06:10:12 -0500
From: "Paul Rolland" <rol@witbe.net>
To: <davem@redhat.com>, <kuznet@ms2.inr.ac.ru>, <linux-kernel@vger.kernel.org>
Cc: <rol@as2917.net>
Subject: [PATCH 2.5.56] net/ipv4/route.c doesn't compile without /proc support
Date: Sun, 12 Jan 2003 12:18:26 +0100
Organization: Witbe.net
Message-ID: <008c01c2ba2c$5452e000$2101a8c0@witbe>
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

Here is a quick patch to allow correct compile of net/ipv4/route.c
when not using /proc support.

Without it, some attempts to create entries in /proc are resulting
in invoking functions that are protected by #ifdef CONFIG_PROC_FS...

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

