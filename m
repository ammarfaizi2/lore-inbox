Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267292AbTAWVpr>; Thu, 23 Jan 2003 16:45:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267300AbTAWVpr>; Thu, 23 Jan 2003 16:45:47 -0500
Received: from air-2.osdl.org ([65.172.181.6]:57810 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id <S267292AbTAWVpo>;
	Thu, 23 Jan 2003 16:45:44 -0500
Date: Thu, 23 Jan 2003 13:54:48 -0800
From: Dave Olien <dmo@osdl.org>
To: axboe@suse.de, akpm@digeo.com
Cc: linux-kernel@vger.kernel.org, markw@osdl.org, cliffw@osdl.org,
       maryedie@osdl.org, jenny@osdl.org
Subject: [BUG] BUG_ON in I/O scheduler, bugme # 288
Message-ID: <20030123135448.A8801@acpi.pdx.osdl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Jens, Andrew

The group here doing dbt2 workload measurements have hit a couple of
problems APPARENTLY in the block I/O scheduler when doing write-intensive
raw disk I/O through a DAC960 extremeraid 2000 controller.
This wasn't a problem in 2.5.49.  It has appeared since then.

I've filed a bug on the OSDL bugme database.  You can read it at:

	http://bugme.osdl.org/show_bug.cgi?id=288

I've also put a more complete report in my web site:

	http://www.osdl.org/archive/dmo/deadline_bugon.

Begin with the README file.

For same reason, the README file isn't appearing on my web page.
I'll look into that. In the mean time, I've included the contests
of the README file below.

I'm about to try reproducing the problem on a smaller hardware
configuration.  Then, I'll test whether the same problem occurs with
read intensive I/O.



Dave Olien


-------------README---------------------------------------------------


Summary:

BUG_ON and system hangs occuring while doing write-itensive RAW disk I/O
to disks on a DAC960 extremeRAID 2000 controller.

It's possible the BUG_ON and system hangs are different, possibly
even unrelated problems.  But I'm grouping them together for now
until I've had more time to investigate.

In this directory are:

	DOT_CONFIG: the .config file for the kernel that was running.
		
	disktest.tar: a tar source file for the disktest program, 


	disktest_2.5.59.sh: a script that runs the disktest program to
			reproduce the system hanging events.

	BUG_ON: A console listing of the BUG_ON event.

	DISKTEST_STACKS: stack listings of the disktest threads that are
		hung in I/O, taken by the sysrq stack trace command.


The kernel being run was 2.5.59.  We also tried 2.5.59-mm2, and it
failed as well.

This was NOT a problem on linux 2.5.49.

The distribution on that system was Redhat 7.3.  So, the gcc compiler version
was 2.96.

The hardware configuration originally used to produce the failure is:

	8 Pentium III Xeon procssors.
	16 gig of memory, but the kernel is configured to use only 4gig.
	DAC960 extreme raid 2000, with 2 scsi channels, 11 disks on
		each chanel.  Each disk is 70 gigabytes. Each disk is
		its own logical device.


The BUG_ON() was encountered running sapdb database with the dbt2 work load.
The BUG_ON occurred at a time that the database was performing a checkpoint.
This is a random write-intensive activity that is done over many
disk devices.

The I/O is done on RAW devices.

Other times, the operating system didn't BUG_ON, but the system effectivly
hung during these checkpoint episodes.

We discovered that disktest could reproduce the problem with disktest
when run on the same hardware platform.  I'm in the process of trying
to reproduce the problem on a smaller configuration.  I'll also see
if it's only a write-intesive problem, or if there is a similar problem
with read-intensive I/O.
