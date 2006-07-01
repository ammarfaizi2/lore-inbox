Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750747AbWGAQ3b@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750747AbWGAQ3b (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 1 Jul 2006 12:29:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750793AbWGAQ3b
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 1 Jul 2006 12:29:31 -0400
Received: from embla.aitel.hist.no ([158.38.50.22]:1163 "HELO
	embla.aitel.hist.no") by vger.kernel.org with SMTP id S1750747AbWGAQ3b
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 1 Jul 2006 12:29:31 -0400
Date: Sat, 1 Jul 2006 18:25:32 +0200
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, neilb@cse.unsw.edu.au, mingo@redhat.com
Subject: Re: 2.6.17-mm4 raid bugs & traces
Message-ID: <20060701162532.GA14933@aitel.hist.no>
References: <20060629013643.4b47e8bd.akpm@osdl.org> <20060701111153.GA10855@aitel.hist.no>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060701111153.GA10855@aitel.hist.no>
User-Agent: Mutt/1.5.11+cvs20060403
From: Helge Hafting <helgehaf@aitel.hist.no>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

More mm4 raid-1 troubles.

This time, the kernel panicked upon shutdown.  I was able
to write down the call trace:

process swapper

super_written
__end_that_request_first
blk_ordered_complete
scsi_end_request
scsi_io_completion
blk_done_softirq
__do_softirq
call_softirq

RIP:md_error
RSP:ffffffff80765e00
CR2:0000000000000048

<0> kernel panic - not syncing: Aiee, killing interrupt handler

Hw involved:
Three raid-1, two on plain scsi and one on SATA.
Each raid-1 consists of two partitions.  This time,
each md device was running in degraded mode.


Booting into 2.6.15 in order to re-add devices and sync the RAID,
I get only 2768K/sec reconstruction speed on SATA, still
1108 minutes (18 hours) to go. :-( 
Odd, as 2.6.17mm4 resynced this in 50min, but hit a
write error (real or imagined?) immediately afterwards.

The other older devices, on plain scsi, resynced much faster.
19381K/sec

More than a little irritating, I need the SATA raid-1 to be in sync
so lilo can install mm5 for me. 18 hours. 

Looks like 2.6.17mm4 doesn't like mirror devices?

Helge Hafting
