Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267600AbUHEHmt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267600AbUHEHmt (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Aug 2004 03:42:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267595AbUHEHms
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Aug 2004 03:42:48 -0400
Received: from fw.osdl.org ([65.172.181.6]:8638 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S267600AbUHEHmO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Aug 2004 03:42:14 -0400
Date: Thu, 5 Aug 2004 00:40:23 -0700
From: Andrew Morton <akpm@osdl.org>
To: Ulrich Drepper <drepper@redhat.com>
Cc: inaky.perez-gonzalez@intel.com, linux-kernel@vger.kernel.org,
       robustmutexes@lists.osdl.org, rusty@rustcorp.com.au, mingo@elte.hu,
       jamie@shareable.org
Subject: Re: [RFC/PATCH] FUSYN Realtime & robust mutexes for Linux, v2.3.1
Message-Id: <20040805004023.65463e88.akpm@osdl.org>
In-Reply-To: <4111E3B5.1070608@redhat.com>
References: <F989B1573A3A644BAB3920FBECA4D25A6EC06D@orsmsx407>
	<20040804232123.3906dab6.akpm@osdl.org>
	<4111DC8C.7050504@redhat.com>
	<20040805001737.78afb0d6.akpm@osdl.org>
	<4111E3B5.1070608@redhat.com>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ulrich Drepper <drepper@redhat.com> wrote:
>
> Andrew Morton wrote:
> 
>  > How large is the slowdown, and on what workloads?
> 
>  The fast path for all locking primitives etc in nptl today is entirely
>  at userlevel.  Normally just a single atomic operation with a dozen
>  other instructions.  With the fusyn stuff each and every locking
>  operation needs a system call to register/unregister the thread as it
>  locks/unlocks mutex/rwlocks/etc.  Go figure how well this works.  We are
>  talking about making the fast path of the locking primitives
>  two/three/four orders of magnitude more expensive.  And this for
>  absolutely no benefit for 99.999% of all the code which uses threads.
> 

ouch, OK.  But doesn't the current futex code continue to work unchanged?

>  > Passing the lock to a non-rt task when there's an rt-task waiting for it
>  > seems pretty poor form, too.
> 
>  No no, that's not what is wanted.  Robust mutexes are a special kind of
>  mutex and not related to rt issues.

I was referring to "scheduling-policy based unlock/wakeup", actually.
