Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261624AbTE2BdF (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 May 2003 21:33:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261823AbTE2BdF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 May 2003 21:33:05 -0400
Received: from holomorphy.com ([66.224.33.161]:60804 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id S261624AbTE2BdE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 May 2003 21:33:04 -0400
Date: Wed, 28 May 2003 18:46:08 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Jim Houston <jim.houston@attbi.com>
Cc: linux-kernel@vger.kernel.org, jim.houston@ccur.com
Subject: Re: signal queue resource - Posix timers
Message-ID: <20030529014608.GX8978@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Jim Houston <jim.houston@attbi.com>, linux-kernel@vger.kernel.org,
	jim.houston@ccur.com
References: <200305281856.h4SIuFZ02449@linux.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200305281856.h4SIuFZ02449@linux.local>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 28, 2003 at 02:56:15PM -0400, Jim Houston wrote:
> In the pre-allocated approach, the timer code would allocate a
> sigqueue structure as part of the timer_create.  I would add new
> send_sigqueue() and send_group_sigqueue() which would accept the
> pointer to the pre-allocated sigqueue structure rather than a siginfo
> pointer. There would also be changes to the code which dequeues the
> siginfo structure to recognize these preallocated sigqueue structures.
> In the case of Posix timers using a preallocated siqueue entry also
> makes handling overruns easier.  If the timer code finds that its
> sigqueue structure is still queued, it can simply increment the
> overrun count.
> The reservation approach would keep a pre-allocated pool of sigqueue
> structures and a reservation count.  The timer_create would reserve
> a sigqueue entry which would be place in the pool until it is needed.
> I wonder if anyone else is interested in this problem.

Well, I've never run into it and it sounds really obscure, but I agree
in principle that it's better to return an explicit error to userspace
than to silently fail, at least when it's feasible (obviously the kernel
can be beaten to death with events faster than it can deliver them, so
it won't always be feasible).

-- wli
