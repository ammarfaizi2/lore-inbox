Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261879AbTLPQmT (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Dec 2003 11:42:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261929AbTLPQmT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Dec 2003 11:42:19 -0500
Received: from chaos.analogic.com ([204.178.40.224]:16003 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP id S261879AbTLPQmR
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Dec 2003 11:42:17 -0500
Date: Tue, 16 Dec 2003 11:44:25 -0500 (EST)
From: "Richard B. Johnson" <root@chaos.analogic.com>
X-X-Sender: root@chaos
Reply-To: root@chaos.analogic.com
To: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
cc: George Anzinger <george@mvista.com>,
       Linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: Catching NForce2 lockup with NMI watchdog
In-Reply-To: <Pine.LNX.4.55.0312161645100.8262@jurand.ds.pg.gda.pl>
Message-ID: <Pine.LNX.4.53.0312161135510.19922@chaos>
References: <3FD5F9C1.5060704@nishanet.com> <Pine.LNX.4.55.0312101421540.31543@jurand.ds.pg.gda.pl>
 <brcoob$a02$1@gatekeeper.tmr.com> <3FDA40DA.20409@mvista.com>
 <Pine.LNX.4.55.0312151412270.26565@jurand.ds.pg.gda.pl> <3FDE2AC6.30902@mvista.com>
 <Pine.LNX.4.55.0312161426060.8262@jurand.ds.pg.gda.pl>
 <Pine.LNX.4.53.0312160846530.17690@chaos> <Pine.LNX.4.55.0312161645100.8262@jurand.ds.pg.gda.pl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 16 Dec 2003, Maciej W. Rozycki wrote:

> On Tue, 16 Dec 2003, Richard B. Johnson wrote:
>
> > Masking OFF the timer channel 0 in the interrupt controller
> > is probably the easiest thing to do. The port is read-write,
> > and the OCW default to having it accessible.
>
>  Note we are writing about configurations involving an I/O APIC, so things
> are not that easy -- the 8254 timer IRQ may be wired in different ways.
>
> --
> +  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
> +--------------------------------------------------------------+
> +        e-mail: macro@ds2.pg.gda.pl, PGP key available        +


Well if I was trying to isolate a problem, I would make it
that easy. You boot the machine in its simplist configuration
and work "up" from there.

Although I haven't looked at recent source-code, with APIC, the
problem is even simpler. If you booted with APIC, just set
the global "using_apic_timer" to zero and, voila`, timer-ticks
stop.

Any any event, the caller needs to know that if there is
any code executing anywhere that does the equivalent of

		for(;;)
                      ;

...the machine will lock-up forever because without that timer,
there will be no preemption. Once a CPU-hog gets the CPU, only
and interrupt can get it away.


Cheers,
Dick Johnson
Penguin : Linux version 2.4.22 on an i686 machine (797.90 BogoMips).
            Note 96.31% of all statistics are fiction.


