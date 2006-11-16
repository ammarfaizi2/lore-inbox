Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1162269AbWKPCty@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1162269AbWKPCty (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Nov 2006 21:49:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1162264AbWKPCse
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Nov 2006 21:48:34 -0500
Received: from 216-99-217-87.dsl.aracnet.com ([216.99.217.87]:24200 "EHLO
	sous-sol.org") by vger.kernel.org with ESMTP id S1162256AbWKPCs1
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Nov 2006 21:48:27 -0500
Message-Id: <20061116024720.765249000@sous-sol.org>
References: <20061116024332.124753000@sous-sol.org>
User-Agent: quilt/0.45-1
Date: Wed, 15 Nov 2006 18:43:50 -0800
From: Chris Wright <chrisw@sous-sol.org>
To: linux-kernel@vger.kernel.org, stable@kernel.org
Cc: Justin Forbes <jmforbes@linuxtx.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       "Theodore Ts'o" <tytso@mit.edu>, Randy Dunlap <rdunlap@xenotime.net>,
       Dave Jones <davej@redhat.com>, Chuck Wolber <chuckw@quantumlinux.com>,
       Chris Wedgwood <reviews@ml.cw.f00f.org>,
       Michael Krufky <mkrufky@linuxtv.org>, torvalds@osdl.org, akpm@osdl.org,
       alan@lxorguk.ukuu.org.uk, David Miller <davem@davemloft.net>,
       bunk@stusta.de, John Heffner <jheffner@psc.edu>
Subject: [patch 18/30] TCP: Dont use highmem in tcp hash size calculation.
Content-Disposition: inline; filename=tcp-don-t-use-highmem-in-tcp-hash-size-calculation.patch
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-stable review patch.  If anyone has any objections, please let us know.
------------------

From: John Heffner <jheffner@psc.edu>

 
This patch removes consideration of high memory when determining TCP
hash table sizes.  Taking into account high memory results in tcp_mem
values that are too large.

Signed-off-by: John Heffner <jheffner@psc.edu>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Chris Wright <chrisw@sous-sol.org>
---

---
 net/ipv4/tcp.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- linux-2.6.18.2.orig/net/ipv4/tcp.c
+++ linux-2.6.18.2/net/ipv4/tcp.c
@@ -2269,7 +2269,7 @@ void __init tcp_init(void)
 					thash_entries,
 					(num_physpages >= 128 * 1024) ?
 					13 : 15,
-					HASH_HIGHMEM,
+					0,
 					&tcp_hashinfo.ehash_size,
 					NULL,
 					0);
@@ -2285,7 +2285,7 @@ void __init tcp_init(void)
 					tcp_hashinfo.ehash_size,
 					(num_physpages >= 128 * 1024) ?
 					13 : 15,
-					HASH_HIGHMEM,
+					0,
 					&tcp_hashinfo.bhash_size,
 					NULL,
 					64 * 1024);

--
