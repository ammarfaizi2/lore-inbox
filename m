Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289051AbSA3KR1>; Wed, 30 Jan 2002 05:17:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289054AbSA3KRO>; Wed, 30 Jan 2002 05:17:14 -0500
Received: from penguin.e-mind.com ([195.223.140.120]:24144 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S289051AbSA3KQ5>; Wed, 30 Jan 2002 05:16:57 -0500
Date: Wed, 30 Jan 2002 11:18:10 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: linux-kernel@vger.kernel.org
Subject: 2.4.18pre7aa1
Message-ID: <20020130111810.A1309@athlon.random>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.12i
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

kernel.org seems down at the moment so I temporarily uploaded it here
(as soon as kernel.org is back, it will be automatically there as well
in the usual place of course).

	ftp://ftp.suse.com/pub/people/andrea/kernel-patches/2.4/2.4.18pre7aa1.gz (single patch)
	ftp://ftp.suse.com/pub/people/andrea/kernel-patches/2.4/2.4.18pre7aa1.tar.gz (collection)

(btw, really while I'm writing this email, the two above files are not
yet available on suse.com either yet but they should become visible very
soon, so if you don't see them immediatly it's normal)

the pte-highmem stuff seems quite solid now (the design that killed the
series was too slow and complex, so I preferred to deal with the
ordering instead and to be fast in the fast paths like reading the same
page a few times in the pagecache).

I will try to concentrate on some merging with Marcelo (in particular
the vm bits hoping he agress with them) and to forward port some stuff
(notably pte-highmem) to 2.5 for Linus in the next days/weeks (plus
fixing pte-highmem on the non x86 archs at least for 2.4).

changelog:

Only in 2.4.18pre4aa1: 00_3.5G-address-space-3
Only in 2.4.18pre7aa1/: 00_3.5G-address-space-4

	Add 3/2/1G option with PAE enabled (3.5G isn't feasible with PAE).
	From Hugh Dickins.

Only in 2.4.18pre7aa1/: 00_VM_IO-fbmem-1

	Cleanup the VM_IO points in the framebuffer drivers.
	From Andrew Morton.

Only in 2.4.18pre4aa1: 00_access_process_vm-1

	Obsoleted by the more generic 00_get_user_pages-1 fix.

Only in 2.4.18pre4aa1: 00_allow_mixed_b_size-1

	Dropped in favour of vary-io. (vary-io core with this patch wouldn't
	perform optimally due additional non mergeable requests with only a
	small b_size in them)

Only in 2.4.18pre7aa1/: 00_alpha-extern-inline-1

	Use static inline for new compilers.

Only in 2.4.18pre4aa1: 00_block-highmem-all-18b-2.bz2
Only in 2.4.18pre7aa1/: 00_block-highmem-all-18b-2.gz
Only in 2.4.18pre4aa1: 00_netconsole-2.4.10-C2-2.bz2
Only in 2.4.18pre7aa1/: 00_netconsole-2.4.10-C2-2.gz
Only in 2.4.18pre4aa1: 60_tux-2.4.17-final-A0.bz2
Only in 2.4.18pre7aa1/: 60_tux-2.4.17-final-A0.gz

	Stop uploading .bz2 files according to the kernel.org policy.

Only in 2.4.18pre7aa1/: 00_get_user_pages-1

	Fix map_user_kiobuf/O_DIRECT and friends, fail
	the get_user_pages if one page in the mapping is non RAM.
	From Andrew Morton.

Only in 2.4.18pre4aa1: 00_icmp-offset-1

	Dropped (not needed).

Only in 2.4.18pre4aa1: 00_lvm-1.0.1-rc4-6.bz2
Only in 2.4.18pre7aa1/: 00_lvm-1.0.2-1.gz

	Upgrade to lvm 1.0.2 from sistina.com.

Only in 2.4.18pre7aa1/: 00_netfilter-missing-1

	A few missing files from a netfilter update. Posted by David Miller on
	l-k.

Only in 2.4.18pre4aa1: 00_o_direct-leftovers-2

	Merged in mainline.

Only in 2.4.18pre4aa1: 00_rcu-poll-3
Only in 2.4.18pre7aa1/: 00_rcu-poll-4

	Dipankar Sarma raised a good point about enabling the true rcu also in
	UP, if the call_rcu is run from interrupt, having the rcu enabled in UP
	avoids the reader side to clear irqs. Patch update from Dipankar.

Only in 2.4.18pre4aa1: 00_waitfor-one-page-1

	Equivalent in mainline.

Only in 2.4.18pre4aa1: 10_lvm-incremental-2
Only in 2.4.18pre4aa1: 10_lvm-snapshot-hardsectsize-2

	Merged into the 1.0.2 Sistina update.

Only in 2.4.18pre4aa1: 10_nfs-o_direct-1
Only in 2.4.18pre7aa1/: 10_nfs-o_direct-2

	Rediffed. (also changed one line to use the host inode in the mapping)

Only in 2.4.18pre7aa1/: 10_rawio-vary-io-1

	rawio improvement to try to use a 4k b_size (rather than the usual
	512byte hardblocksize) on large buffers. Patch from Badari Pulavarty.
	So far the feature is enabled only for aic7xxx (new) and qlogicisp.

Only in 2.4.18pre7aa1/: 10_try-cciss-only-4G-1

	Let's try if this helps fixing the cciss instability with block-highmem
	on a 16G box (I suspect the controller needs to be triggered into DAC
	mode somehow, just writing the high 32bits of the bus address may not
	be enough, just guessing, and if something this patch cannot
	destabilize it further).

Only in 2.4.18pre4aa1: 10_vm-23
Only in 2.4.18pre7aa1/: 10_vm-24

	Made a bit more aggressive and less likely to swap.

Only in 2.4.18pre7aa1/: 20_balance-dirty-wait-1

	Merged a few async flushing changes from rmap12a. Arjan, can you test
	if you still get a write slowdown with this patch too? If yes, the only
	other place that can matter is sync_page_buffers, but that should be
	slower in rmap. However I wonder if this diff will slowdown a workload
	ala dbench.

Only in 2.4.18pre7aa1/: 20_pte-highmem-10
Only in 2.4.18pre4aa1: 20_pte-highmem-6

	New version of pte-highmem. Fixed lots of bugs, should be solid now. To
	compile the current -aa tree on alpha you've to backout pte-highmem-10
	first (I also just updated it partially for alpha, and infact it
	compiles but it also later crashes at boot so it's clearly not finished
	yet on the alpha update side :).

Only in 2.4.18pre4aa1: 30_dyn-sched-3
Only in 2.4.18pre7aa1/: 30_dyn-sched-4

	Fixup a compile trouble with the numa scheduler enabled.

Only in 2.4.18pre4aa1: 50_uml-patch-2.4.17-7.bz2
Only in 2.4.18pre7aa1/: 50_uml-patch-2.4.17-9.gz

	Upgrade to latest update on user-mode-linux.sourceforge.net from Jeff.

Andrea
