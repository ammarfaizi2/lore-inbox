Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315540AbSIDWRK>; Wed, 4 Sep 2002 18:17:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315709AbSIDWRK>; Wed, 4 Sep 2002 18:17:10 -0400
Received: from air-2.osdl.org ([65.172.181.6]:11904 "EHLO doc.pdx.osdl.net")
	by vger.kernel.org with ESMTP id <S315540AbSIDWRI>;
	Wed, 4 Sep 2002 18:17:08 -0400
Date: Wed, 4 Sep 2002 15:21:35 -0700
From: Bob Miller <rem@osdl.org>
To: "Juan M. de la Torre" <jmtorre@gmx.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Questions on semaphores
Message-ID: <20020904152135.A2047@doc.pdx.osdl.net>
References: <20020904212931.GA2014@apocalipsis>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20020904212931.GA2014@apocalipsis>; from jmtorre@gmx.net on Wed, Sep 04, 2002 at 11:29:31PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 04, 2002 at 11:29:31PM +0200, Juan M. de la Torre wrote:
> 
>  Hi people, I have two question regarding the i386 semaphore implementation
>  in kernel 2.4.19. 
>  
>  Please dont blame me if they are too obvius; i'm a newbie in kernel hacking
>  :)
> 
>  The functions __down, __down_interruptible and __down_trylock (defined
>  in arch/i386/kernel/semaphore.c) use the global spinlock
>  'semaphore_lock' to access some fields of the semaphore they are
>  working on:
>  
>  1) Is there any reason to do this?

It was easy to do.

>  2) Wouldn't it be more scalable to use a per-semaphore lock instead a
>     global spinlock?
> 

Yes it would be more scalable, but not as much as you would think.
The __down, __down_interruptible and __down_trylock code only gets
invoked when the semaphore is contended  for.

>  The function __down_trylock try to get the spinlock using
>  spin_lock_irqsave, instead of using spin_lock_irq:
> 
>  1) why? :)
> 

The __down_trylock() code can be called with another lock held.  The
spin_lock_irqsave()/spin_lock_irqrestore() interface is used to restore
the irq value for the lock that may already be held.

>  Thanks in advance,
>  Juanma
> 
The code in the 2.5 tree was changed a while back to use the spinlock in
the wait_queue_head_t to replace the global semaphore spin lock.  So, this
has been "FIXED" in 2.5.

-- 
Bob Miller					Email: rem@osdl.org
Open Source Development Lab			Phone: 503.626.2455 Ext. 17
