Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319220AbSHUVkS>; Wed, 21 Aug 2002 17:40:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319221AbSHUVkS>; Wed, 21 Aug 2002 17:40:18 -0400
Received: from holly.csn.ul.ie ([136.201.105.4]:64772 "HELO holly.csn.ul.ie")
	by vger.kernel.org with SMTP id <S319220AbSHUVkR>;
	Wed, 21 Aug 2002 17:40:17 -0400
Date: Wed, 21 Aug 2002 22:44:19 +0100 (IST)
From: Mel <mel@csn.ul.ie>
X-X-Sender: mel@skynet
To: linux-mm@kvack.org, <linux-kernel@vger.kernel.org>
Subject: VM Regress 0.6
Message-ID: <Pine.LNX.4.44.0208212238050.29496-100000@skynet>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Project page: http://www.csn.ul.ie/~mel/projects/vmregress/
Download:     http://www.csn.ul.ie/~mel/projects/vmregress/vmregress-0.6.tar.gz

This is the third public release of VM Regress. It is the beginnings of a
regression, benchmarking and test tool for the Linux VM. The web page has
an introduction and the project itself has quiet comprehensive
documentation and commentary. It is still in it's very early days but
there is a lot more in here than there was in 0.5.

This release had a lot of minor bug fixes in it including building with
highmem support and late 2.5 kernels. It has been heavily tested with both
2.4.19 and 2.4.19-rmap14a .

The first item feature of note is that multiple instances of the same test can
now run but only one will output information to the proc entry. This will
allow 100 small instances of a test to run rather than one very large
instance.

Second item is the pagemap.o module. When read, it will print out all VMA's
of the reading process and print what pages are present/swapped in that region
in encoded format. A perl library is provided for decoding the information.

Third item is the introduction of the mapanon.o module. It exports four
proc interfaces for open, reading, writing and closing memory mapped
regions. It is designed to be used by a benchmarking perl script
(bin/bench_mapanon.pl --man for details) for testing how quickly anonymous
pages are used within an mmaped region and illustrates what pages the
kernel decides to swap out. The report from the benchmark will show how
quickly pages were accessed, what pages were present/swapped in comparison
to how often a page was referenced and a graph of vmstat output. Tests are
running currently measuring the performance of 2.4.19 and 2.4.19-rmap14a.
They will be posted up when they complete running.

Fourth item is several perl libraries made available that are aimed at making
developing of new tests very easy. They cover a lot of the drudge work a test
has to do such as graphing, reading proc entries, decoding information and so
on. The manual has most of the details. All of VM Regress is designed to
be very easy to interface with so other tests can be easily developed.

The next step is to update mapanon to cover mmaped files as well as anonymous
memory. This is so a simulation web server will be run complete with bots
browsing web pages similar to what Rik Van Riel outlined in an email sent
to the list. This will help the tool be both a micro analysis and
overall performance testing and benchmark tool.

Further down the line is the development of statistical analysis tools for
examining different data sets, in particular the timing information the
bench_mapanon.pl script produces.

This is still very much in it's early days and is expected to take a long time
to develop fully but it's at the point where it can produce useful figures.
Reasonably comprehensive documentation is available with the package and from
the webpage. Any feedback is appreciated.

Full changelog for 0.6

Version 0.6
-----------
  o Allow multiple instances of tests to run. Only one will print to proc
  o pagemap.o module will dump out address space with pages swapped/present
  o mapanon.o benchmark, creates and references mmaped areas so that a script
    can simulate program behavior and see what the process space looks like
    after
  o Created various benchmark perl scripts.
  o Created various support perl modules for running tests in bin/lib/VMR
  o Print out kernel messages
  o Moved the pagemap decode perl routines to a library
  o Fixed CONFIG_HIGHMEM compile error
  o Fixed spinlock redefine errors
  o Fixed use of KERNEL_VERSION macro
  o Fixed various deadlocks

-- 
Mel Gorman
MSc Student, University of Limerick
http://www.csn.ul.ie/~mel

