Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751025AbWELJJI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751025AbWELJJI (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 May 2006 05:09:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751093AbWELJJI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 May 2006 05:09:08 -0400
Received: from ms-smtp-01.tampabay.rr.com ([65.32.5.131]:9662 "EHLO
	ms-smtp-01.tampabay.rr.com") by vger.kernel.org with ESMTP
	id S1751025AbWELJJH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 May 2006 05:09:07 -0400
Message-ID: <4464509B.4080206@cfl.rr.com>
Date: Fri, 12 May 2006 05:08:43 -0400
From: Mark Hounschell <dmarkh@cfl.rr.com>
Reply-To: dmarkh@cfl.rr.com
User-Agent: Thunderbird 1.5 (X11/20060111)
MIME-Version: 1.0
To: Steven Rostedt <rostedt@goodmis.org>
CC: Mark Hounschell <markh@compro.net>, Ingo Molnar <mingo@elte.hu>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Daniel Walker <dwalker@mvista.com>
Subject: Re: rt20 patch question
References: <446089CF.3050809@compro.net> <1147185483.21536.13.camel@c-67-180-134-207.hsd1.ca.comcast.net> <4460ADF8.4040301@compro.net> <Pine.LNX.4.58.0605100827500.3282@gandalf.stny.rr.com> <4461E53B.7050905@compro.net> <Pine.LNX.4.58.0605100938100.4503@gandalf.stny.rr.com> <446207D6.2030602@compro.net> <Pine.LNX.4.58.0605101215220.19935@gandalf.stny.rr.com> <44623157.9090105@compro.net> <Pine.LNX.4.58.0605101446090.22959@gandalf.stny.rr.com> <44623ED4.1030103@compro.net> <44631F1B.8000100@compro.net> <Pine.LNX.4.58.0605110739520.5610@gandalf.stny.rr.com> <Pine.LNX.4.58.0605110805470.5610@gandalf.stny.rr.com> <446335EA.3000506@compro.net> <Pine.LNX.4.58.0605110913220.6863@gandalf.stny.rr.com> <44633B78.8080907@compro.net> <Pine.LNX.4.58.0605110940001.7359@gandalf.stny.rr.com> <446350CF.3010204@compro.net> <Pine.LNX.4.58.0605120221410.26721@gandalf.stny.rr.com>
In-Reply-To: <Pine.LNX.4.58.0605120221410.26721@gandalf.stny.rr.com>
X-Enigmail-Version: 0.94.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Steven Rostedt wrote:
> On Thu, 11 May 2006, Mark Hounschell wrote:
> 
>> Here is a detailed list of the RT tasks running with prios, cpu masks
>> etc. There are 3 nics. eth1 is the nic being used by the emulation. eth2
>> is currently unused.
> 
>> pid      SCHED        PRIO      CPUM TASK
>> ---      ----         ----      ---- ----
> 
> This being a SMP machine, pid 2 and 3 must be the migration threads.
> 
>> 2        FIFO         99           1 (unknown)
>> 3        FIFO         99           1 (unknown)
> 
>> 4        FIFO         1            1 (unknown)
>> 5        FIFO         1            1 (unknown)
>> 6        FIFO         1            1 (unknown)
>> 7        FIFO         1            1 (unknown)
>> 8        FIFO         1            1 (unknown)
>> 9        FIFO         1            1 (unknown)
>> 10       FIFO         1            1 (unknown)
> 
> Do you know what these processes are (12 and 13)?
> 

    2 ?        S      0:00 [migration/0]
    3 ?        S      0:00 [posix_cpu_timer]
.
.
   14 ?        S      0:00 [migration/1]
   15 ?        S      0:00 [posix_cpu_timer]

>> 12       FIFO         99           2 (unknown)
>> 13       FIFO         99           2 (unknown)
> 
> [...]
> 
>> 39       FIFO  acpi   49 [IRQ 9]   1 (unknown)
>> 1129     FIFO  rtc    48 [IRQ 8]   1 (unknown)
>> 1135     FIFO  i8042  47 [IRQ 12]  1 (unknown)
>> 1145     FIFO  floppy 46 [IRQ 6]   1 (unknown)
>> 1178     FIFO  i8042  45 [IRQ 1]   1 (unknown)
>> 1268     FIFO  ide0   44 [IRQ 14]  1 (unknown)
>> 1313     FIFO  ide1   43 [IRQ 15]  1 (unknown)
>>
> 
> FYI, The above are all of higher priority than the below.
> 
>> 1362     FIFO         42 [IRQ 169] 1 (unknown)
>>      ide2, aic7xxx, aic7xxx, eth1, eth2,
>>      gpiohsd, gpiohsd, gpiohsd, gpiohsd, eprm
> 
> Wow! that's a lot on a shared IRQ.  Do you have the ide2 being used. If
> one of these where to spin for a while, then all the below would freeze.
> Also them being preempted will also have a problem.  Perhaps you want to
> raise the priority of this interrupt thread.
> 
I'll try that when I get to work this morning.

>> 2663     FIFO ???     41 [IRQ 4]   1 (unknown)
>> 2667     FIFO ???     40 [IRQ 3]   1 (unknown)
>> 3420     FIFO 82801BA 39 [IRQ 177] 1 (unknown)
>> 5788     FIFO eth0    38 [IRQ 185] 1 (unknown)
>> 8036     FIFO rtom    37 [IRQ 193] 2 (unknown)
>> 10338    FIFO EMU-CPU 33           2 ./vrsx
> 
> [...]
> 
>>> What seems to be happening is that the vortex_timer is going off while the
>>> interrupt is running.  Hence the disable_irq fails and schedules.
>>>
>>> Perhaps the interrupt thread has been preempted by some high priority task
>>> and causes it to lose a connection.
>>>
>>> Yeah that task output would be helpful to see if you can get it to work.
>> Ok I have this but it is 2000+ lines. I probably don't want to put it on
>> the list. Should I send it to you directly?
> 

Done. Keep in mind it was taken only after one of those BUGs that seemed
to cause a network connection loss into the emulation. It was not taken
after one of those "stops" in 'complete preempt' mode. Did the logdev
output show anything of interest concerning the "stops"?

> Yes please (compress it as well).  With so much shared on an IRQ and you
> are disabling it, it might cause some large timeouts. The disable irq with
> the hardirqs as threads is a sleep (that's where you hit the bug) where as
> otherwise it just spins and waits.  So it can be a timing issue.
> 
> Could also you try running the RT kernel without hardirqs as threads to
> see if it works fine then?
> 

I assume you mean in preemptable kernel mode. Will do asap. I have 4
machines I'm attempting to use the rt20 kernel on. All 4 have the
"stop/pause" problem in complete preempt mode. This is the only one of
the 4 that I have seen the BUGs message on so I suspect you are correct
that it may be a result of hardware/configuration. I guess if raising
that irq prio or eliminating the irq threads fixes it, then.....

>>> Also can you show us the output of /proc/interrupts so we know which
>>> threads are associated to the network card interrupt, and see where they
>>> are.
>>>
>> harley:/home/markh/work/lcrs-linux # cat /proc/interrupts
>>            CPU0       CPU1
>>   0:     450333          0  IO-APIC-edge   [........N/  0]  pit
>>   1:       4288          0  IO-APIC-edge   [........./  1]  i8042
>>   8:          2          0  IO-APIC-edge   [........./  0]  rtc
>>   9:          0          0  IO-APIC-level  [........./  0]  acpi
>>  12:      66129          0  IO-APIC-edge   [........./  1]  i8042
>>  14:       3523          0  IO-APIC-edge   [........./  0]  ide0
>>  15:      65675          0  IO-APIC-edge   [........./  0]  ide1
>> 169:     219209          0  IO-APIC-level  [........./  0]  ide2,
>> aic7xxx, aic7xxx, eth1, eth2, gpiohsd, gpiohsd, gpiohsd, gpiohsd, eprm
>> 177:       1821          0  IO-APIC-level  [........./  0]  Intel
>> 82801BA-ICH2
>> 185:     185550          0  IO-APIC-level  [........./  0]  eth0
>> 193:          0      76740  IO-APIC-level  [........./  0]  rtom
>> NMI:          0          0
>> LOC:    2657906     587751
>> ERR:          0
>> MIS:          0
> 
> I see you are pinning all the irqs to CPU0
> 

All except the rtom irq. It is on the same processor as the emulations
CPU thread. Even with the rt20 patch, this is still the only way to
insure deterministic delivery of signals and such from the rtom driver
to the emulations CPU thread. What I find with the rt20 patch (so far)
is that now there seems to be an acceptable(sort of) "max" latency
(-200usec) that allows me to use the machine for things other than just
the emulation.

>> The aic7xxx controllers are both connected to external legacy scsi
>> racks. eth1, eth2, and the aix7xxx cards are in an SBS pci expansion
>> chassis. The 3 gpiohsd and the 1 eprm cards are also in the expansion
>> rack but are not being used at all in this.
> 
> So all but the 3 gpiohsd and eprm are being used?  Still that seems to be
> a lot.  But anyway, send me the compressed task dump, and I'll take a
> look.  Maybe it will shed some light.

Actually eth2 is not being used either. Only one of the scsi controllers
is being used and it only when I boot the emulation from one of the
legacy scsi drives. One scsi card has a bus of tapes the other disks.
When I boot the emulation from a virtual disk file it's not used at all.
IDE2 is my 'linux' boot drive however.

So do you think this BUG reported in 'preempt kernel' mode is related to
the "stops" I am having in 'complete preempt mode?

Mark
