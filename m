Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129511AbRADHiG>; Thu, 4 Jan 2001 02:38:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129752AbRADHh4>; Thu, 4 Jan 2001 02:37:56 -0500
Received: from hermes.mixx.net ([212.84.196.2]:19461 "HELO hermes.mixx.net")
	by vger.kernel.org with SMTP id <S129511AbRADHhs>;
	Thu, 4 Jan 2001 02:37:48 -0500
Message-ID: <3A5427A6.26F25A8A@innominate.de>
Date: Thu, 04 Jan 2001 08:35:02 +0100
From: Daniel Phillips <phillips@innominate.de>
Organization: innominate
X-Mailer: Mozilla 4.72 [de] (X11; U; Linux 2.4.0-prerelease i586)
X-Accept-Language: en
MIME-Version: 1.0
To: ludovic fernandez <ludovic.fernandez@sun.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 2.4.0-prerelease: preemptive kernel.
In-Reply-To: <3A53D863.53203DF4@sun.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ludovic fernandez wrote:
> The following patch makes the kernel preemptable.
> It is against 2.4.0-prerelease on for i386 only.
> It should work for UP and SMP even though I
> didn't validate it on SMP.
> Comments are welcome.

I was expecting to see this sometime in 2.5, not quite so soon...

The key idea here is to disable preemption on spin lock and reenable on
spin unlock.  That's a practical idea, highly compatible with the
current way of doing things.  Its a fairly heavy hit on spinlock
performance, but maybe the overall performance hit is small.  Benchmarks
are needed.

A more ambitious way to proceed is to change spinlocks so they can sleep
(not in interrupts of course).  There would not be any extra overhead
for this on spin_lock (because the sleep test is handled off the fast
path) but spin_unlock gets a little slower - it has to test and jump on
a flag if there are sleepers.

--
Daniel
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
