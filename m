Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262539AbULDMm5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262539AbULDMm5 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 4 Dec 2004 07:42:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262540AbULDMm5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 4 Dec 2004 07:42:57 -0500
Received: from av7-1-sn2.hy.skanova.net ([81.228.8.108]:6021 "EHLO
	av7-1-sn2.hy.skanova.net") by vger.kernel.org with ESMTP
	id S262539AbULDMmz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 4 Dec 2004 07:42:55 -0500
Date: Sat, 4 Dec 2004 13:42:54 +0100 (CET)
Message-Id: <200412041242.iB4CgsN07246@d1o408.telia.com>
From: "Voluspa" <lista4@comhem.se>
Reply-To: "Voluspa" <lista4@comhem.se>
To: andrea@suse.de
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] oom killer (Core)
X-Mailer: SF Webmail
X-SF-webmail-clientstamp: [213.64.150.229] 2004-12-04 13:42:53
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 2004-12-04 8:08:40 Andrea Arcangeli wrote:

> You can try to put back a might_slee_if(wait), but if it deadlocks 
with
> that change sure it's not a bug in my patch, it's instead a bug
> somewhere else that calls alloc_pages w/o GFP_ATOMIC. Ingo's
> lowlatency patch would expose the same bug too since they're aliasing
> the might_sleep to cond_resched.

Putting it back doesn't alter the outcome - hanging. And the original 
patch, (hope it was the right one) from:

http://marc.theaimsgroup.com/?l=linux-kernel&m=110204117506557&w=2

root:loke:/usr/src/linux-2.6.9-oomkill# patch -Np1 -i ../oomkill.patch 
patching file mm/oom_kill.c
patching file mm/page_alloc.c
Hunk #1 succeeded at 608 (offset -3 lines).
Hunk #3 succeeded at 681 (offset -3 lines).
patching file mm/swap_state.c
patching file mm/vmscan.c

has been tried with the following variations. With and without 
optimizing for size, with and without preempt, with and without kernel 
boot params (cfq, lapic), cold and hot starts, and then I threw in a smp 
compile for measure. All have the same behaviour:

[...]
Checking 'hlt' instruction... OK.

[10 minutes wait. Then a long callback trace
 scrolls off the screen ending like Thomas']

<0>Kernel panic - not syncing: Fatal exception in interrupt

My toolchain (well, the whole software system) is quite contemporary 
within the stable branches. Built from scratch with gcc-3.4.3, glibc-
20041011 (nptl) and binutils-2.15.92.0.2

No energy control, acpi-pm or whatever it's called, is used here. The 
machine is extremely stable. Running with 100 percent utilization 24/7.

Don't shoot the messenger ;)
Mats Johannesson

