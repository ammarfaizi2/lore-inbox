Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293008AbSBVVlH>; Fri, 22 Feb 2002 16:41:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293009AbSBVVk5>; Fri, 22 Feb 2002 16:40:57 -0500
Received: from infa.abo.fi ([130.232.208.126]:37380 "EHLO infa.abo.fi")
	by vger.kernel.org with ESMTP id <S293008AbSBVVkr>;
	Fri, 22 Feb 2002 16:40:47 -0500
Date: Fri, 22 Feb 2002 23:40:43 +0200
From: Marcus Alanen <marcus@infa.abo.fi>
Message-Id: <200202222140.XAA16750@infa.abo.fi>
To: balbir_soni@hotmail.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Trivial patch against mempool
In-Reply-To: <F24fGB9wIWXLU9778dv00003562@hotmail.com>
In-Reply-To: <F24fGB9wIWXLU9778dv00003562@hotmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>Check if the alloc_fn and free_fn are not NULL. The caller generally
>ensures that alloc_fn and free_fn are valid. It would not harm
>to check. This makes the checking in mempool_create() more complete.
>
>
>--- mempool.c.org       Fri Feb 22 12:00:58 2002
>+++ mempool.c   Fri Feb 22 12:01:13 2002
>@@ -35,7 +35,7 @@
>        int i;
>
>        pool = kmalloc(sizeof(*pool), GFP_KERNEL);
>-       if (!pool)
>+       if (!pool || !alloc_fn || !free_fn)
>                return NULL;
>        memset(pool, 0, sizeof(*pool));
>

A successful allocation with alloc_fn or free_fn equal to NULL
would return NULL, without freeing pool. => This check would
leak memory? Wouldn't it be better to check for !alloc_fn || !free_fn
before the kmalloc()


-- 
Marcus Alanen
maalanen@abo.fi
