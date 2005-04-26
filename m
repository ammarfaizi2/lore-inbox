Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261474AbVDZMM4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261474AbVDZMM4 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Apr 2005 08:12:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261492AbVDZMM4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Apr 2005 08:12:56 -0400
Received: from smtp204.mail.sc5.yahoo.com ([216.136.130.127]:29051 "HELO
	smtp204.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S261474AbVDZMMy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Apr 2005 08:12:54 -0400
Subject: Re: [patch] optimise loop driver a bit
From: Nick Piggin <nickpiggin@yahoo.com.au>
To: Andrew Morton <akpm@osdl.org>
Cc: axboe@suse.de, lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <20050426050429.69137417.akpm@osdl.org>
References: <426C6AF2.9090406@yahoo.com.au>
	 <20050426050429.69137417.akpm@osdl.org>
Content-Type: text/plain
Date: Tue, 26 Apr 2005 22:12:47 +1000
Message-Id: <1114517567.5097.30.camel@npiggin-nld.site>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2005-04-26 at 05:04 -0700, Andrew Morton wrote:
> Nick Piggin <nickpiggin@yahoo.com.au> wrote:
> >
> > Looks like locking can be optimised quite a lot.
> 
> So I've peered suspiciously at the ->lo_pending handling for some time and
> am unconvinced.  Are you sure that the error path in loop_make_request() is
> correct?  The old code decremented the pending count in there.
> 

Pretty sure it is correct. I'm usually wrong though :P

It decremented lo_pending because it had previously incremented it.
We do away with that and do that under a single critical section,
with the increment done _after_ all error checking. So...

> Why do we need that nasty-looking `pending' local in loop_thread()?

Don't I guess, no. If it reaches zero at any stage then that's
where it should stay. So I think you can just read lo_pending.

Nick

-- 
SUSE Labs, Novell Inc.


