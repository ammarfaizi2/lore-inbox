Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316728AbSGLRiE>; Fri, 12 Jul 2002 13:38:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316739AbSGLRiD>; Fri, 12 Jul 2002 13:38:03 -0400
Received: from dsl-213-023-020-198.arcor-ip.net ([213.23.20.198]:42458 "EHLO
	starship") by vger.kernel.org with ESMTP id <S316728AbSGLRiB>;
	Fri, 12 Jul 2002 13:38:01 -0400
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@arcor.de>
To: Arnd Bergmann <arnd@bergmann-dalldorf.de>, linux-kernel@vger.kernel.org
Subject: Re: spinlock assertion macros
Date: Fri, 12 Jul 2002 19:42:09 +0200
X-Mailer: KMail [version 1.3.2]
References: <200207102128.g6ALS2416185@eng4.beaverton.ibm.com> <E17Szx2-0002es-00@starship> <200207121724.g6CHOU8100100@d12relay01.de.ibm.com>
In-Reply-To: <200207121724.g6CHOU8100100@d12relay01.de.ibm.com>
Cc: Jesse Barnes <jbarnes@sgi.com>,
       kernel-janitor-discuss@lists.sourceforge.net
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <E17T4Qj-0002fN-00@starship>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 12 July 2002 21:24, Arnd Bergmann wrote:
> Daniel Phillips wrote:
> 
> > Any idea how one might implement NEVER_SLEEPS()?  Maybe as:
> 
> Why would you want that? AFAICS there are two kinds of "never
> sleeping" functions: 1. those that don't sleep but don't care
> about it and 2. those that must not sleep because a lock is
> held.
> 
> For 1. no point marking it because it might change without
> being a bug. You also don't want to mark every function
> in the kernel SLEEPS() or NEVER_SLEEPS().
> 
> For 2. we already have MUST_HOLD(foo) or similar, which implicitly 
> means it can never sleep. The same is true for functions
> with spinlocks or preempt_disable around their body.

Thanks for that.

So far, only the MUST_HOLD style of executable locking documentation has 
really survived scrutiny.  It needs some variants: MUST_HOLD_READ, 
MUST_HOLD_WRITE, MUST_HOLD_SEM, MUST_HOLD_READ_SEM and MUST_HOLD_WRITE_SEM, 
or names to that effect.

-- 
Daniel
