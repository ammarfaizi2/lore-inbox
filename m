Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932473AbWEaGM0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932473AbWEaGM0 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 31 May 2006 02:12:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932482AbWEaGM0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 31 May 2006 02:12:26 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:42606 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S932473AbWEaGMZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 31 May 2006 02:12:25 -0400
Date: Wed, 31 May 2006 08:11:10 +0200
From: Jens Axboe <axboe@suse.de>
To: Mark Lord <lkml@rtr.ca>
Cc: Linus Torvalds <torvalds@osdl.org>, Nick Piggin <nickpiggin@yahoo.com.au>,
       linux-kernel@vger.kernel.org, linux-mm@kvack.org, mason@suse.com,
       andrea@suse.de, hugh@veritas.com
Subject: Re: [rfc][patch] remove racy sync_page?
Message-ID: <20060531061110.GB29535@suse.de>
References: <447B8CE6.5000208@yahoo.com.au> <20060529183201.0e8173bc.akpm@osdl.org> <447BB3FD.1070707@yahoo.com.au> <Pine.LNX.4.64.0605292117310.5623@g5.osdl.org> <447BD31E.7000503@yahoo.com.au> <447BD63D.2080900@yahoo.com.au> <Pine.LNX.4.64.0605301041200.5623@g5.osdl.org> <447CE43A.6030700@yahoo.com.au> <Pine.LNX.4.64.0605301739030.24646@g5.osdl.org> <447CF252.7010704@rtr.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <447CF252.7010704@rtr.ca>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 30 2006, Mark Lord wrote:
> Linus wrote:
> >(Yes, tagged queueing makes it less of an issue, of course. I know,
> 
> My observations with (S)ATA tagged/native queuing, is that it doesn't make
> nearly the difference under Linux that it does under other OSs.
> Probably because our block layer is so good at ordering requests,
> either from plugging or simply from clever disk scheduling.

Hmm well, I have seen 30% performance increase for a random read work
load with NCQ, I'd say that is pretty nice. And of course there's the
whole write cache issue, with NCQ you _could_ get away with playing more
safe and disabling write back caching.

NCQ helps us with something we can never fix in software - the
rotational latency. Ordering is only a small part of the picture.

Plus I think that more recent drives have a better NCQ implementation,
the first models I tried were pure and utter crap. Lets just say it
didn't instill a lot of confidence in firmware engineers at various
unnamed drive companies.

-- 
Jens Axboe

