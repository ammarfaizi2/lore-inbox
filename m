Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318435AbSGYMAo>; Thu, 25 Jul 2002 08:00:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318436AbSGYMAo>; Thu, 25 Jul 2002 08:00:44 -0400
Received: from loke.as.arizona.edu ([128.196.209.61]:39818 "EHLO
	loke.as.arizona.edu") by vger.kernel.org with ESMTP
	id <S318435AbSGYMAf>; Thu, 25 Jul 2002 08:00:35 -0400
Date: Thu, 25 Jul 2002 05:00:15 -0700 (MST)
From: Craig Kulesa <ckulesa@as.arizona.edu>
To: Ed Tomlinson <tomlins@cam.org>
cc: Steven Cole <elenstev@mesatop.com>,
       William Lee Irwin III <wli@holomorphy.com>,
       Steven Cole <scole@lanl.gov>, Rik van Riel <riel@conectiva.com.br>,
       <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>
Subject: Re: [PATCH 2/2] move slab pages to the lru, for 2.5.27
In-Reply-To: <200207242012.59150.tomlins@cam.org>
Message-ID: <Pine.LNX.4.44.0207241931060.17413-100000@loke.as.arizona.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 24 Jul 2002, Ed Tomlinson wrote:

> This patch fixes the SMP problems for Steve.  

Good sleuthing!  Glad to hear this seems to solve the bizarre SMP
out-of-memory problems.  However, you should know that there *might* still 
be demons lurking about.

I still have problems with 2.5.27-rmap-slablru with CONFIG_SMP booting on 
a UP laptop, when 2.5.27-rmap (the big rmap patch) works fine in SMP mode. 
I have spinlock debugging turned on and get oopses with modprobe trying to
load the rtc module.  It fails this test in include/asm/spinlock.h:

#ifdef CONFIG_DEBUG_SPINLOCK
        if (lock->magic != SPINLOCK_MAGIC)
                BUG();

Modprobe also traps itself in infinite loops trying to load unix.o for 
net-pf-1.  Eeeks.  I'll test on other UP boxes in SMP mode and see if I 
can trigger anything. 


For now, I've applied Ed's patch and tested that it doesn't cause any 
problems for UP behavior, so I added it to the patch queue against 2.5.27 
and is included in the rmap patches for 2.5.28, which you can download:

	http://loke.as.arizona.edu/~ckulesa/kernel/rmap-vm/2.5.28/

The only new change for 2.5.28 is fixing software suspend to work 
with the full rmap patch.  I tested swsusp with 2.5.28-rmap-slablru, and 
it's very cool. :)

Although I suspect SMP folks will have their hands busy with *other* 
things in 2.5.28, (!!) more SMP feedback regarding slab-on-LRU would be 
most helpful!

Thanks,
Craig Kulesa

