Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261293AbSJYGuf>; Fri, 25 Oct 2002 02:50:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261294AbSJYGuf>; Fri, 25 Oct 2002 02:50:35 -0400
Received: from 167.imtp.Ilyichevsk.Odessa.UA ([195.66.192.167]:14858 "EHLO
	Port.imtp.ilyichevsk.odessa.ua") by vger.kernel.org with ESMTP
	id <S261293AbSJYGue>; Fri, 25 Oct 2002 02:50:34 -0400
Message-Id: <200210250651.g9P6pnp14035@Port.imtp.ilyichevsk.odessa.ua>
Content-Type: text/plain;
  charset="us-ascii"
From: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
Reply-To: vda@port.imtp.ilyichevsk.odessa.ua
To: Jan Marek <linux@hazard.jcu.cz>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [miniPATCH][RFC] Compilation fixes in the 2.5.44
Date: Fri, 25 Oct 2002 09:44:21 -0200
X-Mailer: KMail [version 1.3.2]
References: <20021025062809.GA7522@hazard.jcu.cz>
In-Reply-To: <20021025062809.GA7522@hazard.jcu.cz>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 25 October 2002 04:28, Jan Marek wrote:
> Hallo l-k,
>
> I'm beginner in the kernel hacking (or fixing ;-))).
>
> I have small patch, which is fixing some compilation errors (I'm
> using gcc-2.95.4-17 from Debian sid).
>
> The first chunk fixed this warning:
>
> arch/i386/kernel/irq.c: In function `do_IRQ':
> arch/i386/kernel/irq.c:331: warning: unused variable `esp'
>
> I move declaration of variable esp to the #ifdef blok, where it is
> using...


        unsigned int status;
-       long esp;
 
        irq_enter();
 
 #ifdef CONFIG_DEBUG_STACKOVERFLOW
        /* Debugging check for stack overflow: is there less than 1KB free? */
+       long esp;

Most C compilers don't allow you to mix declarations and code.
This is allowed only in new C standards. But GCC 3 seems to cope,
so it's probably fine for new kernels.

> The second chunk fixed this warning:
>
> In file included from arch/i386/kernel/timers/timer_pit.c:15:
> arch/i386/mach-generic/do_timer.h: In function
> `do_timer_interrupt_hook': arch/i386/mach-generic/do_timer.h:26:
> warning: implicit declaration of function `smp_local_timer_interrupt'
>
> I've found, that declaration of function do_timer_interrupt_hook is
> in the header asm/apic.h and it is as:
>
> extern void do_timer_interrupt_hook...
>
> Then I add #include of asm/apic.h
>
> The third chunk fixed this error:
>
> net/ipv4/raw.c: In function `raw_send_hdrinc':
> net/ipv4/raw.c:297: `NF_IP_LOCAL_OUT' undeclared (first use in this
> function)
> net/ipv4/raw.c:297: (Each undeclared identifier is reported only once
> net/ipv4/raw.c:297: for each function it appears in.)
>
> In this case was missing #include of netfilter_ipv4.h...

I think #include fixes are best sent to Rusty Trivial Russell.

Rusty Russell <rusty@rustcorp.com.au> [5 feb 2002]
	> Here are some cleanups of whitespace in .....
	Want me to add this to the trivial patch collection for tracking?
	If so just send (or cc:) it to trivial@rustcorp.com.au.

BTW, never misspell his name, he will be very upset.
He is *Russell*. Note which letters are doubled and which are not. ;)
--
vda
