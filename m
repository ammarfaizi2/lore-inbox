Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263852AbTE3RV0 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 May 2003 13:21:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263848AbTE3RVZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 May 2003 13:21:25 -0400
Received: from us01-fw3-ext.synopsys.com ([204.176.21.196]:24745 "EHLO
	piper.synopsys.com") by vger.kernel.org with ESMTP id S263852AbTE3RU2
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 May 2003 13:20:28 -0400
Date: Fri, 30 May 2003 10:33:29 -0700
From: Joe Buck <jbuck@synopsys.com>
To: Bernd Jendrissek <berndj@prism.co.za>
Cc: Kendrick Hamilton <hamilton@sedsystems.ca>, gcc@gcc.gnu.org,
       linux-kernel@vger.kernel.org
Subject: Re: Problem Installing Linux Kernel Module compiled with gcc-3.2.x
Message-ID: <20030530103329.A848@synopsys.com>
References: <Pine.LNX.4.44.0305300919510.3613-100000@sw-55.sedsystems.ca> <20030530192240.A7564@prism.co.za>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20030530192240.A7564@prism.co.za>; from berndj@prism.co.za on Fri, May 30, 2003 at 07:22:40PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 30, 2003 at 07:22:40PM +0200, Bernd Jendrissek wrote:

> If you look at linux/include/linux/spinlock.h, you'll see:
> 
> /*
>  * Your basic spinlocks, allowing only a single CPU anywhere
>  *
>  * Most gcc versions have a nasty bug with empty initializers.
>  */
> #if (__GNUC__ > 2)
>   typedef struct { } spinlock_t;
>   #define SPIN_LOCK_UNLOCKED (spinlock_t) { }
> #else
>   typedef struct { int gcc_is_buggy; } spinlock_t;
>   #define SPIN_LOCK_UNLOCKED (spinlock_t) { 0 }
> #endif

Yuk!  What is the benefit of introducing this incompatibility?  #ifdefs
are harmful to maintainance, and it's only one word, so why not always
put in the dummy struct member?

> Hmm, actually I thought the kernel had a mechanism to prevent a GCC 3.x
> module from being loaded into a GCC 2.x kernel and vice versa?

Is there any reason, other than the above-described bit of evil, for doing
this (forbidding mixing)?  It prevents the bug-finding approach I
described earlier (a binary search for finding miscompiled code) from
working.
