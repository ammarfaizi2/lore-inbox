Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293017AbSBVV7h>; Fri, 22 Feb 2002 16:59:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293019AbSBVV72>; Fri, 22 Feb 2002 16:59:28 -0500
Received: from f156.law11.hotmail.com ([64.4.17.156]:65287 "EHLO hotmail.com")
	by vger.kernel.org with ESMTP id <S293017AbSBVV7W>;
	Fri, 22 Feb 2002 16:59:22 -0500
X-Originating-IP: [156.153.254.10]
From: "Balbir Singh" <balbir_soni@hotmail.com>
To: marcus@infa.abo.fi, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Trivial patch against mempool
Date: Fri, 22 Feb 2002 13:59:16 -0800
Mime-Version: 1.0
Content-Type: text/plain; format=flowed
Message-ID: <F156NzW3l1GM3h3vLgA000074ec@hotmail.com>
X-OriginalArrivalTime: 22 Feb 2002 21:59:16.0582 (UTC) FILETIME=[2BDF6060:01C1BBEC]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


You are absoultely correct. The correct patch is

--- mempool.c.org       Fri Feb 22 12:00:58 2002
+++ mempool.c   Fri Feb 22 15:01:02 2002
@@ -34,6 +34,9 @@
        mempool_t *pool;
        int i;

+       if (!alloc_fn || !free_fn)
+               return NULL;
+
        pool = kmalloc(sizeof(*pool), GFP_KERNEL);
        if (!pool)
                return NULL;

Balbir Singh.


>From: Marcus Alanen <marcus@infa.abo.fi>
>To: balbir_soni@hotmail.com, linux-kernel@vger.kernel.org
>Subject: Re: [PATCH] Trivial patch against mempool
>Date: Fri, 22 Feb 2002 23:40:43 +0200
>
> >Check if the alloc_fn and free_fn are not NULL. The caller generally
> >ensures that alloc_fn and free_fn are valid. It would not harm
> >to check. This makes the checking in mempool_create() more complete.
> >
> >
> >--- mempool.c.org       Fri Feb 22 12:00:58 2002
> >+++ mempool.c   Fri Feb 22 12:01:13 2002
> >@@ -35,7 +35,7 @@
> >        int i;
> >
> >        pool = kmalloc(sizeof(*pool), GFP_KERNEL);
> >-       if (!pool)
> >+       if (!pool || !alloc_fn || !free_fn)
> >                return NULL;
> >        memset(pool, 0, sizeof(*pool));
> >
>
>A successful allocation with alloc_fn or free_fn equal to NULL
>would return NULL, without freeing pool. => This check would
>leak memory? Wouldn't it be better to check for !alloc_fn || !free_fn
>before the kmalloc()
>
>
>--
>Marcus Alanen
>maalanen@abo.fi




_________________________________________________________________
Send and receive Hotmail on your mobile device: http://mobile.msn.com

