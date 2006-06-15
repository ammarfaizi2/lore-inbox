Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750714AbWFOWFa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750714AbWFOWFa (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Jun 2006 18:05:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750716AbWFOWFa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Jun 2006 18:05:30 -0400
Received: from nf-out-0910.google.com ([64.233.182.184]:62755 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1750714AbWFOWF3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Jun 2006 18:05:29 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=googlemail.com;
        h=received:date:x-x-sender:to:cc:subject:in-reply-to:message-id:references:mime-version:content-type:from;
        b=ibqMeRx0zeRcBAU5be8HvAByg5UEnZGThEitiIREk9W1yD03CXGfOnkd4MQnW2xcvGjzBNbQFB+PCDJL842AeZFevr1lmAqAtvTlFptkEWYgbR1D1gQYD15pvhPLyJITiTyFsUhOxWQWSwLd4e+iQqypzYsvfu1XJTSzlbizEYk=
Date: Fri, 16 Jun 2006 00:05:21 +0100 (BST)
X-X-Sender: simlo@localhost.localdomain
To: Mike Kravetz <kravetz@us.ibm.com>
cc: Darren Hart <dvhltc@us.ibm.com>, Ingo Molnar <mingo@elte.hu>,
       linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
       John Stultz <johnstul@us.ibm.com>
Subject: Re: [RFC PATCH -rt] Priority preemption latency
In-Reply-To: <20060615210658.GA19525@monkey.ibm.com>
Message-ID: <Pine.LNX.4.64.0606152347320.24056@localhost.localdomain>
References: <200606091701.55185.dvhltc@us.ibm.com> <200606102324.58932.dvhltc@us.ibm.com>
 <20060611073609.GA12456@elte.hu> <200606120838.25200.dvhltc@us.ibm.com>
 <20060615210658.GA19525@monkey.ibm.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
From: Esben Nielsen <nielsen.esben@googlemail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 15 Jun 2006, Mike Kravetz wrote:

> On Mon, Jun 12, 2006 at 08:38:24AM -0700, Darren Hart wrote:
>> I started running this version of the patch with prio-preemt in a loop
>> over 10 hours ago, and it's still running.  This seems to be the right fix.
>
> Unfortunately, this test did eventually fail over in our environment.
> John Stultz added the concept of 'interrupter threads' to the testcase.
> These high priority RT interrupter threads, occasionally wake up and
> run for a short period of time.  Since these new threads are higher
> priority than any other, they theoretically should not impact the
> testcase.  This is because the primary purpose of the testcase is to
> ensure that lower priority tasks do not run while higher priority tasks
> are waiting for a CPU.
>
> After adding these interrupter threads, the tetscase fails (on a system
> here) about 50% of the time.  An updated version of prio-preempt.c is
> attached.  It needs the same headers/makefile/etc as originally provided
> by Darren.
>
> Any help figuring out what is happening here would be appreciated.


Well, I can't say understand what your test is supposed to test. But I 
know having printf() inside something which is supposed to be RT is a big 
no-no as it can block.

What if the first printf() after pthread_cond_wait() is blocking?
The interrupt threads probably use a lot of CPU overall and they have 
priority 90. They might slow the output device for printf() so much down 
that some queue becomes full and printf() must block.

Esben

> -- 
> Mike
>
