Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264737AbUGFXg0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264737AbUGFXg0 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Jul 2004 19:36:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264750AbUGFXg0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Jul 2004 19:36:26 -0400
Received: from holomorphy.com ([207.189.100.168]:15578 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S264737AbUGFXgX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Jul 2004 19:36:23 -0400
Date: Tue, 6 Jul 2004 16:36:18 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Cc: nickpiggin@yahoo.com.au
Subject: Re: 2.6.7-mm6
Message-ID: <20040706233618.GW21066@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
	nickpiggin@yahoo.com.au
References: <20040705023120.34f7772b.akpm@osdl.org> <20040706125438.GS21066@holomorphy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040706125438.GS21066@holomorphy.com>
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 06, 2004 at 05:54:38AM -0700, William Lee Irwin III wrote:
> Uneventful on alpha, needed a make rpm compilefix Andi's got queued for
> the next merge on x86-64 and otherwise uneventful there.
> OTOH, various things made sparc64 a living Hell that took about 9
> hours of solid compile/boot/crash drudgery to carry out bisection
> search on to find the offending patches.
> First, I had to back out bk-input because it has a sysfsification patch
> that deadlocks sunzilog.c at boot.
> Second, I had to back out those scheduler cleanups because it appears
> that one of those scheduler cleanups deadlocks the system during
> secondary wakeup.
> Third, some naive check for undefined symbols failed to understand the
> relocation types indicating that a given operand refers to some hard
> register, which manifest as undefined symbols in ELF executables. A
> patch to refine its criteria, which I used to build with, follows. rmk
> and hpa have some other ideas on this undefined symbol issue I've not
> quite had the opportunity to get a clear statement of yet.
> If it could be arranged so that the authors of the bk-input and
> scheduler patches fix their code prior to merging, I'd be much obliged.

Nick, of these:
#sched-clean-init-idle.patch
#sched-clean-fork.patch
#sched-clean-fork-rename-wake_up_new_process-wake_up_new_task.patch
#sched-misc-cleanups-2.patch
#sched-unlikely-rt_task.patch
#sched-misc.patch
#sched-misc-fix-rt.patch
#sched-no-balance-clone.patch
#sched-remove-balance-clone.patch
#sched-fork-hotplug-cleanuppatch.patch

I have it isolated down to the sched-clean-init-idle.patch and
sched-clean-fork.patch. sched-clean-init-idle.patch fails to build without
the second of those two applied, so I didn't do any work to narrow it down
further.


-- wli
