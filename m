Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262266AbSKZXH6>; Tue, 26 Nov 2002 18:07:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262602AbSKZXH6>; Tue, 26 Nov 2002 18:07:58 -0500
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:24782 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id <S262266AbSKZXH5>; Tue, 26 Nov 2002 18:07:57 -0500
Date: Wed, 27 Nov 2002 00:15:08 +0100
From: Adrian Bunk <bunk@fs.tum.de>
To: Linus Torvalds <torvalds@transmeta.com>,
       Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>
Cc: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux v2.5.48
Message-ID: <20021126231507.GF21307@fs.tum.de>
References: <Pine.LNX.4.44.0211172036590.32717-100000@penguin.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0211172036590.32717-100000@penguin.transmeta.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 17, 2002 at 08:41:05PM -0800, Linus Torvalds wrote:

>...
> Summary of changes from v2.5.47 to v2.5.48
> ============================================
>...
> Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>:
>   o [IPSEC]: More fixes and corrections
>...

The following part of this patch looks bogus:

<--  snip  -->

--- 1.6/net/key/af_key.c        Fri Nov  8 00:34:37 2002
+++ 1.7/net/key/af_key.c        Mon Nov 11 01:03:55 2002
...
@@ -2179,7 +2223,7 @@
        if (skb)
                kfree_skb(skb);

-       return err;
+       return err ? : len;
 }

 static int pfkey_recvmsg(struct kiocb *kiocb,

<--  snip  -->


Is the following correct to fix it?


--- linux/net/key/af_key.c.old	2002-11-27 00:12:28.000000000 +0100
+++ linux/net/key/af_key.c	2002-11-27 00:12:40.000000000 +0100
@@ -2242,7 +2242,7 @@
 	if (skb)
 		kfree_skb(skb);
 
-	return err ? : len;
+	return err ? err : len;
 }
 
 static int pfkey_recvmsg(struct kiocb *kiocb,


cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

