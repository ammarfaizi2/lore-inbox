Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268716AbUJMO5V@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268716AbUJMO5V (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Oct 2004 10:57:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267823AbUJMO5V
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Oct 2004 10:57:21 -0400
Received: from mx1.redhat.com ([66.187.233.31]:25535 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S268716AbUJMO4O (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Oct 2004 10:56:14 -0400
Message-ID: <416D41FF.6080002@redhat.com>
Date: Wed, 13 Oct 2004 10:55:59 -0400
From: Neil Horman <nhorman@redhat.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.0; hi, Mom) Gecko/20020604 Netscape/7.01
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Martijn Sipkema <martijn@entmoot.nl>
CC: linux-kernel@vger.kernel.org
Subject: Re: waiting on a condition
References: <02bb01c4b138$8a786f10$161b14ac@boromir>
In-Reply-To: <02bb01c4b138$8a786f10$161b14ac@boromir>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Martijn Sipkema wrote:
> L.S.
> 
> I'd like to do something similar as can be done using a POSIX condition
> variable in the kernel, i.e. wait for some condition to become true. The
> pthread_cond_wait() function allows atomically unlocking a mutex and
> waiting on a condition. I think I should do something like:
> (the condition is updated from an interrupt handler)
> 
> disable interrupts
> acquire spinlock
> if condition not satisfied
>     add task to wait queue
>     set task to sleep
> release spinlock
> restore interrupts
> schedule
> 
> Now, this will only work with preemption disabled within the critical
> section. How would something like this be done whith preemption
> enabled?
> 
you above algorithm seems rather prone to deadlock.  Everything else in 
the kernel does more or less this operation by using a wait queue and a 
call to schedule to make tasks sleep until an event is signaled with a 
call to one of the wake_up family of functions.  Then a spinlock is used 
  to protect any critical data regions in smp environments.  Search the 
kernel for calls to add_wait_queue and wake_up[_interruptible] for 
examples of how this is implemented.

HTH
Neil

> 
> --ms
> 
> 
> 
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/


-- 
/***************************************************
  *Neil Horman
  *Software Engineer
  *Red Hat, Inc.
  *nhorman@redhat.com
  *gpg keyid: 1024D / 0x92A74FA1
  *http://pgp.mit.edu
  ***************************************************/
