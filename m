Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268626AbTGOPRN (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Jul 2003 11:17:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268470AbTGOPPf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Jul 2003 11:15:35 -0400
Received: from chaos.analogic.com ([204.178.40.224]:41092 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP id S268522AbTGOPOY
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Jul 2003 11:14:24 -0400
Date: Tue, 15 Jul 2003 11:31:17 -0400 (EDT)
From: "Richard B. Johnson" <root@chaos.analogic.com>
X-X-Sender: root@chaos
Reply-To: root@chaos.analogic.com
To: Kathy Frazier <kfrazier@mdc-dayton.com>
cc: Andi Kleen <ak@muc.de>, linux-kernel@vger.kernel.org
Subject: RE: Interrupt doesn't make it to the 8259 on a ASUS P4PE mobo
In-Reply-To: <PMEMILJKPKGMMELCJCIGOEKNCCAA.kfrazier@mdc-dayton.com>
Message-ID: <Pine.LNX.4.53.0307151125400.15686@chaos>
References: <PMEMILJKPKGMMELCJCIGOEKNCCAA.kfrazier@mdc-dayton.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 15 Jul 2003, Kathy Frazier wrote:

> Thanks for your reply, Andi.
>
> >> We have a proprietary PCI board installed in a (UP) system with an ASUS
> P4PE
> >> motherboard (uses Intel 845PE chipset). This system is running Red Hat
> 9.0
>
> >Have you checked the 845 errata sheets on the Intel website?
> >Perhaps it is some known hardware bug.
>
> >One thing you could try is to use Local APIC / IO APIC interrupt processing
> >instead of 8259.
>
> Our hardware engineer has combed the Intel and ASUS websites, but found
> nothing.  I'll give the APIC a try and see if I get different results and
> let you know.
>
> >>
> >> /* start timer */
> >> dmatimer.expires = jiffies + 0.5*HZ;
>
> >That's a serious bug. You cannot use floating point in the kernel.
> >It will corrupt the FP state of the user process.
>
> HZ on the INTEL platform is 100, so this should simply add 50 to the current
> value of jiffies.  Besides, assigning the value to the unsigned int field
> (expires) will truncate it to an integer anyway.  Is there a more
> appropriate way to handle a short timeout?

It will truncate it at runtime.

I suggest

	dmatimer.expires = jiffies + HZ/2;

Also, you you need to use the time_before() macro, like

	while ( time_before(jiffies, dmatimer.expires) )
            do_something();

... so you don't have a timer-wrap problem during jiffie rollover if
you haven't already done so (I don't have your source here).

>
> Thanks,
> Kathy


Cheers,
Dick Johnson
Penguin : Linux version 2.4.20 on an i686 machine (797.90 BogoMips).
Why is the government concerned about the lunatic fringe? Think about it.

