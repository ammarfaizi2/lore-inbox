Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270425AbTGZQjK (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 26 Jul 2003 12:39:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270468AbTGZQjJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 26 Jul 2003 12:39:09 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:51358 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S270425AbTGZQi6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 26 Jul 2003 12:38:58 -0400
Date: Sat, 26 Jul 2003 18:40:58 +0200
From: Jens Axboe <axboe@suse.de>
To: Lou Langholtz <ldl@aros.net>
Cc: Con Kolivas <kernel@kolivas.org>,
       Marc-Christian Petersen <m.c.p@wolk-project.de>,
       Felipe Alfaro Solana <felipe_alfaro@linuxmail.org>,
       LKML <linux-kernel@vger.kernel.org>, mingo@elte.hu
Subject: Re: Ingo Molnar and Con Kolivas 2.6 scheduler patches
Message-ID: <20030726164058.GD518@suse.de>
References: <1059211833.576.13.camel@teapot.felipe-alfaro.com> <200307261142.43277.m.c.p@wolk-project.de> <200307270047.54349.kernel@kolivas.org> <3F22AF7E.1080601@aros.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3F22AF7E.1080601@aros.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 26 2003, Lou Langholtz wrote:
> Con Kolivas wrote:
> 
> >. . .
> >Actually this is not strange to me. It has become obvious that the 
> >problems with interactivity that have evolved in 2.5 are not scheduler 
> >related. Just try plugging in all the old 2.4 O(1) scheduler settings into 
> >the current scheduler and you will see that it still performs badly. What 
> >exactly is the cause is a mystery but seems to be more a combination of 
> >factors with a careful look at the way the vm behaves being part of that. 
> >. . .
> >
> Any chance that the problem may be due to the block layer system (and 
> block driver(s)) getting more cycles than it should? Particularly with 

Not likely

> the out-of-band like work queue scheduling? That would at least explain 

If anything, 2.6 will unplug sooner than 2.4. 2.4 will unplug only when
someone does a wait_on_buffer/page, 2.6 will unplug when:

- queued requests exceed unplug threshold, 4 requests
- unplug timeout, 3ms
- someone doing wait_on_page/buffer

Can't rule out a bug of course, the horrible audio skips I've seen in
2.6 are not io related though. Block layer will only do out of band
unplugs for the timer unplug, and even that could be superceded by a new
request entering the queue (or someone doing wait_bla)

> the scheduling oddities I'm seeing with 2.6.0-test1 after a minute of so 
> of intense I/O.

CPU or disk scheduling oddities?

People should try booting with elevator=deadline to see if it changes
anything for these types of workloads, AS is really not optimal for that
at all.

-- 
Jens Axboe

