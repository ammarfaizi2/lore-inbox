Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261567AbTLILY1 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Dec 2003 06:24:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265473AbTLILY1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Dec 2003 06:24:27 -0500
Received: from gprs149-183.eurotel.cz ([160.218.149.183]:36736 "EHLO
	amd.ucw.cz") by vger.kernel.org with ESMTP id S261567AbTLILYV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Dec 2003 06:24:21 -0500
Date: Tue, 9 Dec 2003 12:25:09 +0100
From: Pavel Machek <pavel@ucw.cz>
To: "Yu, Luming" <luming.yu@intel.com>
Cc: Aaron Lehmann <aaronl@vitelus.com>,
       ACPI mailing list <acpi-devel@lists.sourceforge.net>,
       kernel list <linux-kernel@vger.kernel.org>
Subject: Re: Tell user when ACPI is killing machine
Message-ID: <20031209112509.GF297@elf.ucw.cz>
References: <3ACA40606221794F80A5670F0AF15F8401720C05@PDSMSX403.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3ACA40606221794F80A5670F0AF15F8401720C05@PDSMSX403.ccr.corp.intel.com>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> >> >cpufreq is not connected to acpi thermal subsystem. Dominik has some
> >> >patches to change that, IIRC.
> >> Is it merged into ACPI ?
> 
> >Not yet, IIRC. It is pretty big patch.
> 
> Would you please point out where they are? --Luming

In http://sourceforge.net/mailarchive/message.php?msg_id=6219572,
Dominik wrote: [This is what I was talking about; oops, google groups
does not seem to index acpi-devel :-(].
								Pavel

From: Dominik Brodowski <linux@br...>
[PATCHES 2.6] ACPI processor driver updates [idle,throttling,cpufreq,thermal]  
2003-10-06 13:00

 The following patches which
 - a) replace the broken ACPI CPUfreq driver with a better, flexible variant,
 - b) modularize the processor.c code: instead of one large file there are
      many small files.
 - c) improve passive cooling support
 - d) allow for easy adding of proper locking and ref-counting in processor.c
 have been re-diffed against linux-2.6.0-test6-bk-current and are available
 on my website. 
 Len, I'll send them to you in private e-mail for easier merging later.
 
 Please apply.
 
 	Dominik
 

http://www.brodo.de/patches/2003-10-06/acpi-2.6.0-test6-2-remove_previous_pstates_implementation
 	The previous arch/i386/kernel/cpu/cpufreq/acpi.c CPUfreq
 	driver was broken, of bad design, and needs to replaced 
 	by something better. But, as a first step, remove all 
 	parts related to P-States from ACPI code.
 
 http://www.brodo.de/patches/2003-10-06/acpi-2.6.0-test6-2-processor_submodules
 	Add a "submodule interface" to drivers/acpi/processor.c
 
 	It allows to create other "modules" which access the acpi_handle 
 	for the processor, and which get notified if the event value 
 	maches the value passed in acpi_processor_register_notify.
 
 http://www.brodo.de/patches/2003-10-06/acpi-2.6.0-test6-2-processor_perflib
 	This patch adds a new "P-States library" to drivers/acpi/
 
 	CPUfreq drivers can now easly access the contents of the 
 	_PCT and the _PSS. For example, the speedstep-centrino 
 	driver could be appended so that it passes the appropriate 
 	value to the P-States library which then evaluates _PDC, 
 	and then returns the updated _PCT and _PSS.
 
 	Also, the platform limit is now handled as a cpufreq notifier and
 	as a call to cpufreq_policy_update.
 
 http://www.brodo.de/patches/2003-10-06/acpi-2.6.0-test6-2-new_acpi_io_driver
 	This re-adds the acpi P-States I/O driver. It is much smaller,
 	leaner and cleaner.
 
 http://www.brodo.de/patches/2003-10-06/acpi-2.6.0-test6-2-idle_submodule
 	This moves the idle handler out of drivers/acpi/processor and into
 	an own module.
 
 	Even if only C1 is available, it is now used. If the user prefers the 
 	default pm_idle, he can unload processor_idle, and still have the other
 	functionality available.
 
 http://www.brodo.de/patches/2003-10-06/acpi-2.6.0-test6-2-thermal_submodule
 	This adds a new mechanism to manage passive cooling. Instead of
 	hardcoded -and partly wrong- access to CPUfreq and ACPI 
 	throttling-, add a generic mechanism which other modules can 
 	register with.
 
 http://www.brodo.de/patches/2003-10-06/acpi-2.6.0-test6-2-thermal_cpufreq
 	Use _any_ CPUfreq driver for passive cooling. Implemented by an
 	cpufreq policy notifier and cpufreq_update_policy.
  
 http://www.brodo.de/patches/2003-10-06/acpi-2.6.0-test6-2-thermal_throttling
 	Move throttling into its own submodule, and register it with the new
 	passive cooling module. Also, the now-useless "limit" interface is
 	removed.
 


 



-- 
When do you have a heart between your knees?
[Johanka's followup: and *two* hearts?]
