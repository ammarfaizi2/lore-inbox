Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751243AbWAVBaR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751243AbWAVBaR (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 21 Jan 2006 20:30:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751245AbWAVBaR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 21 Jan 2006 20:30:17 -0500
Received: from sp-260-1.net4.netcentrix.net ([4.21.254.118]:5135 "EHLO
	asmodeus.mcnaught.org") by vger.kernel.org with ESMTP
	id S1751243AbWAVBaP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 21 Jan 2006 20:30:15 -0500
To: Lee Revell <rlrevell@joe-job.com>
Cc: gene.heskett@verizon.net, linux-kernel@vger.kernel.org
Subject: Re: [2.6 patch] the scheduled removal of the obsolete raw driver
References: <20060119030251.GG19398@stusta.de>
	<200601211853.56339.gene.heskett@verizon.net>
	<87bqy5m8u3.fsf@asmodeus.mcnaught.org>
	<200601211909.15559.gene.heskett@verizon.net>
	<1137888945.11722.5.camel@mindpipe>
From: Doug McNaught <doug@mcnaught.org>
Date: Sat, 21 Jan 2006 20:30:13 -0500
In-Reply-To: <1137888945.11722.5.camel@mindpipe> (Lee Revell's message of
 "Sat, 21 Jan 2006 19:15:45 -0500")
Message-ID: <877j8tm4m2.fsf@asmodeus.mcnaught.org>
User-Agent: Gnus/5.1006 (Gnus v5.10.6) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Lee Revell <rlrevell@joe-job.com> writes:

> On Sat, 2006-01-21 at 19:09 -0500, Gene Heskett wrote:

>> Good, but what about speed, is that impacted in any way they can 
>> measure, or is this flag/method actually faster than the raw driver is?
>
> A loss of speed is a loss of functionality, and would not be accepted.

Actually it's only partly about speed--they want to implement not only
their own filesystem but their own memory caching strategy, and don't
want the same data in their cache and the Linux page cache (which
would waste memory and possibly cause aliasing problems).  Both the
raw driver and O_DIRECT allow direct writes to disk without going
through the page cache; there is no significant performance difference
(since performance is dominated by the time required to write a page
to disk).  O_DIRECT is just a much cleaner way to do it, and is
also supported on other systems like Solaris IIRC.

-Doug
