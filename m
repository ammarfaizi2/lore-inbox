Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261848AbVBCVQG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261848AbVBCVQG (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Feb 2005 16:16:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263219AbVBCVQG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Feb 2005 16:16:06 -0500
Received: from out006pub.verizon.net ([206.46.170.106]:40702 "EHLO
	out006.verizon.net") by vger.kernel.org with ESMTP id S261848AbVBCVPz
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Feb 2005 16:15:55 -0500
Message-Id: <200502032115.j13LFWFY009703@localhost.localdomain>
To: Ingo Molnar <mingo@elte.hu>
cc: Con Kolivas <kernel@kolivas.org>, "Bill Huey (hui)" <bhuey@lnxw.com>,
       "Jack O'Quin" <joq@io.com>, Nick Piggin <nickpiggin@yahoo.com.au>,
       linux <linux-kernel@vger.kernel.org>, rlrevell@joe-job.com,
       CK Kernel <ck@vds.kolivas.org>, utz <utz@s2y4n2c.de>,
       Andrew Morton <akpm@osdl.org>, alexn@dsv.su.se,
       Rui Nuno Capela <rncbc@rncbc.org>, Chris Wright <chrisw@osdl.org>,
       Arjan van de Ven <arjanv@redhat.com>
Subject: Re: [patch, 2.6.11-rc2] sched: RLIMIT_RT_CPU_RATIO feature 
In-reply-to: Your message of "Thu, 03 Feb 2005 21:47:11 +0100."
             <20050203204711.GB25018@elte.hu> 
Date: Thu, 03 Feb 2005 16:15:32 -0500
From: Paul Davis <paul@linuxaudiosystems.com>
X-Authentication-Info: Submitted using SMTP AUTH at out006.verizon.net from [151.197.43.196] at Thu, 3 Feb 2005 15:15:51 -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> yield_to(tid) should not be too hard to implement. Ingo? What do you
>> think?
>
>i dont really like it - it's really the wrong interface to use. Futexes
>are a much better locking/signalling interface. yield_to() would not be

i agree in principle, and i was suprised to see Con express this
thought so readily. 

however, i don't agree that futexes are conceptually superior. they
don't express the intended operation nearly as accurately as
yield_to(tid) would. the operation is "i have nothing else to do, and
i want <tid> to run next". a futex says "this particular condition is
satisfied, which might wake one or more tasks". its still necessary
for the caller to go to sleep explicitly, its still necessary for the
tasks involved to know about the futexes, which actually are really
irrelevant - there are no conditions to satisfy, just a series of
tasks we want to run.

--p


