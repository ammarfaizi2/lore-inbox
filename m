Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964892AbVJaXqq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964892AbVJaXqq (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 31 Oct 2005 18:46:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964894AbVJaXqp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 31 Oct 2005 18:46:45 -0500
Received: from maggie.cs.pitt.edu ([130.49.220.148]:59579 "EHLO
	maggie.cs.pitt.edu") by vger.kernel.org with ESMTP id S964892AbVJaXqp
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 31 Oct 2005 18:46:45 -0500
From: Claudio Scordino <cloud.of.andor@gmail.com>
To: Ulrich Drepper <drepper@gmail.com>
Subject: Re: Task profiling in Linux
Date: Tue, 1 Nov 2005 00:46:38 +0100
User-Agent: KMail/1.8
References: <200510232249.39236.cloud.of.andor@gmail.com> <a36005b50510310915q53ded6e8y607a536992924e5a@mail.gmail.com>
In-Reply-To: <a36005b50510310915q53ded6e8y607a536992924e5a@mail.gmail.com>
Cc: linux-kernel@vger.kernel.org, fabio checconi <checconi@gandalf.sssup.it>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200511010046.39445.cloud.of.andor@gmail.com>
X-Spam-Score: -1.665/8 BAYES_00 SA-version=3.000002
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thank you for your suggestion, but I still have a question about it. 

If I do

clock_gettime (CLOCK_THREAD_CPUTIME_ID, &old);
sleep(5);
clock_gettime (CLOCK_THREAD_CPUTIME_ID, &new);

why the difference (new-old) includes also the time the process has slept ?

Maybe there was a misunderstanding: I am looking for a way to know how long a 
process has _actually_ executed, accounting for all periods that it has not 
executed for some reason (like sleep, blocking, preemptions, etc.). And I 
need the high precision gave by the TSC (jiffies is not enough).

getrusage works fine, but has a coarse-grain precision (jiffies).
clock_gettime, instead, has a very good precision (thanks to TSC) but as you 
can see, it does not return the time that the process has actually 
executed...

If I am wrong, please tell me where.

Thank you,

            Claudio


On Monday 31 October 2005 18:15, you wrote:
> On 10/23/05, Claudio Scordino <cloud.of.andor@gmail.com> wrote:
> > To accomplish that, I can't just read the current time in different parts
> > of the program, nor I can set and use a timer, because this wouldn't
> > consider preemptions...
>
> struct timespec start;
> clock_gettime (CLOCK_PROCESS_CPUTIME_ID, &start);
>
> ... do work...
>
> struct timespec end;
> clock_gettime (CLOCK_PROCESS_CPUTIME_ID, &end);
>
> ... subtract start from end
>
> Or use CLOCK_THREAD_CPUTIME_ID if this is more correct for your
> application.
>
> This works since Roland's clock work got added in the 2.6 series.
> Before that preemption wasn't excluded.
