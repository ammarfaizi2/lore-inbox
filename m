Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265174AbTLFOkh (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 6 Dec 2003 09:40:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265175AbTLFOkg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 6 Dec 2003 09:40:36 -0500
Received: from zork.zork.net ([64.81.246.102]:41346 "EHLO zork.zork.net")
	by vger.kernel.org with ESMTP id S265174AbTLFOk0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 6 Dec 2003 09:40:26 -0500
To: William Lee Irwin III <wli@holomorphy.com>
Cc: Colin Coe <colin@coesta.com>, linux-kernel@vger.kernel.org
Subject: IRQ balancing
References: <3350.192.168.1.3.1070677965.squirrel@www.coesta.com>
	<20031206024251.GG8039@holomorphy.com>
Reply-To: Sean Neakums <sneakums@zork.net>
From: Sean Neakums <sneakums@zork.net>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>, Colin Coe
 <colin@coesta.com>,  linux-kernel@vger.kernel.org
Date: Sat, 06 Dec 2003 14:40:19 +0000
In-Reply-To: <20031206024251.GG8039@holomorphy.com> (William Lee Irwin,
 III's message of "Fri, 5 Dec 2003 18:42:51 -0800")
Message-ID: <6u1xri2eng.fsf_-_@zork.zork.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

William Lee Irwin III <wli@holomorphy.com> writes:

> On Sat, Dec 06, 2003 at 10:32:45AM +0800, Colin Coe wrote:
>> This indicates to me that the processing load is being evenly distributed
>> accross the two processes.  Under v2.6.0-testxx however, 'cat
>> /proc/interrupts' shows this:
>> [root@host root]# cat /proc/interrupts
>>            CPU0       CPU1
>>   0:     633122         30    IO-APIC-edge  timer
>>   1:        207              IO-APIC-edge  i8042
>>   2:                              XT-PIC  cascade
>>   4:         48          1    IO-APIC-edge  serial
>>   5:        449          1   IO-APIC-level  eth1
>>  10:        135          1   IO-APIC-level  aic7xxx
>>  11:       1447          1   IO-APIC-level  eth0
>>  12:         61              IO-APIC-edge  i8042
>>  14:                       IO-APIC-level  CS46XX
>>  15:      14982          1   IO-APIC-level  megaraid
>
> 2.6 does balancing across packages, not logical cpus, so this will
> happen and it will be largely harmless, except for what appears to
> be some kind of bug where it's stealing the timer from logical cpu 1.

I noticed something similar way back when, and what I took away from
the ensuing discussion (which may be complete poppycock) was:

  "IRQ balancing" means having individual IRQs run on the same CPU as
  much as possible, which (I assume) mitigates cacheline bouncing or
  something along those lines.  It does not mean having each IRQ
  serviced equally by each CPU.  The kernel's default policy is now to
  have all IRQs run on CPU0, with "noirqbalance"'s effect being to
  have the IRQs be serviced by CPUs in a round-robin fashion.
  noirqbalance is intended to be used when one is runing a userspace
  IRQ balancing policy daemon, such as the one written by Arjan Van de
  Ven (http://people.redhat.com/arjanv/irqbalance/).

-- 
Not bad, for a human.
