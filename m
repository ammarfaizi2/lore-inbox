Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751274AbWHIRTk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751274AbWHIRTk (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Aug 2006 13:19:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751273AbWHIRTk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Aug 2006 13:19:40 -0400
Received: from wx-out-0506.google.com ([66.249.82.228]:4654 "EHLO
	wx-out-0506.google.com") by vger.kernel.org with ESMTP
	id S1751236AbWHIRTj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Aug 2006 13:19:39 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=BpFKIqg8Bl9sfhDj/CBqadEeYZ5rkH4ndpCknAnd0+bUsC1CCEdAibDVb/URGx8MlqMQLnGsTPuyJyHQ2C+NJkg88sF5vOWv3/vPz8JUxrtxIFUtHYuc7iCH7vBDSuWeh7HUXB2Bhf0p0G8qfPVx1v61FG/8dg2wj+laTUzCxGw=
Message-ID: <e6babb600608091019pb17dcbft555cf5c964574664@mail.gmail.com>
Date: Wed, 9 Aug 2006 10:19:37 -0700
From: "Robert Crocombe" <rcrocomb@gmail.com>
To: "Steven Rostedt" <rostedt@goodmis.org>
Subject: Re: [Patch] restore the RCU callback to defer put_task_struct() Re: Problems with 2.6.17-rt8
Cc: "hui Bill Huey" <billh@gnuppy.monkey.org>, linux-kernel@vger.kernel.org,
       "Ingo Molnar" <mingo@elte.hu>, "Thomas Gleixner" <tglx@linutronix.de>,
       "Darren Hart" <dvhltc@us.ibm.com>
In-Reply-To: <e6babb600608081435l575f8ecdhbbc35066a8357f59@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <e6babb600608012231r74470b77x6e7eaeab222ee160@mail.gmail.com>
	 <e6babb600608012237g60d9dfd7ga11b97512240fb7b@mail.gmail.com>
	 <1154541079.25723.8.camel@localhost.localdomain>
	 <e6babb600608030448y7bb0cd34i74f5f632e4caf1b1@mail.gmail.com>
	 <1154615261.32264.6.camel@localhost.localdomain>
	 <20060808025615.GA20364@gnuppy.monkey.org>
	 <20060808030524.GA20530@gnuppy.monkey.org>
	 <e6babb600608081146k663e3ee4g4b93ba325bf9257e@mail.gmail.com>
	 <Pine.LNX.4.58.0608081506060.16824@gandalf.stny.rr.com>
	 <e6babb600608081435l575f8ecdhbbc35066a8357f59@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/8/06, Robert Crocombe <rcrocomb@gmail.com> wrote:
> I'm back to poking at 16-rt29 to see if the problem is simply somewhat
> less likely.

Unable to crash the 2.6.16-rt29 kernel after 462 kernel compilations.
But I got about 40 of these warnings:

irq 106: nobody cared (try booting with the "irqpoll" option)

Call Trace:
       <ffffffff88003c32>{:tg3:tg3_interrupt_tagged+61}
       <ffffffff801523a0>{__report_bad_irq+56}
       <ffffffff801525ce>{note_interrupt+479}
       <ffffffff80152287>{do_irqd+514}
       <ffffffff80152085>{do_irqd+0}
       <ffffffff8013f454>{keventd_create_kthread+0}
       <ffffffff8013f72b>{kthread+219}
       <ffffffff8012719c>{schedule_tail+198}
       <ffffffff8010bc6e>{child_rip+8}
       <ffffffff8013f454>{keventd_create_kthread+0}
       <ffffffff8013f650>{kthread+0}
       <ffffffff8010bc66>{child_rip+0}
---------------------------
| preempt count: 00000001 ]
| 1-level deep critical section nesting:
----------------------------------------
.. [<ffffffff80373aca>] .... _raw_spin_lock_irq+0x17/0x24
.....[<ffffffff8015226e>] ..   ( <= do_irqd+0x1e9/0x2e3)

handlers:
[<ffffffff88003bf5>] (tg3_interrupt_tagged+0x0/0x11b [tg3])

-- 
Robert Crocombe
rcrocomb@gmail.com
