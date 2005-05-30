Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261506AbVE3MPn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261506AbVE3MPn (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 May 2005 08:15:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261507AbVE3MPn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 May 2005 08:15:43 -0400
Received: from brick.kernel.dk ([62.242.22.158]:60390 "EHLO
	nelson.home.kernel.dk") by vger.kernel.org with ESMTP
	id S261506AbVE3MPd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 May 2005 08:15:33 -0400
Date: Mon, 30 May 2005 14:16:35 +0200
From: Jens Axboe <axboe@suse.de>
To: Greg Stark <gsstark@mit.edu>
Cc: "Eric D. Mudama" <edmudama@gmail.com>,
       Matthias Andree <matthias.andree@gmx.de>, linux-kernel@vger.kernel.org,
       jgarzik@pobox.com
Subject: Re: [PATCH] SATA NCQ support
Message-ID: <20050530121635.GQ7054@suse.de>
References: <20050527070353.GL1435@suse.de> <20050527131842.GC19161@merlin.emma.line.org> <20050527135258.GW1435@suse.de> <429732CE.5010708@gmx.de> <20050527145821.GX1435@suse.de> <87oeatxtw4.fsf@stark.xeocode.com> <311601c905052921046692cd3e@mail.gmail.com> <87d5r9xmgr.fsf@stark.xeocode.com> <20050530063322.GE7054@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050530063322.GE7054@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 30 2005, Jens Axboe wrote:
> > People actually tend to report that IDE drives are *faster*. Until
> > they're told they have to disable write-caching on their IDE drives to
> > get a fair comparison, then the performance is absolutely abysmal. The
> > interesting thing is that SCSI drives don't seem to take much of a
> > performance hit from having write-caching disabled while IDE drives
> > do.
> 
> NCQ will surely lessen the impact of disabling write caching, how much
> still remains to be seen. You could test, if you have the hardware :)
> Real life testing is more interesting than benchmarks.

With a few simple tests, I'm unable to show any write performance
improvement with write back caching off and NCQ (NCQ with queueing depth
of 1 and 16 tested). I get a steady 0.55-0.57MiB/sec with 8 threads
random writes, a little over 5MiB/sec with sequential writes.

Reads are _much_ nicer. Sequential read with 8 threads are 23% faster
with a queueing depth of 16 than 1, random reads are 85% (!!) faster at
depth 16 than 1.

Testing was done with the noop io scheduler this time, to only show NCQ
benefits outside of what the io scheduler can do for reordering.

This is with a Maxtor 7B300S0 drive. I would have posted results for a
Seagate ST3120827AS as well, but that drive happily ignores any attempt
to turn off write back caching. To top things off, it even accepts FUA
writes but ignores that as well (they still go to cache).

-- 
Jens Axboe

