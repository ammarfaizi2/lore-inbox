Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161031AbVLJU52@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161031AbVLJU52 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 10 Dec 2005 15:57:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161034AbVLJU52
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 10 Dec 2005 15:57:28 -0500
Received: from smtp2.Stanford.EDU ([171.67.16.125]:41348 "EHLO
	smtp2.Stanford.EDU") by vger.kernel.org with ESMTP id S1161031AbVLJU51
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 10 Dec 2005 15:57:27 -0500
Subject: Re: [RT] fix delay in do_vgettimeofday() in
	arch/x86_64/kernel/vsyscall.c
From: Fernando Lopez-Lezcano <nando@ccrma.Stanford.EDU>
To: john stultz <johnstul@us.ibm.com>
Cc: nando@ccrma.Stanford.EDU, Serge Belyshev <belyshev@depni.sinp.msu.ru>,
       Ingo Molnar <mingo@elte.hu>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <1134182041.4002.10.camel@leatherman>
References: <87d5k6ukky.fsf@foo.vault.bofh.ru>
	 <1134182041.4002.10.camel@leatherman>
Content-Type: text/plain
Date: Sat, 10 Dec 2005 12:56:54 -0800
Message-Id: <1134248214.16295.9.camel@cmn3.stanford.edu>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2005-12-09 at 18:33 -0800, john stultz wrote:
> On Fri, 2005-12-09 at 22:38 +0300, Serge Belyshev wrote:
> > 
> > There are occasional very very long (30..60 sec) delays happening when calling
> > gettimeofday() vsyscall on x86_64 with 2.6.14-rt22 kernel.
> > 
> > These delays come from while() looping over invalid data that are
> > going to be discarded by seqlock.
> 
> Ah, good catch! I just included a similar change (moved all the math
> outside the lock) in my own tree.

Is there something equivalent on i386 or this is just an x86_64 thing?
Over the past few days I have seen temporary "lockups" of my machine
(athlon X2 running -2.6.14-rt22, PREEMPT_RT, no hi res timers) lasting
for, say between 10 and 30 seconds. This happens maybe one to three
times in a day (that I noticed). The symptom is that the mouse moves but
everything else is just not doing anything. I don't see anything in the
logs or dmesg after the freeze, or on the servers that machine depends
on (through nfs). During one of those lockups a system load monitor in
the gnome panel was visible and it looked like there was a 100% system
load (or close) in one of the cpus. 

-- Fernando


