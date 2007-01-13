Return-Path: <linux-kernel-owner+w=401wt.eu-S1751338AbXAMJvy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751338AbXAMJvy (ORCPT <rfc822;w@1wt.eu>);
	Sat, 13 Jan 2007 04:51:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751355AbXAMJvy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 13 Jan 2007 04:51:54 -0500
Received: from a80-100-32-23.adsl.xs4all.nl ([80.100.32.23]:45231 "EHLO
	mail.vanvergehaald.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751338AbXAMJvx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 13 Jan 2007 04:51:53 -0500
Date: Sat, 13 Jan 2007 10:51:51 +0100
From: Toon van der Pas <toon@hout.vanvergehaald.nl>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Two versions of the truth (Documentation/{filesystems/proc.txt,sysctl/vm.txt}
Message-ID: <20070113095151.GA24254@shuttle.vanvergehaald.nl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I was looking for a description of the kernel parameter page-cluster
and found two versions that appear to be very different to me.
(see the two text fragments below)

The first one talks about the clusting of pages on a page fault,
when pages need to be read into memory.
The second one talks about the number of pages written to swap in
a single attempt.

Which one is correct?
I'm inclined to choose the first description.
The second one appears to be wrong to me because paged-in pages are
simply evicted from the page cache when need be, they are never
written out to swap. At least, that's what I've always thought.

Can anybody help me out?
Regards,
Toon.

8< - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

/usr/src/linux-2.6.18-gentoo-r4/Documentation/sysctl/vm.txt:
============================================================
page-cluster:

The Linux VM subsystem avoids excessive disk seeks by reading
multiple pages on a page fault. The number of pages it reads
is dependent on the amount of memory in your machine.

The number of pages the kernel reads in at once is equal to
2 ^ page-cluster. Values above 2 ^ 5 don't make much sense
for swap because we only cluster swap data in 32-page groups.

/usr/src/linux-2.6.18-gentoo-r4/Documentation/filesystems/proc.txt:
===================================================================
page-cluster
------------

page-cluster controls the number of pages which are written to swap
in a single attempt.  The swap I/O size.

It is a logarithmic value - setting it to zero means "1 page",
setting it to 1 means "2 pages", setting it to 2 means "4 pages",
etc.

The default value is three (eight pages at a time).  There may be
some small benefits in tuning this to a different value if your
workload is swap-intensive.
