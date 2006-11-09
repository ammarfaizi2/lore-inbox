Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1424201AbWKIXjD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1424201AbWKIXjD (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Nov 2006 18:39:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161850AbWKIXjD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Nov 2006 18:39:03 -0500
Received: from www.osadl.org ([213.239.205.134]:44956 "EHLO mail.tglx.de")
	by vger.kernel.org with ESMTP id S1161826AbWKIXjB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Nov 2006 18:39:01 -0500
Message-Id: <20061109233030.915859000@cruncher.tec.linutronix.de>
Date: Thu, 09 Nov 2006 23:38:16 -0000
From: Thomas Gleixner <tglx@linutronix.de>
To: Andrew Morton <akpm@osdl.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@elte.hu>,
       Len Brown <lenb@kernel.org>, John Stultz <johnstul@us.ibm.com>,
       Arjan van de Ven <arjan@infradead.org>, Andi Kleen <ak@suse.de>,
       Roman Zippel <zippel@linux-m68k.org>
Subject: [patch 00/21] Highres / dynticks drop in replacement for
	2.6.19-rc5-mm1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew,

this is a drop in replacement for the following patches in 2.6.19-rc5-mm1:

hrtimers-state-tracking.patch
up to
acpi-verify-lapic-timer-fix.patch

The patch set is taking all the changes made during the -mm testing into
account and merged them back at the appropriate places.

Changes vs. the initially reviewed patch set:

- Trivial compile / Kconfig fixes
- command line paramater fixups
- apic timer / ACPI (C states) broadcasting fixups
- Disabled apic timer for high res on UP systems due to the unsolvable
  brokeness of BIOS supplied C state functionality
- APIC code cleanup in i386
- reworked APIC timer calibration

Dropped from the rc5-mm1 patch conglomerate:

- the naive attempt to detect the local APIC timer brokeness in C2 state
  due to circular dependency on interrupts (where the local APIC timer
  interrupt might be the only active one). The problem is detectable, 
  but it needs more thought and the gathered information/experience is
  not lost ! Replaced by brute force for now.

Some annotations for making the review simpler:

hrtimers-state-tracking.patch
	callback state trivial fix

hrtimers-clean-up-callback-tracking.patch
	no changes, kept for linearity

hrtimers-move-and-add-documentation.patch
	no changes, kept for linearity

clockevents-core.patch
	One off bug fixed
	inlcude and compile fixes
	broadcast support

acpi-include-apic-h.patch
	new

acpi-keep-track-of-timer-broadcast.patch
	new

acpi-add-hres-dyntick-broadcast-support.patch
	new

i386-cleanup-apic.patch
	new, no functional changes

clockevents-drivers-for-i386.patch
	broadcast fixups

pm-timer-allow-early-access.patch
	new, no functional changes
	
i386-lapic-calibrate-timer.patch
	new

high-res-timers-core.patch
	trivial fixups

gtod-mark-tsc-unusable-for-highres-timers.patch
	no changes, kept for linearity

dynticks-core.patch
	trivial fixups

dynticks-add-nohz-stats-to-proc-stat.patch
	no changes, patch fuzz due to prior patches

dynticks-i386-arch-code.patch
	no changes, patch fuzz due to prior patches

dynticks-i386-nmi-fix.patch
	new

high-res-timers-dynticks-enable-i386-support.patch
	no changes, patch fuzz due to prior patches

debugging-feature-timer-stats.patch
	no changes, patch fuzz due to prior patches

Thanks,

	tglx
--

