Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261872AbUCILRL (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Mar 2004 06:17:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261878AbUCILRK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Mar 2004 06:17:10 -0500
Received: from mailgate.uni-paderborn.de ([131.234.22.32]:62883 "EHLO
	mailgate.uni-paderborn.de") by vger.kernel.org with ESMTP
	id S261872AbUCILRA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Mar 2004 06:17:00 -0500
Message-ID: <404DA7A8.4090109@uni-paderborn.de>
Date: Tue, 09 Mar 2004 12:16:56 +0100
From: Bjoern Schmidt <lucky21@uni-paderborn.de>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; de-AT; rv:1.5) Gecko/20031107 Debian/1.5-3
X-Accept-Language: en
MIME-Version: 1.0
To: len.brown@intel.com
CC: linux-kernel@vger.kernel.org
Subject: Re: fsb of older cpu
References: <A6974D8E5F98D511BB910002A50A6647615F47CB@hdsmsx402.hd.intel.com> <1078815523.2342.535.camel@dhcppc4>
In-Reply-To: <1078815523.2342.535.camel@dhcppc4>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-UNI-PB_FAK-EIM-MailScanner-Information: Please see http://imap.uni-paderborn.de for details
X-UNI-PB_FAK-EIM-MailScanner: Found to be clean
X-UNI-PB_FAK-EIM-MailScanner-SpamCheck: not spam, SpamAssassin (score=0,
	required 4)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Len,

> C-states should be called Idle-states -- they're entered when the
> processor is idle.  No instructions are executed when in a C-state > 0.

i know about the acpi spec ;)

> 
> C1 is supported by all processors automatically with some carefully
> placed insructions inside the idle loop.  Not all processors suport
> higher C-states with more power savings in idle.  You'll be able to tell
> what is supported and what is used by looking in /proc/acpi/CPU0/power. 
> I'm not sure we update the counter to reflect entering C1...

The supported modes are:

root@kilobyte:/proc/acpi/processor/C097# cat power
active state:        C2
default state:       C1
bus master activity: 00000000
states:
     C1:              promotion[C2] demotion[--] latency[000] usage[00000240]
    *C2:              promotion[--] demotion[C1] latency[100] usage[169083068]
     C3:              <not supported>

Do you know a little program to visualize the fadt flags in a human
readable way?

> 
> Then there are P-states -- performance states.  These are used by the
> various cpufreq drivers such as speed-step(tm;-).  These can modulate
> both voltage and Mhz at the same time depending on load and are thus the
> most effective and most desireable way to save cpu power w/ minimal
> performance impact.

In the BIOS there is an option to half the core freq in idle, is
it possible to create a proc interface to set it statically to
the half?

In the System Programming Guide i can read that i can reprogram the
clock multiplier by setting RESET# to low and A20M#, IGNNE#, LINT[1]
and LINT[0] to 1111 for 1/2. Unfortunately i dont know how to
program this in assembler code, i can several programming
languages, but not yet asm :(
Can you recommend a good online book?

> 
> Thermal throttling is  something else.  This is invoked as the
> passive-colling method of last resort when the processor is very hot
> (busy).  The actual clock to the processor is modulated so that it slows
> down and thus power is saved in proportion to how much it is slowed
> down.  Throttling will noticeably slow down your system when you want it
> fast the most -- heavy load.

On my system the passive cooling is always active, but i am sure
that it does not work or at least not correctly.

root@kilobyte:/tmp# cat /proc/acpi/processor/C097/throttling
state count:             8
active state:            T7
states:
     T0:                  00%
     T1:                  12%
     T2:                  25%
     T3:                  37%
     T4:                  50%
     T5:                  62%
     T6:                  75%
    *T7:                  87%

T7 equals that only 13% of performance ist available,
but i cannot determine any slowdown on my system.

root@kilobyte:/tmp# cat /proc/acpi/thermal_zone/C105/*
cooling mode:            passive
<polling disabled>
state:                   passive
temperature:             91 C
critical (S5):           95 C
passive:                 48 C: tc1=1 tc2=2 tsp=200 devices=0xc11dc6a8
active[0]:               94 C: devices=0xc11d5268
active[1]:               92 C: devices=0xc11d4be8

If throttling is active, how is it possible that the temperature
is so high? The current load average is 0.00, 0.04, 0.07.
The system is only under heavy load every day 6:40am for one
hour.

The trip_points are usually 95:0:48:70:65. I set them to these
high values to test how hot the cpu can get with activated
passive cooling and without fan-cooling.

> 
> Of course, then there is active cooling -- fan control...

I prefer passive cooling because i want to avoid that
the fan will ever be turned on.


-- 
Mit freundlichen Gruessen
Bjoern Schmidt


