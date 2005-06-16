Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261158AbVFPHZr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261158AbVFPHZr (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Jun 2005 03:25:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261173AbVFPHZr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Jun 2005 03:25:47 -0400
Received: from smtp.osdl.org ([65.172.181.4]:1509 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261158AbVFPHZN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Jun 2005 03:25:13 -0400
Date: Thu, 16 Jun 2005 00:24:51 -0700
From: Andrew Morton <akpm@osdl.org>
To: Badari Pulavarty <pbadari@us.ibm.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: 2.6.12-rc6-mm1 & 2K lun testing
Message-Id: <20050616002451.01f7e9ed.akpm@osdl.org>
In-Reply-To: <1118856977.4301.406.camel@dyn9047017072.beaverton.ibm.com>
References: <1118856977.4301.406.camel@dyn9047017072.beaverton.ibm.com>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Badari Pulavarty <pbadari@us.ibm.com> wrote:
>
> I sniff tested 2K lun support with 2.6.12-rc6-mm1 on
>  my AMD64 box. I had to tweak qlogic driver and
>  scsi_scan.c to see all the luns.
> 
>  (2.6.12-rc6 doesn't see all the LUNS due to max_lun
>  issue - which is fixed in scsi-git tree).
> 
>  Test 1:
>  	run dds on all 2048 "raw" devices - worked
>  great. No issues.
> 
>  Tests 2: 
>  	run "dds" on 2048 filesystems (one file
>  per filesystem). Kind of works. I was expecting better
>  responsiveness & stability.
> 
> 
>  Overall - Good news is, it works. 
> 
>  Not so good news - with filesystem tests, machine becomes 
>  unresponsive, lots of page allocation failures but machine 
>  stays up and completes the tests and recovers.

Any chance of getting a peek at /proc/slabinfo?

Presumably increasing /proc/sys/vm/min_free_kbytes will help.

We seem to be always ooming when allocating scsi command structures. 
Perhaps the block-level request structures are being allocated with
__GFP_WAIT, but it's a bit odd.  Which I/O scheduler?  If cfq, does
reducing /sys/block/*/queue/nr_requests help?

