Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277544AbRJJXrD>; Wed, 10 Oct 2001 19:47:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277541AbRJJXqw>; Wed, 10 Oct 2001 19:46:52 -0400
Received: from cerebus.wirex.com ([65.102.14.138]:16636 "EHLO
	figure1.int.wirex.com") by vger.kernel.org with ESMTP
	id <S277540AbRJJXqi>; Wed, 10 Oct 2001 19:46:38 -0400
Date: Wed, 10 Oct 2001 16:44:30 -0700
From: Chris Wright <chris@wirex.com>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] 2.4.11 min() in tcp.c
Message-ID: <20011010164430.B19995@figure1.int.wirex.com>
Mail-Followup-To: Linus Torvalds <torvalds@transmeta.com>,
	linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

compiling 2.4.11 gives the following warning.

tcp.c:855: warning: comparison of distinct pointer types lacks a cast

the following patch, changes min() to min_t() to make size_t explicit.

thanks,
-chris

--- linux-2.4.11/net/ipv4/tcp.c	Mon Oct  1 09:19:57 2001
+++ linux-2.4.11-min/net/ipv4/tcp.c	Wed Oct 10 16:42:55 2001
@@ -852,7 +852,7 @@
 
 		page = pages[poffset/PAGE_SIZE];
 		offset = poffset % PAGE_SIZE;
-		size = min(psize, PAGE_SIZE-offset);
+		size = min_t (size_t, psize, PAGE_SIZE-offset);
 
 		if (tp->send_head==NULL || (copy = mss_now - skb->len) <= 0) {
 new_segment:
