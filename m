Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262291AbTLLW32 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Dec 2003 17:29:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262427AbTLLW3L
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Dec 2003 17:29:11 -0500
Received: from gateway-1237.mvista.com ([12.44.186.158]:43257 "EHLO
	av.mvista.com") by vger.kernel.org with ESMTP id S262291AbTLLW1n
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Dec 2003 17:27:43 -0500
Message-ID: <3FDA40DA.20409@mvista.com>
Date: Fri, 12 Dec 2003 14:27:38 -0800
From: George Anzinger <george@mvista.com>
Organization: MontaVista Software
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2) Gecko/20021202
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: macro@ds2.pg.gda.pl
CC: bill davidsen <davidsen@tmr.com>, linux-kernel@vger.kernel.org
Subject: Re: Catching NForce2 lockup with NMI watchdog
References: <3FD5F9C1.5060704@nishanet.com> <Pine.LNX.4.55.0312101421540.31543@jurand.ds.pg.gda.pl> <brcoob$a02$1@gatekeeper.tmr.com>
In-Reply-To: <brcoob$a02$1@gatekeeper.tmr.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Having had cause to try and figure out all this, I vote for the following being 
included in the source somewhere...

-g

bill davidsen wrote:
> In article <Pine.LNX.4.55.0312101421540.31543@jurand.ds.pg.gda.pl>,
> Maciej W. Rozycki <macro@ds2.pg.gda.pl> wrote:
> 
> |  The I/O APIC NMI watchdog utilizes the property of being transparent to a
> | single IRQ source of a specially reconfigured 8259A PIC (the master one in
> | the IA32 PC architecture).  There are more prerequisites that have to be
> | met and all indeed are for a 100% compatible PC as specified by the
> | Intel's Multiprocessor Specification.
> | 
> | 1. The INT output of the master 8259A PIC has to be connected to the LINT0
> | (or LINTIN0; the name varies by implementations) inputs of all local APICs
> | in the system.
> | 
> | 2a. The OUT0 output of the 8254 PIT (IOW the timer source) has to be 
> | directly connected to the INTIN2 input of the first I/O APIC.
> | 
> | 2b. Alternatively the INT output of the master 8259A PIC has to be
> | connected to the INTIN0 input of the first I/O APIC.
> | 
> | 3. There must be no glue logic that would change logical properties of the
> | signal between the INT output of the master 8259A PIC and the respective
> | APIC interrupt inputs.
> | 
> | In practice, assuming the MP IRQ routing information provided the BIOS has
> | been correct (which is not always the case), prerequisites #1 and #2 have
> | been met so far, but #3 has proved to be occasionally problematic.
> 
> In practice many system seem to take a good bit of guessing and testing.
> I have an old P-II which only works with acpi=force and nmi_watchdog=2,
> for instance.
> 
> It would be nice if there were a program which could poke at the
> hardware and suggest options which might work, as in eliminating the
> ones which can be determined not to work. Absent that trial and error
> rule, unfortunately.

-- 
George Anzinger   george@mvista.com
High-res-timers:  http://sourceforge.net/projects/high-res-timers/
Preemption patch: http://www.kernel.org/pub/linux/kernel/people/rml

