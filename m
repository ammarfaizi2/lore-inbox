Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129267AbRAFBIe>; Fri, 5 Jan 2001 20:08:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129383AbRAFBIX>; Fri, 5 Jan 2001 20:08:23 -0500
Received: from pizda.ninka.net ([216.101.162.242]:44425 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S129267AbRAFBID>;
	Fri, 5 Jan 2001 20:08:03 -0500
Date: Fri, 5 Jan 2001 16:49:08 -0800
Message-Id: <200101060049.QAA09715@pizda.ninka.net>
From: "David S. Miller" <davem@redhat.com>
To: misiek@pld.ORG.PL
CC: linux-kernel@vger.kernel.org
Subject: Re: reset_xmit_timer errors with 2.4.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   Date: 	Fri, 5 Jan 2001 19:22:39 +0100
   From: Arkadiusz Miskiewicz <misiek@pld.ORG.PL>

   On/Dnia Fri, Jan 05, 2001 at 06:52:52AM -0800, Patrick Michael Kane wrote
   > With 2.4.0 installed, I've started to see the following errors:
   > 
   > reset_xmit_timer sk=cfd889a0 1 when=0x3b4a, caller=c01e0748
   > reset_xmit_timer sk=cfd889a0 1 when=0x3a80, caller=c01e0748
   >

   the same problem here

Does the following patch fix this for people?

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
