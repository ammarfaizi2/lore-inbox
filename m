Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965204AbWE1BNo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965204AbWE1BNo (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 27 May 2006 21:13:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965206AbWE1BNo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 27 May 2006 21:13:44 -0400
Received: from ms-smtp-02.nyroc.rr.com ([24.24.2.56]:65408 "EHLO
	ms-smtp-02.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S965204AbWE1BNo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 27 May 2006 21:13:44 -0400
Subject: Re: [-rt BUG] scheduling with irqs disabled: swapper
From: Steven Rostedt <rostedt@goodmis.org>
To: john stultz <johnstul@us.ibm.com>
Cc: Ingo Molnar <mingo@elte.hu>, Thomas Gleixner <tglx@linutronix.de>,
       mingo@redhat.com, lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <1148775233.30211.1.camel@leatherman>
References: <1f1b08da0605261553v5e55ebdfpc790ebd5e5b0add8@mail.gmail.com>
	 <1148692456.5381.7.camel@localhost.localdomain>
	 <1148775233.30211.1.camel@leatherman>
Content-Type: text/plain
Date: Sat, 27 May 2006 21:13:26 -0400
Message-Id: <1148778806.5381.11.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.2.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2006-05-27 at 17:13 -0700, john stultz wrote:
> On Fri, 2006-05-26 at 21:14 -0400, Steven Rostedt wrote:
> > On Fri, 2006-05-26 at 15:53 -0700, john stultz wrote:
> > > Hey Ingo, All,
> > > 	We had the following bug reported on bootup on one of our boxes (it
> > > was a 4way I believe) running -rt22. So far it seems to be a one-off
> > > but I figured I'd post it to see if anyone had a clue.
> > 
> > I'm assuming this is a i386.  Also I'm assuming that frame pointers was
> > not compiled in since the stack is a little suspicious.
> > 
> > Anyway, could you show the /proc/interrupts of this machine.  I'm
> > curious if the i8042 isn't sharing an interrupt with something with
> > NODELAY in it.
> 
> Here ya go:
>             CPU0       CPU1       CPU2       CPU3
>    0:       8796    3868607        275     531673  IO-APIC-edge   [........N/  0]  pit
>    2:          0          0          0          0  XT-PIC         [........N/  0]  cascade
>    3:          5        620          2        229  IO-APIC-edge   [........./ 63]  serial
>    8:          0          1          0          0  IO-APIC-edge   [........./  0]  rtc
>   11:          0          0          0          0  IO-APIC-edge   [........./  0]  acpi
>   19:        120          0          0          1  IO-APIC-level  [........./  0]  ohci_hcd:usb1, ohci_hcd:usb2
>   24:         57          9          5      46795  IO-APIC-level  [........./  0]  eth0
>   26:       1396      14537          0        702  IO-APIC-level  [........./  0]  ioc0
>  NMI:          0          0          0          0
>  LOC:    6907796    4419008    4415669    4413513
>  ERR:          0
>  MIS:          0

Thanks, but I was looking more into the code, and I'm wondering...
Does this machine have "irqfixup" or "irqpoll" set in the kernel command
line?

I think that -rt doesn't support it yet.  That is, it can call a handler
from interrupt context, which should have been a thread.

Let me know if that was the case.

-- Steve


