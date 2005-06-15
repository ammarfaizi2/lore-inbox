Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261462AbVFOBSF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261462AbVFOBSF (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Jun 2005 21:18:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261467AbVFOBSF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Jun 2005 21:18:05 -0400
Received: from e34.co.us.ibm.com ([32.97.110.132]:6346 "EHLO e34.co.us.ibm.com")
	by vger.kernel.org with ESMTP id S261462AbVFOBQ2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Jun 2005 21:16:28 -0400
Subject: Re: Tuning ext3 for large disk arrays
From: Badari Pulavarty <pbadari@us.ibm.com>
To: Peter Chubb <peterc@gelato.unsw.edu.au>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andreas Hirstius <Andreas.Hirstius@cern.ch>
In-Reply-To: <17071.25351.996975.416810@wombat.chubb.wattle.id.au>
References: <17071.25351.996975.416810@wombat.chubb.wattle.id.au>
Content-Type: text/plain
Organization: 
Message-Id: <1118796785.4301.368.camel@dyn9047017072.beaverton.ibm.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 14 Jun 2005 17:53:05 -0700
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

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

Ted mentioned that you can force ext3 mkfs to use "64k" as blocksize
through "-b 65536" option.

And also, while using 64K blocksize - can you compare performance with
other mount options like: "writeback" and  "nobh,writeback" ? 
I am curious.

Thanks,
Badari



