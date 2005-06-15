Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261451AbVFOApx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261451AbVFOApx (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Jun 2005 20:45:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261453AbVFOApx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Jun 2005 20:45:53 -0400
Received: from e1.ny.us.ibm.com ([32.97.182.141]:47552 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S261451AbVFOApl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Jun 2005 20:45:41 -0400
Subject: Re: Tuning ext3 for large disk arrays
From: Badari Pulavarty <pbadari@us.ibm.com>
To: Peter Chubb <peterc@gelato.unsw.edu.au>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andreas Hirstius <Andreas.Hirstius@cern.ch>
In-Reply-To: <17071.25351.996975.416810@wombat.chubb.wattle.id.au>
References: <17071.25351.996975.416810@wombat.chubb.wattle.id.au>
Content-Type: text/plain
Organization: 
Message-Id: <1118794936.4301.363.camel@dyn9047017072.beaverton.ibm.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 14 Jun 2005 17:22:16 -0700
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

What kernel are you running ?  Does the kernel has ext3 "reservation"
support enabled ? Do you see performance problem with "read" tests also
? And also, does the write test writes to multiple files in the same
directory ? Or multiple threads writing to same file ?

Thanks,
Badari

On Tue, 2005-06-14 at 16:06, Peter Chubb wrote:
> Hi folks,
>    We've been doing a few scalability measurements on disk arrays.  We
> know how to tune xfs to give reasonable performance.  But I'm not sure
> how to tune ext3, and the default parameters give poor performance.
> 
> See http://scalability.gelato.org/DiskScalability/Results for the
> graphs.
> 
> iozone for 24 10k SATA disks spread across 3 3ware controllers gives a
> peak read throughput on XFS of around 1050M/sec; but ext3 conks out
> at around half that.  The maximum single threaded read performance we
> got was 450M/sec, and it's pretty constant from 12 through 24
> spindles.  We see no difference between setting -E stride=XX and
> leaving this parameter off.
> 
> The system uses 64k pages; we can set XFS up with 64k blocks; it may
> be that part of the problem is that ext3 can't use larger blocks.  We
> repeated the XFs measurements configuring the kernel and filesystem to
> use 4k pages/blocks, and although the throughput is lower than with
> the 64k page size, it's still significantly better than with ext3.
> Moreover, configuring XFS with 4k blocks, but using 64k pages gives
> results (not shown on the Wiki page) almost the same as the 64k
> pages/64k blocks.
> 
> Before going on and starting to look for bottlenecks, I'd like to be
> sure that ext3 is tuned appropriately.  mke2fs doesn't seem to have
> many appropriate tweaks, however...???
> 
> --
> Dr Peter Chubb  http://www.gelato.unsw.edu.au  peterc AT gelato.unsw.edu.au
> The technical we do immediately,  the political takes *forever*
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 
> 

