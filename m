Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261182AbTFJSLU (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Jun 2003 14:11:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261245AbTFJSLU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Jun 2003 14:11:20 -0400
Received: from pao-ex01.pao.digeo.com ([12.47.58.20]:44606 "EHLO
	pao-ex01.pao.digeo.com") by vger.kernel.org with ESMTP
	id S261182AbTFJSLT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Jun 2003 14:11:19 -0400
Date: Tue, 10 Jun 2003 11:25:41 -0700
From: Andrew Morton <akpm@digeo.com>
To: george anzinger <george@mvista.com>
Cc: linux-kernel@vger.kernel.org, Eric.Piel@Bull.Net
Subject: Re: [PATCH] Some clean up of the time code.
Message-Id: <20030610112541.3f12586d.akpm@digeo.com>
In-Reply-To: <3EE5FB06.1060207@mvista.com>
References: <3EE52CA7.9010007@mvista.com>
	<20030609182213.2072ca24.akpm@digeo.com>
	<3EE5FB06.1060207@mvista.com>
X-Mailer: Sylpheed version 0.9.0pre1 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 10 Jun 2003 18:25:01.0119 (UTC) FILETIME=[9ACF24F0:01C32F7D]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

george anzinger <george@mvista.com> wrote:
>
> Andrew Morton wrote:
> > george anzinger <george@mvista.com> wrote:
> > 
> >>-void do_settimeofday(struct timeval *tv)
> >> +int do_settimeofday(struct timespec *tv)
> >>  {
> >> +	if ((unsigned long)tv->tv_nsec > NSEC_PER_SEC)
> >> +		return -EINVAL;
> >> +
> > 
> > 
> > Should that be ">="?
> > 
> > Is there any reasonable way to avoid breaking existing
> > do_settimeofday() implementations? That's just more grief all round.
> 
> Hm. Giving this more thought, the main reason for the change was to 
> move to the timespec from the timeval, i.e. nanoseconds instead of 
> microseconds.  The error check was put in because the function was 
> already being changed.  The reason to move to the timespec is to 
> complete the change made to xtime and to more correctly align with the 
> POSIX clock_settime, both of which use timespec.
> 

Well if it's really the Right Thing To Do then OK.  Was just checking.

About 30 do_settimeofday() implementations need to be repaired.
