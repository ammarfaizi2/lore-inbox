Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268339AbUIGRRd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268339AbUIGRRd (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Sep 2004 13:17:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268372AbUIGRJx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Sep 2004 13:09:53 -0400
Received: from zeus.kernel.org ([204.152.189.113]:53473 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id S268279AbUIGRGW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Sep 2004 13:06:22 -0400
Message-ID: <413DE6C9.5050402@colorfullife.com>
Date: Tue, 07 Sep 2004 18:50:17 +0200
From: Manfred Spraul <manfred@colorfullife.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; fr-FR; rv:1.7.2) Gecko/20040803
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Christoph Hellwig <hch@lst.de>
CC: akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] make kmem_find_general_cachep static in slab.c
References: <20040907143632.GA8480@lst.de>
In-Reply-To: <20040907143632.GA8480@lst.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christoph Hellwig wrote:

>--- 1.35/include/linux/slab.h	2004-09-03 11:08:25 +02:00
>+++ edited/include/linux/slab.h	2004-09-07 14:47:58 +02:00
>@@ -55,7 +55,6 @@
> /* prototypes */
> extern void kmem_cache_init(void);
> 
>-extern kmem_cache_t *kmem_find_general_cachep(size_t, int gfpflags);
>  
>

Why?
It's intended for users that want to kmalloc always the same amount of 
memory.
For example the network layer could call kmem_find_general_cachep once 
for dev->mtu and then just call kmem_cache_alloc instead of kmalloc. The 
loop in kmalloc often needs more cpu cycles than the actual alloc.

--
    Manfred
