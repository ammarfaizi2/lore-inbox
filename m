Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264539AbTFALsw (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 1 Jun 2003 07:48:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264543AbTFALsw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 1 Jun 2003 07:48:52 -0400
Received: from hermine.idb.hist.no ([158.38.50.15]:50180 "HELO
	hermine.idb.hist.no") by vger.kernel.org with SMTP id S264539AbTFALsv
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 1 Jun 2003 07:48:51 -0400
Date: Sun, 1 Jun 2003 14:06:10 +0200
To: Andrew Morton <akpm@digeo.com>, neilb@cse.unsw.edu.au
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: 2.5.66-mm3 and raid still oopses, but later than mm1/mm2
Message-ID: <20030601120610.GA6249@hh.idb.hist.no>
References: <20030403005817.69a29d7b.akpm@digeo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030403005817.69a29d7b.akpm@digeo.com>
User-Agent: Mutt/1.5.4i
From: Helge Hafting <helgehaf@aitel.hist.no>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

2.5.70-mm3 with raid1 has improved to some extent,
the RAID crash now happens somewhat later.

I got a lot of kernel errors during RAID initialization,
with normal boot messages inbetween.  Nothing made it to
the logs.  I eventually got this:

Kernel BUG at mm/slab.c:1682
invalid operand 0000 [#1]
PREEMPTSMP
CPU:0
EIP at free_block+0x276/0x350
process fsck

Call trace:
drain_array
reap_timer_fnc
reap_timer_fnc
run_timer_softirq
do_softirq
smp_apic_timer
apic_timer_interrupt

<0> KErnel panic exception in interrupt
in interrupt - not syncing
reboot in 300 seconds

This is 2.5.70-mm3, with a patch that makes
matroxfb work so I could see the entire oops.

This is a dual celeron, with 2 scsi disks.
Root & /home is on raid-1, there is also a raid-0,
all disk-based filesystems are ext2.

Helge Hafting
