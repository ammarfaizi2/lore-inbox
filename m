Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264628AbTA0WjH>; Mon, 27 Jan 2003 17:39:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264630AbTA0WjH>; Mon, 27 Jan 2003 17:39:07 -0500
Received: from pizda.ninka.net ([216.101.162.242]:62098 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S264628AbTA0WjG>;
	Mon, 27 Jan 2003 17:39:06 -0500
Date: Mon, 27 Jan 2003 14:36:25 -0800 (PST)
Message-Id: <20030127.143625.84825692.davem@redhat.com>
To: andersg@0x63.nu
Cc: lkernel2003@tuxers.net, linux-kernel@vger.kernel.org, kuznet@ms2.inr.ac.ru,
       tobi@tobi.nu
Subject: [TEST FIX] Re: SSH Hangs in 2.5.59 and 2.5.55 but not 2.4.x,
 through Cisco PIX
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <20030127182856.GE20701@h55p111.delphi.afb.lu.se>
References: <Pine.LNX.4.44.0301270920150.5267-100000@harappa.oldtrail.reston.va.us>
	<20030127.101128.104592362.davem@redhat.com>
	<20030127182856.GE20701@h55p111.delphi.afb.lu.se>
X-FalunGong: Information control.
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hey guys, can you all see if this patch makes the problem go away in
2.5.x?  It is merely a guess, but it is worth enough to experiment.

Alexey, this piece of code was buggy first time it was coded, and it
may still have some holes. :-)))

--- net/ipv4/tcp_output.c.~1~	Mon Jan 27 14:45:49 2003
+++ net/ipv4/tcp_output.c	Mon Jan 27 14:46:33 2003
@@ -889,7 +889,7 @@
 	if (atomic_read(&sk->wmem_alloc) > min(sk->wmem_queued+(sk->wmem_queued>>2),sk->sndbuf))
 		return -EAGAIN;
 
-	if (before(TCP_SKB_CB(skb)->seq, tp->snd_una)) {
+	if (0 && before(TCP_SKB_CB(skb)->seq, tp->snd_una)) {
 		if (before(TCP_SKB_CB(skb)->end_seq, tp->snd_una))
 			BUG();
 
