Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266535AbSKUK4m>; Thu, 21 Nov 2002 05:56:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266537AbSKUK4m>; Thu, 21 Nov 2002 05:56:42 -0500
Received: from [195.223.140.107] ([195.223.140.107]:40853 "EHLO athlon.random")
	by vger.kernel.org with ESMTP id <S266535AbSKUK4l>;
	Thu, 21 Nov 2002 05:56:41 -0500
Date: Thu, 21 Nov 2002 12:03:48 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: linux-kernel@vger.kernel.org
Subject: 2.4.20rc2aa1
Message-ID: <20021121110348.GC1259@dualathlon.random>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
X-GPG-Key: 1024D/68B9CB43
X-PGP-Key: 1024R/CB4660B9
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Please read the comments on the 9981_elevator-lowlatency-1 patch, if you
don't want to risk bandwidth regressions in some seeking workload, make
sure to backout the 9981_elevator-lowlatency-1 patch before compiling.

URL:

	http://www.us.kernel.org/pub/linux/kernel/people/andrea/kernels/v2.4/2.4.20rc2aa1.gz
	http://www.us.kernel.org/pub/linux/kernel/people/andrea/kernels/v2.4/2.4.20rc2aa1/

Changelog between 2.4.20rc1aa1 and 2.4.20rc2aa1:

Only in 2.4.20rc2aa1: 00_backout-irda-trivial-1

	My gprs phone stops working with this applied (and the palm as well
	works only once in a while with it applied).

Only in 2.4.20rc1aa1: 00_extraversion-12
Only in 2.4.20rc2aa1: 00_extraversion-13
Only in 2.4.20rc1aa1: 00_read_full_page-get_block-err-1
Only in 2.4.20rc2aa1: 00_read_full_page-get_block-err-2

	Rediffed.

Only in 2.4.20rc2aa1: 00_highio-nohighmem-fix-1

	Potential performance with highio disabled or on non highio capable
	devices. (from Jens, but found some week ago by me and also more
	recently by Steve Lord on l-k)

Only in 2.4.20rc2aa1: 00_i810-unlock_page-fastcall-1

	Make sure it sees the fastcall calling conventions.

Only in 2.4.20rc2aa1: 00_intermezzo-tcgets-1
Only in 2.4.20rc2aa1: 00_presto-dentry-slab-1

	Fix compile problems.

Only in 2.4.20rc2aa1: 00_msgrcv-smp-race-1
Only in 2.4.20rc2aa1: 00_poll-smp-races-1

	Fix a few smp races.

Only in 2.4.20rc1aa1: 00_readahead-got-broken-somewhere-1
Only in 2.4.20rc2aa1: 00_readahead-got-broken-somewhere-2

	Increase the readahead a bit more, to make read against read
	faster decreasing the seeks.

Only in 2.4.20rc2aa1: 00_umount-against-unused-dirty-inodes-race-1

	The lowlatency bit in unused-dirty-inodes was racy,
	noticed by Terence Rokop at Polyserve. This fix
	allows to retain the lowlatency optimization. Other lowlatency
	patches around may need the same fix.

Only in 2.4.20rc2aa1: 55_uml-highmem-1

	Fix compile problem.

Only in 2.4.20rc1aa1: 95_fsync-corruption-fix-2

	This introduced a cache coherency problem with O_DIRECT so backed out.

Only in 2.4.20rc2aa1: 9980_fix-pausing-2

	Fix various longstanding unplugging races that could lead to long hangs
	with the disk idle and all tasks in D state. This fixes the
	get_request_wait against get_request_wait case too.

Only in 2.4.20rc2aa1: 9981_elevator-lowlatency-1

	*Very* experimental patch, that limits the queue size to a small value,
	this should provide more interactive behaviour better for a desktop
	but it will make things like dbench behave very very badly, the numbers
	will be quite horrible (i.e. low performance). OTOH I suspect the 2.5 deadline
	I/O scheduler would do very bad on dbench too if applied on top of a 2.4.
	2.5 can reorder stuff at the pagecache layer, during the writeback stage,
	2.4 only relies on the elevator instead. Anyways the patch is safe so I want
	to give it a spin knowing in advance that dbench will decrease horribly.
	If you test it let me know what you think about it. If you go read the code
	you will notice read-latency is now pointless with this patch applied
	(with a `cp /dev/zero .` in background the max number of requests in
	the queue could be even lower than the seventh-request where read-latency
	would attempt to put the read request). This should make lowmem machine beahave
	much better too, since it's less likely to block for vm. Running the contest
	benchmark on this one would be interesting too.

Andrea
