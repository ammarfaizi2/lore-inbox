Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313507AbSDLK2r>; Fri, 12 Apr 2002 06:28:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313508AbSDLK2q>; Fri, 12 Apr 2002 06:28:46 -0400
Received: from ds217-115-141-141.dedicated.hosteurope.de ([217.115.141.141]:52494
	"HELO ds217-115-141-141.dedicated.hosteurope.de") by vger.kernel.org
	with SMTP id <S313507AbSDLK2q>; Fri, 12 Apr 2002 06:28:46 -0400
Date: Fri, 12 Apr 2002 12:28:45 +0200
From: Jochen Suckfuell <jo-lkml@suckfuell.net>
To: Zlatko Calusic <zlatko.calusic@iskon.hr>
Cc: Christoph Hellwig <hch@infradead.org>,
        "Stephen C. Tweedie" <sct@redhat.com>, Jens Axboe <axboe@suse.de>,
        linux-kernel@vger.kernel.org
Subject: Re: sard/iostat disk I/O statistics/accounting for 2.5.8-pre3
Message-ID: <20020412122845.B27560@ds217-115-141-141.dedicated.hosteurope.de>
In-Reply-To: <dnu1qia3zg.fsf@magla.zg.iskon.hr> <20020411150219.A10486@infradead.org> <878z7u6tjd.fsf@atlas.iskon.hr> <20020411210916.GO23513@matchmail.com> <dnwuvd6djx.fsf@magla.zg.iskon.hr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Fri, Apr 12, 2002 at 01:06:10AM +0200, Zlatko Calusic wrote:
> > major minor  #blocks  name     rio rmerge rsect ruse wio wmerge wsect wuse running use aveq
> >    3     0   10037774 ide/host0/bus0/target0/lun0/disc 2381496 3602026 12295120 24796300 2167401 11887863 28592436 168474630 -1 849341880 -666064880
> >
> Also, it _seems_ that only on whole devices ios_in_flight variable
> (column "running" in /proc/partitions) drops to -1. Your (and mine)
> output shows it clearly, yes. This needs further investigation, I have
> been unable to find the problem so far.

I have seen ios_in_flight as low as -4 already.

> And, as aveq value is calculated directly from the ios_in_flight
> value, the average queue value is wrong too (it never goes negative,
> if everything is all right).
The use (one of the most important values here) is also completely wrong
when ios_in_flight is too low: Whenever ios_in_flight!=0, the disk is
accounted as running.

I have patched gen_partition_disk() to correct the ios_in_flight value
as a workaround. This is better than checking it each time ios_in_flight
is decremented, because it only happens when someone reads
/proc/partitions, and so it doesn't slow down the disk access.

But I'm still trying to reproduce the cause of the problem.

Bye
Jochen

-- 
Jochen Suckfuell
