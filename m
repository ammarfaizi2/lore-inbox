Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750714AbWKFKlp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750714AbWKFKlp (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Nov 2006 05:41:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750890AbWKFKlp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Nov 2006 05:41:45 -0500
Received: from brick.kernel.dk ([62.242.22.158]:2894 "EHLO kernel.dk")
	by vger.kernel.org with ESMTP id S1750714AbWKFKlo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Nov 2006 05:41:44 -0500
Date: Mon, 6 Nov 2006 11:43:50 +0100
From: Jens Axboe <jens.axboe@oracle.com>
To: Brent Baccala <cosine@freesoft.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: async I/O seems to be blocking on 2.6.15
Message-ID: <20061106104350.GR13555@kernel.dk>
References: <Pine.LNX.4.64.0611030311430.25096@debian.freesoft.org> <20061103122055.GE13555@kernel.dk> <Pine.LNX.4.64.0611031049120.7173@debian.freesoft.org> <20061103160212.GK13555@kernel.dk> <Pine.LNX.4.64.0611031214560.28100@debian.freesoft.org> <20061105121522.GC13555@kernel.dk> <Pine.LNX.4.64.0611060136250.4220@debian.freesoft.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0611060136250.4220@debian.freesoft.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 06 2006, Brent Baccala wrote:
> On Sun, 5 Nov 2006, Jens Axboe wrote:
> 
> >On Fri, Nov 03 2006, Brent Baccala wrote:
> >>
> >>Does 7 microseconds seem a bit excessive for an io_submit (and a
> >>gettimeofday)?
> >
> >I guess you mean miliseconds, not microseconds. 7 miliseconds seems way
> >too long. I repeated your test here, and the 100 submits take 97000
> >microseconds here - or 97 miliseconds. So that's a little less than 1
> >msec per io_submit. Still pretty big. You can experiment with oprofile
> >to profile where the kernel spends its time in that period.
> >
> >-- 
> >Jens Axboe
> >
> 
> Yes, of course, milliseconds.  I have enough other problems with this
> program (measured in minutes, and no mistake that) that I doubt I'll
> be profiling the kernel any time soon, but thank you for your help.
> 
> More than anything else, you've made me understand that I can't just
> fire off a bunch of async requests like I'm tossing peanuts across the
> table.  I've really got to pay attention to what's in that kernel
> queue and how it gets managed.

Yeah, I'm afraid so. We really should be returning EAGAIN or something
like that for the congested condition, though.

-- 
Jens Axboe

