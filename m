Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266199AbUHAXnq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266199AbUHAXnq (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 1 Aug 2004 19:43:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266200AbUHAXnq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 1 Aug 2004 19:43:46 -0400
Received: from LPBPRODUCTIONS.COM ([68.98.211.131]:40656 "HELO
	lpbproductions.com") by vger.kernel.org with SMTP id S266199AbUHAXnn
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 1 Aug 2004 19:43:43 -0400
From: Matt Heler <lkml@lpbproductions.com>
Reply-To: lkml@lpbproduction.scom
To: Ingo Molnar <mingo@elte.hu>
Subject: Re: [patch] voluntary-preempt-2.6.8-rc2-O2
Date: Sun, 1 Aug 2004 16:44:04 -0700
User-Agent: KMail/1.6.82
Cc: linux-kernel@vger.kernel.org, Lee Revell <rlrevell@joe-job.com>,
       mingo@redhat.com, Felipe Alfaro Solana <felipe_alfaro@linuxmail.org>
References: <20040713143947.GG21066@holomorphy.com> <20040729222657.GA10449@elte.hu> <20040801193043.GA20277@elte.hu>
In-Reply-To: <20040801193043.GA20277@elte.hu>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200408011644.06537.lkml@lpbproductions.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo,

I get the following error below on with your patch applied on stock 
2.6.8-rc2 ...

  CC      kernel/softirq.o
  CC      kernel/hardirq.o
kernel/hardirq.c:51: error: conflicting types for 'generic_handle_IRQ_event'
include/linux/irq.h:78: error: previous declaration of 
'generic_handle_IRQ_event' was here
kernel/hardirq.c:51: error: conflicting types for 'generic_handle_IRQ_event'
include/linux/irq.h:78: error: previous declaration of 
'generic_handle_IRQ_event' was here
make[1]: *** [kernel/hardirq.o] Error 1
make: *** [kernel] Error 2


Matt H.


On Sunday 01 August 2004 12:30 pm, Ingo Molnar wrote:
> here's the latest version of the voluntary-preempt patch:
>
>   http://redhat.com/~mingo/voluntary-preempt/voluntary-preempt-2.6.8-rc2-O2
>
> this patch is mainly a stabilization effort. I dropped the irq-threads
> code added in -M5 and rewrote it from scratch based on -L2 - it is
> simpler and should be more robust.
>
> The same /proc/irq/* configuration switches are still present, but i
> added the following additional rule: if _any_ handler of a given IRQ is
> marked as non-threaded then all handlers will be executed non-threaded
> as well.
>
> E.g. if you have the following handlers on IRQ 10:
>
>  10:      11584   IO-APIC-level  eth0, eth1, eth2
>
> and you change /proc/irq/16/eth1/threaded from 1 to 0 then the eth0 and
> eth2 handlers will be executed non-threaded as well. (This rule only
> enforces what the hardware enforces anyway, none of the previous patches
> allowed true separation of these handlers.)
>
> i also changed the IO-APIC level-triggered code to be robust when
> redirection is done. The noapic workaround should not be necessary
> anymore.
>
> the keyboard lockups are now hopefully all gone too - i've tested
> IO-APIC and non-IO-APIC setups as well and NumLock/ScrollLock works fine
> in all sorts of workloads.
>
> Let me know if you still have any problems.
>
> 	Ingo
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
