Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265020AbSJWOdi>; Wed, 23 Oct 2002 10:33:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265028AbSJWOdi>; Wed, 23 Oct 2002 10:33:38 -0400
Received: from transport.cksoft.de ([62.111.66.27]:61958 "EHLO
	transport.cksoft.de") by vger.kernel.org with ESMTP
	id <S265020AbSJWOdh>; Wed, 23 Oct 2002 10:33:37 -0400
Date: Wed, 23 Oct 2002 14:33:48 +0000 (UTC)
From: "Bjoern A. Zeeb" <bzeeb-lists@lists.zabbadoz.net>
X-X-Sender: bz@e0-0.zab2.int.zabbadoz.net
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Problem compiling 2.5.44 (net/ipv4/raw.c)
In-Reply-To: <1035317921.31979.137.camel@irongate.swansea.linux.org.uk>
Message-ID: <Pine.BSF.4.44.0210230521150.717-100000@e0-0.zab2.int.zabbadoz.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 22 Oct 2002, Alan Cox wrote:

> On Tue, 2002-10-22 at 19:49, Juan M. de la Torre wrote:
> >
> >   net/ipv4/raw.c: In function `raw_send_hdrinc':
> >   net/ipv4/raw.c:297: `NF_IP_LOCAL_OUT' undeclared (first use in this
> >   function)
> >   net/ipv4/raw.c:297: (Each undeclared identifier is reported only once
> >   net/ipv4/raw.c:297: for each function it appears in.)
> >   make[2]: *** [net/ipv4/raw.o] Error 1
> >   make[1]: *** [net/ipv4] Error 2
> >   make: *** [net] Error 2
> >
> >  net/ipv4/raw.c includes linux/netfilter.h, but not linux/netfilter_ipv4.h
> >  (NF_IP_LOCAL_OUT is defined in netfilter_ipv4.h).
>
> Fixed in -ac1 - you can just grab the net/ipv4/raw.c fix if need be


Please remove include for netfilter.h as this is already included in
netfilter_ipv4.h.

--- linux/net/ipv4/raw.c.orig	Tue Oct 22 15:20:07 2002
+++ linux/net/ipv4/raw.c	Tue Oct 22 21:16:17 2002
@@ -64,7 +64,7 @@
 #include <net/raw.h>
 #include <net/inet_common.h>
 #include <net/checksum.h>
-#include <linux/netfilter.h>
+#include <linux/netfilter_ipv4.h>

 struct sock *raw_v4_htable[RAWV4_HTABLE_SIZE];
 rwlock_t raw_v4_lock = RW_LOCK_UNLOCKED;

-- 
Bjoern A. Zeeb				bzeeb at Zabbadoz dot NeT
56 69 73 69 74				http://www.zabbadoz.net/

