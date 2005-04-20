Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261299AbVDTDg3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261299AbVDTDg3 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Apr 2005 23:36:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261304AbVDTDg3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Apr 2005 23:36:29 -0400
Received: from e34.co.us.ibm.com ([32.97.110.132]:16832 "EHLO
	e34.co.us.ibm.com") by vger.kernel.org with ESMTP id S261299AbVDTDgV
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Apr 2005 23:36:21 -0400
From: James Cleverdon <jamesclv@us.ibm.com>
Reply-To: jamesclv@us.ibm.com
Organization: IBM LTC (xSeries Solutions)
To: philip dahlquist <dahlquist@kreative.net>
Subject: Re: easy softball jiffies quest(ion)
Date: Tue, 19 Apr 2005 20:36:14 -0700
User-Agent: KMail/1.7.1
Cc: linux-kernel@vger.kernel.org
References: <20050409010252.2eca2177.dahlquist@kreative.net>
In-Reply-To: <20050409010252.2eca2177.dahlquist@kreative.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200504192036.14994.jamesclv@us.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

As others have said, maybe jiffies isn't the time value you want.  
However, clock ticks are available in userland via the times system 
call.

Note the warning at the end; you'll have to do your comparisons 
correctly or fail when the counter overflows.

man 2 times:

	...
	Return Value
		The function times returns the number of clock ticks that have
		elapsed since an arbitrary point in the past.  For Linux this
		point is the moment the system was booted.  This return
		value may overflow the possible range of type clock_t.


On Friday 08 April 2005 10:02 pm, philip dahlquist wrote:
> hi,
>
> i'm on a quest to get access to jiffies in user space so i can write
> a simple stepper motor driver program.  i co-opted the "#includes"
> list from alessandro rubini's jit.c file from "linux device drivers"
> to write jfi.c.
>
> this is it:
> ------------------------------------------------------------------
> #include <linux/config.h>
> #include <linux/module.h>
> #include <linux/moduleparam.h>
> #include <linux/init.h>
>
> #include <linux/time.h>
> #include <linux/timer.h>
> #include <linux/kernel.h>
> #include <linux/proc_fs.h>
> #include <linux/types.h>
> #include <linux/spinlock.h>
> #include <linux/interrupt.h>
>
> #include <asm/hardirq.h>
>
>
> int main(void)
> {
> 	unsigned long j = jiffies + (50 * HZ);
> 	printf("start jiffies = %9li\n",jiffies);
> 	while(jiffies < j)
> 		;
>
> 	printf("done jiffies = %9li\n", jiffies);
> 	return 0;
> }
[[ Snip! ]]

-- 
James Cleverdon
IBM LTC (xSeries Linux Solutions)
{jamesclv(Unix, preferred), cleverdj(Notes)} at us dot ibm dot comm
