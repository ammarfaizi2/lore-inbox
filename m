Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262662AbSJTHTs>; Sun, 20 Oct 2002 03:19:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262667AbSJTHTr>; Sun, 20 Oct 2002 03:19:47 -0400
Received: from rth.ninka.net ([216.101.162.244]:42631 "EHLO rth.ninka.net")
	by vger.kernel.org with ESMTP id <S262662AbSJTHTq>;
	Sun, 20 Oct 2002 03:19:46 -0400
Subject: Re: [PATCH] 2.5.44: net/ipv4/ip_proc.c compile error fix for AX25
	enabled
From: "David S. Miller" <davem@rth.ninka.net>
To: dd8ne@bnv-bamberg.de
Cc: linux-kernel@vger.kernel.org, ralf@linux-mips.org.linux-hams,
       acme@conectiva.com.br
In-Reply-To: <200210200648.g9K6mkD05952@dd8ne.ampr.org>
References: <200210200648.g9K6mkD05952@dd8ne.ampr.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 20 Oct 2002 00:36:39 -0700
Message-Id: <1035099399.4137.7.camel@rth.ninka.net>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2002-10-19 at 23:48, Hans-Joachim Hetscher wrote:
> ip_proc.c does't compile for CONFIG_AX25.
> 
> Here the patch ...

This points out another problem, that it doesn't handle
CONFIG_AX25_MODULE either.

I've fixed all of this in my tree as follows:

# This is a BitKeeper generated patch for the following project:
# Project Name: Linux kernel tree
# This patch format is intended for GNU patch command version 2.5 or higher.
# This patch includes the following deltas:
#	           ChangeSet	1.812   -> 1.813  
#	  net/ipv4/ip_proc.c	1.10    -> 1.11   
#
# The following is the BitKeeper ChangeSet Log
# --------------------------------------------
# 02/10/20	davem@nuts.ninka.net	1.813
# net/ipv4/ip_proc.c: Include linux/ax25.h and handle modular AX25.
# --------------------------------------------
#
diff -Nru a/net/ipv4/ip_proc.c b/net/ipv4/ip_proc.c
--- a/net/ipv4/ip_proc.c	Sun Oct 20 00:20:53 2002
+++ b/net/ipv4/ip_proc.c	Sun Oct 20 00:20:53 2002
@@ -31,7 +31,9 @@
 extern int tcp_get_info(char *, char **, off_t, int);
 
 #ifdef CONFIG_PROC_FS
-#ifdef CONFIG_AX25
+#if defined(CONFIG_AX25) || defined(CONFIG_AX25_MODULE)
+
+#include <linux/ax25.h>
 
 /* ------------------------------------------------------------------------ */
 /*
@@ -64,7 +66,7 @@
 	return buf;
 
 }
-#endif /* CONFIG_AX25 */
+#endif /* CONFIG_AX25 || CONFIG_AX25_MODULE */
 
 struct arp_iter_state {
 	int is_pneigh, bucket;
@@ -196,7 +198,7 @@
 
 	read_lock(&n->lock);
 	/* Convert hardware address to XX:XX:XX:XX ... form. */
-#ifdef CONFIG_AX25
+#if defined(CONFIG_AX25) || defined(CONFIG_AX25_MODULE)
 	if (hatype == ARPHRD_AX25 || hatype == ARPHRD_NETROM)
 		ax2asc2((ax25_address *)n->ha, hbuffer);
 	else {
@@ -207,7 +209,7 @@
 		hbuffer[k++] = ':';
 	}
 	hbuffer[--k] = 0;
-#ifdef CONFIG_AX25
+#if defined(CONFIG_AX25) || defined(CONFIG_AX25_MODULE)
 	}
 #endif
 	sprintf(tbuf, "%u.%u.%u.%u", NIPQUAD(*(u32*)n->primary_key));
