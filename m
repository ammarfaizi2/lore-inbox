Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261881AbTLPR1D (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Dec 2003 12:27:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261956AbTLPR1D
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Dec 2003 12:27:03 -0500
Received: from gateway-1237.mvista.com ([12.44.186.158]:39153 "EHLO
	av.mvista.com") by vger.kernel.org with ESMTP id S261881AbTLPR1A
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Dec 2003 12:27:00 -0500
Message-ID: <3FDF4060.30303@mvista.com>
Date: Tue, 16 Dec 2003 09:26:56 -0800
From: George Anzinger <george@mvista.com>
Organization: MontaVista Software
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2) Gecko/20021202
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
CC: linux-kernel@vger.kernel.org
Subject: Re: Catching NForce2 lockup with NMI watchdog
References: <3FD5F9C1.5060704@nishanet.com> <Pine.LNX.4.55.0312101421540.31543@jurand.ds.pg.gda.pl> <brcoob$a02$1@gatekeeper.tmr.com> <3FDA40DA.20409@mvista.com> <Pine.LNX.4.55.0312151412270.26565@jurand.ds.pg.gda.pl> <3FDE2AC6.30902@mvista.com> <Pine.LNX.4.55.0312161426060.8262@jurand.ds.pg.gda.pl>
In-Reply-To: <Pine.LNX.4.55.0312161426060.8262@jurand.ds.pg.gda.pl>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Maciej W. Rozycki wrote:
> On Mon, 15 Dec 2003, George Anzinger wrote:
> 
> 
>>> Hmm, you could have simply asked... ;-)  Anyway, an inclusion is doable,
>>>I guess.
>>
>>I suspect I did, but most likey the wrong place.  In any case, I would like to 
>>think that "read the source, Luke" is the right answer.
> 
> 
>  Certainly it is, but not necessarily the only one. ;-)
> 
> 
>>So, while I am in the asking mode, is there a simple way to turn off the PIT 
>>interrupt without changing the PIT program?  I would like a way to stop the 
>>interrupts AND also stop the NMIs that it generates for the watchdog.  I suspect 
>>that this is a bit more complex that it would appear, due to how its wired.
> 
> 
>  Well, in PC/AT compatible implementations, the counter #0 of the PIT has
> its gate hardwired to active, so you cannot mask the PIT output itself.  
> So the only other choices are either reprogramming the counter to a mode
> that won't cause periodic triggers (which is probably the easiest way, but
> you don't want to do that for some purpose, right?) or reprogramming
> interrupt controllers not to accept interrupts arriving from the PIT.
> 
>  Note that Linux may behave strangely then. ;-)

This is for the VST code where we want to stop the timer interrupts for a bit IF 
and only if we are in the idle task AND there are no timers to service, i.e. the 
interrupt would be useless.  We don't want to mess with the PIT program as that 
would mess up the time when we turn it on again.  So we just want to stop a few 
interrupts from time to time.  We catch up after turning the PIT back on by 
using the TSC or pm_timer or some other source that keeps something close to 
reasonable time.
> 

-- 
George Anzinger   george@mvista.com
High-res-timers:  http://sourceforge.net/projects/high-res-timers/
Preemption patch: http://www.kernel.org/pub/linux/kernel/people/rml

