Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264127AbTEaDY7 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 May 2003 23:24:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264129AbTEaDY7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 May 2003 23:24:59 -0400
Received: from main.gmane.org ([80.91.224.249]:59812 "EHLO main.gmane.org")
	by vger.kernel.org with ESMTP id S264127AbTEaDY6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 May 2003 23:24:58 -0400
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: "Brian J. Murrell" <brian@interlinx.bc.ca>
Subject: Re: local apic timer ints not working with vmware: nolocalapic
Date: Fri, 30 May 2003 23:38:16 -0400
Message-ID: <pan.2003.05.31.03.38.16.701826@interlinx.bc.ca>
References: <2C8EEAE5E5C@vcnet.vc.cvut.cz> <20030528173432.GA21379@linux.interlinx.bc.ca> <Pine.LNX.4.50.0305281341160.1982-100000@montezuma.mastecende.com> <pan.2003.05.30.22.14.35.511205@interlinx.bc.ca> <Pine.LNX.4.50.0305301907230.29718-100000@montezuma.mastecende.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Complaints-To: usenet@main.gmane.org
User-Agent: Pan/0.14.0 (I'm Being Nibbled to Death by Cats!)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 30 May 2003 19:23:33 -0400, Zwane Mwaikambo wrote:
> 
> Considering the dalay, i'll resend and give it another go, but generally 
> it means it's not going anywhere.

That sucks.

> 
>> The unfortunate thing is that even this sort of fix will not help my
>> situation.  The reason being (which I only discovered by accident when I
>> set "dont_enable_local_apic = 1" rather than "dont_use_local_apic_timer"
>> and it didn't correct the booting problem) is that it seems that even if
>> the local apic is set disabled by setting dont_enable_local_apic = 1 in
>> arch/i386/kernel/apic.c, setup_APIC_clocks() is still called.
> 
> How did you determine that?

Well, originally it was a mistake in setting the wrong flag to 1
(dont_enable_local_apic rather than dont_use_local_apic_timer) and finding
that it did not cure the problem, when I went back to my change to figure
out why, I noticed that I had set the wrong flag.

> Was this with my patch applied?

I did not try your patch since I did pretty much the same thing with my
"mistake" described above.

> I 
> originally did this patch for the exact same problem (buggy local APIC 
> implimentation).

I know nothing about the APIC stuff, but it seems strange that even though
it's disabled (dont_enable_local_apic = 1) setup_APIC_clocks() is still
called.  Maybe the latter is not dependent on the former, so there should
not be a dependence on dont_enable_local_apic == 0 for setup_APIC_clocks()
to still be used.

> Linux version 2.5.70-mm1 (zwane@montezuma.mastecende.com) (gcc version 
> Kernel command line: nolapic nmi_watchdog=2 ro root=/dev/hda1 profile=2 
> debug console=tty0 cons0
> kernel profiling enabled
> Initializing CPU#0
> CPU0: Intel Celeron (Mendocino) stepping 05
> per-CPU timeslice cutoff: 365.65 usecs.
> task migration cache decay timeout: 1 msecs.
> SMP motherboard not detected.
> Local APIC not detected. Using dummy APIC emulation.
> Starting migration thread for cpu 0

Yes, it's further along in the boot where my system runs into trouble,
right here:

Using local APIC timer interrupts.
calibrating APIC timer ...
..... CPU clock speed is 1658.7651 MHz.
..... host bus clock speed is 0.0000 MHz.
cpu: 0, clocks: 0, slice: 0

I will take another stab at all of this tomorrow to double-verify what I
am saying here regarding the use of local APIC timer interrupts even if
the local apic usage flag is set to disable (dont_enable_local_apic = 1).

b.


