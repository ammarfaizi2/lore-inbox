Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135293AbRAFXrQ>; Sat, 6 Jan 2001 18:47:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135324AbRAFXrH>; Sat, 6 Jan 2001 18:47:07 -0500
Received: from pizda.ninka.net ([216.101.162.242]:50833 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S135293AbRAFXq4>;
	Sat, 6 Jan 2001 18:46:56 -0500
Date: Sat, 6 Jan 2001 15:29:39 -0800
Message-Id: <200101062329.PAA13498@pizda.ninka.net>
From: "David S. Miller" <davem@redhat.com>
To: safemode@voicenet.com
CC: linux-kernel@vger.kernel.org
In-Reply-To: <3A573BD2.C7F7771F@voicenet.com> (message from safemode on Sat,
	06 Jan 2001 10:37:54 -0500)
Subject: Re: ip_conntrack locks up hard on 2.4.0 after about 10 hours
In-Reply-To: <3A573BD2.C7F7771F@voicenet.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   Date: 	Sat, 06 Jan 2001 10:37:54 -0500
   From: safemode <safemode@voicenet.com>

   Jan  6 06:18:10 icebox kernel: reset_xmit_timer sk=c17fd040 1
   when=0x5d9e, caller=c01a6bf1

I posted a fix for this on Linux-kernel yesterday, had you tested it
you would have seen at least this part of your problem report go away.
I'm reposting the fix for your convenience:

--- net/ipv4/tcp_input.c.~1~	Wed Dec 13 10:31:48 2000
+++ net/ipv4/tcp_input.c	Fri Jan  5 17:01:53 2001
@@ -1705,7 +1705,7 @@
 
 		if ((__s32)when < (__s32)tp->rttvar)
 			when = tp->rttvar;
-		tcp_reset_xmit_timer(sk, TCP_TIME_RETRANS, when);
+		tcp_reset_xmit_timer(sk, TCP_TIME_RETRANS, min(when, TCP_RTO_MAX));
 	}
 }
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
