Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263244AbUBDSYF (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Feb 2004 13:24:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263584AbUBDSYF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Feb 2004 13:24:05 -0500
Received: from e5.ny.us.ibm.com ([32.97.182.105]:48593 "EHLO e5.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S263244AbUBDSYB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Feb 2004 13:24:01 -0500
Subject: Re: TSC and real-time clock slippage with 2.6.2
From: john stultz <johnstul@us.ibm.com>
To: Ian Chard <ian@chard.org>
Cc: lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <1075901679.5608.13.camel@tanagra>
References: <1075901679.5608.13.camel@tanagra>
Content-Type: text/plain
Message-Id: <1075918985.794.4.camel@cog.beaverton.ibm.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-7) 
Date: Wed, 04 Feb 2004 10:23:05 -0800
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2004-02-04 at 05:34, Ian Chard wrote:
> Ever since I upgraded from 2.4.20 to the 2.6 tree, I've had a problem
> with real-time clock slippage and hard hangs on my Athlon XP 2500+
> (1830MHz according to /proc/cpuinfo).  I've kept an eye on the list and
> have applied new patches as the problem seems to be known about, but as
> the problem's still there with 2.6.2 I thought it was about time I
> reared my ugly head.
> 
> At or shortly after boot time, I get the "Losing too many ticks!"
> message (this seems to be related to how hard the system is working --
> if it runs an fsck, the message appears immediately).  Then, while the
> system is running, the real-time clock will lose time: the more jobs use
> the CPU, the more time I lose.  Occasionally, the system will oops or
> hard-hang altogether (which could be an unrelated driver issue; it is
> pretty unusual).
> 
> I'm willing to test any patches you clever folk want to throw at me, or
> alternatively if there's an easy solution I'll try anything.

Are you using the amd76x_pm module?

Also, does time still drift backward with the following patch?

Could you also send me your dmesg and ntp drift file for both with and
without this patch?

thanks
-john

===== arch/i386/kernel/timers/timer_tsc.c 1.35 vs edited =====
--- 1.35/arch/i386/kernel/timers/timer_tsc.c	Wed Jan  7 00:31:11 2004
+++ edited/arch/i386/kernel/timers/timer_tsc.c	Tue Jan 20 13:22:54 2004
@@ -226,7 +226,7 @@
 	delta += delay_at_last_interrupt;
 	lost = delta/(1000000/HZ);
 	delay = delta%(1000000/HZ);
-	if (lost >= 2) {
+	if (0 && (lost >= 2)) {
 		jiffies_64 += lost-1;
 
 		/* sanity check to ensure we're not always losing ticks */



