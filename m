Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269798AbUJWC2B@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269798AbUJWC2B (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Oct 2004 22:28:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269681AbUJWC1u
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Oct 2004 22:27:50 -0400
Received: from users.ccur.com ([208.248.32.211]:50123 "EHLO mig.iccur.com")
	by vger.kernel.org with ESMTP id S269798AbUJWC1Y (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Oct 2004 22:27:24 -0400
Date: Fri, 22 Oct 2004 22:27:19 -0400
From: Joe Korty <joe.korty@ccur.com>
To: Roland McGrath <roland@redhat.com>
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] posix timers using == instead of & for bitmask tests
Message-ID: <20041023022719.GA26057@tsunami.ccur.com>
Reply-To: joe.korty@ccur.com
References: <20041022143953.GA17881@tsunami.ccur.com> <200410222203.i9MM3KJG005761@magilla.sf.frob.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200410222203.i9MM3KJG005761@magilla.sf.frob.com>
User-Agent: Mutt/1.4.1i
X-OriginalArrivalTime: 23 Oct 2004 02:27:18.0916 (UTC) FILETIME=[D19F8C40:01C4B8A7]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 22, 2004 at 03:03:20PM -0700, Roland McGrath wrote:
> > Make posix-timers do a get_task_struct / put_task_struct if either
> > SIGEV_SIGNAL or SIGEV_THREAD_ID is set.  Currently the get/put is done
> > only if both are set.
> 
> What is the purpose of this change?  The `good_sigevent' check ensures that
> if SIGEV_THREAD_ID is set, then the value is exactly
> SIGEV_SIGNAL|SIGEV_THREAD_ID.  In fact, this change has no effect at all
> because SIGEV_SIGNAL is zero.  If it weren't, it would have an undesireable
> effect of doing the task_struct refcounting all the time instead of only
> for SIGEV_THREAD_ID.  That refcounting is never required in the plain
> SIGEV_SIGNAL case, because the task_struct pointer stored in the
> group_leader, and that is never freed before all the posix-timers data
> structures get cleared out anyway (exit_itimers).  It's only required for
> SIGEV_THREAD_ID, where the target thread might have died before the timer
> was next examined.

Hi Roland,
 Thanks for answering my mistaken impressions.  I saw after I wrote that
SIGEV_SIGNAL == 0 which makes everything work.  And I was laboring under
the misconception that SIGEV_SIGNAL and SIGEV_THREAD were mutually exclusive
which isn't true, one always has SIGEV_SIGNAL if SIGEV_THREAD is set.

Regards,
Joe
