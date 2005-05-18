Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262412AbVERXtT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262412AbVERXtT (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 May 2005 19:49:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262413AbVERXtT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 May 2005 19:49:19 -0400
Received: from one.firstfloor.org ([213.235.205.2]:18821 "EHLO
	one.firstfloor.org") by vger.kernel.org with ESMTP id S262412AbVERXtM
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 May 2005 19:49:12 -0400
To: joe.korty@ccur.com
Cc: robustmutexes@lists.osdl.org, george@mvista.com,
       linux-kernel@vger.kernel.org
Subject: Re: [RFC] A more general timeout specification
References: <20050518201517.GA16193@tsunami.ccur.com>
From: Andi Kleen <ak@muc.de>
Date: Thu, 19 May 2005 01:49:11 +0200
In-Reply-To: <20050518201517.GA16193@tsunami.ccur.com> (Joe Korty's message
 of "Wed, 18 May 2005 16:15:17 -0400")
Message-ID: <m1hdh0yu14.fsf@muc.de>
User-Agent: Gnus/5.110002 (No Gnus v0.2) Emacs/21.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Joe Korty <joe.korty@ccur.com> writes:

> The fusyn (robust mutexes) project proposes the creation
> of a more general data structure, 'struct timeout', for the
> specification of timeouts in new services.  In this structure,
> the user specifies:
>
>     a time, in timespec format.
>     the clock the time is specified against (eg, CLOCK_MONOTONIC).
>     whether the time is absolute, or relative to 'now'.

If you do a new structure for this I would suggest adding a
"precision" field (or the same with a different name). Basically
precision would tell the kernel that the wakeup can be in a time
range, not necessarily on the exact time specified. This helps
optimizing the idle loop because you can batch timers better and is
important for power management and virtualized environments. The
kernel internally does not use support this yet, but there are plans
to change the internal timers in this direction and if you're defining
a new user interface I would add support for this.

I am not sure precision would be the right name, other suggestions
are welcome.

> Also proposed are two new kernel routines for the manipulation
> of timeouts:
>
> 	timeout_validate()
> 	timeout_sleep()
>
> timeout_validate() error-checks the syntax of a timeout
> argument and returns either zero or -EINVAL.  By breaking
> timeout_validate() out from timeout_sleep(), it becomes possible

It is also useful to avoid code duplication in compat. 


-Andi
