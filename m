Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264931AbSKEGFk>; Tue, 5 Nov 2002 01:05:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264957AbSKEGFk>; Tue, 5 Nov 2002 01:05:40 -0500
Received: from dp.samba.org ([66.70.73.150]:49614 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id <S264931AbSKEGFh>;
	Tue, 5 Nov 2002 01:05:37 -0500
Date: Tue, 5 Nov 2002 17:10:19 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: David Miller <davem@redhat.com>, linux-kernel@vger.kernel.org,
       trivial@rustcorp.com.au
Subject: [TRIVIAL] Squash warning in net/ipv4/route.c
Message-ID: <20021105061019.GK13707@zax.zax>
Mail-Followup-To: David Gibson <david@gibson.dropbear.id.au>,
	Linus Torvalds <torvalds@transmeta.com>,
	David Miller <davem@redhat.com>, linux-kernel@vger.kernel.org,
	trivial@rustcorp.com.au
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This squashes an "implicit declaration of xfrm_init()" warning.

diff -urN /home/dgibson/kernel/linuxppc-2.5/include/net/xfrm.h linux-bluefish/include/net/xfrm.h
--- /home/dgibson/kernel/linuxppc-2.5/include/net/xfrm.h	2002-10-31 11:35:50.000000000 +1100
+++ linux-bluefish/include/net/xfrm.h	2002-11-05 16:50:33.000000000 +1100
@@ -377,6 +377,7 @@
 extern void xfrm_replay_advance(struct xfrm_state *x, u32 seq);
 extern int xfrm_check_selectors(struct xfrm_state **x, int n, struct flowi *fl);
 extern int xfrm4_rcv(struct sk_buff *skb);
+extern void xfrm_init(void);
 
 
 extern wait_queue_head_t *km_waitq;
diff -urN /home/dgibson/kernel/linuxppc-2.5/net/ipv4/route.c linux-bluefish/net/ipv4/route.c
--- /home/dgibson/kernel/linuxppc-2.5/net/ipv4/route.c	2002-10-31 11:35:50.000000000 +1100
+++ linux-bluefish/net/ipv4/route.c	2002-11-05 16:57:43.000000000 +1100
@@ -94,6 +94,7 @@
 #include <net/arp.h>
 #include <net/tcp.h>
 #include <net/icmp.h>
+#include <net/xfrm.h>
 #ifdef CONFIG_SYSCTL
 #include <linux/sysctl.h>
 #endif


-- 
David Gibson			| For every complex problem there is a
david@gibson.dropbear.id.au	| solution which is simple, neat and
				| wrong.
http://www.ozlabs.org/people/dgibson
