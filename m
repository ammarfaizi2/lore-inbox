Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288787AbSBMThH>; Wed, 13 Feb 2002 14:37:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288800AbSBMTg5>; Wed, 13 Feb 2002 14:36:57 -0500
Received: from air-2.osdl.org ([65.201.151.6]:30981 "EHLO osdlab.pdx.osdl.net")
	by vger.kernel.org with ESMTP id <S288787AbSBMTgi>;
	Wed, 13 Feb 2002 14:36:38 -0500
Date: Wed, 13 Feb 2002 11:32:21 -0800 (PST)
From: "Randy.Dunlap" <rddunlap@osdl.org>
X-X-Sender: <rddunlap@dragon.pdx.osdl.net>
To: <linux-kernel@vger.kernel.org>
cc: <mingo@elte.hu>, <axboe@suse.de>
Subject: scheduler changes ??
Message-ID: <Pine.LNX.4.33L2.0202131130040.1530-100000@dragon.pdx.osdl.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This is something that I noticed (and Jens noticed :) while I was
working on adding some bounce IO stats to BIO.

Is this purely/mostly scheduler related?
Are these improvements well-known, expected?
I have't heard much, if anything, about them.
They are terrific (in a good sense of the word).


All workloads were run on a VA Linux 4400, 4-proc x86, with 4 GB RAM.
All times are in minutes:seconds.

The workloads are "fillmem" and "mmap002", both from Juan
Quintela's memtest suite.


"fillmem" workload (3 runs with each kernel):
(6 instances of 'fillmem 700')

> 2.4.16 vanilla:          3:02, 2:48, 3:08
> 2.4.16 + block-highmem:  2:51, 2:54, 2:55

> 2.5.2-pre11:             0:30, 0:30, 0:53


And when I use "mmap002" (2 runs with each kernel/options):
(5 instances of 'mmap002 500')

2.4.16 + block-highmem + default idle loop:   3:49, 1:56
2.4.16 + block-highmem + idle=poll:           1:59, 1:59

2.5.2 + default idle loop:                    1:32, 1:37
2.5.2 + idle=poll:                            1:31, 1:37


Kernel profiles on these show that most time is being spent in
default_idle() or poll_idle().

Comments?

Thanks,
  ~Randy

