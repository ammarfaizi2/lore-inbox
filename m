Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265192AbSKSL5B>; Tue, 19 Nov 2002 06:57:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265211AbSKSL5B>; Tue, 19 Nov 2002 06:57:01 -0500
Received: from zero.aec.at ([193.170.194.10]:55557 "EHLO zero.aec.at")
	by vger.kernel.org with ESMTP id <S265192AbSKSL5B>;
	Tue, 19 Nov 2002 06:57:01 -0500
To: jim.houston@attbi.com
Cc: linux-kernel@vger.kernel.org
Subject: Re: LTP - gettimeofday02 FAIL
References: <200211190127.gAJ1RWg11023@linux.local>
From: Andi Kleen <ak@muc.de>
Date: 19 Nov 2002 13:03:48 +0100
In-Reply-To: <200211190127.gAJ1RWg11023@linux.local>
Message-ID: <m3bs4l7om3.fsf@averell.firstfloor.org>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jim Houston <jim.houston@attbi.com> writes:

> I believe that this is the result of lost ticks.  It has gotten much
> easier to lose a tick since HZ was changed to 1000.  When the timer
> interrupt is delayed, the other processors will continue to keep reasonable
> time (based on the TSC), but when the timer interrupt eventually happens,
> it will add one tick's worth of nanoseconds to xtime.tv_nsec and set
> last_tsc_low to the current tsc value.  The other processors now base
> their time on this new last_tsc_low and  will see time go backwards.

It could be detected by keeping a per cpu last_tsc.

Best would be to use a global timer like HPET, but it's not available
everywhere and much slower than rdtsc too.

-Andi
