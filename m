Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315475AbSEBX55>; Thu, 2 May 2002 19:57:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315477AbSEBX55>; Thu, 2 May 2002 19:57:57 -0400
Received: from mailout03.sul.t-online.com ([194.25.134.81]:2434 "EHLO
	mailout03.sul.t-online.com") by vger.kernel.org with ESMTP
	id <S315475AbSEBX5z>; Thu, 2 May 2002 19:57:55 -0400
To: "Kosta Porotchkin" <kporotchkin@gmx.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: IO APIC error
In-Reply-To: <007a01c1f234$d7214eb0$a396a8c0@compaq12xl510a>
From: Andi Kleen <ak@muc.de>
Date: 03 May 2002 01:57:45 +0200
Message-ID: <m3bsbycdc6.fsf@averell.firstfloor.org>
User-Agent: Gnus/5.070095 (Pterodactyl Gnus v0.95) Emacs/20.7
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Kosta Porotchkin" <kporotchkin@gmx.net> writes:

>1. For some reason the "dmesg" is not displaying an early kernel messages.
>The log started somewhere from CPU #2 initialization (which is third CPU -
>Two Xeons are recognized as four processors, it is normal). I stopped this
>kernel in debugger and got some messages from MP table parsing procedure
>which were not included in "dmesg" output:

Increase the buffer in kernel/printk.c


>3. The things are going wrong during the test phase (i.e. after the "testing
>the IO APIC....................." is printed). IO APIC #2 register #00 reads
>02008000, which is wrong according to the chipset specification - should be
>02000000. That is the reason I got the warning "unexpected IO-APIC, please
>mail to linux-smp@vger.kernel.org". Let's said that the platform I using is
>pretty new and some hardware errors may happen, so I am less worry about
>this particular message. The most strange thing is the readings from the
>rest of IO APICs. The IO APIC #3 reads physical ID 4, #4 also 4, both # 5
>and #8 has 08000000 in their register #00. How it can be?

It's possible that the mptable is wrong. Windows uses ACPI to find
the IO-APIC, so the mptable is often not well tested. It may help
to change the MP support in the BIOS setup from 1.4 to 1.1.

> 4. When I tried to understand the source code, I found that all the IO APIC
> operations are done trough the fixed memory addresses (io_apic_read() and
> io_apic_write() in io_apic.h). I am sure, I do not understand the boot
> process enough for asking my questions, but probably someone from Linux
> community will help me to solve this problem. Why the fixed addresses are
> used? Shouldn't we use the base address provided by BIOS in MP table for
> each IO APIC?

The MP table contains physical addresses. Linux kernel uses virtual 
addresses. The physical addresses are mapped to the fixed virtual
addresses in init_apic_mappings(). 

-Andi
