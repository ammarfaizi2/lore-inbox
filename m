Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262993AbUCLVw1 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Mar 2004 16:52:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262994AbUCLVw1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Mar 2004 16:52:27 -0500
Received: from 162.100.172.209.cust.nextweb.net ([209.172.100.162]:53457 "EHLO
	jlundell.local") by vger.kernel.org with ESMTP id S262993AbUCLVwP
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Mar 2004 16:52:15 -0500
Mime-Version: 1.0
Message-Id: <p06100330bc77e10e4915@[192.168.0.3]>
In-Reply-To: <16464.18916.155063.971896@alkaid.it.uu.se>
References: <p0610038abc75b353d82c@[192.168.0.3]>
 <16464.18916.155063.971896@alkaid.it.uu.se>
Date: Fri, 12 Mar 2004 13:52:09 -0800
To: linux-kernel@vger.kernel.org
From: Jonathan Lundell <linux@lundell-bros.com>
Subject: Re: nmi oddity
Content-Type: text/plain; charset="us-ascii" ; format="flowed"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At 12:13 PM +0100 3/11/04, Mikael Pettersson wrote:
>Jonathan Lundell writes:
>  > Running smp 2.4.9 (don't ask) with updated nmi logic on a Dell 650
>  > (UP P4), I notice that NMI is running at about 1.08 Hz. Per the
>  > kernel logic, it should be running at HZ (100) Hz.
>  >
>  > I'm using NMI_LOCAL_APIC. check_nmi_watchdog() never gets called in
>  > this mode in an smp kernel, near as I can tell, so nmi_hz never gets
>  > set to 1.
>  >
>  > What's going on? Or does anyone else see it?
>
>This is a normal. The NMIs are generated from an in-CPU performance
>counter configured to increment once per CPU core clock cycle.
>(There is no wallclock-like event available, alas.)
>
>Whenever the kernel is idle, "hlt" is normally executed which
>stops the CPU until the next external interrupt (typically the
>timer). Hence, an idle machine will see a much lower NMI frequence
>than a non-idle one.

That's exactly what's happening; thanks.

If I run a compute-intensive task in the background (eg cat 
/dev/zero > /dev/null), the nmi frequency jumps up to 100 Hz.

Switching to NMI_IO_APIC is the best solution for me.

It makes NMI_LOCAL_APIC a v. questionable choice for a watchdog....

>This behaviour is not universal. Server Tualatins seem to run at
>full speed all the time; perhaps they ignore hlt?
>
>If you want NMI_LOCAL_APIC to be clock-like, upgrade your cooling
>solution and disable hlt.
>
>/Mikael
>-
>To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
>the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html
>Please read the FAQ at  http://www.tux.org/lkml/


-- 
/Jonathan Lundell.
