Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266193AbUIJGtJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266193AbUIJGtJ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Sep 2004 02:49:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266539AbUIJGtI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Sep 2004 02:49:08 -0400
Received: from fw.osdl.org ([65.172.181.6]:63688 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S266193AbUIJGtC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Sep 2004 02:49:02 -0400
Date: Thu, 9 Sep 2004 23:49:00 -0700
From: Chris Wright <chrisw@osdl.org>
To: Roland McGrath <roland@redhat.com>
Cc: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] fix sigqueue accounting for posix-timers broken by new RLIMIT_SIGPENDING tracking code
Message-ID: <20040909234900.Q1973@build.pdx.osdl.net>
References: <200409100510.i8A5AVD7025919@magilla.sf.frob.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <200409100510.i8A5AVD7025919@magilla.sf.frob.com>; from roland@redhat.com on Thu, Sep 09, 2004 at 10:10:31PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Roland McGrath (roland@redhat.com) wrote:
> 
> The introduction of RLIMIT_SIGPENDING and the associated tracking code was
> broken for the case of preallocated sigqueue elements, i.e. posix-timers.
> It wrongly includes the timer's preallocated sigqueue structs in the count
> towards the per-user when allocating them, but (rightly) does not decrement
> the count when they are freed.  

Are you sure?  IOW, are you seeing a leak of the count?  The sigqueue
structure has a lifetime the same as the timer, IIRC.  So each time the
signal is sent/received there's no accounting, because it's reused.
But timer create/delete does sigqueue_alloc -> __sigqueue_alloc which
does the inc. and sigqueue_free -> __sigqueue_free which does the dec.
I'm fairly sure I had tested this.

thanks,
-chris
-- 
Linux Security Modules     http://lsm.immunix.org     http://lsm.bkbits.net
