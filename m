Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129327AbQJ1QTM>; Sat, 28 Oct 2000 12:19:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130236AbQJ1QTA>; Sat, 28 Oct 2000 12:19:00 -0400
Received: from isis.its.uow.edu.au ([130.130.68.21]:18884 "EHLO
	isis.its.uow.edu.au") by vger.kernel.org with ESMTP
	id <S129327AbQJ1QSu>; Sat, 28 Oct 2000 12:18:50 -0400
Message-ID: <39FAFC63.EDD4A767@uow.edu.au>
Date: Sun, 29 Oct 2000 03:18:43 +1100
From: Andrew Morton <andrewm@uow.edu.au>
X-Mailer: Mozilla 4.7 [en] (X11; I; Linux 2.4.0-test8 i586)
X-Accept-Language: en
MIME-Version: 1.0
To: "Stephen E. Clark" <sclark46@gte.net>
CC: lk <linux-kernel@vger.kernel.org>, "David S. Miller" <davem@redhat.com>
Subject: Re: RTNL assert
In-Reply-To: <39FA4968.62588272@gte.net> <39FAAFF2.200E1860@uow.edu.au> <39FADF38.9CA09B1A@gte.net>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Stephen E. Clark" wrote:
> 
> I also get the same error if I try to configure in normal IPV4
> tunneling. I guess it needs the same kind of patch.

Yep.

--- linux-2.4.0-test10-pre5/net/ipv4/ipip.c	Sat Sep  9 16:19:30 2000
+++ linux-akpm/net/ipv4/ipip.c	Sun Oct 29 03:17:38 2000
@@ -894,7 +894,9 @@
 #ifdef MODULE
 	register_netdev(&ipip_fb_tunnel_dev);
 #else
+	rtnl_lock();
 	register_netdevice(&ipip_fb_tunnel_dev);
+	rtnl_unlock();
 #endif
 
 	inet_add_protocol(&ipip_protocol);
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
