Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276247AbRJKKcn>; Thu, 11 Oct 2001 06:32:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276204AbRJKKcf>; Thu, 11 Oct 2001 06:32:35 -0400
Received: from penguin.e-mind.com ([195.223.140.120]:30808 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S275981AbRJKKcW>; Thu, 11 Oct 2001 06:32:22 -0400
Date: Thu, 11 Oct 2001 12:32:31 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: linux-kernel@vger.kernel.org
Cc: Robert Macaulay <robert_macaulay@dell.com>,
        Stephan von Krawczynski <skraw@ithnet.com>,
        "Jeffrey W. Baker" <jwbaker@acm.org>,
        Lorenzo Allegrucci <lenstra@tiscalinet.it>
Subject: 2.4.12aa1 [was Re: 2.4.11aa1 [was Re: 2.4.11pre6aa1]]
Message-ID: <20011011123231.C714@athlon.random>
In-Reply-To: <20011009205516.F724@athlon.random> <20011010051104.F726@athlon.random>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20011010051104.F726@athlon.random>; from andrea@suse.de on Wed, Oct 10, 2001 at 05:11:04AM +0200
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This update has further VM work (actually fixes compared to 2.4.11aa1),
I also changed my mind about a few bits, and I suggest to test it since
this one seems to run very well for me.

Lorenzo and Jeffrey, I'd be interested if you could check with your
tests how it behaves compared to 2.4.12 vanilla.

Thanks!!

URL:

	ftp://ftp.us.kernel.org/pub/linux/kernel/people/andrea/kernels/v2.4/2.4.12aa1.bz2
	ftp://ftp.us.kernel.org/pub/linux/kernel/people/andrea/kernels/v2.4/2.4.12aa1/00_vm-2

(as usual ftp.kernel.org gets it faster)

Only in 2.4.12aa1: 00_cache-without-buffers-1

	Don't account the buffer cache as pagecache. The logic is racy
	(theoretically the "cache" value could also become negative) but that's
	not a problem. Patch from Chris Mason.

Only in 2.4.11aa1: 00_copy-user-lat-5
Only in 2.4.12aa1: 00_lowlatency-fixes-1

	Replaced the lowlatency in copy-user with explicit preemption
	points. This is basically Andrew's patch posted to l-k yesterday but
	I'm always using conditional_schedule() that uses unlikely. It isn't
	worthwhile to make the __set_current_task(TASK_RUNNABLE) conditional
	since it's in the slow path. I also hooked into the wait unlocked
	buffers code. Also schedule after the pagecache is released, so it's
	not a contention point.

	Some #include rule: conditional_schedule() is defined by linux/sched.h
	and likely/unlikely are defined by linux/kernel.h, so the latter are
	generally always available in any kernel code without the need
	of the #include <linux/compiler.h> (see the 10_compiler.h-1 patch).

Only in 2.4.11aa1: 00_o_direct-1
Only in 2.4.12aa1: 00_o_direct-2

	Never use i_sb->s_blocksize* and friends in the pagecache layer, it is
	the wrong thing for the blkdevs. Use inode->i_blkbits instead that
	is defined ad hoc by the blkdev open code.

Only in 2.4.12aa1: 00_parport-fix-1

	Parport compile fix from Tim.

Only in 2.4.11aa1: 00_vm-1
Only in 2.4.12aa1: 00_vm-2
Only in 2.4.11aa1: 10_debug-gfp-1

	Further vm changes. First of all it fixes the reclaiming of mapped
	pagecache/swapcache. vm-1 was not allowing the mapped cache to be
	released correctly (it would been very bad if all the normal or dma
	zone were mapped for example). Also added some write throttling at
	the page layer to avoid unnecessary bangs on the clean cache.
	This is still a bit experimental of course, but it is doing very well
	here so far. As usual I'd really like if people could test and
	feedback. Thanks!

Only in 2.4.12aa1: 10_lvm-snapshot-hardsectsize-1

	Use the hardblocksize as the snapshot COWs rawio blocksize. The
	"softblocksize" is meaningless for physical volumes and it
	was breaking some compatibility with older lvmtools that sets
	different alignments. Based on a patch from Chris Mason.

Only in 2.4.11aa1: 50_uml-patch-2.4.10-7.bz2
Only in 2.4.12aa1: 50_uml-patch-2.4.11-1.bz2
Only in 2.4.11aa1: 52_uml-export-objs-1

	Picked last update at user-mode-linux.sourceforge.net from Jeff.

Only in 2.4.11aa1: 60_tux-2.4.10-ac10-D2.bz2
Only in 2.4.12aa1: 60_tux-2.4.10-ac10-E6.bz2

	Picked latest Ingo's tux release at www.redhat.com/~mingo/ .

Andrea
