Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261715AbVDCMcY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261715AbVDCMcY (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 3 Apr 2005 08:32:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261716AbVDCMcX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 3 Apr 2005 08:32:23 -0400
Received: from aun.it.uu.se ([130.238.12.36]:46235 "EHLO aun.it.uu.se")
	by vger.kernel.org with ESMTP id S261715AbVDCMcC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 3 Apr 2005 08:32:02 -0400
Date: Sun, 3 Apr 2005 14:31:55 +0200 (MEST)
Message-Id: <200504031231.j33CVtHp021214@harpo.it.uu.se>
From: Mikael Pettersson <mikpe@csd.uu.se>
To: wingc@engin.umich.edu
Subject: Re: clock runs at double speed on x86_64 system w/ATI RS200 chipset
Cc: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2 Apr 2005 13:19:44 -0500 (EST), Christopher Allen Wing wrote:
>On Sat, 2 Apr 2005, Mikael Pettersson wrote:
>
>> >	APIC error on CPU0: 00(40)
>> >	APIC error on CPU0: 40(40)
>>
>> Those are "received illegal vector" errors, and they
>> typically indicate hardware flakiness or BIOS issues.
>>
>> Could be inadequate power supply, inadequate cooling,
>> a BIOS bug (please check for updates), a too new CPU
>> (again, check for a BIOS update), or simply a poorly-
>> designed mainboard.
>
>
>Thanks. I tried the latest BIOS for the board but that did not resolve the
>problem. The clock still runs at double speed (2000 timer
>interrupts/second instead of 1000) and I still get the APIC errors.
>
>I'll enter a support request with the manufacturer.
>
>
>
>I was able to get the problem to go away by using a BIOS option to
>"disable APIC mode". When I do this the kernel outputs at boot:
>
>	ACPI: Using PIC for interrupt routing
>
>and the output of /proc/interrupts reads 'XT-PIC' for everything.
>
>
>If anyone has a suggestion for debugging the clock problem in APIC mode
>I'd be interested. I'm guessing that something is causing the timer
>interrupt to be mapped twice- are there any tools for looking at the ACPI
>tables that may help, or are there kernel boot options to give more detail
>about how the interrupt routing is being set up?

Well, first step is to try w/o ACPI. ACPI is inherently fragile
and bugs there can easily explain your timer problems. Either
recompile with CONFIG_ACPI=n, or boot with "acpi=off pci=noacpi".

/Mikael
