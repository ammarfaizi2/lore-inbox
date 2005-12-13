Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932512AbVLMH0j@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932512AbVLMH0j (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Dec 2005 02:26:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932529AbVLMH0j
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Dec 2005 02:26:39 -0500
Received: from mini.brewt.org ([216.18.5.212]:34831 "HELO mini.brewt.org")
	by vger.kernel.org with SMTP id S932525AbVLMH0i convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Dec 2005 02:26:38 -0500
Date: Mon, 12 Dec 2005 23:26:37 -0800
From: "Adrian Yee" <brewt-linux-kernel@brewt.org>
Subject: tsc clock issues with dual core and question about irq balancing
To: linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Message-Id: <GMail.1134458797.49013860.4106109506@brewt.org>
Mime-Version: 1.0
X-Gmail-Account: brewt@brewt.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I've been having tsc issues where it counts back occasionally causing
things like ping to break with errors: "Warning: time of day goes back
(-1451987us), taking countermeasures."  It seems related to
http://bugzilla.kernel.org/show_bug.cgi?id=5105 , but that bug seems to
be closed (and more x86_64 related).  I also get other timing issues
like single clicks registering as double clicks, and at times double
clicks that don't register.  In addition, if I stress the system with
something like prime95, then after about 2 minutes the system clock will
speed up where the clock advances by minutes every second.  As suggested
in bug 5105, I switched to use the pmtimer (clock=pmtmr, my system
doesn't seem to support hpet) and it has fixed the ping and clock issue,
but my system doesn't 'feel' right.  For example, ssh'ing out of the
machine is fine, but when ssh'ing into the system a dmesg is very slow
(spurts out a few pages then pauses for 10-20 seconds, then repeat). 
Also, general desktop usage seems a little sluggish and not what a smp
system should feel like.

I'm currently running an i386 (ie. not x86_64) 2.6.15-rc5 kernel w/ SMP,
APIC and ACPI enabled (AMD Cool & Quiet disabled), an Athlon 64 X2 3800+
and EVGA nForce4 SLI (NF41) motherboard.  I previously had the processor
running on an Abit AV8 (K8T800 Pro chipset) board and was having similar
issues, so it seems to be a dual core issue.  I'd just like to add that
I'm currently testing the system with "nosmp noapic acpi=off clock=tsc"
(it was losing interrupts and wouldn't boot properly with apic/acpi on)
and so far everything seems to work (this includes ssh and desktop usage
is better).

My other question is about irq balancing - I turned it on, but it
doesn't seem to be working properly:

           CPU0       CPU1       
  0:     109208        975    IO-APIC-edge  timer
  1:       1226         10    IO-APIC-edge  i8042
  8:     275272          1    IO-APIC-edge  rtc
  9:          0          0   IO-APIC-level  acpi
 12:       4133          4    IO-APIC-edge  i8042
 14:       5135          8    IO-APIC-edge  ide0
 15:         17          8    IO-APIC-edge  ide1
 16:      25084          1   IO-APIC-level  eth0
 17:      43597          1   IO-APIC-level  eth1
 18:        185          5   IO-APIC-level  libata
 19:          0          0   IO-APIC-level  libata
 20:      11525          1   IO-APIC-level  EMU10K1
 21:      24870          1   IO-APIC-level  nvidia
NMI:          0          0 
LOC:     110119     110118 
ERR:          0
MIS:          0

Are there certain conditions where irq balancing doesn't work properly? 
Thanks.

Adrian
