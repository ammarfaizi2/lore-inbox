Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262798AbVDAXYJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262798AbVDAXYJ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Apr 2005 18:24:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262799AbVDAXYI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Apr 2005 18:24:08 -0500
Received: from hammer.engin.umich.edu ([141.213.40.79]:49894 "EHLO
	hammer.engin.umich.edu") by vger.kernel.org with ESMTP
	id S262798AbVDAXYB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Apr 2005 18:24:01 -0500
Date: Fri, 1 Apr 2005 18:24:00 -0500 (EST)
From: Christopher Allen Wing <wingc@engin.umich.edu>
To: linux-kernel@vger.kernel.org
Subject: clock runs at double speed on x86_64 system w/ATI RS200 chipset
Message-ID: <Pine.LNX.4.58.0504011809160.31049@hammer.engin.umich.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm testing a system based on a ATI Radeon Xpress 200 motherboard.
(host bridge PCI device 1002:5950)

Something is causing the timer interrupt to be received twice as often as
desired; this makes the clock run at double normal speed.

I first noticed the problem when testing Red Hat 2.4 and 2.6 kernels;
however, I just reproduced it on the latest kernel.org release (2.6.11.6).


While messing around with the 2.4 kernel, I managed to make the problem go
away by getting the timer interrupt to be delivered via the XT-PIC instead
of the APIC. I don't know enough about how the interrupt routing/ACPI
works to figure out what's wrong.


At first I thought the problem seemed similar to the one discussed in June
2004 on lkml under the subject "linux-2.6.7-bk2 runs faster than
linux-2.6.7 ;)"; see:

http://marc.theaimsgroup.com/?w=2&r=1&s=linux-2.6.7-bk2+runs+faster&q=t


However the problem still exists in 2.6.11.6, as well as older Red Hat 2.4
and 2.6 kernels, so I'm guessing that it is an unrelated problem.

In short the timer interrupt gets received twice as many times as it
should:


$ cat /proc/interrupts; sleep 10; cat /proc/interrupts
  0:    2812271    IO-APIC-edge  timer
LOC:    1405962

(only 5 seconds elapse; not 10)

  0:    2822285    IO-APIC-edge  timer
LOC:    1410969



Note that this corresponds to 1000 local APIC timer ints/sec, but 2000
'timer' ints/second.



Here's the dmesg log from booting:

	http://www-personal.engin.umich.edu/~wingc/code/dmesg-2.6.11.6

I also see messages from the kernel like:

	APIC error on CPU0: 00(40)
	APIC error on CPU0: 40(40)

so I'd guess that something is wrong in the way that the machine is set
up. Perhaps the BIOS or ACPI tables are just defective.


I'd appreciate it if anyone familiar with how ACPI and the interrupt
routing could suggest a way to figure out what's going on.


Thanks,

Chris Wing
wingc@engin.umich.edu
