Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265838AbTL3Qbn (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Dec 2003 11:31:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265839AbTL3Qbn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Dec 2003 11:31:43 -0500
Received: from mx1.elte.hu ([157.181.1.137]:51367 "EHLO mx1.elte.hu")
	by vger.kernel.org with ESMTP id S265838AbTL3Qbl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Dec 2003 11:31:41 -0500
Date: Tue, 30 Dec 2003 17:32:30 +0100
From: Ingo Molnar <mingo@elte.hu>
To: "David S. Miller" <davem@redhat.com>
Cc: linux-kernel@vger.kernel.org, netdev@oss.sgi.com
Subject: [patch] clean up tcp_sk(), 2.6.0
Message-ID: <20031230163230.GA12553@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
X-ELTE-SpamVersion: SpamAssassin ELTE 1.0
X-ELTE-VirusStatus: clean
X-ELTE-SpamCheck: no
X-ELTE-SpamCheck-Details: score=-4.9, required 5.9,
	BAYES_00 -4.90
X-ELTE-SpamLevel: 
X-ELTE-SpamScore: -4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


i recently wasted a few hours on a bug where i used "tcp_sk(sock)"
instead of "tcp_sk(sock->sk)" - the former, while being blatantly
incorrect, compiles just fine on 2.6.0. The patch below is equivalent to
the define but is also type-safe. Compiles cleanly & boots fine on
2.6.0.

	Ingo

--- linux/include/linux/tcp.h.orig
+++ linux/include/linux/tcp.h
@@ -386,7 +386,10 @@ struct tcp_sock {
 	struct tcp_opt	  tcp;
 };
 
-#define tcp_sk(__sk) (&((struct tcp_sock *)__sk)->tcp)
+static inline struct tcp_opt * tcp_sk(const struct sock *__sk)
+{
+	return &((struct tcp_sock *)__sk)->tcp;
+}
 
 #endif
 
