Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262452AbTAaVor>; Fri, 31 Jan 2003 16:44:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262469AbTAaVoq>; Fri, 31 Jan 2003 16:44:46 -0500
Received: from ns0.cobite.com ([208.222.80.10]:27655 "EHLO ns0.cobite.com")
	by vger.kernel.org with ESMTP id <S262452AbTAaVop>;
	Fri, 31 Jan 2003 16:44:45 -0500
Date: Fri, 31 Jan 2003 16:54:10 -0500 (EST)
From: David Mansfield <lkml@dm.cobite.com>
X-X-Sender: david@admin
To: Andrew Morton <akpm@digeo.com>, <linux-kernel@vger.kernel.org>
Subject: 2.5.59-mm7 results with database 'benchmark'
Message-ID: <Pine.LNX.4.44.0301311641050.17695-100000@admin>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Andrew et al.

I have run my 'production database load' against the 2.5.59-mm7 kernel.  
Fortunately for me, but unfortunately for you, I have upgraded the system 
CPUs.  They were 2 x PIII 866Mhz, 256kb cache, now 2 x PIII 1Ghz, 256kb 
cache.  I reran the 2.4.18-19.7.xsmp test as a baseline for comparison.  I 
include all results to date here.  System and workload descriptions 
follow. 

The (slight) advantage that the 2.5.59 series had over the RedHat
kernels has evaporated.  But it was marginal to begin with.

As usual, I'm willing to test...

Results:

kernel                        minutes
----------------------------- -----------
old cpus, 2x866mhz:
2.4.20-aa1                    134
2.5.59                        124
2.4.18-19.7.xsmp              128
2.5.59-mm5                    157
2.5.59-mm5-no-anticipatory-io 125
2.5.59-mm6                    125

new cpus, 2x1ghz:
2.4.18-19.7.xsmp              118  <---       new run
2.5.59-mm7                    118  <---       new run


Platform and configuration:
HP LH3000 U3.  Dual 1Ghz Intel Pentium III, 2GB ram.  megaraid controller
with two channels, each channel raid 5 (hardware raid) PV on 6 15k scsi
disks, one megaraid LV per PV.

Two plain disks w/pairs of partitions in raid 1 for OS (redhat 7.3), a
second pair of partitions (regular partitions with ext2) for Oracle 
redo-log (in a log 'group').

Oracle version 8.1.7.4 (no aio support in this release) is accessing
datafiles on the two megaraid devices via /dev/raw stacked on top of
device-mapper (lvm2).

Workload:
The workload consists of a few different phases.

1) Indexing: multiple indexes built against a 9 million row table.  This
is mostly about sequential scans of a single table, with bursts of write
activity.  50 minutes or so.

2) Analyzing: The database scans tables and
builds statistics.  Most of the time is spent analyzing the 9 million row
table.  This is a completely cpu bound step on our underpowered system.
30 minutes.

3) Summarization: the large table is aggregated in about 100
different ways.  Records are generated for each different summarization.
This is mixed read-write load.  50 minutes or so.

-- 
/==============================\
| David Mansfield              |
| lkml@dm.cobite.com           |
\==============================/


