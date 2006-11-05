Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932681AbWKEMNV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932681AbWKEMNV (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 5 Nov 2006 07:13:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932682AbWKEMNV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 5 Nov 2006 07:13:21 -0500
Received: from brick.kernel.dk ([62.242.22.158]:5714 "EHLO kernel.dk")
	by vger.kernel.org with ESMTP id S932681AbWKEMNV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 5 Nov 2006 07:13:21 -0500
Date: Sun, 5 Nov 2006 13:15:23 +0100
From: Jens Axboe <jens.axboe@oracle.com>
To: Brent Baccala <cosine@freesoft.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: async I/O seems to be blocking on 2.6.15
Message-ID: <20061105121522.GC13555@kernel.dk>
References: <Pine.LNX.4.64.0611030311430.25096@debian.freesoft.org> <20061103122055.GE13555@kernel.dk> <Pine.LNX.4.64.0611031049120.7173@debian.freesoft.org> <20061103160212.GK13555@kernel.dk> <Pine.LNX.4.64.0611031214560.28100@debian.freesoft.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0611031214560.28100@debian.freesoft.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 03 2006, Brent Baccala wrote:
> On Fri, 3 Nov 2006, Jens Axboe wrote:
> 
> >Try to time it (visual output of the app is not very telling, and it's
> >buffered) and then apply some profiling.
> 
> OK, a little more info.  I added gettimeofday() calls after each call
> to io_submit(), put the timevals in an array, and after everything was
> done computed the difference between each timeval and the program start
> time, as well as the deltas.  I got this:
> 
> 0: 0.080s
> 1: 0.086s  0.006s
> 2: 0.102s  0.016s
> 3: 0.111s  0.008s
> 4: 0.118s  0.007s
> 5: 0.134s  0.015s
> 6: 0.141s  0.006s
> 7: 0.148s  0.006s
> 8: 0.158s  0.009s
> 9: 0.164s  0.006s
> ...
> 96: 1.036s  0.007s
> 97: 1.044s  0.007s
> 98: 1.147s  0.102s
> 99: 1.155s  0.008s
> 
> 98 appears to be an aberration.  Perhaps three of the times on an
> average run are around a tenth of a second; all of the others are
> pretty steady at 7 or 8 microseconds.  So, it's basically linear in
> its time consumption.
> 
> Does 7 microseconds seem a bit excessive for an io_submit (and a
> gettimeofday)?

I guess you mean miliseconds, not microseconds. 7 miliseconds seems way
too long. I repeated your test here, and the 100 submits take 97000
microseconds here - or 97 miliseconds. So that's a little less than 1
msec per io_submit. Still pretty big. You can experiment with oprofile
to profile where the kernel spends its time in that period.

-- 
Jens Axboe

