Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932533AbWBQHMu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932533AbWBQHMu (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Feb 2006 02:12:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932546AbWBQHMu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Feb 2006 02:12:50 -0500
Received: from ozlabs.org ([203.10.76.45]:11156 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S932533AbWBQHMu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Feb 2006 02:12:50 -0500
Subject: Re: Robust futexes
From: Rusty Russell <rusty@rustcorp.com.au>
To: Paul Jackson <pj@SGI.com>
Cc: mingo@elte.hu, linux-kernel@vger.kernel.org
In-Reply-To: <20060216224207.98526b40.pj@sgi.com>
References: <1140152271.25078.42.camel@localhost.localdomain>
	 <20060216224207.98526b40.pj@sgi.com>
Content-Type: text/plain
Date: Fri, 17 Feb 2006 18:12:50 +1100
Message-Id: <1140160371.25078.81.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.2.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2006-02-16 at 22:42 -0800, Paul Jackson wrote:
> Rusty wrote:
> >  having futex
> > calls which tell the kernel that the u32 value is in fact the holder's
> > TID?
> 
> Huh - I must be dense.  When would these calls be made?
> Once per task creation, once per allocation of memory
> for the lock, once per contested lock attempt, once per
> uncontested lock attempt, ... ?

Hi Paul,

	Sorry if I wasn't clear.  A flag on the futex_wait operation (or, given
the current implementation, YA multiplexed FUTEX_WAIT variant).

> With Ingo's robust_futexes, you could have a task that
> has taken and released a gazillion futex locks, and is
> still at the present moment holding 47 of them, drop dead
> and be able to initiate cleanup of exactly those 47 locks,
> never having made but one system call at the birth of the
> thread.
> 
> Can your idea do that?

I think so, yes.  The kernel realizes it has to sleep, checks the thread
corresponding to the TID it just read is still alive, if not goes into
cleanup path...

Does that clarify?
Rusty.
-- 
 ccontrol: http://ozlabs.org/~rusty/ccontrol

