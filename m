Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266152AbUBKSgg (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Feb 2004 13:36:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266153AbUBKSgg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Feb 2004 13:36:36 -0500
Received: from e31.co.us.ibm.com ([32.97.110.129]:28818 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP id S266152AbUBKSge
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Feb 2004 13:36:34 -0500
Subject: Re: 2.6.2 - System clock runs too fast
From: john stultz <johnstul@us.ibm.com>
To: Markus Hofmann <markus@gofurther.de>
Cc: lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <200402111007.50549.markus@gofurther.de>
References: <200402101332.26552.markus@gofurther.de>
	 <1076442533.1351.35.camel@cog.beaverton.ibm.com>
	 <200402111007.50549.markus@gofurther.de>
Content-Type: text/plain
Message-Id: <1076524588.795.28.camel@cog.beaverton.ibm.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-7) 
Date: Wed, 11 Feb 2004 10:36:28 -0800
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2004-02-11 at 01:07, Markus Hofmann wrote:
> Thank you for answering.
> In the meantime I heard that apm could cause this problem. I tested this by 
> compiling acpi. The result was that the clock runs normal with acpi.
> But I want to use apm. So I removed the acpi and now the system clock is too 
> slow with only apm.
> 
> I think this is a very curious thing! :-(

Indeed, normally its ACPI that causes more problems. That's a new one.

I'd be curious how this drift changes using the attached patch.

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







