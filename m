Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S274909AbTGaXHI (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 31 Jul 2003 19:07:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S274910AbTGaXHI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 31 Jul 2003 19:07:08 -0400
Received: from users.ccur.com ([208.248.32.211]:52401 "HELO rudolph.ccur.com")
	by vger.kernel.org with SMTP id S274909AbTGaXG7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 31 Jul 2003 19:06:59 -0400
Date: Thu, 31 Jul 2003 19:06:36 -0400
From: Joe Korty <joe.korty@ccur.com>
To: Robert Love <rml@tech9.net>
Cc: torvalds@osdl.org, akpm@digeo.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] protect migration/%d etc from sched_setaffinity
Message-ID: <20030731230635.GA7852@rudolph.ccur.com>
Reply-To: Joe Korty <joe.korty@ccur.com>
References: <20030731224604.GA24887@tsunami.ccur.com> <1059692548.931.329.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1059692548.931.329.camel@localhost>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> On Thu, 2003-07-31 at 15:46, Joe Korty wrote:
> 
> > Lock out users from changing the cpu affinity of those per-cpu system
> > daemons which cannot survive such a change, such as migration/%d.
> > 
> > Passes basic handtest of sched_setaffinity(2) on various locked and
> > unlocked processes on a i386, otherwise untested except by eyeball.
> > 
> > Except for one line in i386, no arch needed any changes to support
> > this patch.
> 
> I have been wondering what to do about processor affinity and kernel
> threads. I just concluded "only root can change it, and we can let root
> stab herself if she really wants to."
> 
> But if this is really an issue, why not just do:
> 
> 	ret = -EINVAL;
> 	if (!p->mm)
> 		goto out_unlock;
> 
> in sys_sched_setaffinity ?
> 
> 	Robert Love


It's not all system daemons, just some of them that need protection.

Keeping the set of locked-down daemons to the smallest possible is
important when one wants to 'set aside' cpus for use only by
specific, need-the-lowest-latency-possible realtime applications.

Joe
