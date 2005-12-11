Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750822AbVLKVVh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750822AbVLKVVh (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 11 Dec 2005 16:21:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750827AbVLKVVh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 11 Dec 2005 16:21:37 -0500
Received: from zproxy.gmail.com ([64.233.162.202]:17581 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750822AbVLKVVg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 11 Dec 2005 16:21:36 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:reply-to:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id:from;
        b=bZkcYLQ7CXKN8ciXYT7XckxftSCJ2T+hRSnj1qw7fmXL88kvldLFhbhP+pslB5K0WlVro9kPVvc3ptFxJUJ/PUJhu5ydKPXEWEEO/uMczPsPzVz48cahEhAnj25h2mLXJWL3QcmU1Wd2zKvZc5JzeYB+REL0AL+pQm59CDSkid4=
Reply-To: ajwade@cpe001346162bf9-cm0011ae8cd564.cpe.net.cable.rogers.com
To: vatsa@in.ibm.com
Subject: Re: Semantics of smp_mb() [was : Re: [PATCH] Fix RCU race in access of nohz_cpu_mask ]
Date: Sun, 11 Dec 2005 16:21:18 -0500
User-Agent: KMail/1.8.3
Cc: Oleg Nesterov <oleg@tv-sign.ru>, linux-kernel@vger.kernel.org,
       Dipankar Sarma <dipankar@in.ibm.com>,
       "Paul E. McKenney" <paulmck@us.ibm.com>, Andrew Morton <akpm@osdl.org>,
       Ingo Molnar <mingo@elte.hu>, Rusty Russell <rusty@rustcorp.com.au>
References: <439889FA.BB08E5E1@tv-sign.ru> <439B24A7.E2508AAE@tv-sign.ru> <20051211174114.GA4883@in.ibm.com>
In-Reply-To: <20051211174114.GA4883@in.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200512111621.20365.ajwade@cpe001346162bf9-cm0011ae8cd564.cpe.net.cable.rogers.com>
From: Andrew James Wade <andrew.j.wade@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 11 December 2005 12:41, Srivatsa Vaddagiri wrote:
> [Changed the subject line to be more generic in the interest of wider audience]
> 
> We seem to be having some confusion over the exact semantics of smp_mb().
> 
> Specifically, are all stores preceding smp_mb() guaranteed to have finished
> (committed to memory/corresponding cache-lines on other CPUs invalidated) 
> *before* successive loads are issued?

I doubt it. That's definitely not true of smp_wmb(), which boils down to
__asm__ __volatile__ ("": : :"memory") on SMP i386 (which the constrains
how the compiler orders write instructions, but is otherwise a nop. i386
has in-order writes.).

And it makes sense that wmb() wouldn't wait for writes: RCU needs
constraints on the order in which writes become visible, but has very week
constraints on when they do. Waiting for writes to flush would hurt
performance.

Andrew Wade
