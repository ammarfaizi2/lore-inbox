Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267347AbTAUXqr>; Tue, 21 Jan 2003 18:46:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267348AbTAUXqq>; Tue, 21 Jan 2003 18:46:46 -0500
Received: from e35.co.us.ibm.com ([32.97.110.133]:10742 "EHLO
	e35.co.us.ibm.com") by vger.kernel.org with ESMTP
	id <S267347AbTAUXqp>; Tue, 21 Jan 2003 18:46:45 -0500
Subject: Re: [RFC][PATCH] linux-2.5.59_lost-tick_A0
From: john stultz <johnstul@us.ibm.com>
To: Andrew Morton <akpm@digeo.com>
Cc: lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <3E2DD8A7.3F07C40E@digeo.com>
References: <1043189962.15683.82.camel@w-jstultz2.beaverton.ibm.com>
	 <3E2DD8A7.3F07C40E@digeo.com>
Content-Type: text/plain
Organization: 
Message-Id: <1043192901.15683.103.camel@w-jstultz2.beaverton.ibm.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.1 
Date: 21 Jan 2003 15:48:22 -0800
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2003-01-21 at 15:32, Andrew Morton wrote:
> john stultz wrote:
> > 
> > All,
> >         This patch addresses the following problem: Linux cannot properly
> > handle the case where interrupts are disabled for longer then two ticks.
> > 
> 
> Question is: who is holding interrupts off for so long?

Unfortunately in my situation there is a card which can cause 30ms
stalls in an SMI handler. Yuck, I know. :P

> It might be better to implement a detection scheme inside
> the timer interrupt handler: if the time since last interrupt
> exceeds two ticks, whine and drop a backtrace.
> 
> That backtrace will point up into the local_irq_enable() in
> the offending code, and we can go fix it?

Hmm, clever! That would be a very good check for software caused stalls.
I'll try to drop that in. 

thanks for the feedback!
-john
 

