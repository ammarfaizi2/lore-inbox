Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261581AbTBJEXy>; Sun, 9 Feb 2003 23:23:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261593AbTBJEXy>; Sun, 9 Feb 2003 23:23:54 -0500
Received: from packet.digeo.com ([12.110.80.53]:47057 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S261581AbTBJEXx>;
	Sun, 9 Feb 2003 23:23:53 -0500
Date: Sun, 9 Feb 2003 20:33:43 -0800
From: Andrew Morton <akpm@digeo.com>
To: David Lang <david.lang@digitalinsight.com>
Cc: riel@conectiva.com.br, andrea@suse.de, ckolivas@yahoo.com.au,
       linux-kernel@vger.kernel.org, axboe@suse.de
Subject: Re: stochastic fair queueing in the elevator [Re: [BENCHMARK]
 2.4.20-ck3 / aa / rmap with contest]
Message-Id: <20030209203343.06608eb3.akpm@digeo.com>
In-Reply-To: <Pine.LNX.4.44.0302092018180.15944-100000@dlang.diginsite.com>
References: <Pine.LNX.4.50L.0302100211570.12742-100000@imladris.surriel.com>
	<Pine.LNX.4.44.0302092018180.15944-100000@dlang.diginsite.com>
X-Mailer: Sylpheed version 0.8.9 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 10 Feb 2003 04:33:31.0599 (UTC) FILETIME=[90C485F0:01C2D0BD]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Lang <david.lang@digitalinsight.com> wrote:
>
> note that issuing a fsync should change all pending writes to 'syncronous'
> as should writes to any partition mounted with the sync option, or writes
> to a directory with the S flag set.

We know, at I/O submission time, whether a write is to be waited upon. 
That's in writeback_control.sync_mode.

That, combined with an assumption that "all reads are synchronous" would
allow the outgoing BIOs to be appropriately tagged.

It's still approximate.  An exact solution would involve only marking I/O as
synchronous when some process actually waits on its completion.  I do not
believe that all the extra lookup and locking infrastructure and storage
which this would require is justified.  Certainly not in a first iteration.

The Rice Uni researchers did implement controls which attempted to learn IO
submission patterns on a per-process basis, and I believe these were also
used to avoid undesirable starvations.  We have only briefly played with
process-aware logic.

The first thing to do is to get the anticipatory scheduler working properly.
Nick has been tied down for a week chasing generic bugs in the request layer.
He seems to have nailed the important ones now.


