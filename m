Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751267AbWBMOtQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751267AbWBMOtQ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Feb 2006 09:49:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751705AbWBMOtQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Feb 2006 09:49:16 -0500
Received: from rrzmta2.rz.uni-regensburg.de ([132.199.1.17]:21176 "EHLO
	rrzmta2.rz.uni-regensburg.de") by vger.kernel.org with ESMTP
	id S1751267AbWBMOtQ convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Feb 2006 09:49:16 -0500
From: "Ulrich Windl" <ulrich.windl@rz.uni-regensburg.de>
Organization: Universitaet Regensburg, Klinikum
To: Andi Kleen <ak@suse.de>
Date: Mon, 13 Feb 2006 15:49:07 +0100
MIME-Version: 1.0
Subject: Re: 2.6.15:kernel/time.c: The Nanosecond and code duplication
Cc: linux-kernel@vger.kernel.org
Message-ID: <43F0AA74.15190.1B9A30E@Ulrich.Windl.rkdvmks1.ngate.uni-regensburg.de>
In-reply-to: <p73ek274lf3.fsf@verdi.suse.de>
References: <43F05143.29965.5D3E74@Ulrich.Windl.rkdvmks1.ngate.uni-regensburg.de>
X-mailer: Pegasus Mail for Windows (4.31)
Content-type: text/plain; charset=ISO-8859-1
Content-transfer-encoding: 8BIT
Content-description: Mail message body
X-Content-Conformance: HerringScan-0.25/Sophos-P=4.02.0+V=4.02+U=2.07.127+R=06 February 2006+T=118652@20060213.143907Z
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 13 Feb 2006 at 11:12, Andi Kleen wrote:

> "Ulrich Windl" <ulrich.windl@rz.uni-regensburg.de> writes:
> 
> > but there's no POSIX like syscall interface 
> > (clock_getres, clock_gettime, clock_settime) yet.
> 
> % grep clock include/asm-x86_64/unistd.h 
> #define __NR_clock_settime      227
> __SYSCALL(__NR_clock_settime, sys_clock_settime)
> #define __NR_clock_gettime      228
> __SYSCALL(__NR_clock_gettime, sys_clock_gettime)
> #define __NR_clock_getres       229
> __SYSCALL(__NR_clock_getres, sys_clock_getres)
> #define __NR_clock_nanosleep    230
> __SYSCALL(__NR_clock_nanosleep, sys_clock_nanosleep)
> 
> Has been available for quite some time.
> 
> However the calls are currently slower than gettimeofday and also
> don't use nanoseconds internally in all cases (depends on the architecture), 
> but still microseconds.  But I'm not sure it matters that much
> because the underlying timers are often not better than microseconds
> anyways and with nanoseconds you start to time even the inherent system
> call latency.

Andi,

thanks! I must have been overlooking the implementation of those. Actually when 
you want to have nanoseconds even if the get_offset() just returns microsecond 
granularity?: If you mathematically correct the clock with nanosecond accuracy (or 
even less). With one model you'll see gradual time change, in the other case 
you'll see jumps of 1000ns. OK, the clock might jump by 100ns for other reasons, 
but currently the clock is so amazingly stable that I hardly believe the results 
I've measured (but that's quite another topic).

I'm fully aware that nanosecond resolution will give us peace for the next years. 
However my 700 MHz Pentium III is already as low as 1µs of jitter, so in theory 
the nanosecond may be worth it (e.g. getting a better estimate of the actual 
jitter).

Regards,
Ulrich

