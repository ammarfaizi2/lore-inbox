Return-Path: <linux-kernel-owner+w=401wt.eu-S1755018AbXACITQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755018AbXACITQ (ORCPT <rfc822;w@1wt.eu>);
	Wed, 3 Jan 2007 03:19:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755019AbXACITQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Jan 2007 03:19:16 -0500
Received: from brick.kernel.dk ([62.242.22.158]:11465 "EHLO kernel.dk"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755015AbXACITQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Jan 2007 03:19:16 -0500
Date: Wed, 3 Jan 2007 09:22:03 +0100
From: Jens Axboe <jens.axboe@oracle.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, Nick Piggin <nickpiggin@yahoo.com.au>,
       Nick Piggin <npiggin@suse.de>
Subject: Re: [PATCH] 4/4 block: explicit plugging
Message-ID: <20070103082202.GG11203@kernel.dk>
References: <11678105083001-git-send-email-jens.axboe@oracle.com> <1167810508576-git-send-email-jens.axboe@oracle.com> <20070103000909.dc70594f.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20070103000909.dc70594f.akpm@osdl.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 03 2007, Andrew Morton wrote:
> On Wed,  3 Jan 2007 08:48:28 +0100
> Jens Axboe <jens.axboe@oracle.com> wrote:
> 
> > This is a patch to perform block device plugging explicitly in the submitting
> > process context rather than implicitly by the block device.
> 
> I don't think anyone will regret the passing of
> address_space_operations.sync_page().

Hardly :-)

> Do you have any benchmarks which got faster with these changes?

On the hardware I have immediately available, I see no regressions wrt
performance. With instrumentation it's simple to demonstrate that most
of the queueing activity of an io heavy benchmark spends less time in
the kernel (most merging activity takes place outside of the queue lock,
hence queueing is lock free).

I've asked Ken to run this series on some of his big iron, I hope he'll
have some results for us soonish. I can run some pseudo benchmarks on a
4-way here with some simulated storage to demonstrate the locking
improvements.

I don't see 3/4 and 4/4 on lkml yet, I wonder if they got lost.

-- 
Jens Axboe

