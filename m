Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267339AbTAUXX5>; Tue, 21 Jan 2003 18:23:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267342AbTAUXX5>; Tue, 21 Jan 2003 18:23:57 -0500
Received: from packet.digeo.com ([12.110.80.53]:58087 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S267339AbTAUXXz>;
	Tue, 21 Jan 2003 18:23:55 -0500
Message-ID: <3E2DD8A7.3F07C40E@digeo.com>
Date: Tue, 21 Jan 2003 15:32:55 -0800
From: Andrew Morton <akpm@digeo.com>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.5.51 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: john stultz <johnstul@us.ibm.com>
CC: lkml <linux-kernel@vger.kernel.org>
Subject: Re: [RFC][PATCH] linux-2.5.59_lost-tick_A0
References: <1043189962.15683.82.camel@w-jstultz2.beaverton.ibm.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 21 Jan 2003 23:32:55.0620 (UTC) FILETIME=[6CA34840:01C2C1A5]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

john stultz wrote:
> 
> All,
>         This patch addresses the following problem: Linux cannot properly
> handle the case where interrupts are disabled for longer then two ticks.
> 

Question is: who is holding interrupts off for so long?

It might be better to implement a detection scheme inside
the timer interrupt handler: if the time since last interrupt
exceeds two ticks, whine and drop a backtrace.

That backtrace will point up into the local_irq_enable() in
the offending code, and we can go fix it?
