Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262615AbVHDPpt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262615AbVHDPpt (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Aug 2005 11:45:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262609AbVHDPpe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Aug 2005 11:45:34 -0400
Received: from ms-smtp-04.nyroc.rr.com ([24.24.2.58]:64130 "EHLO
	ms-smtp-04.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S262615AbVHDPow (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Aug 2005 11:44:52 -0400
Subject: Re: [PATCH] pmtmr and PRINTK_TIME timings display
From: Steven Rostedt <rostedt@goodmis.org>
To: Borislav Petkov <petkov@uni-muenster.de>
Cc: lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <200508041723.25848.petkov@uni-muenster.de>
References: <200508041459.43500.petkov@uni-muenster.de>
	 <1123161545.12009.6.camel@localhost.localdomain>
	 <200508041723.25848.petkov@uni-muenster.de>
Content-Type: text/plain; charset=UTF-8
Organization: Kihon Technologies
Date: Thu, 04 Aug 2005 11:44:45 -0400
Message-Id: <1123170285.12009.18.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> I get it. Actually, I wasn't very sure whether this is the right solution 
> since my desktop machine uses tsc timer as default while the laptop the 
> pmtmr. I also remember that there was a patch a while ago on lkml which 
> enabled a modifiable behavior for PRINTK_TIME through a /proc interface and 
> kernel boot option but it somehow didn't get accepted. Ok, then, since we 
> keep the jiffies solution across arch's, how can I force the kernel to use 
> tsc for printk timings so that i can see the deltas between the different 
> printk's instead of the jiffies_64 ns value? The Pentium-M Centrino on the 
> laptop evidently supports rdtsc as a msr instruction after testing with this 
> small inline assembly snippet:

Just turn off the PM timer by disabling CONFIG_X86_PM_TIMER, then your
laptop should just use the tsc timer.


>From make menuconfig:

 Prompt: Power Management Timer Support                                  │
  │   Defined at drivers/acpi/Kconfig:307                                   │
  │   Depends on: !X86_VOYAGER && !X86_VISWS && !IA64_HP_SIM && (IA64 || X8 │
  │   Location:                                                             │
  │     -> Power management options (ACPI, APM)                             │
  │       -> ACPI (Advanced Configuration and Power Interface) Support      │
  │         -> ACPI Support (ACPI [=y])           

-- Steve


