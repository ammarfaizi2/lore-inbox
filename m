Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129489AbRBQU35>; Sat, 17 Feb 2001 15:29:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131420AbRBQU3q>; Sat, 17 Feb 2001 15:29:46 -0500
Received: from minus.inr.ac.ru ([193.233.7.97]:47117 "HELO ms2.inr.ac.ru")
	by vger.kernel.org with SMTP id <S129489AbRBQU3c>;
	Sat, 17 Feb 2001 15:29:32 -0500
From: kuznet@ms2.inr.ac.ru
Message-Id: <200102172029.XAA28904@ms2.inr.ac.ru>
Subject: Re: SO_SNDTIMEO: 2.4 kernel bugs
To: chris@scary.beasts.org (Chris Evans)
Date: Sat, 17 Feb 2001 23:29:14 +0300 (MSK)
Cc: linux-kernel@vger.kernel.org, davem@redhat.com
In-Reply-To: <Pine.LNX.4.30.0102170126130.21158-100000@ferret.lmh.ox.ac.uk> from "Chris Evans" at Feb 17, 1 01:35:15 am
X-Mailer: ELM [version 2.4 PL24]
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

> Unfortunately, it seems to be very buggy. Here are two buggy scenarios.


--- ../vger3-010210/linux/net/ipv4/tcp.c	Sat Feb 10 23:16:51 2001
+++ linux/net/ipv4/tcp.c	Sat Feb 17 23:27:43 2001
@@ -691,6 +691,8 @@
 
 		set_current_state(TASK_INTERRUPTIBLE);
 
+		if (!timeo)
+			break;
 		if (signal_pending(current))
 			break;
 		if (tcp_memory_free(sk) && !vm_wait)
--- ../vger3-010210/linux/net/core/sock.c	Tue Jan 30 21:20:16 2001
+++ linux/net/core/sock.c	Sat Feb 17 23:27:44 2001
@@ -727,6 +727,8 @@
 	clear_bit(SOCK_ASYNC_NOSPACE, &sk->socket->flags);
 	add_wait_queue(sk->sleep, &wait);
 	for (;;) {
+		if (!timeo)
+			break;
 		if (signal_pending(current))
 			break;
 		set_bit(SOCK_NOSPACE, &sk->socket->flags);
