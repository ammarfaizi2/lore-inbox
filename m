Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932246AbVKZO6X@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932246AbVKZO6X (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 26 Nov 2005 09:58:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932250AbVKZO6W
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 26 Nov 2005 09:58:22 -0500
Received: from mx2.mail.elte.hu ([157.181.151.9]:27035 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S932246AbVKZO6V (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 26 Nov 2005 09:58:21 -0500
Date: Sat, 26 Nov 2005 15:58:24 +0100
From: Ingo Molnar <mingo@elte.hu>
To: john stultz <johnstul@us.ibm.com>
Cc: lkml <linux-kernel@vger.kernel.org>, Darren Hart <dvhltc@us.ibm.com>,
       Nishanth Aravamudan <nacc@us.ibm.com>,
       Frank Sorenson <frank@tuxrocks.com>,
       George Anzinger <george@mvista.com>,
       Roman Zippel <zippel@linux-m68k.org>,
       Ulrich Windl <ulrich.windl@rz.uni-regensburg.de>,
       Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH 0/13] Time: Generic Timeofday Subsystem (v B11)
Message-ID: <20051126145824.GA13726@elte.hu>
References: <20051122013515.18537.76463.sendpatchset@cog.beaverton.ibm.com> <20051126145043.GA12999@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051126145043.GA12999@elte.hu>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: -1.5
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-1.5 required=5.9 tests=ALL_TRUSTED,AWL autolearn=no SpamAssassin version=3.0.3
	-2.8 ALL_TRUSTED            Did not pass through any untrusted hosts
	1.3 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Ingo Molnar <mingo@elte.hu> wrote:

> While we are at introducing and moving around code, i've done a big 
> cleanup of all code touched/introduced by your patchset. The 
> gtod-B11-cleanup.tar.gz file containing the cleanup patch-series can 
> be found at:
> 
>    http://redhat.com/~mingo/gtod-patches/
> 
> (i'll send the patches individually as well, as replies to your mails).

the patch-queue goes like this:

timeofday-ntp-part1.patch
timeofday-ntp-part2.patch
timeofday-clocksource-core.patch
timeofday-core.patch
timeofday-arch-i386-part1.patch
timeofday-arch-i386-part2.patch
timeofday-arch-i386-part3.patch
timeofday-arch-i386-part4.patch
timeofday-arch-i386-part5.patch
timeofday-arch-i386-part6.patch
timeofday-arch-x86-64-part1.patch
timeofday-arch-x86-64-part2.patch
timeofday-paranoid-debug.patch
timeofday-paranoid-debug-fix.patch

warn-on-once.patch

timeofday-ntp-part1-cleanup.patch
timeofday-ntp-part2-cleanup.patch
timeofday-clocksource-core-cleanup.patch
timeofday-core-cleanup.patch
timeofday-arch-i386-part1-cleanup.patch
timeofday-arch-i386-part2-part3-cleanup.patch
timeofday-arch-i386-part5-cleanup.patch
timeofday-arch-x86-64-part1-cleanup.patch
timeofday-arch-x86-64-part2-cleanup.patch

i.e. all the new patches come after the B11 patches. The diffstat of all 
the changes i did:

 Documentation/kernel-parameters.txt |    2 
 arch/i386/kernel/hpet.c             |   35 +--
 arch/i386/kernel/i8253.c            |   29 +--
 arch/i386/kernel/tsc.c              |  156 +++++++++-------
 arch/i386/lib/delay.c               |   28 +-
 arch/x86_64/kernel/time.c           |   91 ++++-----
 arch/x86_64/kernel/vsyscall.c       |   45 ++--
 drivers/clocksource/acpi_pm.c       |   50 ++---
 drivers/clocksource/cyclone.c       |   71 +++----
 drivers/clocksource/tsc-interp.c    |   55 ++---
 include/asm-generic/bug.h           |   10 +
 include/asm-generic/timeofday.h     |    3 
 include/asm-i386/tsc.h              |   12 -
 include/linux/clocksource.h         |   43 ++--
 include/linux/timex.h               |   12 -
 kernel/time.c                       |  347 ++++++++++++++++++++----------------
 kernel/time/clocksource.c           |   80 ++++----
 kernel/time/jiffies.c               |   23 +-
 kernel/time/timeofday.c             |  195 ++++++++++----------
 kernel/timer.c                      |  158 +++++++++-------
 20 files changed, 808 insertions(+), 637 deletions(-)

	Ingo
