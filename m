Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263428AbTFDPRV (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Jun 2003 11:17:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263449AbTFDPRV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Jun 2003 11:17:21 -0400
Received: from DELFT.AURA.CS.CMU.EDU ([128.2.206.88]:32661 "EHLO
	delft.aura.cs.cmu.edu") by vger.kernel.org with ESMTP
	id S263428AbTFDPRU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Jun 2003 11:17:20 -0400
Date: Wed, 4 Jun 2003 11:30:50 -0400
To: linux-kernel@vger.kernel.org
Subject: Re: [Linux-ia64] Re: web page on O(1) scheduler
Message-ID: <20030604153048.GB26064@delft.aura.cs.cmu.edu>
Mail-Followup-To: linux-kernel@vger.kernel.org
References: <5.2.0.9.2.20030529062657.01fcaa50@pop.gmx.net> <5.2.0.9.2.20030604074452.00ce0380@pop.gmx.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5.2.0.9.2.20030604074452.00ce0380@pop.gmx.net>
User-Agent: Mutt/1.5.4i
From: Jan Harkes <jaharkes@cs.cmu.edu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 04, 2003 at 09:13:43AM +0200, Mike Galbraith wrote:
> Using sched_yield() as a mutex is exactly the same as using a party line 
> for private conversation.

I actually used sched_yield for the 'inverse' mutex case. One thread was
pretty much exclusively holding a mutex, but other threads sometimes try
to get through the same critical section and block on mutex_lock. 

The first thread then occasionally does,

    mutex_unlock()
    sched_yield()
    mutex_lock()

Without the sched_yield, other threads never get a chance to wake up and
grab the mutex before the mutex hogging thread is back in the critical
section.

This is ofcourse the simple explanation, this was actually part of a
wrapper around pthreads that needed to provide non-concurrent
co-routines that in specific situations could run concurrently for a bit
to do DNS lookups and such.

Not sure how different semantics affect this because I went with a
different solution a while ago.

Jan
