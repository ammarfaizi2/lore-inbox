Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261410AbTCYDNX>; Mon, 24 Mar 2003 22:13:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261413AbTCYDNW>; Mon, 24 Mar 2003 22:13:22 -0500
Received: from supreme.pcug.org.au ([203.10.76.34]:54502 "EHLO pcug.org.au")
	by vger.kernel.org with ESMTP id <S261410AbTCYDNV>;
	Mon, 24 Mar 2003 22:13:21 -0500
Date: Tue, 25 Mar 2003 14:24:00 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: jgrimm2@us.ibm.com
Cc: LKML <linux-kernel@vger.kernel.org>,
       Trivial Kernel Patches <trivial@rustcorp.com.au>,
       "David S. Miller" <davem@redhat.com>
Subject: [PATCH] warning and unused in sctp.h
Message-Id: <20030325142400.194987b0.sfr@canb.auug.org.au>
X-Mailer: Sylpheed version 0.8.10 (GTK+ 1.2.10; i386-debian-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This patch changes a flags argument to spin_lock_irq_save to unsigned long
and removes its unused attribute.  The first gets rid of several warnings
and the second is "obviously correct" (at least according to Rusty) :-).

Thanks to DaveM for forcing me to build kernels with a 64 cross compiler :-)

-- 
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

diff -ruN 2.5.66/include/net/sctp/sctp.h 2.5.66-warnings.1/include/net/sctp/sctp.h
--- 2.5.66/include/net/sctp/sctp.h	2003-03-25 12:08:26.000000000 +1100
+++ 2.5.66-warnings.1/include/net/sctp/sctp.h	2003-03-25 14:19:04.000000000 +1100
@@ -356,7 +356,7 @@
 static inline void sctp_skb_list_tail(struct sk_buff_head *list,
 				      struct sk_buff_head *head)
 {
-	int flags __attribute__ ((unused));
+	unsigned long flags;
 
 	sctp_spin_lock_irqsave(&head->lock, flags);
 	sctp_spin_lock(&list->lock);
