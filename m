Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266805AbTBGXCA>; Fri, 7 Feb 2003 18:02:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266809AbTBGXCA>; Fri, 7 Feb 2003 18:02:00 -0500
Received: from e2.ny.us.ibm.com ([32.97.182.102]:16060 "EHLO e2.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S266805AbTBGXB7>;
	Fri, 7 Feb 2003 18:01:59 -0500
Subject: Re: [RFC][PATCH] linux-2.5.59_getcycles_A0
From: john stultz <johnstul@us.ibm.com>
To: Andi Kleen <ak@suse.de>
Cc: lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <p73ptq3bxh6.fsf@oldwotan.suse.de>
References: <1044649542.18673.20.camel@w-jstultz2.beaverton.ibm.com.suse.lists.linux.kernel>
	 <p73ptq3bxh6.fsf@oldwotan.suse.de>
Content-Type: text/plain
Organization: 
Message-Id: <1044659375.18676.80.camel@w-jstultz2.beaverton.ibm.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.1 
Date: 07 Feb 2003 15:09:35 -0800
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2003-02-07 at 13:19, Andi Kleen wrote:
> john stultz <johnstul@us.ibm.com> writes:
> > 	This patch moves the get_cycles() implementation into the timer_opts
> > subsystem. This patch corrects issues between the hangcheck-timer code
> > and systems running with timer_cyclone. As an extra bonus, it removes
> > the CONFIG_X86_TSC #ifdef in get_cycles replacing it with
> > timer->get_cycles(). 
> 
> Is this really a good idea? get_cycles is normally not used to get accurate
> time, but just to get random numbers for /dev/random or quickly estimate
> some code (scheduler used to use it for that). I think the TSC even when
> unsynchronized is better for that than an external timer which potentially
> lower resolution and long access time.
> 
> If you really added it I would at least change the random device to 
> use the old macro.

I'm sorry, I'm not seeing get_cycles used in /dev/random (although they
do make a direct call to rdtsc if its available - which is fine, since
the TSCs I deal with daily just give random values anyway :). So I don't
believe that is a concern.  

Additionally, the hangcheck timer code does calculate time (although,
not system time) using get_cycles, and this gives them a good
abstraction so the right thing happens on the right box. 

Let me know if you have any other concerns.

thanks
-john







