Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265586AbTFRWqz (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Jun 2003 18:46:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265584AbTFRWoA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Jun 2003 18:44:00 -0400
Received: from mail.ccur.com ([208.248.32.212]:45580 "EHLO exchange.ccur.com")
	by vger.kernel.org with ESMTP id S265592AbTFRWnW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Jun 2003 18:43:22 -0400
Date: Wed, 18 Jun 2003 18:57:10 -0400
From: Joe Korty <joe.korty@ccur.com>
To: george anzinger <george@mvista.com>
Cc: lkml <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@elte.hu>
Subject: Re: O(1) scheduler seems to lock up on sched_FIFO and sched_RR tasks
Message-ID: <20030618225710.GA20631@tsunami.ccur.com>
Reply-To: joe.korty@ccur.com
References: <3EF0979C.8060603@mvista.com> <20030618193053.GA15576@tsunami.ccur.com> <3EF0E7AC.60007@mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3EF0E7AC.60007@mvista.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> >Hi George,
> > When I boost the priority of each of the per-cpu 'events/%d' daemon to
> >96, the problem goes away.
> 
> Seems like your saying that the events workqueues are involved in the 
> scheduler in some ugly way.  Certainly not what your average rt 
> programmer would expect :(  What is going on here?


My guess is that tty/ptty driver character processing is done by the
event daemons.  In which case your high priority bash is running but the
characters it puts out (if any) cannot be seen nor are the characters
you type in passed to bash, until the mid-priority process exits and
lets the event daemon run.

I view this as a kind of priority inversion.  The only solution is for
RT users to learn what each daemon does and hand-boost the priority of
each to the RT priority appropriate to their mix of RT applications.

Joe
