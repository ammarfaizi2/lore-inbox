Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265898AbUGTOSo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265898AbUGTOSo (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Jul 2004 10:18:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265900AbUGTOSo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Jul 2004 10:18:44 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:8892 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S265898AbUGTOSl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Jul 2004 10:18:41 -0400
Date: Tue, 20 Jul 2004 10:19:05 -0200
From: Jens Axboe <axboe@suse.de>
To: Ingo Molnar <mingo@elte.hu>
Cc: Lee Revell <rlrevell@joe-job.com>, Andrew Morton <akpm@osdl.org>,
       linux-audio-dev@music.columbia.edu, arjanv@redhat.com,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [linux-audio-dev] Re: [announce] [patch] Voluntary Kernel Preemption Patch
Message-ID: <20040720121905.GG1651@suse.de>
References: <1089673014.10777.42.camel@mindpipe> <20040712163141.31ef1ad6.akpm@osdl.org> <1089677823.10777.64.camel@mindpipe> <20040712174639.38c7cf48.akpm@osdl.org> <1089687168.10777.126.camel@mindpipe> <20040712205917.47d1d58b.akpm@osdl.org> <1089705440.20381.14.camel@mindpipe> <20040719104837.GA9459@elte.hu> <1090301906.22521.16.camel@mindpipe> <20040720061227.GC27118@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040720061227.GC27118@elte.hu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 20 2004, Ingo Molnar wrote:
> > How much I/O do you allow to be in flight at once?  It seems like by
> > decreasing the maximum size of I/O that you handle in one interrupt
> > you could improve this quite a bit.  Disk throughput is good enough,
> > anyone in the real world who would feel a 10% hit would just throw
> > hardware at the problem.
> 
> i'm not sure whether this particular value (max # of sg-entries per IO
> op) is runtime tunable. Jens? Might make sense to enable elvtune-alike
> tunability of this value.

elvtune is long dead :-)

it's not tweakable right now, but if you wish to experiment you just
need to add a line to ide-disk.c:idedisk_setup() - pseudo patch:

+	blk_queue_max_sectors(drive->queue, 32);
+
	printk("%s: max request size: %dKiB\n", drive->name, drive->queue->max_sectors / 2);

	/* Extract geometry if we did not already have one for the drive */

above will limit max request to 16kb, experiment as you see fit.

-- 
Jens Axboe

