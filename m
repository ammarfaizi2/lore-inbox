Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318348AbSHKUNV>; Sun, 11 Aug 2002 16:13:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318349AbSHKUNU>; Sun, 11 Aug 2002 16:13:20 -0400
Received: from holly.csn.ul.ie ([136.201.105.4]:11269 "HELO holly.csn.ul.ie")
	by vger.kernel.org with SMTP id <S318348AbSHKUNU>;
	Sun, 11 Aug 2002 16:13:20 -0400
Date: Sun, 11 Aug 2002 21:17:01 +0100 (IST)
From: Mel <mel@csn.ul.ie>
X-X-Sender: mel@skynet
To: linux-mm@kvack.org
Cc: linux-kernel@vger.kernel.org
Subject: [ANNOUNCE] VM Regress - A VM regression and test tool
Message-ID: <Pine.LNX.4.44.0208112109110.16360-100000@skynet>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Project page: http://www.csn.ul.ie/~mel/projects/vmregress/
Download:     http://www.csn.ul.ie/~mel/projects/vmregress/vmregress-0.4.tar.gz

This is the first public release of VM Regress v0.4 (BumbleBee). It is the
beginnings of a regression, benchmarking and test tool for the Linux VM.
The web page has an introduction and the project itself has quiet
comprehensive documentation and commentary so I am not going to go into
heavy detail here.

There appears to be frequent trouble reliably testing the VM and comparing
the impact (beneficial or otherwise) of VM features. As best as I can
tell, there is heavy reliance on stress testing or intuitive decisions
made by individual kernel developers to prove a VM is working or that is
is better than another implementation. This tool eventually will be able
to provide empirical data on VM performance as well as acting as a
regression tool to make sure changes don't break anything.

It works by using kernel modules to get a definite view of what the kernel
is at and to provide reliable, reproducible tests. Modules are divided
up into 4 catagories. Core modules provide infrastructure for the tool.
Sense modules tell what is going on in the VM. Test tests particular
features and bench modules (none yet) will benchmark different sections
of the VM.

The aim is to eventually eliminate guesswork in development. The tool will
be able to tell for definite if a feature works. If it does work, it will
be able to tell how well or poorly the feature performed. This will
hopefully replace ad-hoc shell script tests and provide concrete
performance data any developer can reliably produce and use as proof of
"Feature X is better"

The interface to the tests are via proc at /proc/vmregress. Help is provided
for most of them by cat'ing the entries after module load. The README and
manual are very comprehensive and each c file has a detailed description at
the top so I'm not going to go into heavy detail in this mail. The README
includes a sample set of tests to illustrate how the tool can be used to
provide useful information about performance.

This was developed against 2.4.18 and 2.4.19 but will compile with 2.5.30
and takes into account the existence of rmap (will compile and work with
or without rmap). Bear in mind the tool is far for complete and I'm just
looking for feedback on the viability and usefulness (or the lack thereof)
of this tool. Consequently, it doesn't do much. Currently it

o Provides infrastructure such as proc helper functions, page table walk
  functions and so on
o Provides tests for the /proc interface to ensure it works
o Prints out the sizeof() VM related structs and prints out the memory usage
o Prints out information on all zones in the system
o Tests physical page allocation/free functions with either GFP_ATOMIC or
  GFP_KERNEL flags
o Tests page faulting routines

This has been tested heavily with UML 2.4.18 and with a dual PII350 running
2.4.19 . It is known to compile with 2.5.30 but I haven't done any 2.5 testing
yet due to the lack of a crash box. It will work with or without rmap as
the tool was written with it (as well as every other VM feature) in mind.

Any feedback is appreciated.

-- 
Mel Gorman
MSc Student, University of Limerick
http://www.csn.ul.ie/~mel

