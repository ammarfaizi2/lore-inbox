Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311231AbSCLPQG>; Tue, 12 Mar 2002 10:16:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311232AbSCLPP4>; Tue, 12 Mar 2002 10:15:56 -0500
Received: from mail.rpi.edu ([128.113.22.40]:43944 "EHLO mail.rpi.edu")
	by vger.kernel.org with ESMTP id <S311231AbSCLPPn>;
	Tue, 12 Mar 2002 10:15:43 -0500
Date: Tue, 12 Mar 2002 10:12:12 -0500 (EST)
Message-Id: <20020312.101212.25466030.obatan@rpi.edu>
To: lk@tantalophile.demon.co.uk
Cc: greearb@candelatech.com, linux-kernel@vger.kernel.org
Subject: Re: a faster way to gettimeofday?
From: OBATA Noboru <noboru@ylug.org>
In-Reply-To: <20020312130635.C4281@kushida.apsleyroad.org>
In-Reply-To: <20020312130635.C4281@kushida.apsleyroad.org>
X-Mailer: Mew version 3.0.54 on Emacs 20.7 / Mule 4.0 (HANANOEN)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> If you run NTP (synchronisation with atomic clock standards over the
> network), you get really good real world clock times.  It continually
> adjust gettimeofday() but not the rdtsc clock.  That may highlight any
> drift due to thermal effects in the PC.
> 
> I would guess you're not running NTP?

You are right.  I'm not running NTP.  Actually, I was using
clockspeed (http://cr.yp.to/clockspeed.html) before, which
adjusts system clock using RDTSC, but I have stopped it to
observe pure system clock.

In the first version my userland gettimeofday, I'm more
interested in how RDTSC could be configured to synchronize with
the system clock, rather than the real world clock time.

To atapt the system clock change, userland gettimeofday should
issue real gettimeofday system call occasionally, as Terje
suggests early in this thread, and adjust calibration
parameters.  I'll call it "adaptive userland gettimeofday."

You may not need calibration any longer since it is adaptive.
However, it will be slower and less effective because much
adjusting code should be implemented.  So I'm hesitating to
implement adaptive userland gettimeofday :-).

-- 
OBATA Noboru (noboru@ylug.org)
