Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266767AbSLJVCU>; Tue, 10 Dec 2002 16:02:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266772AbSLJVCU>; Tue, 10 Dec 2002 16:02:20 -0500
Received: from natsmtp01.webmailer.de ([192.67.198.81]:25732 "EHLO
	post.webmailer.de") by vger.kernel.org with ESMTP
	id <S266767AbSLJVCT>; Tue, 10 Dec 2002 16:02:19 -0500
Content-Type: text/plain;
  charset="us-ascii"
From: Arnd Bergmann <arnd@bergmann-dalldorf.de>
To: "'Arnaldo Carvalho de Melo'" <acme@conectiva.com.br>
Subject: [PATCH] make net/ipv4/route.c compile without CONFIG_PROC_FS
Date: Tue, 10 Dec 2002 22:08:31 +0100
User-Agent: KMail/1.4.3
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-Id: <200212102208.31562.arnd@bergmann-dalldorf.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The recent cleanup of /proc/net/rt_cache broke compiling
without procfs, this makes it work again.

===== net/ipv4/route.c 1.31 vs edited =====
--- 1.31/net/ipv4/route.c       Sun Dec  8 03:45:58 2002
+++ edited/net/ipv4/route.c     Tue Dec 10 22:01:36 2002
@@ -402,6 +402,11 @@
 {
        remove_proc_entry("rt_cache", proc_net);
 }
+#else
+
+#define rt_cache_stat_get_info (get_info_t*)0
+static inline int rt_cache_proc_init(void) { return 0; }
+
 #endif /* CONFIG_PROC_FS */

 static __inline__ void rt_free(struct rtable *rt)

