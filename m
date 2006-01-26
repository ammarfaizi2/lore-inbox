Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751140AbWAZBJD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751140AbWAZBJD (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Jan 2006 20:09:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751208AbWAZBJC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Jan 2006 20:09:02 -0500
Received: from mail1.webmaster.com ([216.152.64.168]:13068 "EHLO
	mail1.webmaster.com") by vger.kernel.org with ESMTP
	id S1751140AbWAZBJA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Jan 2006 20:09:00 -0500
From: "David Schwartz" <davids@webmaster.com>
To: "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>
Cc: <hancockr@shaw.ca>
Subject: RE: sched_yield() makes OpenLDAP slow
Date: Wed, 25 Jan 2006 17:07:36 -0800
Message-ID: <MDEHLPKNGKAHNMBLJOLKAEJBJKAB.davids@webmaster.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.6604 (9.0.2911.0)
Importance: Normal
In-Reply-To: <43D78262.2050809@symas.com>
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.2670
X-Authenticated-Sender: joelkatz@webmaster.com
X-Spam-Processed: mail1.webmaster.com, Wed, 25 Jan 2006 17:04:22 -0800
	(not processed: message from trusted or authenticated source)
X-MDRemoteIP: 206.171.168.138
X-Return-Path: davids@webmaster.com
X-MDaemon-Deliver-To: linux-kernel@vger.kernel.org
Reply-To: davids@webmaster.com
X-MDAV-Processed: mail1.webmaster.com, Wed, 25 Jan 2006 17:04:42 -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> Robert Hancock wrote:

>  > "If there are threads blocked on the mutex object referenced by mutex
>  > when pthread_mutex_unlock() is called, resulting in the mutex becoming
>  > available, the scheduling policy shall determine which thread shall
>  > acquire the mutex."
>  >
>  > This says nothing about requiring a reschedule. The "scheduling policy"
>  > can well decide that the thread which just released the mutex can
>  > re-acquire it.

> No, because the thread that just released the mutex is obviously not one
> of  the threads blocked on the mutex.

	So what?

> When a mutex is unlocked, one of
> the *waiting* threads at the time of the unlock must acquire it, and the
> scheduling policy can determine that.

	This is false and is nowhere found in the standard.

> But the thread the released the
> mutex is not one of the waiting threads, and is not eligible for
> consideration.

	Where are you getting this from? Nothing requires the scheduler to schedule
any threads when the mutex is released.

	All that must happen is that the mutex must be unlocked. The scheduler is
permitted to allow any thread it wants to run at that point, or no thread.
Nothing says the thread that released the mutex can't continue running and
nothing says that it can't call pthread_mutex_lock and re-acquire the mutex
before any other thread gets around to getting it.

	In general, it is very bad karma for the scheduler to stop a thread before
its timeslice is up if it doesn't have to. Consider one CPU and two threads,
each needing to do 100 quick lock/unlock cycles. Why force 200 context
switches?

	DS


