Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316446AbSHOCL4>; Wed, 14 Aug 2002 22:11:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316465AbSHOCL4>; Wed, 14 Aug 2002 22:11:56 -0400
Received: from holly.csn.ul.ie ([136.201.105.4]:40466 "HELO holly.csn.ul.ie")
	by vger.kernel.org with SMTP id <S316446AbSHOCLy>;
	Wed, 14 Aug 2002 22:11:54 -0400
Date: Thu, 15 Aug 2002 03:15:42 +0100 (IST)
From: Mel <mel@csn.ul.ie>
X-X-Sender: mel@skynet
To: linux-mm@kvack.org
Cc: linux-kernel@vger.kernel.org
Subject: VM Regress 0.5
Message-ID: <Pine.LNX.4.44.0208150312220.20123-100000@skynet>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Project page: http://www.csn.ul.ie/~mel/projects/vmregress/
Download:     http://www.csn.ul.ie/~mel/projects/vmregress/vmregress-0.5.tar.gz

This is the second public release of VM Regress. It is the beginnings of
a regression, benchmarking and test tool for the Linux VM. The web page has
an introduction and the project itself has quiet comprehensive documentation
and commentary. It is still in it's very early days.

This release has a lot of solidification of the suite infrastructure, the
full changelog is at the end. I'm not going to bore people with the details
but it is in better shape. There is two new features that are of serious note.

1. Print out page present/swapped map
   The pagetable core module can now print out a map at the end of the test
   representing pages in an address space. This means that when a tests is run
   referencing pages, it is possible to see *exactly* what the address space
   looked like after. I am considering expanding this to print out the address
   space of any process but I'm not sure how useful that would be. It might be
   handy for running an ad-hoc shell script and having the module attach to
   the process to print out it's address space before exiting to see what it
   looked like at the end.....

2. A script plot_map.pl is provided that will take test output that has a map
   (currently only fault.o) and produce a webpage of it. See
   http://www.csn.ul.ie/~mel/projects/vmregress/output_sample/test_fault_zero.html
   for what a sample page looks like. The graph shows the address space been
   tested. When the test finished, the whole process was been swapped out so
   all the pages at the beginning are swapped and the later ones are still
   present. It is expected that later tests will show how well rmap makes
   this look in comparison to older kernels. Later tests will also have a
   more interesting reference pattern than straight linear referencing

The next feature to add to the graphs is including an artifical page reference
count. For a given test, the number of times a page was referenced will be
recorded and this will be compared to the pages present in memory. This should
help determine if Linux can choose the right pages to keep in memory or
not. From there, tests will be written with different reference pattern
and different types of memory such as mmaped files and so on.

A feature of lesser note is the beginning of been able to view the vmalloc
area. At the moment, it'll only print out the dimensions though. Much of the
rest was building up the core.

Again, it can't provide all the answers yet, but it's very early days and
if this was a quick job, it would have been written already :-) . I hope
that eventually it'll be able to answer most VM related questions.

Changelog for this release as follows....

 Version 0.5
 -----------
   o Added a module kvirtual for printing out the vmalloc address space
   o Can now pass a pointer to client data into page table walk functions
   o Proc buffers are now stored in the vmr_desc_t struct
   o Proc buffers can be grown
   o Process maps can be printed out to view present/swapped pages
   o Created plot_map.pl which will plot a page present/swapped graph
   o set plot_map.pl to output html pages upon request
   o Updated kernel patches to 2.4.20pre2 . Should apply to 2.5.x

Any feedback is appreciated.

-- 
Mel Gorman
MSc Student, University of Limerick
http://www.csn.ul.ie/~mel

