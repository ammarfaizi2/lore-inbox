Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265105AbVBDPTw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265105AbVBDPTw (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Feb 2005 10:19:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265367AbVBDPTv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Feb 2005 10:19:51 -0500
Received: from www2.muking.org ([216.231.42.228]:35634 "HELO www2.muking.org")
	by vger.kernel.org with SMTP id S265105AbVBDPTZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Feb 2005 10:19:25 -0500
To: Ingo Molnar <mingo@elte.hu>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.11-rc3-V0.7.38-01
References: <20050204100347.GA13186@elte.hu>
From: Kevin Hilman <kevin@hilman.org>
Organization: None to speak of.
Date: 04 Feb 2005 07:19:19 -0800
In-Reply-To: <20050204100347.GA13186@elte.hu>
Message-ID: <83hdksxsi0.fsf@www2.muking.org>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

What is the proper way to setup a real counting semaphore under the
-RT kernel?

I've noticed that just using a struct semaphore, normal counting
semaphore usage[*] can trigger the "lock recursion deadlock" in
kernel/rt.c since 'struct semaphore' now uses an rt_mutex.  

What I've done for now is to use sema_init_nocheck() to disable the
checking in the case of a counting semaphore, but I remember seeing
discussion in an earlier thread about creating a separate counting
semaphore type.  Is this still planned?

Kevin
http://hilman.org/kevin/

[*] For example, an open semaphore being down'ed and thus acquired and
the same thread doing a down() again before another thread has a
chance to up() the semaphore.  


Ingo Molnar <mingo@elte.hu> writes:

> i have released the -V0.7.38-01 Real-Time Preemption patch, which can be
> downloaded from the usual place:
> 
>   http://redhat.com/~mingo/realtime-preempt/
> 
> Changes since -37-03:
> 
>  - merged to 2.6.11-rc3
> 
>  - deadlock-tracer fix from Eugeny S. Mints
> 
>  - converted an oprofile spinlock to raw, which should fix the bug 
>    reported by Peter Zijlstra.
> 
> to create a -V0.7.38-01 tree from scratch, the patching order is:
> 
>   http://kernel.org/pub/linux/kernel/v2.6/linux-2.6.10.tar.bz2
>   http://kernel.org/pub/linux/kernel/v2.6/testing/patch-2.6.11-rc3.bz2
>   http://redhat.com/~mingo/realtime-preempt/realtime-preempt-2.6.11-rc3-V0.7.38-01
