Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272341AbRISS0w>; Wed, 19 Sep 2001 14:26:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274134AbRISS0q>; Wed, 19 Sep 2001 14:26:46 -0400
Received: from t2.redhat.com ([199.183.24.243]:14330 "HELO
	executor.cambridge.redhat.com") by vger.kernel.org with SMTP
	id <S272341AbRISS0O>; Wed, 19 Sep 2001 14:26:14 -0400
To: Andrea Arcangeli <andrea@suse.de>
Cc: David Howells <dhowells@redhat.com>,
        Linus Torvalds <torvalds@transmeta.com>,
        Manfred Spraul <manfred@colorfullife.com>, Ulrich.Weigand@de.ibm.com,
        linux-kernel@vger.kernel.org
Subject: Re: Deadlock on the mm->mmap_sem 
In-Reply-To: Message from Andrea Arcangeli <andrea@suse.de> 
   of "Wed, 19 Sep 2001 20:03:57 +0200." <20010919200357.Z720@athlon.random> 
Date: Wed, 19 Sep 2001 19:26:33 +0100
Message-ID: <6663.1000923993@warthog.cambridge.redhat.com>
From: David Howells <dhowells@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> if we go generic then I strongly recommend my version of the generic
> semaphores is _much_ faster (and cleaner) than this one

Not so:-) Your patch, Andrea, grabs the spinlock far more than is necessary.

> (it even allows more than 2^31 concurrent readers on 64 bit archs ;).

Easy enough to fix. Just apply this as well:

--- linux-rwsem-old/include/linux/rwsem.h       Wed Sep 19 19:23:44 2001
+++ linux-rwsem/include/linux/rwsem.h   Wed Sep 19 19:23:47 2001
@@ -26,7 +26,7 @@
  * - if wait_list is not empty, then there are processes waiting for the semaphore
  */
 struct rw_semaphore {
-       int                     activity;
+       long                    activity;
        spinlock_t              lock;
        struct list_head        wait_list;
 };

David
