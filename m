Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263186AbTDRSKV (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Apr 2003 14:10:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263190AbTDRSKV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Apr 2003 14:10:21 -0400
Received: from holly.csn.ul.ie ([136.201.105.4]:14767 "EHLO holly.csn.ul.ie")
	by vger.kernel.org with ESMTP id S263186AbTDRSKT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Apr 2003 14:10:19 -0400
Date: Fri, 18 Apr 2003 19:22:11 +0100 (IST)
From: Mel Gorman <mel@csn.ul.ie>
X-X-Sender: mel@skynet
To: Linux Memory Management List <linux-mm@kvack.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: VM Regress 0.9 released
Message-ID: <Pine.LNX.4.53.0304181900170.30626@skynet>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

VM Regress is a framework for a regrssion, testing and benchmark tool for
the Virtual Memory (VM) system. It will ultimatly be able to perform
reliable, reproducable testing on every aspect of the VM including
providing empirical performance data. It relies on a combination of
userspace tools and kernel modules to accuratly determine the current
state of the kernel and to reliably reproduce tests.

Project Page: http://www.csn.ul.ie/~mel/projects/vmregress/
Download:     http://www.csn.ul.ie/~mel/projects/vmregress/vmregress-0.9.tar.gz
Manual:       http://www.csn.ul.ie/~mel/projects/vmregress/vmregress.pdf

The manual is quite comprehensive and all scripts have man pages available
(via perldoc) so it should be fairly easy how the framework is structured.

This release has focused a lot on making the tool work with late 2.4 and
2.5 kernels. All modules and tools have been tested with 2.4.20 and
2.5.67 on a small UP box and more importantly on a Quad Xeon xSeries 350
which IBM generously gave to help me research. All tests and benchmarks
completed successfully and I think the last of the bugs have been shaken
out (famous last words).

Other changes;

All modules now use a common init and proc buffer management code. This
makes the "highest" level modules a lot smaller than they were (often more
than 100 lines less) and a lot easier to understand and develop. Even
though this release is a good deal more comprehensive than the previous
release, it is still smaller overall.

The userspace scripts will work with the different procutil versions out
there.

The kvirtual module for printing out what the kernel address space looks
like is a lot more accurate than it was. This is mainly of help to new
people who just want to see how memory is laid out.

The userspace scripts now share as much code as possible in perl libraries
and the scripts are now responsible for collecting data from multiple
kernel modules rather than duplicating code (for example, test modules no
longer print out zone information).

I am hoping now that the framework is there to develop other tests and
have finer grain control on what tests actually do rather than focusing on
shell scripts which impact on many different areas. Most of the annoying
and drudgery aspects of testing is now provided for so I am hoping to get
back onto this fulltime in 2 weeks or so after the documentation of the
2.4.20 VM is finalised.

Changelogs since the last major release

Version 0.9
-----------
  o Moved all module initialise code to a global init.c that is #included
  o Moved all read/write proc code to a global proc.c that is #included
  o Fixed the testproc module so that it wouldn't crash with pages > 10
  o Taught the kvirtual module a lot about what is in the linear address space
  o Removed a lot of common code that was in modules
  o Perl scripts now use kernel modules to collect most data
  o Perl scripts use as much common common code as possible
  o Added perl library for the easier creation of reports
  o Miscalculation in pagetable.o meant that mmap benchmarks were unreliable

Version 0.8a
------------
  o Minor bug fixes in the core
  o OSDL based merging
    - Fixed the extract_structs.pl script to ensure its a struct been extracted
    - Move the creation of internal.h from Makefiles to the configure script
    - Use configure script to apply kernel patch if requested
  o Read kernel release version directly from Kernel makefile
  o Automatically generate makefiles depending on kernel version from configure
  o Teach extract_structs.pl to identify a struct that is typedef'd
  o vmr_mmzone.h has been expanded to map between different struct and field
    names between kernel versions. Not many differences thankfully


-- 
Mel Gorman
MSc Student, University of Limerick
http://www.csn.ul.ie/~mel
