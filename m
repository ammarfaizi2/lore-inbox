Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262844AbTLPVx3 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Dec 2003 16:53:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262859AbTLPVx3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Dec 2003 16:53:29 -0500
Received: from gateway-1237.mvista.com ([12.44.186.158]:16376 "EHLO
	av.mvista.com") by vger.kernel.org with ESMTP id S262844AbTLPVx1
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Dec 2003 16:53:27 -0500
Message-ID: <3FDF7ED3.5020802@mvista.com>
Date: Tue, 16 Dec 2003 13:53:23 -0800
From: George Anzinger <george@mvista.com>
Organization: MontaVista Software
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2) Gecko/20021202
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
CC: linux-kernel@vger.kernel.org
Subject: Re: Catching NForce2 lockup with NMI watchdog
References: <3FD5F9C1.5060704@nishanet.com> <Pine.LNX.4.55.0312101421540.31543@jurand.ds.pg.gda.pl> <brcoob$a02$1@gatekeeper.tmr.com> <3FDA40DA.20409@mvista.com> <Pine.LNX.4.55.0312151412270.26565@jurand.ds.pg.gda.pl> <3FDE2AC6.30902@mvista.com> <Pine.LNX.4.55.0312161426060.8262@jurand.ds.pg.gda.pl> <3FDF4060.30303@mvista.com> <Pine.LNX.4.55.0312162141070.8262@jurand.ds.pg.gda.pl>
In-Reply-To: <Pine.LNX.4.55.0312162141070.8262@jurand.ds.pg.gda.pl>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Maciej W. Rozycki wrote:
> On Tue, 16 Dec 2003, George Anzinger wrote:
> 
> 
>>This is for the VST code where we want to stop the timer interrupts for a bit IF 
>>and only if we are in the idle task AND there are no timers to service, i.e. the 
>>interrupt would be useless.  We don't want to mess with the PIT program as that 
>>would mess up the time when we turn it on again.  So we just want to stop a few 
>>interrupts from time to time.  We catch up after turning the PIT back on by 
>>using the TSC or pm_timer or some other source that keeps something close to 
>>reasonable time.
> 
> 
>  I see.  Well, then disable_irq(0) may be the easiest way to do that for
> the regular timer interrupt.  For the NMI watchdog from the I/O APIC you'd
> use disable_8259A_irq(0) and for one from the local APIC -- just mask the
> APIC_LVTPC interrupt (there's no wrapper function, but that's easy).

How confusing :(  Could you give me some idea how this works?  I have tried 
disable_irq(0) and, as best as I can tell, it does not do the trick.  The 
confusion I have is understanding where in the chain of hardware each of these 
thing is taking place.

For example, it would be "nice" if I could just turn off the PIT interrupt line 
so that both the NMI (PIT generated) and the PIT interrupt would be put on hold. 
  Your answer seems to indicate that disable_irq() is working down stream from 
where the NMI signal is connected to the PIT interrupt line, so we need to turn 
of the NMI as well.  A picture would be nice here :)

> 

-- 
George Anzinger   george@mvista.com
High-res-timers:  http://sourceforge.net/projects/high-res-timers/
Preemption patch: http://www.kernel.org/pub/linux/kernel/people/rml

