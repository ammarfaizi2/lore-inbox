Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751371AbWDKRFJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751371AbWDKRFJ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Apr 2006 13:05:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751378AbWDKRFJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Apr 2006 13:05:09 -0400
Received: from [212.33.166.178] ([212.33.166.178]:3589 "EHLO raad.intranet")
	by vger.kernel.org with ESMTP id S1751371AbWDKRFH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Apr 2006 13:05:07 -0400
From: Al Boldi <a1426z@gawab.com>
To: Con Kolivas <kernel@kolivas.org>
Subject: Re: Fwd: Re: [patch][rfc] quell interactive feeding frenzy
Date: Tue, 11 Apr 2006 20:03:24 +0300
User-Agent: KMail/1.5
References: <200604112100.28725.kernel@kolivas.org>
In-Reply-To: <200604112100.28725.kernel@kolivas.org>
Cc: linux-kernel@vger.kernel.org, Mike Galbraith <efault@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="windows-1256"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200604112003.24517.a1426z@gawab.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Con Kolivas wrote:
> Hi Al

Hi Con!

> On Tuesday 11 April 2006 00:43, Al Boldi wrote:
> > After that the loadavg starts to wrap.
> > And even then it is possible to login.
> > And that's not with the default 2.6 scheduler, but rather w/ spa.
>
> Since you seem to use plugsched, I wonder if you could tell me how does
> current staircase perform with a load like that?

With plugsched-2.6.16 your staircase sched reaches about 40 then slows down, 
maxing around 100.  Setting sched_compute=1 causes console lock-ups.

With staircase14.2-test3 it reaches around 300 then slows down, halting at 
around 500.

Your scheduler seems to be tuned for single-user multi-tasking, i.e. 
concurrent tasks around 10, where its aggressive nature is sustained by a 
short run-queue.  Once you go above 50, this aggressiveness starts to  
express itself as very jumpy.

This is of course very cpu/mem/ctxt dependent and it would be great, if your 
scheduler could maybe do some simple on-the-fly benchmarking as it 
reschedules, thus adjusting this aggressiveness depending on its 
sustainability.

Thanks!

--
Al

