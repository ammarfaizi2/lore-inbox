Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265459AbTLHP7p (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Dec 2003 10:59:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265438AbTLHP7p
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Dec 2003 10:59:45 -0500
Received: from tmr-02.dsl.thebiz.net ([216.238.38.204]:47621 "EHLO
	gatekeeper.tmr.com") by vger.kernel.org with ESMTP id S265466AbTLHP4b
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Dec 2003 10:56:31 -0500
To: linux-kernel@vger.kernel.org
Path: gatekeeper.tmr.com!davidsen
From: davidsen@tmr.com (bill davidsen)
Newsgroups: mail.linux-kernel
Subject: Re: SMP broken on Dell PowerEdge 4100/200 under 2.6.0-testxx?
Date: 8 Dec 2003 15:45:13 GMT
Organization: TMR Associates, Schenectady NY
Message-ID: <br26a9$f6j$1@gatekeeper.tmr.com>
References: <3350.192.168.1.3.1070677965.squirrel@www.coesta.com> <20031206043757.GJ8039@holomorphy.com> <1070686126.1166.0.camel@chevrolet.hybel> <20031206045409.GK8039@holomorphy.com>
X-Trace: gatekeeper.tmr.com 1070898313 15571 192.168.12.62 (8 Dec 2003 15:45:13 GMT)
X-Complaints-To: abuse@tmr.com
Originator: davidsen@gatekeeper.tmr.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <20031206045409.GK8039@holomorphy.com>,
William Lee Irwin III  <wli@holomorphy.com> wrote:
| l?r, 06.12.2003 kl. 05.37 skrev William Lee Irwin III:
| >> Yeah, it looks like it hit you too.
| >> Could you boot with noirqbalance on the kernel commandline and see if
| >> the problem goes away?
| 
| On Sat, Dec 06, 2003 at 05:48:46AM +0100, Stian Jordet wrote:
| > Wow, that actually fixed it :)
| >            CPU0       CPU1
| >   0:      65636      63667    IO-APIC-edge  timer
| >   1:        150        136    IO-APIC-edge  i8042
| >   2:          0          0          XT-PIC  cascade
| >   3:          2          1    IO-APIC-edge  serial
| >   8:          3          1    IO-APIC-edge  rtc
| >   9:          0          0   IO-APIC-level  acpi
| >  14:         18         37    IO-APIC-edge  ide0
| 
| Okay, irqbalance has gaffed (as predicted). Could you send in
| /proc/cpuinfo and /var/log/dmesg?

I think the most confusing thing about this was the choice of
"noirqbalance" as an option to mean "do balance irqs." I'm not sure that
the default to put all irqs on a single CPU is optimal in any case, but
the naming is particularly bad.

On light irq load the cache probably gets reloaded before the next
interrupt on modern CPUs, and under really heavy irq pressure I see
posts showing some overflow to other CPUs, so it's the in-between cases
which benefit. At least I hope, people did look at cache and ctx effects
before putting irqs on a single CPU, given the people I assume they are
right.

-- 
bill davidsen <davidsen@tmr.com>
  CTO, TMR Associates, Inc
Doing interesting things with little computers since 1979.
