Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261893AbTE2FNb (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 May 2003 01:13:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261904AbTE2FNb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 May 2003 01:13:31 -0400
Received: from ajax.cs.uga.edu ([128.192.251.3]:61854 "EHLO ajax.cs.uga.edu")
	by vger.kernel.org with ESMTP id S261893AbTE2FNa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 May 2003 01:13:30 -0400
To: linux-kernel@vger.kernel.org
Cc: Jim Houston <jim.houston@attbi.com>
Subject: Re: signal queue resource - Posix timers
From: Ed L Cashin <ecashin@uga.edu>
Date: Thu, 29 May 2003 01:26:45 -0400
In-Reply-To: <20030529014608.GX8978@holomorphy.com> (William Lee Irwin III's
 message of "Wed, 28 May 2003 18:46:08 -0700")
Message-ID: <87y90q1fxm.fsf@cs.uga.edu>
User-Agent: Gnus/5.090014 (Oort Gnus v0.14) Emacs/21.2
 (i386-debian-linux-gnu)
References: <200305281856.h4SIuFZ02449@linux.local>
	<20030529014608.GX8978@holomorphy.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

William Lee Irwin III <wli@holomorphy.com> writes:

> On Wed, May 28, 2003 at 02:56:15PM -0400, Jim Houston wrote:
>> In the pre-allocated approach, the timer code would allocate a
>> sigqueue structure as part of the timer_create.  I would add new
>> send_sigqueue() and send_group_sigqueue() which would accept the
>> pointer to the pre-allocated sigqueue structure rather than a siginfo
>> pointer. There would also be changes to the code which dequeues the
>> siginfo structure to recognize these preallocated sigqueue structures.
>> In the case of Posix timers using a preallocated siqueue entry also
>> makes handling overruns easier.  If the timer code finds that its
>> sigqueue structure is still queued, it can simply increment the
>> overrun count.
>> The reservation approach would keep a pre-allocated pool of sigqueue
>> structures and a reservation count.  The timer_create would reserve
>> a sigqueue entry which would be place in the pool until it is needed.
>> I wonder if anyone else is interested in this problem.
>
> Well, I've never run into it and it sounds really obscure, but I agree
> in principle that it's better to return an explicit error to userspace
> than to silently fail, at least when it's feasible (obviously the kernel
> can be beaten to death with events faster than it can deliver them, so
> it won't always be feasible).

Why couldn't this be a configurable per-user thing like RSS rlimits?

-- 
--Ed L Cashin     PGP public key: http://noserose.net/e/pgp/

