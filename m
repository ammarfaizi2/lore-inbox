Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267303AbUIJJIA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267303AbUIJJIA (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Sep 2004 05:08:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267324AbUIJJIA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Sep 2004 05:08:00 -0400
Received: from fw.osdl.org ([65.172.181.6]:8387 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S267303AbUIJJH6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Sep 2004 05:07:58 -0400
Date: Fri, 10 Sep 2004 02:05:29 -0700
From: Andrew Morton <akpm@osdl.org>
To: Kirill Korotaev <dev@sw.ru>
Cc: wli@holomorphy.com, torvalds@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] adding per sb inode list to make invalidate_inodes()
 faster
Message-Id: <20040910020529.2a1ea4f3.akpm@osdl.org>
In-Reply-To: <41416BCA.3020005@sw.ru>
References: <4140791F.8050207@sw.ru>
	<Pine.LNX.4.58.0409090844410.5912@ppc970.osdl.org>
	<20040909171927.GU3106@holomorphy.com>
	<20040909110622.78028ae6.akpm@osdl.org>
	<20040909181818.GF3106@holomorphy.com>
	<20040909120818.7f127d14.akpm@osdl.org>
	<41416BCA.3020005@sw.ru>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Kirill Korotaev <dev@sw.ru> wrote:
>
> Well for sure this bug can be triggered only on really big servers with
>  a huge amount of memory and cache size.
>  It's up to you whether to apply it or not. I understand your position 
>  about 8 bytes, but probably it's just a question of using kernel, 
>  whether it's a user or server system.
>  Probably we can introduce some config option which would trigger 
>  features such as this one for enterprise systems.

I am paralysed by indecision!

It would be nice if we had evidence that more than one site in the world
was affected by this :(

I can't see an less space-consuming alternative here (apart from per-sb lru)

>  >> Also, the additional sizeof(struct list_head) is only a requirement
>  >> while the global inode LRU is maintained. I believed it would have
>  >> been beneficial to have localized the LRU to the sb also, which would
>  >> have maintained sizeof(struct inode0 at parity with current mainline.
>  > 
>  > Could be.  We would give each superblock its own shrinker callback and
>  > everything should balance out nicely (hah).
>
>  heh, and how do you plan to make per-sb LRU to be fair?

Good point.  
