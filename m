Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262958AbTJUFkq (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Oct 2003 01:40:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262965AbTJUFkq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Oct 2003 01:40:46 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:9688 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S262958AbTJUFkp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Oct 2003 01:40:45 -0400
Date: Tue, 21 Oct 2003 07:40:44 +0200
From: Jens Axboe <axboe@suse.de>
To: Daniel Phillips <phillips@arcor.de>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] ide write barrier support
Message-ID: <20031021054044.GC1128@suse.de>
References: <20031013140858.GU1107@suse.de> <200310201910.48837.phillips@arcor.de> <20031020195632.GA1128@suse.de> <200310210146.35881.phillips@arcor.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200310210146.35881.phillips@arcor.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 21 2003, Daniel Phillips wrote:
> On Monday 20 October 2003 21:56, Jens Axboe wrote:
> > There IS a correctness issue, in
> > that drives ship with write back caching enabled. The fs assumes that
> > once wait_on_buffer() returns, the data is on disk. Which is false, can
> > remain false for quite a long number of seconds.
> 
> Maybe what you're saying is, there are only two ways to deal with IDE drives 
> with non-disablable writeback cache:
> 
>   1) flush the cache on every write
>   2) Implement write barriers, add them to all the journalling filesystems,
>      and flush only on the write barrier
> 
> and (1) is just too slow.  Correct?

Yes, that is exactly what I'm saying. It's not just that, though.
Completely disabling write back caching on IDE drives totally kills
performance typically, they are just not meant to be driven this way.

-- 
Jens Axboe

