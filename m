Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129401AbRAXQpi>; Wed, 24 Jan 2001 11:45:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129561AbRAXQp1>; Wed, 24 Jan 2001 11:45:27 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:44294 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S129401AbRAXQpX>;
	Wed, 24 Jan 2001 11:45:23 -0500
Date: Wed, 24 Jan 2001 17:44:39 +0100
From: Jens Axboe <axboe@suse.de>
To: Steven Cole <scole@lanl.gov>
Cc: Marcelo Tosatti <marcelo@conectiva.com.br>,
        lkml <linux-kernel@vger.kernel.org>
Subject: Re: 2.4.1pre8 slowdown on dbench tests
Message-ID: <20010124174439.W16110@suse.de>
In-Reply-To: <01012208583400.01639@spc.esa.lanl.gov> <01012313294400.01045@spc.esa.lanl.gov> <20010123215419.A7435@suse.de> <01012409085700.02477@spc.esa.lanl.gov>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <01012409085700.02477@spc.esa.lanl.gov>; from scole@lanl.gov on Wed, Jan 24, 2001 at 09:08:57AM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 24 2001, Steven Cole wrote:
> > Thanks! Could I talk you into doing one last run? pre8 with
> > include/linux/elevator.h having these values set for
> > ELEVATOR_LINUS:
> >
> Here are two sets of dbench 48 runs with that mod. I can't explain why the
> second set is faster.  The second set was performed with no reboot after the 
> first set.  The individual runs were performed with no wait in-between.

Was this the 2.4.1-pre8x tree? Regardless, it's about back to the
same dbench performance that we saw earlier with the more unfair
setup. The blk-xx changes in recent 2.4.1-pre were not meant (and
never claimed :-) to boost dbench performance. That's actually
quite easy to do: let one thread completely finish I/O, _then_
move on to the next one. This isn't what we want in Real Life.

The fact that dbench performance remains pretty good from stock
kernel against the changes I told you to do is excellent and
mainly due to the batch freeing changes.

In most real life situations, throughput on account of no care for
latency is not ideal. Even though dbench performance drops a bit,
you will see better distribution of the bandwidth between the
threads. Think file serving.

-- 
* Jens Axboe <axboe@suse.de>
* SuSE Labs
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
