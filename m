Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265407AbRF0Vj0>; Wed, 27 Jun 2001 17:39:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265418AbRF0VjR>; Wed, 27 Jun 2001 17:39:17 -0400
Received: from gateway.sequent.com ([192.148.1.10]:1008 "EHLO
	gateway.sequent.com") by vger.kernel.org with ESMTP
	id <S265407AbRF0Vi7>; Wed, 27 Jun 2001 17:38:59 -0400
Date: Wed, 27 Jun 2001 14:38:45 -0700
From: Mike Kravetz <mkravetz@sequent.com>
To: Manfred Spraul <manfred@colorfullife.com>
Cc: Scott Long <scott@swiftview.com>, linux-kernel@vger.kernel.org
Subject: Re: wake_up vs. wake_up_sync
Message-ID: <20010627143845.D1135@w-mikek2.des.beaverton.ibm.com>
In-Reply-To: <3B3A4E8B.E4301909@colorfullife.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <3B3A4E8B.E4301909@colorfullife.com>; from manfred@colorfullife.com on Wed, Jun 27, 2001 at 11:22:19PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 27, 2001 at 11:22:19PM +0200, Manfred Spraul wrote:
> > Why would you want to prevent
> > reschedule_idle()?
> > 
> If one process runs, wakes up another process and _knows_ that it's
> going to sleep immediately after the wake_up it doesn't need the
> reschedule_idle: the current cpu will be idle soon, the scheduler
> doesn't need to find another cpu for the woken up thread.

I'm curious.  How does the caller of wake_up_sync know that the
current cpu will soon be idle.  Does it assume that there are no
other tasks on the runqueue waiting for a CPU?  If there are other
tasks on the runqueue, isn't it possible that another task has a
higher goodness value than the task being awakened.  In such a case,
isn't is possible that the awakened task could sit on the runqueue
(waiting for a CPU) while tasks with a lower goodness value are
allowed to run?

-- 
Mike Kravetz                                 mkravetz@sequent.com
IBM Linux Technology Center
