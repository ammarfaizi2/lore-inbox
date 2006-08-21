Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932113AbWHUMtP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932113AbWHUMtP (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Aug 2006 08:49:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932100AbWHUMtP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Aug 2006 08:49:15 -0400
Received: from e3.ny.us.ibm.com ([32.97.182.143]:15255 "EHLO e3.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S932092AbWHUMtO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Aug 2006 08:49:14 -0400
Date: Mon, 21 Aug 2006 18:18:30 +0530
From: Srivatsa Vaddagiri <vatsa@in.ibm.com>
To: Mike Galbraith <efault@gmx.de>
Cc: Ingo Molnar <mingo@elte.hu>, Nick Piggin <nickpiggin@yahoo.com.au>,
       Sam Vilain <sam@vilain.net>, linux-kernel@vger.kernel.org,
       Kirill Korotaev <dev@openvz.org>, Balbir Singh <balbir@in.ibm.com>,
       sekharan@us.ibm.com, Andrew Morton <akpm@osdl.org>,
       nagar@watson.ibm.com, matthltc@us.ibm.com, dipankar@in.ibm.com
Subject: Re: [PATCH 0/7] CPU controller - V1
Message-ID: <20060821124830.GB14291@in.ibm.com>
Reply-To: vatsa@in.ibm.com
References: <20060820174015.GA13917@in.ibm.com> <1156156960.7772.38.camel@Homer.simpson.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1156156960.7772.38.camel@Homer.simpson.net>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 21, 2006 at 10:42:40AM +0000, Mike Galbraith wrote:
> WRT interactivity: Looking at try_to_wake_up(), it appears that wake-up
> of a high priority group-a task will not result in preemption of a lower
> priority current group-b task.  True?

I dont think it is true. The definition of TASK_PREEMPTS_CURR() is
unchanged with these patches. Also group priority is linked to the
highest priority task it has. As a result, the high-priority group-a
task should preempt the low priority group-b task.

This is unless group-a has currently run out of its bandwidth and is sitting in 
the expired queue (which is something that the TASK_PREEMPTS_CURR()
can be optimized to check for).

-- 
Regards,
vatsa
