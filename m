Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267419AbRHKK0m>; Sat, 11 Aug 2001 06:26:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267449AbRHKK0c>; Sat, 11 Aug 2001 06:26:32 -0400
Received: from lanm-pc.com ([64.81.97.118]:48629 "EHLO golux.thyrsus.com")
	by vger.kernel.org with ESMTP id <S267419AbRHKK0R>;
	Sat, 11 Aug 2001 06:26:17 -0400
Date: Sat, 11 Aug 2001 06:23:49 -0400
From: "Eric S. Raymond" <esr@thyrsus.com>
To: Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: Kernel lockups on dual-Athlon board -- help wanted
Message-ID: <20010811062349.A1769@thyrsus.com>
Reply-To: esr@thyrsus.com
Mail-Followup-To: "Eric S. Raymond" <esr@thyrsus.com>,
	Linux Kernel List <linux-kernel@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Organization: Eric Conspiracy Secret Labs
X-Eric-Conspiracy: There is no conspiracy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Gary Sandine of Los Alamos Computers and I are attempting to qualify
Linux on a Tyan 2462 K7 Thunder motherboard -- dual Athlon 1200 MP
chips supported by an AMD 760 chipset.  We have been seeing mysterious
lockups during commands to build things from source, like kernels and X.

We've been trying to track down the problem for about sixteen hours
and have gathered quite a bit of data, but don't have a theory to  explain
it.

First, we have established that this is a real kernel hang, not just a 
bad device state:

A. Lockups can be induced in either console or X mode.  A reliable way to 
   induce them is to run `make clean' on an X tree (any sufficiently 
   long-running command seems to do it).

B. We logged in over the network, started a top(1) in the network
   session, induced the hang on the console, and watch top(1) freeze.
   So 

C. The magic AltSysRq command is ineffective when the lockups happen.

Here's what we know about it:

1. Lockups never occur under a uniprocessor kernel.

2. Configuring APM and ACPI out of the kernel does not prevent the lockups.
   Disabling ACPI and power management doesn't stop them either.

3. Changing kernels from 2.4.3 to 2.4.7 doesn't prevent the lockups.

4. The SMP kernel built for either PII or AMD (no APM, no ACPI) locks up.

5. There is an undocumented BIOS setting "Use PCI Interrupt Entries in 
   MP table."  By default it is on.  Turning it off doesn't prevent the
   lockups.

6. Here's a weird one.  When the kernel is running, the power switch
   has to be pressed down for 4 seconds to power down the machine.  But
   during a lockup it powers down the machine instantly.

What we're seeing suggests some bad interaction between the SMP
support and the hardware.  But item 7 hints that power management
could be involved, even though we have it configured out.

Anybody have a brilliant insight?  Suggestions for further tests?
-- 
		<a href="http://www.tuxedo.org/~esr/">Eric S. Raymond</a>

Government should be weak, amateurish and ridiculous. At present, it
fulfills only a third of the role.
	-- Edward Abbey
