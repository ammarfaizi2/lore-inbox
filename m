Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263033AbTH0B3U (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Aug 2003 21:29:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263041AbTH0B3U
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Aug 2003 21:29:20 -0400
Received: from adsl-63-194-239-202.dsl.lsan03.pacbell.net ([63.194.239.202]:55052
	"EHLO mmp-linux.matchmail.com") by vger.kernel.org with ESMTP
	id S263033AbTH0B3R (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Aug 2003 21:29:17 -0400
Date: Tue, 26 Aug 2003 18:29:14 -0700
From: Mike Fedyk <mfedyk@matchmail.com>
To: Andrew Morton <akpm@osdl.org>
Cc: Peter Chubb <peterc@gelato.unsw.edu.au>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 2.6.0-test4 -- add context switch counters
Message-ID: <20030827012914.GB5280@matchmail.com>
Mail-Followup-To: Andrew Morton <akpm@osdl.org>,
	Peter Chubb <peterc@gelato.unsw.edu.au>,
	linux-kernel@vger.kernel.org
References: <16204.520.61149.961640@wombat.disy.cse.unsw.edu.au> <20030826181807.1edb8c48.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030826181807.1edb8c48.akpm@osdl.org>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 26, 2003 at 06:18:07PM -0700, Andrew Morton wrote:
> Peter Chubb <peterc@gelato.unsw.edu.au> wrote:
> >
> > Currently, the context switch counters reported by getrusage() are
> >  always zero.  The appended patch adds fields to struct task_struct to
> >  count context switches, and adds code to do the counting.
> >
> >  The patch adds 4 longs to struct task struct, and a single addition to
> >  the fast path in schedule().
> 
> OK...  Why is this useful?  A bit of googling doesn't show much interest in
> it.
> 
> What apps should be reporting this info?  /usr/bin/time?

E: Could not open lock file /var/lib/apt/lists/lock - open (13 Permission denied)
E: Unable to lock the list directory
Command exited with non-zero status 100
	Command being timed: "apt-get update"
	User time (seconds): 0.01
	System time (seconds): 0.00
	Percent of CPU this job got: 6%
	Elapsed (wall clock) time (h:mm:ss or m:ss): 0:00.32

	Average shared text size (kbytes): 0
	Average unshared data size (kbytes): 0
	Average stack size (kbytes): 0
	Average total size (kbytes): 0

The averages might be nice...

	Maximum resident set size (kbytes): 0
	
But the maximum would allow any polling app to do its polling less often.
As well as the averages above...
	
	Average resident set size (kbytes): 0
	Major (requiring I/O) page faults: 320
	Minor (reclaiming a frame) page faults: 21
	Voluntary context switches: 0

How can you have voluntary context switches in a preemptive environment?

	Involuntary context switches: 0

	Swaps: 0
	
Counting swaps would be nice too.	
	
	File system inputs: 0
	File system outputs: 0
	Socket messages sent: 0
	Socket messages received: 0
	Signals delivered: 0

Yes, yes, yes.

     	Page size (bytes): 4096
	Exit status: 100


One more thing:
$ cat /proc/meminfo 
MemTotal:       320628 kB
MemFree:          5148 kB
Buffers:          8316 kB

Where'd shared go, and why didn't rmap start populating this value?  It
should be there in the pte-chain lists...

Cached:         127140 kB
SwapCached:          0 kB
Active:         266212 kB
Inactive:        10608 kB
HighTotal:           0 kB
HighFree:            0 kB

Why is high(total|free) there in a non-highmem kernel?  If this file were
more dynamic, then we wouldn't have apps that counted on the line number
instead of the first colum's value...

Ok, so that was two more... ;)

