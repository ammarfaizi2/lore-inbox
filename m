Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263001AbUDLSQ6 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Apr 2004 14:16:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263007AbUDLSQ6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Apr 2004 14:16:58 -0400
Received: from e2.ny.us.ibm.com ([32.97.182.102]:659 "EHLO e2.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S263001AbUDLSQ4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Apr 2004 14:16:56 -0400
Subject: Re: hangcheck watchdog triggers if clock=pit. Missing code in
	monotonic_clock_pit()?
From: john stultz <johnstul@us.ibm.com>
To: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>,
       Joel Becker <Joel.Becker@oracle.com>
Cc: lkml <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>
In-Reply-To: <200404101635.37401.vda@port.imtp.ilyichevsk.odessa.ua>
References: <200404101635.37401.vda@port.imtp.ilyichevsk.odessa.ua>
Content-Type: text/plain
Message-Id: <1081793784.4705.22.camel@cog.beaverton.ibm.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-7) 
Date: Mon, 12 Apr 2004 11:16:25 -0700
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2004-04-10 at 06:35, Denis Vlasenko wrote:
> linux-2.6.5/arch/i386/kernel/time.c:
> ====================================
> /* monotonic_clock(): returns # of nanoseconds passed since time_init()
>  *              Note: This function is required to return accurate
>  *              time even in the absence of multiple timer ticks.
>  */
[snip]
> linux-2.6.5/arch/i386/kernel/timers/timer_pit.c:
> ================================================
> static unsigned long long monotonic_clock_pit(void)
> {
>         return 0;
> }

Part of the problem is that the PIT timesource cannot account for lost
ticks, thus we cannot strictly conform to the
monotonic_clock()interface. 

So either we just return (jiffies_64 * TICK_NSEC), and just have an
exception to the rule, or the hangcheck watchdog needs to know what to
do when monotonic_clock always returns zero. 

Joel: Do you have a preference?

thanks
-john


