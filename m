Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131613AbRCVU7s>; Thu, 22 Mar 2001 15:59:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131764AbRCVU7i>; Thu, 22 Mar 2001 15:59:38 -0500
Received: from cmgm.Stanford.EDU ([171.65.21.67]:47577 "EHLO cmgm.stanford.edu")
	by vger.kernel.org with ESMTP id <S131613AbRCVU7Z>;
	Thu, 22 Mar 2001 15:59:25 -0500
Date: Thu, 22 Mar 2001 12:58:37 -0800 (PST)
From: Craig Cummings <cummings@cmgm.stanford.edu>
To: <linux-kernel@vger.kernel.org>
Subject: Bug report
Message-ID: <Pine.GSO.4.31.0103221257390.10736-100000@cmgm.stanford.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi there,

I think this qualifies as a bug but let me know if this could be a
configuration or hardware issue.

I've been having problems with memory leaks when I run programs on
large--up to 250MB text files.  (I know this is huge, but that's the 3
billion base human genome for you.)  At first I though it was a Perl
problem but I later found that a completely unrelated C program also
caused memory leaks.  I recently upgraded to the 2.4 kernel, hoping to
solve these problems (see below).  However, the memory leaks are still
happening and this time I know the problem is at a deeper level than my
programs.  Some standard UNIX programs are leaking a lot of memory.  I
would appreciate some advice and ultimately, a fix.  Unfortunately, My
programming skills are not sufficient for tinkering with the kernel
source.  Thank you, in advance for your help.  Details follow.

Regards,

Craig Cummings


Here are the specs for my system:
	Dell Precision XPSt700, Pentium III, 512 MB RAM
	I've recently upgraded from Red Hat 6.2 with the 2.2.14 kernel to
	Red Hat 7, then built the 2.4.2 kernel on my own.

Here's what happens with grep:

Output of free, freshly booted system:

             total       used       free     shared    buffers     cached
Mem:        513616      47516     466100          0       2476      27048
-/+ buffers/cache:      17992     495624
Swap:       128480          0     128480

Output of free after grep 'NT_005289' Data/hs_chr12.fa:

             total       used       free     shared    buffers     cached
Mem:        513616     183548     330068          0       2624     159616
-/+ buffers/cache:      21308     492308
Swap:       128480          0     128480

Output of grep 'NT_005289' Data/hs_chr2.fa:

>gi|12728771|ref|NT_005289.2|Hs2_5446 Homo sapiens chromosome 2 working draft sequence segment

Output of free after this grep:

             total       used       free     shared    buffers     cached
Mem:        513616     424272      89344          0       2860     394232
-/+ buffers/cache:      27180     486436
Swap:       128480          0     128480

Output of grep 'NT_005289' Data/hs_chr2.fa:

>gi|12728771|ref|NT_005289.2|Hs2_5446 Homo sapiens chromosome 2 working draft sequence segment

Output of free after this grep:

             total       used       free     shared    buffers     cached
Mem:        513616     424272      89344          0       2860     394232
-/+ buffers/cache:      27180     486436
Swap:       128480          0     128480

File sizes of the two files grep'ed:

-rw-rw-r--    1 cummings genomics 135744469 Mar 12 22:09 Data/hs_chr12.fa
-rw-rw-r--    1 cummings genomics 240244039 Mar 12 22:24 Data/hs_chr2.fa

Note that these file sizes are equivalent to the amount of memory leaked
when grep is called on that file.

When I grep the same file a second time, very little additional memory is
leaked.


This same phenomenon occurs when I run a different UNIX program, e.g. wc:

Output of wc -l Data/hs_chr3.fa:

2915465 Data/hs_chr3.fa

Output of free:

             total       used       free     shared    buffers     cached
Mem:        513616     511520       2096          0       1252     481020
-/+ buffers/cache:      29248     484368
Swap:       128480          0     128480

Interestingly, after running wc a second time on the same file, it goes
very fast and very little additional memory is leaked:

             total       used       free     shared    buffers     cached
Mem:        513616     510732       2884          0       1204     480948
-/+ buffers/cache:      28580     485036
Swap:       128480         40     128440


-------------------------------------------
Craig Cummings, Ph.D.

Relman Laboratory
Stanford University School of Medicine
Department of Microbiology and Immunology

e-mail: cummings@cmgm.stanford.edu
phone:  650-498-5998
fax:    650-852-3291

