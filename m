Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261368AbTAXWZn>; Fri, 24 Jan 2003 17:25:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264644AbTAXWZn>; Fri, 24 Jan 2003 17:25:43 -0500
Received: from ns0.cobite.com ([208.222.80.10]:43023 "EHLO ns0.cobite.com")
	by vger.kernel.org with ESMTP id <S261368AbTAXWZl>;
	Fri, 24 Jan 2003 17:25:41 -0500
Date: Fri, 24 Jan 2003 17:34:13 -0500 (EST)
From: David Mansfield <david@cobite.com>
X-X-Sender: david@admin
To: Nick Piggin <piggin@cyberone.com.au>
cc: David Mansfield <lkml@dm.cobite.com>, Andrew Morton <akpm@digeo.com>,
       <linux-kernel@vger.kernel.org>
Subject: 2.5.59mm5 database 'benchmark' results
In-Reply-To: <3E3188EB.4050807@cyberone.com.au>
Message-ID: <Pine.LNX.4.44.0301241718440.32240-100000@admin>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Nick, Andrew, lists,

I've been testing some recent kernels to see how they compare with a 
particular database workload.  The workload is actually part of our 
production process (last months run) but on a test server.  I'll describe 
the platform and the workload, but first, the results :-)

kernel           minutes     comment
-------------    ----------- ---------------------------------
2.4.20-aa1       134         i consider this 'baseline'
2.5.59           124         woo-hoo
2.4.18-19.7.xsmp 128         not bad for frankenstein's montster
2.5.59-mm5       157         uh-oh

Platform:
HP LH3000 U3.  Dual 866 Mhz Intel Pentium III, 2GB ram.  megaraid 
controller with two channels, each channel raid 5 PV on 6 15k scsi disks, 
one megaraid LV per PV.

Two plain disks w/pairs of partitions in raid 1 for OS (redhat 7.3), a 
second pair for Oracle redo-log (in a log 'group').

Oracle version 8.1.7 (no aio support in this release) is accessing
datafiles on the two megaraid devices via /dev/raw stacked on top of
device-mapper 

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

I'll test any kernel you throw my way.

David



-- 
/==============================\
| David Mansfield              |
| david@cobite.com             |
\==============================/

