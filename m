Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263416AbRFRXhP>; Mon, 18 Jun 2001 19:37:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263419AbRFRXhF>; Mon, 18 Jun 2001 19:37:05 -0400
Received: from zikova.cvut.cz ([147.32.235.100]:37394 "EHLO zikova.cvut.cz")
	by vger.kernel.org with ESMTP id <S263416AbRFRXgw>;
	Mon, 18 Jun 2001 19:36:52 -0400
From: "Petr Vandrovec" <VANDROVE@vc.cvut.cz>
Organization: CC CTU Prague
To: Timur Tabi <ttabi@interactivesi.com>
Date: Tue, 19 Jun 2001 01:36:26 MET-1
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
Content-transfer-encoding: 7BIT
Subject: Re: gnu asm help...
CC: linux-kernel@vger.kernel.org, ashok.raj@intel.com
X-mailer: Pegasus Mail v3.40
Message-ID: <635DA093636@vcnet.vc.cvut.cz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 18 Jun 01 at 18:20, Timur Tabi wrote:
> You want to return the variable?  Try this:
> 
> static __inline__ unsigned long atomic_inc(atomic_t *v)
> {
>     __asm__ __volatile__(
>         LOCK "incl %0"
>         :"=m" (v->counter)
>         :"m" (v->counter));
> 
>     return v->counter;
> }

No. Another CPU might increment value between LOCK INCL and
fetching v->counter. On ia32 architecture you are almost out of
luck. You can either try building atomic_inc around CMPXCHG,
using it as conditional store (but CMPXCHG is not available 
on i386), or you can just guard your atomic variable with 
spinlock - but in that case there is no reason for using atomic_t 
at all. 
                                            Best regards,
                                                Petr Vandrovec
                                                vandrove@vc.cvut.cz
                                                
P.S.: Why you need to know that value? You can either rewrite
your code with atomic_dec_and_test/atomic_inc_and_test, or
you overlooked some race, or you have really strange problem.
