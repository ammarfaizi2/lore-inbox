Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751702AbWBMKMg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751702AbWBMKMg (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Feb 2006 05:12:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751707AbWBMKMg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Feb 2006 05:12:36 -0500
Received: from cantor2.suse.de ([195.135.220.15]:3221 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1751702AbWBMKMf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Feb 2006 05:12:35 -0500
To: "Ulrich Windl" <ulrich.windl@rz.uni-regensburg.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.15:kernel/time.c: The Nanosecond and code duplication
References: <43F05143.29965.5D3E74@Ulrich.Windl.rkdvmks1.ngate.uni-regensburg.de>
From: Andi Kleen <ak@suse.de>
Date: 13 Feb 2006 11:12:32 +0100
In-Reply-To: <43F05143.29965.5D3E74@Ulrich.Windl.rkdvmks1.ngate.uni-regensburg.de>
Message-ID: <p73ek274lf3.fsf@verdi.suse.de>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Ulrich Windl" <ulrich.windl@rz.uni-regensburg.de> writes:

> but there's no POSIX like syscall interface 
> (clock_getres, clock_gettime, clock_settime) yet.

% grep clock include/asm-x86_64/unistd.h 
#define __NR_clock_settime      227
__SYSCALL(__NR_clock_settime, sys_clock_settime)
#define __NR_clock_gettime      228
__SYSCALL(__NR_clock_gettime, sys_clock_gettime)
#define __NR_clock_getres       229
__SYSCALL(__NR_clock_getres, sys_clock_getres)
#define __NR_clock_nanosleep    230
__SYSCALL(__NR_clock_nanosleep, sys_clock_nanosleep)

Has been available for quite some time.

However the calls are currently slower than gettimeofday and also
don't use nanoseconds internally in all cases (depends on the architecture), 
but still microseconds.  But I'm not sure it matters that much
because the underlying timers are often not better than microseconds
anyways and with nanoseconds you start to time even the inherent system
call latency.



-Andi
