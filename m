Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261356AbSKZXoS>; Tue, 26 Nov 2002 18:44:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263105AbSKZXoS>; Tue, 26 Nov 2002 18:44:18 -0500
Received: from air-2.osdl.org ([65.172.181.6]:24045 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id <S261356AbSKZXoR>;
	Tue, 26 Nov 2002 18:44:17 -0500
Date: Tue, 26 Nov 2002 15:49:11 -0800 (PST)
From: "Randy.Dunlap" <rddunlap@osdl.org>
X-X-Sender: <rddunlap@dragon.pdx.osdl.net>
To: Adrian Bunk <bunk@fs.tum.de>
cc: Linus Torvalds <torvalds@transmeta.com>,
       Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux v2.5.48
In-Reply-To: <20021126231507.GF21307@fs.tum.de>
Message-ID: <Pine.LNX.4.33L2.0211261547450.2873-100000@dragon.pdx.osdl.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 27 Nov 2002, Adrian Bunk wrote:

| On Sun, Nov 17, 2002 at 08:41:05PM -0800, Linus Torvalds wrote:
|
| >...
| > Summary of changes from v2.5.47 to v2.5.48
| > ============================================
| >...
| > Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>:
| >   o [IPSEC]: More fixes and corrections
| >...
|
| The following part of this patch looks bogus:
|
| <--  snip  -->
|
| --- 1.6/net/key/af_key.c        Fri Nov  8 00:34:37 2002
| +++ 1.7/net/key/af_key.c        Mon Nov 11 01:03:55 2002
| ...
| @@ -2179,7 +2223,7 @@
|         if (skb)
|                 kfree_skb(skb);
|
| -       return err;
| +       return err ? : len;
|  }
|
|  static int pfkey_recvmsg(struct kiocb *kiocb,
|
| <--  snip  -->
|
|
| Is the following correct to fix it?
|
|
| --- linux/net/key/af_key.c.old	2002-11-27 00:12:28.000000000 +0100
| +++ linux/net/key/af_key.c	2002-11-27 00:12:40.000000000 +0100
| @@ -2242,7 +2242,7 @@
|  	if (skb)
|  		kfree_skb(skb);
|
| -	return err ? : len;
| +	return err ? err : len;
|  }
|
|  static int pfkey_recvmsg(struct kiocb *kiocb,

Hi Adrian,

That's a gcc extension that means the same as your patch.  See
http://gcc.gnu.org/onlinedocs/gcc-3.2/gcc/Conditionals.html#Conditionals

It would be OK with me not to accept such extensions.  :)

-- 
~Randy

