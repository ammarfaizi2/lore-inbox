Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267149AbTAPS0A>; Thu, 16 Jan 2003 13:26:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267151AbTAPS0A>; Thu, 16 Jan 2003 13:26:00 -0500
Received: from e33.co.us.ibm.com ([32.97.110.131]:16379 "EHLO
	e33.co.us.ibm.com") by vger.kernel.org with ESMTP
	id <S267149AbTAPSZ7>; Thu, 16 Jan 2003 13:25:59 -0500
Date: Thu, 16 Jan 2003 10:27:23 -0800
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: Linus Torvalds <torvalds@transmeta.com>
cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: [PATCH] (0/3) NUMA aware scheduler
Message-ID: <2050000.1042741643@flay>
X-Mailer: Mulberry/2.1.2 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Following is a sequence of patches to add NUMA awareness to the scheduler.
These have been submitted to you several times before, but in my opinion
were structured in such a way to make them too invasive to non-NUMA machines.
I propsed a new scheme of working in "concentric circles" which this set 
follows (Erich did most of the hard work of restructuring), and is now 
completely non-invasive to non-NUMA systems. It has no effect whatsoever 
on standard machines. This can be seen by code inspection, and has been 
checked by benchmarking.

These patches are the culmination of work by Erich Focht, Michael Hohnbaum
and myself. We've also incorporated feedback from Christoph and Robert Love.
I believe these are now ready for mainline acceptance. I've tested them on
NUMA-Q, standard SMP and UP. Erich has run them on the NEC ia64 NUMA machine.

Benchmarks on a 16-way NUMA-Q machine w/ 16Gb of RAM

Kernbench: (average of 5 kernel compiles)
                                   Elapsed        User      System         CPU
                        2.5.58     20.012s     191.81s      48.37s     1200.6%
              2.5.58-numasched      19.57s    187.264s     42.186s     1171.8%

NUMA schedbench 64: (64 processes running memory allocation fairly heavily)
                                               Elapsed   TotalUser    TotalSys
                        2.5.48                  608.81     9418.37       26.74
              2.5.58-numasched                  230.49     3613.47       15.57

