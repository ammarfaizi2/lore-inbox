Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278295AbRJSES4>; Fri, 19 Oct 2001 00:18:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278297AbRJSESr>; Fri, 19 Oct 2001 00:18:47 -0400
Received: from penguin.e-mind.com ([195.223.140.120]:20008 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S278295AbRJSESi>; Fri, 19 Oct 2001 00:18:38 -0400
Date: Fri, 19 Oct 2001 06:19:14 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: linux-kernel@vger.kernel.org
Subject: 2.4.13pre5aa1
Message-ID: <20011019061914.A1568@athlon.random>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.12i
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The vm part in particular is right now getting stressed on a 16G box kindly
provided by osdlab.org and it didn't exibith any problem yet. This is a trace
of the workload that is running on the machine overnight.

   procs                      memory    swap          io     system         cpu
 r  b  w   swpd   free   buff  cache  si  so    bi    bo   in    cs  us  sy  id
 0  3  2 7055840   5592    196   4208 681 903   687   904   56    87   0   5  95
 0  3  0 7055332   4956    184   4196 5892 4820  5892  4832  418   547   0   3  97
 0  3  0 7056004   5816    176   4184 6172 6400  6172  6400  418   579   0   4  96
 0  3  0 7055912   5688    192   4184 4720 4096  4736  4112  355   456   0   2  98
 0  3  1 7055852   5300    180   4220 5624 5068  5720  5072  408   526   0   2  98
 0  3  0 7055992   5228    176   4220 6384 5744  6384  5744  427   586   0   1  99
 0  3  0 7055900   5232    176   4220 6016 5676  6016  5676  417   545   0   2  98
 0  3  0 7056396   5844    180   4220 5644 5656  5656  5660  402   560   0   1  99
 0  3  1 7056476   6012    176   4216 6104 6144  6104  6144  411   582   0   1  99
 0  3  0 7056084   5592    176   4220 5540 4452  5540  4452  386   525   0   1  98
 0  3  0 7055948   5400    176   4220 5184 4724  5184  4724  355   519   0   2  98
 0  3  0 7056676   6136    176   4232 7360 7592  7360  7592  519   720   0   1  98
 0  4  0 7056264   5572    176   4240 5888 5112  5908  5112  411   535   0   1  99
 0  3  1 7055948   5444    180   4240 5632 4912  5656  4932  402   605   0   1  99
 0  3  0 7055780   5088    176   4240 4932 4276  4932  4276  350   432   0   1  99
 0  3  0 7055612   5128    176   4240 4564 4252  4564  4252  340   434   0   0 100

             total       used       free     shared    buffers     cached
Mem:      16493180   16488716       4464          0        184       4260
-/+ buffers/cache:   16484272       8908
Swap:     36941584    7054904   29886680

It seems still very responsive despite of the load (and also despite being at
the other side of the Atlantic :).

URL:

	ftp://ftp.us.kernel.org/pub/linux/kernel/people/andrea/kernels/v2.4/2.4.13pre5aa1.bz2
	ftp://ftp.us.kernel.org/pub/linux/kernel/people/andrea/kernels/v2.4/2.4.13pre5aa1/

If it swaps too much please try:

	echo 6 > /proc/sys/vm/vm_scan_ratio
	echo 2 > /proc/sys/vm/vm_mapped_ratio
	echo 4 > /proc/sys/vm/vm_balance_ratio

Thanks!

--
Only in 2.4.13pre5aa1: 00_alpha-rest-pci-1
Only in 2.4.13pre5aa1: 00_alpha-tsunami-1

	iommu alpha fixes from Jay Estabrook, Ivan Kokshaysky and Richard
	Henderson.

Only in 2.4.13pre3aa1: 00_files_struct_rcu-2.4.10-04-1
Only in 2.4.13pre5aa1: 00_files_struct_rcu-2.4.10-04-2

	Latest uptdate from Maneesh Soni including the memalloc faliure bugfix
	Chip Salzenberg.

Only in 2.4.13pre3aa1: 00_highmem-deadlock-1
Only in 2.4.13pre5aa1: 00_highmem-deadlock-2

	Rediffed so that it's self contained (previously it wasn't very
	readable).

Only in 2.4.13pre3aa1: 00_lowlatency-fixes-1
Only in 2.4.13pre5aa1: 00_lowlatency-fixes-2

	Added a reschedule point, mainly for madvise but it's in the ->nopage
	way too.

Only in 2.4.13pre3aa1: 00_seg-reload-1

	Dropped, the common case is user<->kernel, and it have to be very fast
	too since it's more important. (idling routers would better not use
	irq at all but to dedicate a cpu to the polling work)

Only in 2.4.13pre3aa1: 00_vm-3
Only in 2.4.13pre3aa1: 00_vm-3.2
Only in 2.4.13pre5aa1: 10_vm-4

	Further vm work. Not sure if this is better than the previous one, but
	now the few magic numbers are sysctl configurable. Included many fixes
	from Linus (that are also in pre5 of course) and one fix from Manfred
	to avoid interrupt to eat the pfmemalloc reserved pool.

Only in 2.4.13pre3aa1: 10_highmem-debug-5
Only in 2.4.13pre5aa1: 20_highmem-debug-6

	Fixed zone alignment to avoid crashes when highmem emulation is enabled.

Only in 2.4.13pre5aa1: 10_lvm-deadlock-fix-1

	Dropped sync_dev from blkdev ->close to avoid a deadlock on lvm close(2),
	fix from Alexander Viro.

Only in 2.4.13pre3aa1: 60_tux-2.4.10-ac12-H1.bz2
Only in 2.4.13pre5aa1: 60_tux-2.4.10-ac12-H8.bz2

	Latest update from Ingo Molnar at www.redhat.com/~mingo/ .
--

Andrea
