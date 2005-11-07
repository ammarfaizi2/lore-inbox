Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751346AbVKGLxo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751346AbVKGLxo (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Nov 2005 06:53:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751347AbVKGLxo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Nov 2005 06:53:44 -0500
Received: from xproxy.gmail.com ([66.249.82.194]:34533 "EHLO xproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751346AbVKGLxn convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Nov 2005 06:53:43 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=pdR6vOjsYqIe07z6eVTPrkDk3vyXXiomC0b5tD1hwaoc+nTyVsd9anUFmMKjVS7nXym+L6gNLPHnP2pRnf5A56yHZ0O9IvKSl2unl0uAUu+FTrT6PTFUF6JmjQCNMLRoCVtz4b9rU7Q/OB6BsZbZMnRzirrsgGhsRwY8nvj4pC0=
Message-ID: <1e62d1370511070353o1d1d4931ncf0ff8a5f5658069@mail.gmail.com>
Date: Mon, 7 Nov 2005 16:53:42 +0500
From: Fawad Lateef <fawadlateef@gmail.com>
To: liyu <liyu@ccoss.com.cn>
Subject: Re: [question] I doublt on timer interrput.
Cc: LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <436EEEA4.1020703@ccoss.com.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <436EEEA4.1020703@ccoss.com.cn>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/7/05, liyu <liyu@ccoss.com.cn> wrote:
>
>     I have one question about timer interrupt (i386 architecture).
>
>     As we known, the timer emit HZ times interrputs per second,
> and in i386. The interrupt handler will call scheduler_tick()
> each time (on i386 at least, both enable or disable APIC).
>
>     On my Celeron machine(IOW, only one CPU, not SMP/SMT), I defined
> a global int variable 'tick_count' in kernel/sched.c, and add one line
> of code like follow in scheduler_tick():
>
>     ++tick_count;
>
>     but I found it is not same with content of the /proc/interrupts,
> and the differennt between them is not little.
>
>     I can not understand why that is.
>
>     Any useful idea.
>
>

What I found in the kernel code is that scheduler_tick is called from
two locations in the kernel (2.6.14-mm1) code (i386).

1) from kernel/timer.c in update_process_times which is called from
arch/i386/kernel/apic.c and its calling depends on the CONFIG_SMP
defined or not (see
http://sosdg.org/~coywolf/lxr/source/arch/i386/kernel/apic.c#L1160)
and as you don't have CONFIG_SMP enabled so its won't be called from
here.

2) from sched_fork function in kernel/sched.c
(http://sosdg.org/~coywolf/lxr/source/kernel/sched.c#L1414) and I
think its called when newly forked process setup is going to be
performed, and I think as from here scheduler_tick is called in your
case, so you are getting different value for your variable tick_count

scheduler_tick might be called from somewhere else which I am missing
so please CMIIW !

--
Fawad Lateef
