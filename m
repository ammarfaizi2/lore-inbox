Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267644AbUHELsT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267644AbUHELsT (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Aug 2004 07:48:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267649AbUHELsT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Aug 2004 07:48:19 -0400
Received: from ozlabs.org ([203.10.76.45]:55984 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S267644AbUHELsS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Aug 2004 07:48:18 -0400
Subject: Re: [RFC/PATCH] FUSYN Realtime & robust mutexes for Linux, v2.3.1
From: Rusty Russell <rusty@rustcorp.com.au>
To: Ulrich Drepper <drepper@redhat.com>
Cc: Andrew Morton <akpm@osdl.org>, inaky.perez-gonzalez@intel.com,
       lkml - Kernel Mailing List <linux-kernel@vger.kernel.org>,
       robustmutexes@lists.osdl.org, Ingo Molnar <mingo@elte.hu>,
       jamie@shareable.org
In-Reply-To: <4111E3B5.1070608@redhat.com>
References: <F989B1573A3A644BAB3920FBECA4D25A6EC06D@orsmsx407>
	 <20040804232123.3906dab6.akpm@osdl.org>	<4111DC8C.7050504@redhat.com>
	 <20040805001737.78afb0d6.akpm@osdl.org>  <4111E3B5.1070608@redhat.com>
Content-Type: text/plain
Message-Id: <1091704539.5031.42.camel@bach>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Thu, 05 Aug 2004 21:48:05 +1000
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2004-08-05 at 17:37, Ulrich Drepper wrote:
> Andrew Morton wrote:
> > Passing the lock to a non-rt task when there's an rt-task waiting for it
> > seems pretty poor form, too.
> 
> No no, that's not what is wanted.  Robust mutexes are a special kind of
> mutex and not related to rt issues.  Lockers of robust mutexes have to
> register with the kernel (i.e., the locking must actually be performed
> by the kernel) so that in case the thread goes away or the entire
> process dies, the mutex is unlocked and other waiters (other threads, in
> the same or other processes) can get the lock.

I don't think this is neccessarily true: I think that platforms with
64-bit compare-and-exchange can do the whole thing in userspace.  They
would set the mutex and stamp in the thread ID simultanously, allowing
for "dead thread" detection (ie. I didn't get the lock, and it's a
robust mutex: check the holder is still alive).

W/o 64-bit compare-and-exchange a 100% robust solution may not be
possible though.

Thoughts?
Rusty.
-- 
Anyone who quotes me in their signature is an idiot -- Rusty Russell

