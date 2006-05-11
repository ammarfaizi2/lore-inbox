Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751819AbWEKO5Y@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751819AbWEKO5Y (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 May 2006 10:57:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751818AbWEKO5Y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 May 2006 10:57:24 -0400
Received: from 216-54-166-5.gen.twtelecom.net ([216.54.166.5]:51641 "EHLO
	mx1.compro.net") by vger.kernel.org with ESMTP id S1751819AbWEKO5X
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 May 2006 10:57:23 -0400
Message-ID: <446350CF.3010204@compro.net>
Date: Thu, 11 May 2006 10:57:19 -0400
From: Mark Hounschell <markh@compro.net>
Reply-To: markh@compro.net
Organization: Compro Computer Svcs.
User-Agent: Thunderbird 1.5 (X11/20060111)
MIME-Version: 1.0
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Ingo Molnar <mingo@elte.hu>, linux-kernel <linux-kernel@vger.kernel.org>,
       Daniel Walker <dwalker@mvista.com>
Subject: Re: rt20 patch question
References: <446089CF.3050809@compro.net> <1147185483.21536.13.camel@c-67-180-134-207.hsd1.ca.comcast.net> <4460ADF8.4040301@compro.net> <Pine.LNX.4.58.0605100827500.3282@gandalf.stny.rr.com> <4461E53B.7050905@compro.net> <Pine.LNX.4.58.0605100938100.4503@gandalf.stny.rr.com> <446207D6.2030602@compro.net> <Pine.LNX.4.58.0605101215220.19935@gandalf.stny.rr.com> <44623157.9090105@compro.net> <Pine.LNX.4.58.0605101446090.22959@gandalf.stny.rr.com> <44623ED4.1030103@compro.net> <44631F1B.8000100@compro.net> <Pine.LNX.4.58.0605110739520.5610@gandalf.stny.rr.com> <Pine.LNX.4.58.0605110805470.5610@gandalf.stny.rr.com> <446335EA.3000506@compro.net> <Pine.LNX.4.58.0605110913220.6863@gandalf.stny.rr.com> <44633B78.8080907@compro.net> <Pine.LNX.4.58.0605110940001.7359@gandalf.stny.rr.com>
In-Reply-To: <Pine.LNX.4.58.0605110940001.7359@gandalf.stny.rr.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Steven Rostedt wrote:
> On Thu, 11 May 2006, Mark Hounschell wrote:
> 
> You can also try just
> 
> # echo t > /proc/sysrq-trigger
> 
>> dmesg only shows the BUGs. I have nothing connect to my serial port. I
>> certainly can if I need to.
> 
> Sometimes a serial capture is easier to log, but you don't really need to
> do it.  That's up to you.
> 
>> When finally the network connection closes all my threads must be in
>> fairly good shape because if I simply restart the network software
>> inside the emulation I'm good to go again.
> 
> Hmm, I'm starting to think that this is not really a problem with the -rt
> implementation, and my earlier patch to turn off the BUG dump, is OK.
> 

You could be right. The only thing I am certain is rt20 related is those
"stops" we are also talking about in complete-preempt mode. I can only
say for sure that These BUGs are not seen using a 2.4.13.4 kernel. That
kernel and this app are considered stable to me. All else is fair game.

> What RT prio is the network interrupt at?
> 

Here is a detailed list of the RT tasks running with prios, cpu masks
etc. There are 3 nics. eth1 is the nic being used by the emulation. eth2
is currently unused.

pid      SCHED        PRIO      CPUM TASK
---      ----         ----      ---- ----
2        FIFO         99           1 (unknown)
3        FIFO         99           1 (unknown)
4        FIFO         1            1 (unknown)
5        FIFO         1            1 (unknown)
6        FIFO         1            1 (unknown)
7        FIFO         1            1 (unknown)
8        FIFO         1            1 (unknown)
9        FIFO         1            1 (unknown)
10       FIFO         1            1 (unknown)
12       FIFO         99           2 (unknown)
13       FIFO         99           2 (unknown)
14       FIFO         1            2 (unknown)
15       FIFO         1            2 (unknown)
16       FIFO         1            2 (unknown)
17       FIFO         1            2 (unknown)
18       FIFO         1            2 (unknown)
19       FIFO         1            2 (unknown)
20       FIFO         1            2 (unknown)
22       FIFO         1            1 (unknown)
23       FIFO         1            2 (unknown)
39       FIFO  acpi   49 [IRQ 9]   1 (unknown)
1129     FIFO  rtc    48 [IRQ 8]   1 (unknown)
1135     FIFO  i8042  47 [IRQ 12]  1 (unknown)
1145     FIFO  floppy 46 [IRQ 6]   1 (unknown)
1178     FIFO  i8042  45 [IRQ 1]   1 (unknown)
1268     FIFO  ide0   44 [IRQ 14]  1 (unknown)
1313     FIFO  ide1   43 [IRQ 15]  1 (unknown)

1362     FIFO         42 [IRQ 169] 1 (unknown)
     ide2, aic7xxx, aic7xxx, eth1, eth2,
     gpiohsd, gpiohsd, gpiohsd, gpiohsd, eprm

2663     FIFO ???     41 [IRQ 4]   1 (unknown)
2667     FIFO ???     40 [IRQ 3]   1 (unknown)
3420     FIFO 82801BA 39 [IRQ 177] 1 (unknown)
5788     FIFO eth0    38 [IRQ 185] 1 (unknown)
8036     FIFO rtom    37 [IRQ 193] 2 (unknown)
10338    FIFO EMU-CPU 33           2 ./vrsx
10339    FIFO         9            1 ./vrsx
10340    FIFO         9            1 ./vrsx
10341    FIFO         9            1 ./vrsx
10342    FIFO         9            1 ./vrsx
10343    FIFO         23           1 ./vrsx
10344    FIFO         23           1 ./vrsx
10345    FIFO         9            1 ./vrsx
10346    FIFO         9            1 ./vrsx
10347    FIFO         9            1 ./vrsx
10348    FIFO         9            1 ./vrsx
10349    FIFO         9            1 ./vrsx
10350    FIFO         9            1 ./vrsx
10351    FIFO         9            1 ./vrsx
10356    FIFO         10           1 ./vrsx
10357    FIFO         9            1 ./vrsx
10358    FIFO         11           1 ./vrsx
10363    FIFO         10           1 ./vrsx
10364    FIFO         9            1 ./vrsx
10365    FIFO         11           1 ./vrsx
10366    FIFO         9            1 ./vrsx
10367    FIFO         9            1 ./vrsx
10368    FIFO         9            1 ./vrsx
10369    FIFO         9            1 ./vrsx
10370    FIFO         9            1 ./vrsx
10371    FIFO         16           1 ./vrsx
10372    FIFO         16           1 ./vrsx
10373    FIFO         16           1 ./vrsx
10374    FIFO         16           1 ./vrsx
10375    FIFO         15           1 ./vrsx
10376    FIFO         15           1 ./vrsx
10377    FIFO         15           1 ./vrsx
10378    FIFO         15           1 ./vrsx
10379    FIFO         15           1 ./vrsx
10380    FIFO         15           1 ./vrsx
10381    FIFO         15           1 ./vrsx
10382    FIFO         15           1 ./vrsx
10383    FIFO         15           1 ./vrsx
10384    FIFO         15           1 ./vrsx
10385    FIFO         15           1 ./vrsx
10386    FIFO         15           1 ./vrsx
10387    FIFO         15           1 ./vrsx
10388    FIFO         15           1 ./vrsx
10389    FIFO         15           1 ./vrsx
10390    FIFO         15           1 ./vrsx
10391    FIFO         15           1 ./vrsx
10392    FIFO         9            1 ./vrsx
10393    FIFO         9            1 ./vrsx

> What seems to be happening is that the vortex_timer is going off while the
> interrupt is running.  Hence the disable_irq fails and schedules.
> 
> Perhaps the interrupt thread has been preempted by some high priority task
> and causes it to lose a connection.
> 
> Yeah that task output would be helpful to see if you can get it to work.

Ok I have this but it is 2000+ lines. I probably don't want to put it on
the list. Should I send it to you directly?

> Also can you show us the output of /proc/interrupts so we know which
> threads are associated to the network card interrupt, and see where they
> are.
> 

harley:/home/markh/work/lcrs-linux # cat /proc/interrupts
           CPU0       CPU1
  0:     450333          0  IO-APIC-edge   [........N/  0]  pit
  1:       4288          0  IO-APIC-edge   [........./  1]  i8042
  8:          2          0  IO-APIC-edge   [........./  0]  rtc
  9:          0          0  IO-APIC-level  [........./  0]  acpi
 12:      66129          0  IO-APIC-edge   [........./  1]  i8042
 14:       3523          0  IO-APIC-edge   [........./  0]  ide0
 15:      65675          0  IO-APIC-edge   [........./  0]  ide1
169:     219209          0  IO-APIC-level  [........./  0]  ide2,
aic7xxx, aic7xxx, eth1, eth2, gpiohsd, gpiohsd, gpiohsd, gpiohsd, eprm
177:       1821          0  IO-APIC-level  [........./  0]  Intel
82801BA-ICH2
185:     185550          0  IO-APIC-level  [........./  0]  eth0
193:          0      76740  IO-APIC-level  [........./  0]  rtom
NMI:          0          0
LOC:    2657906     587751
ERR:          0
MIS:          0

The aic7xxx controllers are both connected to external legacy scsi
racks. eth1, eth2, and the aix7xxx cards are in an SBS pci expansion
chassis. The 3 gpiohsd and the 1 eprm cards are also in the expansion
rack but are not being used at all in this.

I'll send the sysreq data when I get it.

Mark


