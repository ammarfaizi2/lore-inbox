Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316853AbSGBShU>; Tue, 2 Jul 2002 14:37:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316856AbSGBShT>; Tue, 2 Jul 2002 14:37:19 -0400
Received: from sutr.cynic.org ([64.174.133.194]:28109 "EHLO sutr.cynic.org")
	by vger.kernel.org with ESMTP id <S316853AbSGBShS>;
	Tue, 2 Jul 2002 14:37:18 -0400
Date: Tue, 2 Jul 2002 11:39:34 -0700
From: Perry The Cynic <perry@cynic.org>
To: Jaap Verhoeven <jaap@gonzo.kelder.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [2.4.19-pre10-ac1] SMP board (AMD 768) fails to initalise 64-bit PCI-irqs ('Probably buggy MP')
Message-ID: <20020702113934.B14308@sutr.cynic.org>
References: <200206191242.28493.jaap@gonzo.kelder.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <200206191242.28493.jaap@gonzo.kelder.net>; from jaap@gonzo.kelder.net on Wed, Jun 19, 2002 at 12:42:28PM +0200
Organization: Cynics at Large
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jaap,

Try 2.4.18 + current ACPI patch + Dominik Brodowski's ACPI IRQ patch and
see if that routes all your IRQs correctly. I've had similar experiences
on S2468UGN (Thunder K7X) - the standard BIOS setup doesn't get the
interrupts right, but ACPI does. My current theory is that Tyan only tests
these boards on Windows 2000/XP, which sets up "the ACPI way", and doesn't
much care if things break the "old way." (Tyan officially only supports
Windows, and their support is, uh, unhelpful when faced with the "L"
word. :-)

Yes, I know you probably need stuff in the -ac kernel. First check whether
ACPI fixes your IRQ problem, THEN worry about merging it in...

Cheers
  -- perry

On Wed, Jun 19, 2002 at 12:42:28PM +0200, Jaap Verhoeven wrote:
> Hi all,
> 
> Kernel fails at initialisation of ALL PCI IRQs when a 64-bit PCI card needs to
> be initialised. Without this card the other 32-bits PCI-cards get their IRQs 
> without a problem.
> 
> Kernel source: 2.4.19-pre10-ac1
> Compiler: gcc version 2.96 20000731 (Red Hat Linux 7.1 2.96-98)
>   * hope this GCC 2.96 isn't a problem anymore
> 64-bit PCI card: HP NetRAID 2m
> Motherboard: TYAN Tiger MPX S2466 (Dual Athlon) with AMD 768
> 
> The NetRAID card seems to be OK, initialises during BIOS boot up, BIOS 
> configuration tool is accessible, etcetera. Also /proc/pci shows nicely the 
> assigned IRQ's for all cards, while /proc/interrupts doesnt.
> 
> Anybody any idea what the problem is here?
> 
> thanks,
> 
>    Jaap
---------------------------------------------------------------------------
Perry The Cynic                                             perry@cynic.org
To a blind optimist, an optimistic realist must seem like an Accursed Cynic.
---------------------------------------------------------------------------
