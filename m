Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261344AbTLHTZF (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Dec 2003 14:25:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261506AbTLHTZF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Dec 2003 14:25:05 -0500
Received: from ms-smtp-01-lbl.southeast.rr.com ([24.25.9.100]:60564 "EHLO
	ms-smtp-01-eri0.southeast.rr.com") by vger.kernel.org with ESMTP
	id S261344AbTLHTXu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Dec 2003 14:23:50 -0500
Message-ID: <3FD4CFEA.6040507@kanar.net>
Date: Mon, 08 Dec 2003 14:24:26 -0500
From: Matthew Kanar <mkanarlists@kanar.net>
User-Agent: Mozilla/5.0 (Windows; U; WinNT4.0; en-US; rv:1.5) Gecko/20031007
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: SMP broken on Dell PowerEdge 4100/200 under 2.6.0-testxx?
References: <10wU2-1mR-11@gated-at.bofh.it> <10wU2-1mR-13@gated-at.bofh.it> <10wU2-1mR-15@gated-at.bofh.it> <10wU3-1mR-17@gated-at.bofh.it> <10wU3-1mR-19@gated-at.bofh.it> <10wU3-1mR-21@gated-at.bofh.it> <10wU3-1mR-23@gated-at.bofh.it> <10wU3-1mR-25@gated-at.bofh.it> <10wU2-1mR-9@gated-at.bofh.it> <10xGk-38t-15@gated-at.bofh.it>
In-Reply-To: <10xGk-38t-15@gated-at.bofh.it>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Zwane Mwaikambo wrote:
> Are you sure you're not running the userspace irq balancer (ps ax | grep
> irqbalance)?

<blush>

Well, userspace irqbalancer wasn't running, but it was started and then
stopped during the system startup.  My apologies.

A few changes in the rcX.d directories and a few reboots later, I have
found that this system exhibits similar behavior to that of others in
this thread.

/proc/interrupts without noirqbalance:
            CPU0       CPU1
   0:     331404         14    IO-APIC-edge  timer
   1:         10          1    IO-APIC-edge  i8042
   2:          0          0          XT-PIC  cascade
   8:          0          1    IO-APIC-edge  rtc
  12:         49          1    IO-APIC-edge  i8042
  14:       5503          0    IO-APIC-edge  ide0
  15:          1          0    IO-APIC-edge  ide1
  16:       1004          1   IO-APIC-level  eth0
NMI:          0          0
LOC:     331292     331291
ERR:          0
MIS:          0

/proc/interrupts with noirqbalance:

            CPU0       CPU1
   0:      70723     137438    IO-APIC-edge  timer
   1:          2          9    IO-APIC-edge  i8042
   2:          0          0          XT-PIC  cascade
   8:          1          0    IO-APIC-edge  rtc
  12:          2         48    IO-APIC-edge  i8042
  14:       3222       1850    IO-APIC-edge  ide0
  15:          1          0    IO-APIC-edge  ide1
  16:        471        459   IO-APIC-level  eth0
NMI:          0          0
LOC:     208023     208022
ERR:          0
MIS:          0

--Matt Kanar



