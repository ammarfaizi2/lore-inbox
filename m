Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267474AbTBUPBb>; Fri, 21 Feb 2003 10:01:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267488AbTBUPBI>; Fri, 21 Feb 2003 10:01:08 -0500
Received: from ip64-48-93-2.z93-48-64.customer.algx.net ([64.48.93.2]:38287
	"EHLO ns1.limegroup.com") by vger.kernel.org with ESMTP
	id <S267474AbTBUO7x>; Fri, 21 Feb 2003 09:59:53 -0500
Date: Fri, 21 Feb 2003 10:09:46 -0500 (EST)
From: Ion Badulescu <ionut@badula.org>
X-X-Sender: ion@guppy.limebrokerage.com
To: Mikael Pettersson <mikpe@user.it.uu.se>
cc: Jeff Garzik <jgarzik@pobox.com>, <linux-kernel@vger.kernel.org>
Subject: Re: UP local APIC is deadly on SMP Athlon
In-Reply-To: <15958.15349.873243.599197@gargle.gargle.HOWL>
Message-ID: <Pine.LNX.4.44.0302210959090.17290-100000@guppy.limebrokerage.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mikael,

On Fri, 21 Feb 2003, Mikael Pettersson wrote:

>  > My only boxes on which this is a problem are the SMP athlons, and only 
>  > with UP kernels...
> 
> Chipset?

AMD 760MP and 760MPX, both have this problem.

> Is the second CPU installed or not?

Installed.

> If the second CPU is installed, has it been disabled in BIOS?

It hasn't been disabled (the BIOS doesn't have that option).

> Relevant config? What combinations of UP_APIC and UP_IOAPIC have
> you been using?

CONFIG_MK7=y
CONFIG_NOHIGHMEM=y
CONFIG_MTRR=y
CONFIG_X86_UP_IOAPIC=y
CONFIG_X86_IO_APIC=y
CONFIG_X86_LOCAL_APIC=y

but CONFIG_X86_IO_APIC can be turned off and the problem still persists.

> Has ACPI been enabled or not?

The problem is present both with and without ACPI.

> A plain kernel with UP_APIC but no SMP or UP_IOAPIC shouldn't
> provoke the kinds of APIC errors you mentioned, unless the APIC
> bus is noisy due to a missing second CPU (just a theory).

Well, the second CPU is there, and there are no problems with the APIC and 
the IO-APIC if the kernel is compiled with CONFIG_SMP=y. Only the UP case 
causes the problem. So I don't think the bus itself is noisy, unless the 
noises are produced by the second CPU somehow, and we can't do anything 
about it because we're not touching that second CPU.

>  > Anyway, I'd like to get to the bottom of this, since I've narrowed it down 
>  > so much. Anyone know who submitted the APIC changes in 2.4.10-pre12?
> 
> Ingo Molnar, Maciej W. Rozycki, and myself.

Thanks for emailing back. :)

Yeah, I noticed your name in most of the relevant changes between
2.4.10-pre11 and pre12, so I was going to email you directly after 
narrowing it down some more. Right now I'm trying to isolate the smallest 
portion of the pre11-pre12 patch that triggers the problem.

But if you have any ideas or patches to try, please do let me know...

> Intel's IA32 manual set, Volume 3, is required reading.

Thanks, I'll try to get it.

I know that AMD's K7 APIC is supposed to be compatible with the Intel P6 
APIC, but do you think there might be some incompatibility between that 
that causes this? Or perhaps some undefined behavior we rely on, and which 
is different between Intel and AMD?...

Anyway, I'll keep on digging.

Thanks,
Ion

-- 
  It is better to keep your mouth shut and be thought a fool,
            than to open it and remove all doubt.

