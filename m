Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285421AbRLNRPR>; Fri, 14 Dec 2001 12:15:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285422AbRLNRPH>; Fri, 14 Dec 2001 12:15:07 -0500
Received: from penguin.e-mind.com ([195.223.140.120]:46689 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S285421AbRLNRPC>; Fri, 14 Dec 2001 12:15:02 -0500
Date: Fri, 14 Dec 2001 18:14:44 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: linux-kernel@vger.kernel.org
Cc: Marcelo Tosatti <marcelo@conectiva.com.br>,
        Andrew Morton <andrewm@uow.edu.au>
Subject: 2.4.17rc1aa1
Message-ID: <20011214181444.B2431@athlon.random>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.12i
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Marcelo, can you merge the loop-deadlock fix? (the others aren't
trivially mergeable yet and for the tcp conntrack you'd need to ask
Rusty first, the change is simple enough that I merged it for now)

Andrew, could you give it a spin to verify I/O performance is back? It
is fast for me now.

URL:

	ftp://ftp.us.kernel.org/pub/linux/kernel/people/andrea/kernels/v2.4/2.4.17rc1aa1.bz2
	ftp://ftp.us.kernel.org/pub/linux/kernel/people/andrea/kernels/v2.4/2.4.17rc1aa1/

Only in 2.4.17rc1aa1: 00_block-highmem-all-18b-2.bz2
Only in 2.4.17pre4aa1: 00_block-highmem-all-18b.bz2
Only in 2.4.17pre4aa1: 00_flush_icache_range-1
Only in 2.4.17rc1aa1: 00_flush_icache_range-2
Only in 2.4.17pre4aa1: 00_silent-stack-overflow-12
Only in 2.4.17rc1aa1: 00_silent-stack-overflow-13
Only in 2.4.17pre4aa1: 00_spinlock-cacheline-2
Only in 2.4.17rc1aa1: 00_spinlock-cacheline-3
Only in 2.4.17pre4aa1: 10_numa-sched-14
Only in 2.4.17rc1aa1: 10_numa-sched-15
Only in 2.4.17pre4aa1: 60_atomic-alloc-6
Only in 2.4.17rc1aa1: 60_atomic-alloc-7

	Rediffed.

Only in 2.4.17pre4aa1: 00_rwsem-fair-25-recursive-6
Only in 2.4.17rc1aa1: 00_rwsem-fair-25-recursive-7

	Not used actively anymore for the coredump (we walk the pagetables
	by hand instead of using the MMU now).

Only in 2.4.17rc1aa1: 00_loop-deadlock-1

	Fixed loop deadlock (balance_dirty() must not be called within the
	request_fn or it can deadlock or recurse way too much). It is
	enough to recall balance_dirty() at the highest layer so this won't
	introduce any stability problem.

Only in 2.4.17rc1aa1: 00_tcp-conntrack-fin-1

	After upgrading my firewall/NAT to 2.4 (s/ipchains/iptables/ :) I started
	getting valid tcp packets dropped/logged (I'm allowing only RELATED and
	ESTABLISHED packets from the outside, with ipchains I was allowing all
	tcp packets that weren't syn and there weren't problems). Rusty sent me
	the above fix to see if my problem with the tcp connection tracking
	goes away (without adding again the rule that all non tcp syn can came in).

Only in 2.4.17pre4aa1: 10_vm-19
Only in 2.4.17rc1aa1: 10_vm-20

	Should fix the I/O async flushing performance drop reported by Andrew.
	Cannot += BUF_LOCKED any longer in balance_dirty because we don't waste
	time any longer refiling clean buffers into the BUF_CLEAN now (sync has to
	pass all over the bh anyways so it doesn't matter for it either).
	Avoid collapsing the max_mapped during shrink_cache internal passes.

Only in 2.4.17pre4aa1: 50_uml-patch-2.4.15-3.bz2
Only in 2.4.17rc1aa1: 50_uml-patch-2.4.16-2.bz2

	Latest update from Jeff at user-mode-linux.sourceforge.net.

Only in 2.4.17pre4aa1: 60_tux-2.4.16-final-C9.bz2
Only in 2.4.17rc1aa1: 60_tux-2.4.16-final-D5.bz2

	Latest update from Ingo at www.redhat.com/~mingo/.

Andrea
