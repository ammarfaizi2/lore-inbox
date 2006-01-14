Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750770AbWANC4l@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750770AbWANC4l (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Jan 2006 21:56:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750826AbWANC4l
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Jan 2006 21:56:41 -0500
Received: from mail.gmx.net ([213.165.64.21]:35295 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1750770AbWANC4l (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Jan 2006 21:56:41 -0500
X-Authenticated: #14349625
Message-Id: <5.2.1.1.2.20060114032117.00be7230@pop.gmx.net>
X-Mailer: QUALCOMM Windows Eudora Version 5.2.1
Date: Sat, 14 Jan 2006 03:56:27 +0100
To: Con Kolivas <kernel@kolivas.org>
From: Mike Galbraith <efault@gmx.de>
Subject: Re: [SCHED] wrong priority calc - SIMPLE test case
Cc: Paolo Ornati <ornati@fastwebnet.it>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Ingo Molnar <mingo@elte.hu>, Nick Piggin <nickpiggin@yahoo.com.au>,
       Peter Williams <pwil3058@bigpond.net.au>, Andrew Morton <akpm@osdl.org>
In-Reply-To: <200601141305.49925.kernel@kolivas.org>
References: <5.2.1.1.2.20060113165958.00beb8e0@pop.gmx.net>
 <5.2.1.1.2.20060113124751.00bf2660@pop.gmx.net>
 <5.2.1.1.2.20060113165958.00beb8e0@pop.gmx.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
X-Antivirus: avast! (VPS 0601-0, 01/02/2006), Outbound message
X-Antivirus-Status: Clean
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At 01:05 PM 1/14/2006 +1100, Con Kolivas wrote:
>On Saturday 14 January 2006 03:15, Mike Galbraith wrote:
>
> > Um... try irman2
> > now... pure evilness)
>
>Hrm I've been using staircase which is immune for so long I'd all but
>forgotten about this test case. Looking at your code I assume your changes
>should help this?

Yes.   How much very much depends on how strictly I try to enforce.  In my 
experimental tree, I have four stages of throttling: 1 threshold to begin 
trying to consume the difference between measured slice_avg and sleep_avg 
(kidd gloves), 2 to begin treating all new sleep as noninteractive (stern 
talking to), 3 to cut off new sleep entirely (you're grounded), and 4 is 
when to start using slice_avg instead of the out of balance sleep_avg for 
the priority calculation (um, bitch-slap?).  Levels 1 and 2 won't stop 
irman2, 3 will, and especially 4 will.

These are all /proc settings at the moment, so I can set set my starvation 
pain threshold from super duper desktop (all off) to just as fair as a 
running slice completion time average can possibly make it (all at 1ns 
differential), and anywhere in between.

         -Mike 

