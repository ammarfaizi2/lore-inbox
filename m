Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263738AbTGAALk (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 Jun 2003 20:11:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264731AbTGAALk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 Jun 2003 20:11:40 -0400
Received: from e34.co.us.ibm.com ([32.97.110.132]:25566 "EHLO
	e34.co.us.ibm.com") by vger.kernel.org with ESMTP id S263738AbTGAALb
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 Jun 2003 20:11:31 -0400
Subject: Re: 2.5.73-mm2 - odd audio problem, bad intel8x0/ac97 clocking.
From: john stultz <johnstul@us.ibm.com>
To: Valdis.Kletnieks@vt.edu
Cc: lkml <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@digeo.com>
In-Reply-To: <200306282131.h5SLVjGk001833@turing-police.cc.vt.edu>
References: <200306282131.h5SLVjGk001833@turing-police.cc.vt.edu>
Content-Type: text/plain
Organization: 
Message-Id: <1057019147.28319.367.camel@w-jstultz2.beaverton.ibm.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.4 
Date: 30 Jun 2003 17:25:48 -0700
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2003-06-28 at 14:31, Valdis.Kletnieks@vt.edu wrote:
> 2.5.73-mm1 is fine.
> 
> This is *not* the "clock runs really really fas"t issue - I left -mm2 running overnight and
> in some 8 hours the system clock only drifted a few seconds versus wall clock (and it's
> possible it was off a few seconds when it booted, as it didn't get an NTP sync at boot).
> 
> Audio plays "too fast" - a 4 minute .ogg goes through in about 3:40, sounding a bit
> high-pitched in the process.

> Any ideas?

Hrmmm. Are you seeing something like:

Loosing too many ticks!
TSC cannot be used as a timesource. (Are you running with SpeedStep?)
Falling back to a sane timesource.

in your dmesg?

I just realized that in clock_fallback() from my lost-tick-speedstep-fix
we don't re-calibrate loops_per_jiffies. The conversion from cycles to
loops should be pretty close, but that might need some additional work. 

Hrmmm..
-john



