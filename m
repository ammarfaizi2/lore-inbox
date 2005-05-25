Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262264AbVEYDgf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262264AbVEYDgf (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 May 2005 23:36:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262262AbVEYDgd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 May 2005 23:36:33 -0400
Received: from gateway-1237.mvista.com ([12.44.186.158]:10735 "EHLO
	av.mvista.com") by vger.kernel.org with ESMTP id S262255AbVEYDg3
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 May 2005 23:36:29 -0400
From: "Sven Dietrich" <sdietrich@mvista.com>
To: "'Nick Piggin'" <nickpiggin@yahoo.com.au>,
       "'Lee Revell'" <rlrevell@joe-job.com>
Cc: "'Andrew Morton'" <akpm@osdl.org>, <dwalker@mvista.com>, <bhuey@lnxw.com>,
       <mingo@elte.hu>, <hch@infradead.org>, <linux-kernel@vger.kernel.org>
Subject: RE: RT patch acceptance
Date: Tue, 24 May 2005 20:36:21 -0700
Message-ID: <005801c560da$ec624f50$c800a8c0@mvista.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook, Build 10.0.6626
In-Reply-To: <4293EFE8.1080106@yahoo.com.au>
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.2180
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> Lee Revell wrote:
> 
> >On Tue, 2005-05-24 at 19:20 -0700, Andrew Morton wrote:
> >
> >>Sven Dietrich <sdietrich@mvista.com> wrote:
> >>
> >>>I think people would find their system responsiveness / 
> tunability  
> >>>goes up tremendously, if you drop just a few unimportant 
> IRQs into  
> >>>threads.
> >>>
> >>People cannot detect the difference between 1000usec and 50usec 
> >>latencies, so they aren't going to notice any changes in 
> >>responsiveness at all.
> >>
> >
> >The IDE IRQ handler can in fact run for several ms, which 
> people sure 
> >can detect.
> >
> >
> 
> Are you serious? Even at 10ms, the monitor refresh rate would 
> have to be over 100Hz for anyone to "notice" anything, 
> right?... What sort of numbers are you talking when you say several?
>

Even without numbers, the IDE IRQ, when run in a thread, 
competes with tasks at process level, so that other
tasks can make some progress. Especially if those tasks are
high priority.

With multiple disks on a chain, you can see transients that
lock up the CPU in IRQ mode for human-perceptible time,
especially on slower CPUs... 

This is part of the reason why SoftIRQd exists: to act as
a governor for bottom halves that run over and over again.
SoftIRQd handles those bursty bottom halves in task space.

So with that, you already have bottom halves in threads.

Then we are just talking about the concept of running the
top-half in a thread as well.

Maybe Lee will have some numbers handy...


