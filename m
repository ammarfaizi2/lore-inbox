Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422742AbWHZChJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422742AbWHZChJ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Aug 2006 22:37:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751557AbWHZChJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Aug 2006 22:37:09 -0400
Received: from wx-out-0506.google.com ([66.249.82.234]:2450 "EHLO
	wx-out-0506.google.com") by vger.kernel.org with ESMTP
	id S1750733AbWHZChG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Aug 2006 22:37:06 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=tMzMCCiUNluSOTQDUKOj+FdEFn4Q/EQb5/j8+mV2UWw4UyF7EtVsTH4gqAMmaioiOhY8hYUxx0eHC+HuWva9FX20zimHF8xIoAp+3yEMowjKFr51jXRzcpo1KULHHm0ZoDSqHVUN5CCCqkeXU/iERKO80h2fBejlmkVpAKsbNEE=
Message-ID: <e6babb600608251937v19b437f4x5ecef7fb615de548@mail.gmail.com>
Date: Fri, 25 Aug 2006 19:37:05 -0700
From: "Robert Crocombe" <rcrocomb@gmail.com>
To: "hui Bill Huey" <billh@gnuppy.monkey.org>
Subject: Re: rtmutex assert failure (was [Patch] restore the RCU callback...)
Cc: "Esben Nielsen" <nielsen.esben@gmail.com>, "Ingo Molnar" <mingo@elte.hu>,
       "Thomas Gleixner" <tglx@linutronix.de>, rostedt@goodmis.org,
       linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <e6babb600608251828i601d91bep9c8ae73341e381d@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <20060818115934.GA29919@gnuppy.monkey.org>
	 <e6babb600608231014r23886965k9cbc1fd3b80930bb@mail.gmail.com>
	 <20060823202046.GA17267@gnuppy.monkey.org>
	 <20060823210558.GA17606@gnuppy.monkey.org>
	 <20060823210842.GB17606@gnuppy.monkey.org>
	 <e6babb600608231822s1ce8b229ubdc85ce7544c6b4@mail.gmail.com>
	 <20060824014658.GB19314@gnuppy.monkey.org>
	 <20060825071957.GA30720@gnuppy.monkey.org>
	 <e6babb600608251824g7e61e28n1c453db05a4e773d@mail.gmail.com>
	 <e6babb600608251828i601d91bep9c8ae73341e381d@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/25/06, Robert Crocombe <rcrocomb@gmail.com> wrote:
> Drat, this isn't quite true.  There was one attempt with 'make', and
> that produced the 1st BUG, but the latter three attempts were with
> 'make -j40': two were okay, and one produced the two BUGs.  Apologies.
>  I will make additional attempts with 'make' only.

Well, I was just doing that, and I got this:

----------- [cut here ] --------- [please bite here ] ---------
Kernel BUG at kernel/rtmutex.c:639
invalid opcode: 0000 [1] PREEMPT
CPU 0
Modules linked in: tg3
Pid: 7332, comm: ld Not tainted 2.6.17-rt8_UP_00 #3
RIP: 0010:[<ffffffff8025e89e>] <ffffffff8025e89e>{rt_lock_slowlock+209}
RSP: 0018:ffff8107ed70f9f8  EFLAGS: 00010246
RAX: ffff8107f2b13540 RBX: ffffffff804aa510 RCX: ffffffff804aacc0
RDX: ffff8107f2b13540 RSI: ffff8107ed70f9e8 RDI: ffffffff804aa510
RBP: ffff8107ed70fab8 R08: 0000000000000000 R09: ffff8107ed70f9f8
R10: 0000000000000002 R11: ffff8107fdcd8080 R12: ffff81001cbe3ad0
R13: 0000000000000000 R14: ffffffff8029a81b R15: 0000000000000001
FS:  00002b9a0c7e0d50(0000) GS:ffffffff805fe000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 000000008005003b
CR2: 00000000005b9e5c CR3: 00000007eb86e000 CR4: 00000000000006e0
Process ld (pid: 7332, threadinfo ffff8107ed70e000, task ffff8107f2b13540)
Stack: 111111110000008c ffff8107ed70fa00 ffff8107ed70fa00 ffff8107ed70fa10
       ffff8107ed70fa10 0000000000000000 111111110000008c ffff8107ed70fa30
       ffff8107ed70fa30 ffff8107ed70fa40
Call Trace:
       <ffffffff8025f4b8>{rt_lock+13}
       <ffffffff8029a81b>{free_pages_bulk+42}
       <ffffffff8029abf7>{__free_pages_ok+438}
       <ffffffff8022c07e>{__free_pages+47}
       <ffffffff80233bb0>{free_pages+128}
       <ffffffff802580df>{free_task+26}
       <ffffffff80245b52>{__put_task_struct+182}
       <ffffffff8025d86e>{thread_return+163}
       <ffffffff8025e876>{rt_lock_slowlock+169}
       <ffffffff8025e0e3>{preempt_schedule_irq+78}
       <ffffffff80259fa6>{retint_kernel+38}
       <ffffffff80209d21>{get_page_from_freelist+204}
       <ffffffff80209ce0>{get_page_from_freelist+139}
       <ffffffff8020dee1>{__alloc_pages+116}
       <ffffffff8022180a>{anon_vma_prepare+44}
       <ffffffff80208468>{__handle_mm_fault+454}
       <ffffffff8028f188>{rt_mutex_slowtrylock+174}
       <ffffffff8020a705>{do_page_fault+1058}
       <ffffffff8025eaa6>{rt_lock_slowunlock+98}
       <ffffffff8025f4a9>{__lock_text_start+9}
       <ffffffff8025a2f1>{error_exit+0}
---------------------------
| preempt count: 00000003 ]
| 3-level deep critical section nesting:
----------------------------------------
.. [<ffffffff8025d303>] .... __schedule+0xb3/0x57b
.....[<ffffffff8025e0e3>] ..   ( <= preempt_schedule_irq+0x4e/0x84)
.. [<ffffffff8025e805>] .... rt_lock_slowlock+0x38/0x277
.....[<ffffffff8025f4b8>] ..   ( <= rt_lock+0xd/0xf)
.. [<ffffffff80263268>] .... oops_begin+0x1b/0x55
.....[<ffffffff802638ff>] ..   ( <= die+0x19/0x44)


Code: 0f 0b 68 71 7e 3f 80 c2 7f 02 65 48 8b 04 25 00 00 00 00 41
RIP <ffffffff8025e89e>{rt_lock_slowlock+209} RSP <ffff8107ed70f9f8>
 <6>note: ld[7332] exited with preempt_count 2

A later example did the same thing, then started "wigging out",
eventually declaring:

 <1>Fixing recursive fault but reboot is needed!

I have a full trace and sysrq-T for this as well.

-- 
Robert Crocombe
rcrocomb@gmail.com
