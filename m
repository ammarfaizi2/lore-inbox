Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129735AbRAaK1M>; Wed, 31 Jan 2001 05:27:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130075AbRAaK1E>; Wed, 31 Jan 2001 05:27:04 -0500
Received: from colorfullife.com ([216.156.138.34]:19726 "EHLO colorfullife.com")
	by vger.kernel.org with ESMTP id <S129735AbRAaK04>;
	Wed, 31 Jan 2001 05:26:56 -0500
Message-ID: <3A77E875.515B87C4@colorfullife.com>
Date: Wed, 31 Jan 2001 11:27:01 +0100
From: Manfred Spraul <manfred@colorfullife.com>
X-Mailer: Mozilla 4.75 [en] (X11; U; Linux 2.2.16-22 i586)
X-Accept-Language: en
MIME-Version: 1.0
To: neufeld@linuxcare.com, linux-kernel@vger.kernel.org
Subject: Re: Request: increase in PCI bus limit
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> 
>    I'm working at a customer site with custom hardware. The 2.4.0 series 
> kernel almost works out of the box, but the machine has 52 PCI busses. 
> Plans are to produce a 4-way box which would have over 80 PCI busses. The 
> file include/asm-i386/mpspec.h allocates space for 32 busses in the 
> definition of the macro MAX_MP_BUSSES. 
>

How long is the MP structure?
smp_scan_config() reserves only 4 kB:

	reserve_bootmem(mpf->mpf_physptr, PAGE_SIZE);

reserving the actual size (mpf->mpf_physptr->mpc_length) could be
tricky.

It should be possible to dynamically allocate the memory for the busses:
It's not yet possible (smp_read_mpc() is called at a very early stage,
before kmalloc is initialized), but we must move it to a later stage
anyway:
some Compaq bios version need ioremap() in smp_read_mpc(), and we should
parse the ACPI tables for APIC descriptors (MADT, ia64 does that
already).

I'll add it to my TODO list.

--
	Manfred
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
