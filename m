Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129030AbQJ3NZg>; Mon, 30 Oct 2000 08:25:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129131AbQJ3NZ0>; Mon, 30 Oct 2000 08:25:26 -0500
Received: from cx425802-a.blvue1.ne.home.com ([24.0.54.216]:60420 "EHLO
	wr5z.localdomain") by vger.kernel.org with ESMTP id <S129030AbQJ3NZP>;
	Mon, 30 Oct 2000 08:25:15 -0500
Date: Mon, 30 Oct 2000 07:24:53 -0600 (CST)
From: Thomas Molina <tmolina@home.com>
To: torvalds@transmeta.com
cc: linux-kernel@vger.kernel.org
Subject: dropping untracked packets patch for 2.4 (fwd)
Message-ID: <Pine.LNX.4.21.0010300714300.1445-100000@wr5z.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,
Rusty Russell suggested I send the following patch to you.  It redirects
to the log file those annoying dropping untracked packet messages.  This
patch works agains any recent 2.4.0-test kernels.

diff -urN linux.new1/net/ipv4/netfilter/ip_nat_standalone.c linux.new/net/ipv4/netfilter/ip_nat_standalone.c
--- linux.new1/net/ipv4/netfilter/ip_nat_standalone.c	Sun Oct 22 15:19:07 2000
+++ linux/net/ipv4/netfilter/ip_nat_standalone.c	Sun Oct 22 13:37:44 2000
@@ -72,7 +72,7 @@
            unreliable. */
 	if (!ct) {
 		if (net_ratelimit())
-			printk("NAT: %u dropping untracked packet %p %u %u.%u.%u.%u -> %u.%u.%u.%u\n",
+			printk(KERN_DEBUG "NAT: %u dropping untracked packet %p %u %u.%u.%u.%u -> %u.%u.%u.%u\n",
 			       hooknum,
 			       *pskb,
 			       (*pskb)->nh.iph->protocol,
 

---------- Forwarded message ----------
Date: Mon, 30 Oct 2000 15:50:18 +1100
From: Rusty Russell <rusty@linuxcare.com.au>
To: Thomas Molina <tmolina@home.com>
Subject: Re: Three kernel messages 

In message <Pine.LNX.4.21.0010230959520.2837-100000@wr5z.localdomain> you write
:
> I finally got tired of seeing these messages.  Win98 boxes on my lan
> spew these each time they are booted and corrupt whatever virtual
> console I'm on.  The following workaround sends these messages to
> /var/log/messages.  Patch is against 2.4.0-test10-pre4, but should apply
> to recent kernels.

Thanks: please change to KERN_DEBUG and send to Linus...

Cheers,
Rusty.
--
Hacking time.

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
