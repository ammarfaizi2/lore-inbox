Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S283566AbRLIPrI>; Sun, 9 Dec 2001 10:47:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S283545AbRLIPq7>; Sun, 9 Dec 2001 10:46:59 -0500
Received: from mx2.elte.hu ([157.181.151.9]:33243 "HELO mx2.elte.hu")
	by vger.kernel.org with SMTP id <S283541AbRLIPqt>;
	Sun, 9 Dec 2001 10:46:49 -0500
Date: Sun, 9 Dec 2001 18:43:57 +0100 (CET)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: <mingo@elte.hu>
To: Frank Cornelis <fcorneli@elis.rug.ac.be>
Cc: <linux-kernel@vger.kernel.org>
Subject: Re: kmem_cache_alloc & kernel_lock
In-Reply-To: <Pine.LNX.4.33.0112091626110.27042-100000@trappist.elis.rug.ac.be>
Message-ID: <Pine.LNX.4.33.0112091843050.5249-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Sun, 9 Dec 2001, Frank Cornelis wrote:

> Can I use kmem_cache_alloc(mycache_cachep, SLAB_KERNEL) within a
> kernel_lock/kernel_unlock block? Or should it be SLAB_ATOMIC?

kernel_lock/kernel_unlock is not a spinlock in the classic Linux sense.
It's automatically undone on scheduling, so you can hold it while
rescheduling, and it will be automatically re-acquired once the process
gets runnable again.

	Ingo

