Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129375AbRAXWF0>; Wed, 24 Jan 2001 17:05:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129383AbRAXWFQ>; Wed, 24 Jan 2001 17:05:16 -0500
Received: from sgi.SGI.COM ([192.48.153.1]:34672 "EHLO sgi.com")
	by vger.kernel.org with ESMTP id <S129375AbRAXWFO>;
	Wed, 24 Jan 2001 17:05:14 -0500
Message-Id: <200101242204.QAA09712@kenobi.americas.sgi.com>
To: linux-kernel@vger.kernel.org
From: kohnke@sgi.com (Marlys Kohnke)
Subject: [ANNOUNCE]: CSA job accounting for Linux 2.4.0
Date: Wed, 24 Jan 2001 16:04:52 -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


     Comprehensive System Accounting (CSA) provides the ability to
track system resource utilization per job and charge back
the cost of those resources to users.  Los Alamos National
Laboratory (LANL) and SGI worked together to provide this
job accounting feature on Linux.

     CSA job accounting is now available and can be downloaded from
the download link at http://oss.sgi.com/projects/csa.
There is a 2.4.0 kernel patch, a module tarball, command
binary and source rpms plus a command source tarball and documentation.
This has only been tested on i386 systems.  An ia64 version
will be available soon.

     CSA is a set of kernel changes, C programs and shell scripts
that provide methods for collecting per-task resource usage data,
monitoring disk usage, and charging fees to specific login
accounts.  CSA takes this per-task accounting information and
combines it outside of the kernel by job identifier (jid) within
system boot uptime periods.  Another project, Process
Aggregates (PAGG), is providing the kernel job infrastructure
needed by CSA (http://oss.sgi.com/projects/pagg).

     Job accounting is important to production sites. As these sites
install large Linux systems, they need the enterprise style accounting
provided by CSA.  Since numerous other Linux sites may not be
interested in job accounting, almost all of the kernel code for
CSA is contained in a loadable kernel module.  Use of this
feature is configurable through the kernel configuration menu.

     The new resource usage counters can also be used by performance
tools like sar and Performance Co-Pilot (PCP).  These counters have
value outside of CSA and should be available regardless of
whether CSA is in use.

     The CSA kernel patch is against a 2.4.0 kernel with the pagg patch
applied.  The "kernel changes" link from http://oss.sgi.com/projects/csa
describes the kernel changes in detail.  In summary, the CSA patch 
contains the following changes:

1)  added i/o counters (bytes read/written, blocks read/written,
    number of read/write syscalls, and i/o wait time) 

2)  added configurable memory integral (memory use over time) counters

3)  added physical and virtual highwater memory counters
    
4)  added CONFIG_CSA_JOB_ACCT kernel configuration menu item

5)  added CSA wrapper procedures (real work done in loadable module)
    for writing accounting records at start of job, end of process,
    end of job, and CSA configuration changes; for processing CSA
    configuration requests; and for processing CSA module registration
    and unregistration

6)  added acctctl syscall to check status, enable and disable
    job accounting, set memory and cpu time thresholds (records only
    written if threshold value is exceeded), provide a daemon accounting
    record buffer to the kernel (i.e. from a workload management program),
    and start/stop user job accounting

     Thanks for any comments and suggestions regarding Linux job
accounting.

----
Marlys Kohnke			Silicon Graphics Inc.
kohnke@sgi.com			655F Lone Oak Drive
(651)683-5324			Eagan, MN 55121
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
