Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261609AbVEJLMs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261609AbVEJLMs (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 May 2005 07:12:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261610AbVEJLMr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 May 2005 07:12:47 -0400
Received: from ns1.suse.de ([195.135.220.2]:48836 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S261609AbVEJLM0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 May 2005 07:12:26 -0400
Date: Tue, 10 May 2005 13:12:24 +0200
From: Andi Kleen <ak@suse.de>
To: Bernd Paysan <bernd.paysan@gmx.de>
Cc: suse-amd64@suse.com, Andi Kleen <ak@suse.de>, linux-kernel@vger.kernel.org
Subject: Re: [suse-amd64] False "lost ticks" on dual-Opteron system (=> timer twice as fast)
Message-ID: <20050510111223.GH25612@wotan.suse.de>
References: <200505081445.26663.bernd.paysan@gmx.de> <20050508134035.GC15724@wotan.suse.de> <200505091253.21252.bernd.paysan@gmx.de> <200505091517.30555.bernd.paysan@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200505091517.30555.bernd.paysan@gmx.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I went through the BIOS setup, and found a disabled feature "ACPI 2.0", 
> which I enabled. Now Linux finds the HPET timer.

Great. The machine came like this? I wish OEMs wouldn't do such things...

> 
> # grep -i hpet boot.log 
> ACPI: HPET (v001 A M I  OEMHPET  0x04000518 MSFT 0x00000097) @ 
> 0x00000000e8ff3c30
> ACPI: HPET id: 0x102282a0 base: 0xfec01000
> time.c: Using 14.318180 MHz HPET timer.
> time.c: Using HPET based timekeeping.
> hpet0: at MMIO 0xfec01000, IRQs 2, 8, 0
> hpet0: 69ns tick, 3 32-bit timers
> hpet_acpi_add: no address or irqs in _CRS
> 
> and everything appears to work (though there's still no designated CPU to 
> handle the timer interrupts). xntpd syncs quickly, I'm happy (so far ;-).

Great.

> 
> So that explains why nobody sees this problem. But the TSC-based fallback 
> timekeeping is still broken on SMP systems with PowerNow and distributed 
> IRQ handling, which both together seem to be rare enough ;-).

There is a patch pending for the TSC problem - using the pmtimer instead
in this case.

But the distributed timer interrupt problem is weird. It should not happen.
You sure it was IRQ 0 that was duplicated and not "LOC" ?

When you watch -n1 cat /proc/interrupts does the rate roughly match
up to 1000Hz?


-Andi

