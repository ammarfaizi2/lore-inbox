Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279261AbRLDBpy>; Mon, 3 Dec 2001 20:45:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282164AbRLDANd>; Mon, 3 Dec 2001 19:13:33 -0500
Received: from abasin.nj.nec.com ([138.15.150.16]:16645 "HELO
	abasin.nj.nec.com") by vger.kernel.org with SMTP id <S284873AbRLCSAt>;
	Mon, 3 Dec 2001 13:00:49 -0500
From: Sven Heinicke <sven@research.nj.nec.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15371.48585.441972.472493@abasin.nj.nec.com>
Date: Mon, 3 Dec 2001 13:00:41 -0500 (EST)
To: linux-kernel@vger.kernel.org
Subject: hints at modifying kswapd params in 2.4.16
X-Mailer: VM 6.72 under 21.1 (patch 14) "Cuyahoga Valley" XEmacs Lucid
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


We have been having many problems on a Dell PowerEdge 4400 with 4G of
memory.  We are willing to get new hardware if, perhaps, there is
something known to not work with that hardwares memory.  If there are
known hardware configurations that work will in high load, high IO
situations.  We really want to stay with Linux, but my boss is getting
increasingly agitated with issues.

Our application has, on the order of 300 network sockets open at any
one time primarily for input.  And only 1 or 2 for output.  We
constantly malloc/free 100k of memory, I mean a lot.  Plus do a fair
amount of SCSI IO.  The threads never use more then like 300M of
memory at a time though caching memory fills up to like 2G.  I believe
it would work on a system with 1G of memory.

With kernels 2.4.14 and before, including some AA kernels, the cache
would fill up memory and do a little swapping to disk and then start
the just-in-time free memory stuff.  We where very happy when 2.4.16
seems smarter about this then previous version and never uses more
then ~2G of cachememory.

But, after running for a time, kswapd starts taking more CPU time then
the threads we are running and slowing down the processing.  Is this
something wrong with kswapd or might modifying files in /proc/sys/vm/
fix this?

If modifying files in /proc/sys/vm/ can fix it, what should one
consider when modifying the /proc/sys/vm/kswapd and other files to
suit my applications?  Also, in my /proc/sys/vm directory there is
only the following files:

$ ls /proc/sys/vm
bdflush  max-readahead  overcommit_memory  pagetable_cache
kswapd   min-readahead  page-cluster

With 2.4.16 I though I should have others as described in the proc.txt
file, like `buffermem', `pagecache' and others.  How do I get these,
and once I do have them some hints on how to modify there values to
optimize my applications might be useful.

	 Sven
