Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268537AbRHKQYj>; Sat, 11 Aug 2001 12:24:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268560AbRHKQY3>; Sat, 11 Aug 2001 12:24:29 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:57707 "EHLO
	flinx.biederman.org") by vger.kernel.org with ESMTP
	id <S268537AbRHKQYT>; Sat, 11 Aug 2001 12:24:19 -0400
To: esr@thyrsus.com
Cc: Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: Re: Kernel lockups on dual-Athlon board -- help wanted
In-Reply-To: <20010811062349.A1769@thyrsus.com>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: 11 Aug 2001 10:17:38 -0600
In-Reply-To: <20010811062349.A1769@thyrsus.com>
Message-ID: <m1itfush99.fsf@frodo.biederman.org>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) Emacs/20.5
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Eric S. Raymond" <esr@thyrsus.com> writes:

> Gary Sandine of Los Alamos Computers and I are attempting to qualify
> Linux on a Tyan 2462 K7 Thunder motherboard -- dual Athlon 1200 MP
> chips supported by an AMD 760 chipset.  We have been seeing mysterious
> lockups during commands to build things from source, like kernels and X.
> 
> We've been trying to track down the problem for about sixteen hours
> and have gathered quite a bit of data, but don't have a theory to  explain
> it.

What kind of case are you running in?  I have heard of one other case
that sounds similiar and in that case the system was in a 1U.
 
> First, we have established that this is a real kernel hang, not just a 
> bad device state:
> 
> A. Lockups can be induced in either console or X mode.  A reliable way to 
>    induce them is to run `make clean' on an X tree (any sufficiently 
>    long-running command seems to do it).
> 
> B. We logged in over the network, started a top(1) in the network
>    session, induced the hang on the console, and watch top(1) freeze.
>    So 
> 
> C. The magic AltSysRq command is ineffective when the lockups happen.
> 
> Here's what we know about it:
> 
> 1. Lockups never occur under a uniprocessor kernel.
> 
> 2. Configuring APM and ACPI out of the kernel does not prevent the lockups.
>    Disabling ACPI and power management doesn't stop them either.
> 
> 3. Changing kernels from 2.4.3 to 2.4.7 doesn't prevent the lockups.
> 
> 4. The SMP kernel built for either PII or AMD (no APM, no ACPI) locks up.
> 
> 5. There is an undocumented BIOS setting "Use PCI Interrupt Entries in 
>    MP table."  By default it is on.  Turning it off doesn't prevent the
>    lockups.

This switches between listing the 4 interrupts that the board uses for pci
between either in the ISA range if interrupts or routing them to the IOAPIC
above the normal 16 ISA interrupts.
 
> 6. Here's a weird one.  When the kernel is running, the power switch
>    has to be pressed down for 4 seconds to power down the machine.  But
>    during a lockup it powers down the machine instantly.
> 
> What we're seeing suggests some bad interaction between the SMP
> support and the hardware.  But item 7 hints that power management
> could be involved, even though we have it configured out.

The board only uses ACPI so power management isn't a large canidate.

I think I have to go with Alan that the most likely case is that the
board is marginal in respect.

Eric
