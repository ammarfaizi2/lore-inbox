Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291487AbSBMJ7u>; Wed, 13 Feb 2002 04:59:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291475AbSBMJ7l>; Wed, 13 Feb 2002 04:59:41 -0500
Received: from anchor-post-34.mail.demon.net ([194.217.242.92]:33040 "EHLO
	anchor-post-34.mail.demon.net") by vger.kernel.org with ESMTP
	id <S291484AbSBMJ7a>; Wed, 13 Feb 2002 04:59:30 -0500
Content-Type: text/plain; charset=US-ASCII
From: Stephen Kitchener <stephen@g6dzj.demon.co.uk>
Reply-To: stephen@g6dzj.demon.co.uk
Organization: none
To: linux-kernel@vger.kernel.org, linux-hams@vger.kernel.org
Subject: AX25 Patches for 2.4.17 and above - have they been included yet
Date: Wed, 13 Feb 2002 10:03:11 +0000
X-Mailer: KMail [version 1.3.2]
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <E16awCH-000Hrq-0Y@anchor-post-34.mail.demon.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I have been looking and searching the latest kernel pachecs and update for 
the fixes that were issued some time ago, but I have yet to see them.

The patches were issed by Henk De Groot and were as follows...

diff -ruN linux/net/core/sock.c linux/net/core/sock.c
--- linux/net/core/sock.c       Fri Dec 28 21:25:37 2001
+++ linux/net/core/sock.c       Fri Dec 28 21:26:35 2001
@@ -81,6 +81,7 @@
  *             Andi Kleen      :       Fix write_space callback
  *             Chris Evans     :       Security fixes - signedness again
  *             Arnaldo C. Melo :       cleanups, use skb_queue_purge
+ *             Jeroen Vreeken  :       Add check for sk->dead in 
sock_def_write_space
  *
  * To Fix:
  *
@@ -1146,7 +1147,7 @@
        /* Do not wake up a writer until he can make "significant"
         * progress.  --DaveM
         */
-       if((atomic_read(&sk->wmem_alloc) << 1) <= sk->sndbuf) {
+       if(!sk->dead && (atomic_read(&sk->wmem_alloc) << 1) <= sk->sndbuf) {
                if (sk->sleep && waitqueue_active(sk->sleep))
                        wake_up_interruptible(sk->sleep);

These were, I believe, issed against the 2.4.17 kernel.

These were to fix a lock up problem that I have encountered when useing an 
scc card and the scc utilites but might have been more general to ax25 use.

Have I missed something and they are there in the kernel now, haven't seen 
anything listed in the kernel changes or are these fixes being incorporated 
in the 2.5.xx series.


-- 
Stephen Kitchener
