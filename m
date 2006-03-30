Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751310AbWC3EFX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751310AbWC3EFX (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Mar 2006 23:05:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751311AbWC3EFW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Mar 2006 23:05:22 -0500
Received: from adsl-64-171-19-66.dsl.sntc01.pacbell.net ([64.171.19.66]:32014
	"EHLO giraffe.giraffe-data.com") by vger.kernel.org with ESMTP
	id S1751310AbWC3EFW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Mar 2006 23:05:22 -0500
Message-ID: <21892.bryanh@giraffe-data.com>
Date: 30 Mar 2006 03:51:51 +0000
From: bryanh@giraffe-data.com (Bryan Henderson)
To: alessandro.zummo@towertech.it
CC: mpm@selenic.com, benh@kernel.crashing.org, ak@muc.de, akpm@osdl.org,
       torvalds@osdl.org, davem@davemloft.net, kkojima@rr.iij4u.or.jp,
       lethal@linux-sh.org, paulus@samba.org, ralf@linux-mips.org,
       rmk@arm.linux.org.uk, linux-kernel@vger.kernel.org, smurf@debian.org,
       stenn@whimsy.udel.edu, bunk@stusta.de, lamont@debian.org
In-reply-to: <20060329200758.2281149b@inspiron>
	(alessandro.zummo@towertech.it)
Subject: Re: 11 minute RTC update (was Re: Remove RTC UIP)
References: <200603270920.k2R9KYYx007214@shell0.pdx.osdl.net>
	<20060327111836.GA79131@muc.de>
	<20060327163218.GD3642@waste.org>
	<20060327190037.GB27030@muc.de>
	<20060327211143.55ef7c4e@inspiron>
	<1143512075.2284.2.camel@localhost.localdomain>
	<20060329000215.683eb2d5@inspiron>
	<20060329000345.GZ3642@waste.org>
	<20060329031102.0e056d85@inspiron>
	<20060329012137.GB3642@waste.org>
	<20060329034555.11785044@inspiron>
	<52304.bryanh@giraffe-data.com> <20060329200758.2281149b@inspiron>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> udev will make a link from /dev/rtc to /dev/rtc0, but it would be
> fine if hwclock can check /dev/rtc0 itself in no device is specified
> on the cmd line.

I think one could argue as strongly that if the user has multiple
clocks and has not selected one as default by symlinking it to /dev/rtc,
then hwclock should make the user choose rather than pick one silently.

I'm ambivalent.  I'll go ahead and make hwclock use /dev/rtc0 if there's
no /dev/rtc, unless I hear more arguments for the other side.

> It would be fine if hwclock can wait for the second to change only
> for a definite amount of time and then always try to set the time.

OK.  N.B. the wait already times out, but in present code, that causes
the program to fail without setting anything.  Also the --fast option
makes hwclock simply skip the whole synchronization process (meant for
use by people who don't find subsecond precision worth two seconds of
waiting at every boot).

I'll make hwclock proceed to set the clock when the synchronization
fails, but not try to recalculate the drift rate.

-- 
Bryan Henderson                                    Phone 408-621-2000
San Jose, California
