Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261693AbVASLco@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261693AbVASLco (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 Jan 2005 06:32:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261694AbVASLcc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 Jan 2005 06:32:32 -0500
Received: from gprs215-131.eurotel.cz ([160.218.215.131]:56481 "EHLO
	amd.ucw.cz") by vger.kernel.org with ESMTP id S261693AbVASLcZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 Jan 2005 06:32:25 -0500
Date: Wed, 19 Jan 2005 12:36:43 +0100
From: Pavel Machek <pavel@suse.cz>
To: Tony Lindgren <tony@atomide.com>
Cc: George Anzinger <george@mvista.com>, john stultz <johnstul@us.ibm.com>,
       Andrea Arcangeli <andrea@suse.de>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       Con Kolivas <kernel@kolivas.org>,
       Martin Schwidefsky <schwidefsky@de.ibm.com>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dynamic tick patch
Message-ID: <20050119113642.GA1358@elf.ucw.cz>
References: <20050119000556.GB14749@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050119000556.GB14749@atomide.com>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> As this patch is related to the VST/High-Res timers, there
> are probably various things that can be merged. I have not
> yet looked at what all could be merged.
> 
> I'd appreciate some comments and testing!

Good news is that it does seem to reduce number of interrupts. Bad
news is that time now runs faster (like "sleep 10" finishes in ~5
seconds) and that I could not measure any difference in power
consumption.

								Pavel

root@amd:~# date; cat /proc/interrupts ; sleep 10; date; cat
/proc/interrupts
Wed Jan 19 12:30:46 CET 2005
           CPU0
  0:      18136    IO-APIC-edge  timer
  1:        557    IO-APIC-edge  i8042
 10:        148   IO-APIC-level  acpi
 12:         69    IO-APIC-edge  i8042
 14:       1587    IO-APIC-edge  ide0
 15:         14    IO-APIC-edge  ide1
 17:          1   IO-APIC-level  yenta
 19:          2   IO-APIC-level  ohci1394
 21:          0   IO-APIC-level  ehci_hcd, uhci_hcd, uhci_hcd, uhci_hcd
 22:          0   IO-APIC-level  VIA8233
 23:          0   IO-APIC-level  eth0
NMI:          0
LOC:      20924
ERR:          0
MIS:          0
Wed Jan 19 12:30:56 CET 2005
           CPU0
  0:      18253    IO-APIC-edge  timer
  1:        558    IO-APIC-edge  i8042
 10:        148   IO-APIC-level  acpi
 12:         69    IO-APIC-edge  i8042
 14:       1587    IO-APIC-edge  ide0
 15:         14    IO-APIC-edge  ide1
 17:          1   IO-APIC-level  yenta
 19:          2   IO-APIC-level  ohci1394
 21:          0   IO-APIC-level  ehci_hcd, uhci_hcd, uhci_hcd, uhci_hcd
 22:          0   IO-APIC-level  VIA8233
 23:          0   IO-APIC-level  eth0
NMI:          0
LOC:      21062
ERR:          0
MIS:          0
root@amd:~#

(But it really took somewhere around 5 seconds).
								Pavel
-- 
People were complaining that M$ turns users into beta-testers...
...jr ghea gurz vagb qrirybcref, naq gurl frrz gb yvxr vg gung jnl!
