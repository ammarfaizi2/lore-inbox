Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280674AbRKSTxs>; Mon, 19 Nov 2001 14:53:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280676AbRKSTxk>; Mon, 19 Nov 2001 14:53:40 -0500
Received: from amsfep14-int.chello.nl ([213.46.243.21]:19554 "EHLO
	amsfep14-int.chello.nl") by vger.kernel.org with ESMTP
	id <S280674AbRKSTxY>; Mon, 19 Nov 2001 14:53:24 -0500
Date: Mon, 19 Nov 2001 20:53:16 +0100
From: Jeroen Vreeken <pe1rxq@amsat.org>
To: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] bug in sock.c
Message-ID: <20011119205316.I604@jeroen.pe1rxq.ampr.org>
In-Reply-To: <20011119181106.A604@jeroen.pe1rxq.ampr.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
In-Reply-To: <20011119181106.A604@jeroen.pe1rxq.ampr.org>; from pe1rxq@amsat.org on Mon, Nov 19, 2001 at 18:11:07 +0100
X-Mailer: Balsa 1.1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch is so popular that some people requested it again but this time
inline :)

So here it is again:

--- linux-2.4.13/net/core/sock.c        Fri Nov 15 21:12:38 2001
+++ linux/net/core/sock.c       Fri Nov 16 20:53:55 2001
@@ -81,6 +81,7 @@
  *             Andi Kleen      :       Fix write_space callback
  *             Chris Evans     :       Security fixes - signedness again
  *             Arnaldo C. Melo :       cleanups, use skb_queue_purge
+ *             Jeroen Vreeken  :       Add check for sk->dead in
sock_def_write_space
  *
  * To Fix:
  *
@@ -1130,7 +1131,7 @@
        /* Do not wake up a writer until he can make "significant"
         * progress.  --DaveM
         */
-       if((atomic_read(&sk->wmem_alloc) << 1) <= sk->sndbuf) {
+       if(!sk->dead && (atomic_read(&sk->wmem_alloc) << 1) <= sk->sndbuf)
{
                if (sk->sleep && waitqueue_active(sk->sleep))
                        wake_up_interruptible(sk->sleep);


