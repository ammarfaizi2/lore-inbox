Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750716AbWC2Nw6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750716AbWC2Nw6 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Mar 2006 08:52:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750734AbWC2Nw6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Mar 2006 08:52:58 -0500
Received: from rtr.ca ([64.26.128.89]:50650 "EHLO mail.rtr.ca")
	by vger.kernel.org with ESMTP id S1750716AbWC2Nw5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Mar 2006 08:52:57 -0500
Message-ID: <442A9131.9030500@rtr.ca>
Date: Wed, 29 Mar 2006 08:52:49 -0500
From: Mark Lord <lkml@rtr.ca>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8) Gecko/20060305 SeaMonkey/1.1a
MIME-Version: 1.0
To: Al Viro <viro@ftp.linux.org.uk>
Cc: Jens Axboe <axboe@suse.de>, Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.16-git4: kernel BUG at block/ll_rw_blk.c:3497
References: <44288882.4020809@rtr.ca> <20060329081642.GU8186@suse.de> <20060329082747.GV27946@ftp.linux.org.uk>
In-Reply-To: <20060329082747.GV27946@ftp.linux.org.uk>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Al Viro wrote:
> On Wed, Mar 29, 2006 at 10:16:43AM +0200, Jens Axboe wrote:
>> triggering. What sort of testing were you running, exactly?

It's a dual 1GHz-P3 SMP test box, with three SATA drives.
Each drive has two partitions, and /dev/md0 was RAID5
over the first partitions of each drive (no spares),
and /dev/md1 was RAID over the second partitions (no spares).

Both /dev/md[01] were formatted as ext2, and mounted,
and several processes were running, copying directory trees
back and forth between the two RAIDs, while the MD layer 
was still doing resyncs underneath it all.

Basically, trying really hard to stress everything.

> I really wonder why it's the call from do_exit() that triggers it.
> The thing is, we get off-by-exactly-one here and all previous callers
> of that puppy would be elsewhere (cfq, mostly).
> 
> IOW, we get exactly one extra call of put_io_context() _and_ have it
> happen before do_exit() (i.e. from normal IO paths).  Interesting...
> 
> Is there any way to reproduce it without too much PITA?

It's only happened the once, so far.  Tell me how you want the code
instrumented, and I'll do it, in case I manage to get it to happen again.

Cheers
