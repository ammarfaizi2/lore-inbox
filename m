Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261855AbTAQWOq>; Fri, 17 Jan 2003 17:14:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261857AbTAQWOq>; Fri, 17 Jan 2003 17:14:46 -0500
Received: from dp.samba.org ([66.70.73.150]:17638 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id <S261855AbTAQWOp>;
	Fri, 17 Jan 2003 17:14:45 -0500
From: Paul Mackerras <paulus@samba.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15912.33206.305816.56149@argo.ozlabs.ibm.com>
Date: Sat, 18 Jan 2003 09:20:38 +1100
To: davem@redhat.com
Cc: Patrick McHardy <kaber@trash.net>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH]: PPP_FILTER outbound only drops with debugging enables
In-Reply-To: <3E27F79F.2090705@trash.net>
References: <3E27F79F.2090705@trash.net>
X-Mailer: VM 7.07 under Emacs 20.7.2
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dave,

This patch looks obviously correct, please send it on to Linus.

Paul.

Patrick McHardy writes:
> Hi.
> 
> Packets in ppp_send_frame catched by pass_filter are only dropped if 
> debuging is enabled:

[snip]

--- linux-2.4.20/drivers/net/ppp_generic.c.orig	2003-01-17 13:15:32.000000000 +0100
+++ linux-2.4.20/drivers/net/ppp_generic.c	2003-01-17 13:16:23.000000000 +0100
@@ -965,11 +965,10 @@
 		if (ppp->pass_filter.filter
 		    && sk_run_filter(skb, ppp->pass_filter.filter,
 				     ppp->pass_filter.len) == 0) {
-			if (ppp->debug & 1) {
+			if (ppp->debug & 1)
 				printk(KERN_DEBUG "PPP: outbound frame not passed\n");
-				kfree_skb(skb);
-				return;
-			}
+			kfree_skb(skb);
+			return;
 		}
 		/* if this packet passes the active filter, record the time */
 		if (!(ppp->active_filter.filter
