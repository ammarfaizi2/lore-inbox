Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263734AbTKFQwU (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Nov 2003 11:52:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263733AbTKFQwT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Nov 2003 11:52:19 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:24039 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S263732AbTKFQwB
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Nov 2003 11:52:01 -0500
Date: Thu, 6 Nov 2003 16:51:59 +0000
From: Matthew Wilcox <willy@debian.org>
To: linux-kernel@vger.kernel.org, linux-ia64@vger.kernel.org
Cc: acpi-devel@lists.sourceforge.net
Subject: Re: [DMESG] cpumask_t in action
Message-ID: <20031106165159.GE26869@parcelfarce.linux.theplanet.co.uk>
References: <20031105222202.GA24119@sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031105222202.GA24119@sgi.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 05, 2003 at 02:22:02PM -0800, Jesse Barnes wrote:
> I'm Cc'ing linux-ia64 because I think we have a lot of boot messages to
> cleanup in arch/ia64...

I agree.  I've booted on 16 way machines and been annoyed by the kernel
messages.  Did you set the dmesg buffer size to 128k or did you capture
the boot messages with a serial card?

The arch/ia64 code is not the only offender; ACPI is terribly verbose too.
I'm going to cc the acpi list too.  See comments below.

> ACPI: SRAT Processor (id[0x00] eid[0x00]) in proximity domain 0 enabled
> ACPI: SRAT Processor (id[0x20] eid[0x00]) in proximity domain 0 enabled
> ACPI: SRAT Processor (id[0x00] eid[0x02]) in proximity domain 1 enabled
> ACPI: SRAT Processor (id[0x20] eid[0x02]) in proximity domain 1 enabled
> ACPI: SRAT Processor (id[0x00] eid[0x04]) in proximity domain 2 enabled
> ACPI: SRAT Processor (id[0x20] eid[0x04]) in proximity domain 2 enabled
> ACPI: SRAT Processor (id[0x00] eid[0x06]) in proximity domain 3 enabled
> ACPI: SRAT Processor (id[0x20] eid[0x06]) in proximity domain 3 enabled
> ACPI: SRAT Processor (id[0x00] eid[0x08]) in proximity domain 4 enabled
> ACPI: SRAT Processor (id[0x20] eid[0x08]) in proximity domain 4 enabled
> ACPI: SRAT Processor (id[0x00] eid[0x0a]) in proximity domain 5 enabled
> ACPI: SRAT Processor (id[0x20] eid[0x0a]) in proximity domain 5 enabled
> ACPI: SRAT Processor (id[0x00] eid[0x0c]) in proximity domain 6 enabled
> ACPI: SRAT Processor (id[0x20] eid[0x0c]) in proximity domain 6 enabled
> ACPI: SRAT Processor (id[0x00] eid[0x0e]) in proximity domain 7 enabled
> ACPI: SRAT Processor (id[0x20] eid[0x0e]) in proximity domain 7 enabled
> ACPI: SRAT Processor (id[0x00] eid[0x10]) in proximity domain 8 enabled
> ACPI: SRAT Processor (id[0x20] eid[0x10]) in proximity domain 8 enabled
> ACPI: SRAT Processor (id[0x00] eid[0x12]) in proximity domain 9 enabled
> ACPI: SRAT Processor (id[0x20] eid[0x12]) in proximity domain 9 enabled
> ACPI: SRAT Processor (id[0x00] eid[0x14]) in proximity domain 10 enabled
> ACPI: SRAT Processor (id[0x20] eid[0x14]) in proximity domain 10 enabled
> ACPI: SRAT Processor (id[0x00] eid[0x16]) in proximity domain 11 enabled
> ACPI: SRAT Processor (id[0x20] eid[0x16]) in proximity domain 11 enabled
> ACPI: SRAT Processor (id[0x00] eid[0x18]) in proximity domain 12 enabled
> ACPI: SRAT Processor (id[0x20] eid[0x18]) in proximity domain 12 enabled
> ACPI: SRAT Processor (id[0x00] eid[0x1a]) in proximity domain 13 enabled
> ACPI: SRAT Processor (id[0x20] eid[0x1a]) in proximity domain 13 enabled
> ACPI: SRAT Processor (id[0x00] eid[0x1c]) in proximity domain 14 enabled
> ACPI: SRAT Processor (id[0x20] eid[0x1c]) in proximity domain 14 enabled
> ACPI: SRAT Processor (id[0x00] eid[0x1e]) in proximity domain 15 enabled
> ACPI: SRAT Processor (id[0x20] eid[0x1e]) in proximity domain 15 enabled
> ACPI: SRAT Processor (id[0x00] eid[0x20]) in proximity domain 16 enabled
> ACPI: SRAT Processor (id[0x20] eid[0x20]) in proximity domain 16 enabled
> ACPI: SRAT Processor (id[0x00] eid[0x22]) in proximity domain 17 enabled
> ACPI: SRAT Processor (id[0x20] eid[0x22]) in proximity domain 17 enabled
> ACPI: SRAT Processor (id[0x00] eid[0x24]) in proximity domain 18 enabled
> ACPI: SRAT Processor (id[0x20] eid[0x24]) in proximity domain 18 enabled
> ACPI: SRAT Processor (id[0x00] eid[0x26]) in proximity domain 19 enabled
> ACPI: SRAT Processor (id[0x20] eid[0x26]) in proximity domain 19 enabled
> ACPI: SRAT Processor (id[0x00] eid[0x28]) in proximity domain 20 enabled
> ACPI: SRAT Processor (id[0x20] eid[0x28]) in proximity domain 20 enabled
> ACPI: SRAT Processor (id[0x00] eid[0x2a]) in proximity domain 21 enabled
> ACPI: SRAT Processor (id[0x20] eid[0x2a]) in proximity domain 21 enabled
> ACPI: SRAT Processor (id[0x00] eid[0x2c]) in proximity domain 22 enabled
> ACPI: SRAT Processor (id[0x20] eid[0x2c]) in proximity domain 22 enabled
> ACPI: SRAT Processor (id[0x00] eid[0x2e]) in proximity domain 23 enabled
> ACPI: SRAT Processor (id[0x20] eid[0x2e]) in proximity domain 23 enabled
> ACPI: SRAT Processor (id[0x00] eid[0x30]) in proximity domain 24 enabled
> ACPI: SRAT Processor (id[0x20] eid[0x30]) in proximity domain 24 enabled
> ACPI: SRAT Processor (id[0x00] eid[0x32]) in proximity domain 25 enabled
> ACPI: SRAT Processor (id[0x20] eid[0x32]) in proximity domain 25 enabled
> ACPI: SRAT Processor (id[0x00] eid[0x34]) in proximity domain 26 enabled
> ACPI: SRAT Processor (id[0x20] eid[0x34]) in proximity domain 26 enabled
> ACPI: SRAT Processor (id[0x00] eid[0x36]) in proximity domain 27 enabled
> ACPI: SRAT Processor (id[0x20] eid[0x36]) in proximity domain 27 enabled
> ACPI: SRAT Processor (id[0x00] eid[0x38]) in proximity domain 28 enabled
> ACPI: SRAT Processor (id[0x20] eid[0x38]) in proximity domain 28 enabled
> ACPI: SRAT Processor (id[0x00] eid[0x3a]) in proximity domain 29 enabled
> ACPI: SRAT Processor (id[0x20] eid[0x3a]) in proximity domain 29 enabled
> ACPI: SRAT Processor (id[0x00] eid[0x3c]) in proximity domain 30 enabled
> ACPI: SRAT Processor (id[0x20] eid[0x3c]) in proximity domain 30 enabled
> ACPI: SRAT Processor (id[0x00] eid[0x3e]) in proximity domain 31 enabled
> ACPI: SRAT Processor (id[0x20] eid[0x3e]) in proximity domain 31 enabled
> ACPI: SRAT Processor (id[0x00] eid[0x40]) in proximity domain 32 enabled
> ACPI: SRAT Processor (id[0x20] eid[0x40]) in proximity domain 32 enabled
> ACPI: SRAT Processor (id[0x00] eid[0x42]) in proximity domain 33 enabled
> ACPI: SRAT Processor (id[0x20] eid[0x42]) in proximity domain 33 enabled
> ACPI: SRAT Processor (id[0x00] eid[0x44]) in proximity domain 34 enabled
> ACPI: SRAT Processor (id[0x20] eid[0x44]) in proximity domain 34 enabled
> ACPI: SRAT Processor (id[0x00] eid[0x46]) in proximity domain 35 enabled
> ACPI: SRAT Processor (id[0x20] eid[0x46]) in proximity domain 35 enabled
> ACPI: SRAT Processor (id[0x00] eid[0x48]) in proximity domain 36 enabled
> ACPI: SRAT Processor (id[0x20] eid[0x48]) in proximity domain 36 enabled
> ACPI: SRAT Processor (id[0x00] eid[0x4a]) in proximity domain 37 enabled
> ACPI: SRAT Processor (id[0x20] eid[0x4a]) in proximity domain 37 enabled
> ACPI: SRAT Processor (id[0x00] eid[0x4c]) in proximity domain 38 enabled
> ACPI: SRAT Processor (id[0x20] eid[0x4c]) in proximity domain 38 enabled
> ACPI: SRAT Processor (id[0x00] eid[0x4e]) in proximity domain 39 enabled
> ACPI: SRAT Processor (id[0x20] eid[0x4e]) in proximity domain 39 enabled
> ACPI: SRAT Processor (id[0x00] eid[0x50]) in proximity domain 40 enabled
> ACPI: SRAT Processor (id[0x20] eid[0x50]) in proximity domain 40 enabled
> ACPI: SRAT Processor (id[0x00] eid[0x52]) in proximity domain 41 enabled
> ACPI: SRAT Processor (id[0x20] eid[0x52]) in proximity domain 41 enabled
> ACPI: SRAT Processor (id[0x00] eid[0x54]) in proximity domain 42 enabled
> ACPI: SRAT Processor (id[0x20] eid[0x54]) in proximity domain 42 enabled
> ACPI: SRAT Processor (id[0x00] eid[0x56]) in proximity domain 43 enabled
> ACPI: SRAT Processor (id[0x20] eid[0x56]) in proximity domain 43 enabled
> ACPI: SRAT Processor (id[0x00] eid[0x58]) in proximity domain 44 enabled
> ACPI: SRAT Processor (id[0x20] eid[0x58]) in proximity domain 44 enabled
> ACPI: SRAT Processor (id[0x00] eid[0x5a]) in proximity domain 45 enabled
> ACPI: SRAT Processor (id[0x20] eid[0x5a]) in proximity domain 45 enabled
> ACPI: SRAT Processor (id[0x00] eid[0x5c]) in proximity domain 46 enabled
> ACPI: SRAT Processor (id[0x20] eid[0x5c]) in proximity domain 46 enabled
> ACPI: SRAT Processor (id[0x00] eid[0x5e]) in proximity domain 47 enabled
> ACPI: SRAT Processor (id[0x20] eid[0x5e]) in proximity domain 47 enabled

... for example ;-)  96 lines which honestly tell me nothing.

> ACPI: SRAT Memory (0x0000003000000000 length 0x0000001000000000 type 0x1) in proximity domain 0 enabled
> ACPI: SRAT Memory (0x000000b000000000 length 0x0000001000000000 type 0x1) in proximity domain 1 enabled
[ snip 44 lines ]
> ACPI: SRAT Memory (0x0000173000000000 length 0x0000001000000000 type 0x1) in proximity domain 46 enabled
> ACPI: SRAT Memory (0x000017b000000000 length 0x0000001000000000 type 0x1) in proximity domain 47 enabled

... and again.

> CPU 0: 61 virtual and 50 physical address bits
> ACPI: Local APIC address 0xc0000000fee00000
> ACPI: LSAPIC (acpi_id[0x00] lsapic_id[0x00] lsapic_eid[0x00] enabled)
> CPU 0 (0x0000) enabled (BSP)
> ACPI: LSAPIC (acpi_id[0x01] lsapic_id[0x20] lsapic_eid[0x00] enabled)
> CPU 1 (0x2000) enabled
> ACPI: LSAPIC (acpi_id[0x02] lsapic_id[0x00] lsapic_eid[0x02] enabled)
> CPU 2 (0x0002) enabled
> ACPI: LSAPIC (acpi_id[0x03] lsapic_id[0x20] lsapic_eid[0x02] enabled)
> CPU 3 (0x2002) enabled
[ snip 180 lines ]
> ACPI: LSAPIC (acpi_id[0x5e] lsapic_id[0x00] lsapic_eid[0x5e] enabled)
> CPU 94 (0x005e) enabled
> ACPI: LSAPIC (acpi_id[0x5f] lsapic_id[0x20] lsapic_eid[0x5e] enabled)
> CPU 95 (0x205e) enabled

The information here, such as it is seems to be a duplicate of the SRAT
information above.

> Boot processor id 0x0/0x0
> task migration cache decay timeout: 10 msecs.
> Starting migration thread for cpu 0
> Bringing up 1
> Processor 8192/1 is spinning up...
> CPU 1: 61 virtual and 50 physical address bits
> CPU 1: nasid 0, slice 2, cnode 0
> CPU 1: base freq=200.000MHz, ITC ratio=15/2, ITC freq=1500.000MHz+/--1ppm
> Calibrating delay loop... 2232.84 BogoMIPS
> CPU1: CPU has booted.
> Processor 1 has spun up...
> CPU 1 IS NOW UP!
> Starting migration thread for cpu 1
> Bringing up 2
> Processor 2/2 is spinning up...
> CPU 2: 61 virtual and 50 physical address bits
> CPU 2: nasid 2, slice 0, cnode 1
> CPU 2: base freq=200.000MHz, ITC ratio=15/2, ITC freq=1500.000MHz+/--1ppm
> Calibrating delay loop... 2241.08 BogoMIPS
> CPU2: CPU has booted.
> Processor 2 has spun up...
> CPU 2 IS NOW UP!
> Starting migration thread for cpu 2

There's a number of things here that annoy me.  One is the stupid
"Processor 8192/1 is spinning up".  I would expect "Processor 2/96
is spinning up", but why have this line at all?  I'd also like to see
"Bringing up 3", "Processor 1 has spun up..." and "CPU 1 IS NOW UP!" go
away.  That'd cut us down to:

> CPU 3: 61 virtual and 50 physical address bits
> CPU 3: nasid 2, slice 2, cnode 1
> CPU 3: base freq=200.000MHz, ITC ratio=15/2, ITC freq=1500.000MHz+/--1ppm
> Calibrating delay loop... 2241.08 BogoMIPS
> CPU3: CPU has booted.
> Starting migration thread for cpu 3

A 40% reduction in per-cpu verbosity ;-)

[920 lines deleted]
> CPUS done 128
> Total of 96 processors activated (213739.60 BogoMIPS).
> NET: Registered protocol family 16
[96 lines which aren't too dissimilar to my K6 box deleted ;-)

-- 
"It's not Hollywood.  War is real, war is primarily not about defeat or
victory, it is about death.  I've seen thousands and thousands of dead bodies.
Do you think I want to have an academic debate on this subject?" -- Robert Fisk
