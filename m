Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266879AbUJBAg3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266879AbUJBAg3 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Oct 2004 20:36:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266888AbUJBAg3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Oct 2004 20:36:29 -0400
Received: from e32.co.us.ibm.com ([32.97.110.130]:25028 "EHLO
	e32.co.us.ibm.com") by vger.kernel.org with ESMTP id S266879AbUJBAg0
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Oct 2004 20:36:26 -0400
Subject: Re: 2.6.9-rc2-mm4 ps hang ?
From: Badari Pulavarty <pbadari@us.ibm.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20041001164938.3231482e.akpm@osdl.org>
References: <1096646925.12861.50.camel@dyn318077bld.beaverton.ibm.com>
	 <20041001120926.4d6f58d5.akpm@osdl.org>
	 <1096666140.12861.82.camel@dyn318077bld.beaverton.ibm.com>
	 <20041001145536.182dada9.akpm@osdl.org>
	 <1096672002.12861.84.camel@dyn318077bld.beaverton.ibm.com>
	 <20041001164938.3231482e.akpm@osdl.org>
Content-Type: text/plain
Organization: 
Message-Id: <1096676949.12861.96.camel@dyn318077bld.beaverton.ibm.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 01 Oct 2004 17:29:10 -0700
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2004-10-01 at 16:49, Andrew Morton wrote:
> Badari Pulavarty <pbadari@us.ibm.com> wrote:
> >
> > Here is the full sysrq-t output.
> 
> What's this guy up to?
> 
> db2fmcd       D 0000000000000000     0 11032      1          1373 11031 (NOTLB)
> 00000101b9b9bef8 0000000000000002 0000003700000037 00000101c13608a0 
>        000000010000009f 0000010199649250 0000010199649588 0000000000000000 
>        0000000000000206 ffffffff801353db 
> Call Trace:<ffffffff801353db>{try_to_wake_up+971} <ffffffff80445570>{__down_write+128} 
>        <ffffffff80125e7f>{sys32_mmap+143} <ffffffff80124b01>{ia32_sysret+0} 
>        
> 
> Something is seriously screwed up if it's stuck in try_to_wake_up().  Tried
> generating a few extra traces?
> 
> Then again, maybe we're missing an up_read() somewhere.  hrm, I'll check.
> 
Doesn't make any sense..

According to my objdump

try_to_wake_up+971 ==> task_rq_unlock()

kernel/sched.c:580
    265f:       48 8b 75 d0             mov   
0xffffffffffffffd0(%rbp),%rsi
    2663:       4c 89 ff                mov    %r15,%rdi
    2666:       e8 00 00 00 00          callq  266b
<try_to_wake_up+0x3cb>   


    578 static inline void task_rq_unlock(spinlock_t *rql, unsigned long
*flags)
    579 {
    580         spin_unlock_irqrestore(rql, *flags);
    581 }

Why would I be stuck in spin_unlock() ?

Thanks,
Badari


