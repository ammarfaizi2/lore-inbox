Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282244AbRLDGbs>; Tue, 4 Dec 2001 01:31:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282236AbRLDGbj>; Tue, 4 Dec 2001 01:31:39 -0500
Received: from asooo.flowerfire.com ([63.254.226.247]:8968 "EHLO
	asooo.flowerfire.com") by vger.kernel.org with ESMTP
	id <S282223AbRLDGbY>; Tue, 4 Dec 2001 01:31:24 -0500
Date: Tue, 4 Dec 2001 00:31:22 -0600
From: Ken Brownfield <brownfld@irridia.com>
To: Sven Heinicke <sven@research.nj.nec.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: hints at modifying kswapd params in 2.4.16
Message-ID: <20011204003122.B31869@asooo.flowerfire.com>
In-Reply-To: <15371.48585.441972.472493@abasin.nj.nec.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
In-Reply-To: <15371.48585.441972.472493@abasin.nj.nec.com>; from sven@research.nj.nec.com on Mon, Dec 03, 2001 at 01:00:41PM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Yes, 2.4.16 fixed a major source of kswapd thrashing for (at least)
mmapped memory, but there are still some corner cases left which I've
also seen.  For instance, in the new case I'm seeing kswapd thrashing
even when freepages hasn't been reached under heavy I/O.  I'm under the
impression that this behavior is more of a mis-behavior rather than a
mis-tuning.

I don't think I've seen a response to my recent post go by; hopefully
the VM issues can still be debugged soon even after the handoff to
Marcelo... :-)
-- 
Ken.
brownfld@irridia.com

PS: The hardware in question on my end is an HP LH6000r, 6-way Xeon, 4GB.

On Mon, Dec 03, 2001 at 01:00:41PM -0500, Sven Heinicke wrote:
| 
| We have been having many problems on a Dell PowerEdge 4400 with 4G of
| memory.  We are willing to get new hardware if, perhaps, there is
| something known to not work with that hardwares memory.  If there are
| known hardware configurations that work will in high load, high IO
| situations.  We really want to stay with Linux, but my boss is getting
| increasingly agitated with issues.
| 
| Our application has, on the order of 300 network sockets open at any
| one time primarily for input.  And only 1 or 2 for output.  We
| constantly malloc/free 100k of memory, I mean a lot.  Plus do a fair
| amount of SCSI IO.  The threads never use more then like 300M of
| memory at a time though caching memory fills up to like 2G.  I believe
| it would work on a system with 1G of memory.
| 
| With kernels 2.4.14 and before, including some AA kernels, the cache
| would fill up memory and do a little swapping to disk and then start
| the just-in-time free memory stuff.  We where very happy when 2.4.16
| seems smarter about this then previous version and never uses more
| then ~2G of cachememory.
| 
| But, after running for a time, kswapd starts taking more CPU time then
| the threads we are running and slowing down the processing.  Is this
| something wrong with kswapd or might modifying files in /proc/sys/vm/
| fix this?
| 
| If modifying files in /proc/sys/vm/ can fix it, what should one
| consider when modifying the /proc/sys/vm/kswapd and other files to
| suit my applications?  Also, in my /proc/sys/vm directory there is
| only the following files:
| 
| $ ls /proc/sys/vm
| bdflush  max-readahead  overcommit_memory  pagetable_cache
| kswapd   min-readahead  page-cluster
| 
| With 2.4.16 I though I should have others as described in the proc.txt
| file, like `buffermem', `pagecache' and others.  How do I get these,
| and once I do have them some hints on how to modify there values to
| optimize my applications might be useful.
| 
| 	 Sven
| -
| To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
| the body of a message to majordomo@vger.kernel.org
| More majordomo info at  http://vger.kernel.org/majordomo-info.html
| Please read the FAQ at  http://www.tux.org/lkml/
