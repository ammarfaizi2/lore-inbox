Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262862AbUCXF7c (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 Mar 2004 00:59:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263010AbUCXF7c
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 Mar 2004 00:59:32 -0500
Received: from ppp-217-133-42-200.cust-adsl.tiscali.it ([217.133.42.200]:2690
	"EHLO dualathlon.random") by vger.kernel.org with ESMTP
	id S262862AbUCXF72 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 Mar 2004 00:59:28 -0500
Date: Wed, 24 Mar 2004 07:00:20 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: linux-kernel@vger.kernel.org
Subject: 2.6.5-rc2-aa2
Message-ID: <20040324060020.GA2065@dualathlon.random>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
X-PGP-Key: 1024R/CB4660B9 CC A0 71 81 F4 A0 63 AC  C0 4B 81 1D 8C 15 C8 E5
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This update covers the paging of nonlinear vmas, and the ppc
architecture (the former is well tested, the latter not but at least it
now compiles on ppc and ppc64).

The next target is the merging of the prio_tree, but that will be a
separated patch. After that this whole thing should be mergeable into
mainline.

Of course I can consider applying a filter to change 'anon_vma_t' to
'struct anon_vma' (even if I personally prefer the typedefs).

BTW, I put the set_page_dirty back into the page_map_lock because we've
to run that under the page_map_lock anyways if the pte was dirty during
swapping/paging. I mean, as far as we run it there, then we can run it
in the other s390-only places too.

URL:
	http://www.us.kernel.org/pub/linux/kernel/people/andrea/kernels/v2.6/2.6.5-rc2-aa2.gz
	http://www.us.kernel.org/pub/linux/kernel/people/andrea/kernels/v2.6/2.6.5-rc2-aa2/

Files 2.6.5-rc2-aa1/anon_vma.gz and 2.6.5-rc2-aa2/anon_vma.gz differ

	Merged Hugh's s390 fixes for physical referenced/dirty bit handling.

	Implemented nonlinear paging support. Tested with two hundred threads
	with 1.7G of shm mapped each trashing in a loop. Verified the nonlinear
	pages are swapped out and swapped in correctly. No races during high load
	so far. Nice swap behaviour is not expectable for nonlinear mappings,
	nonlinear is optimal for either small pageable mappings or big mlocked
	mappings.

	Fixed ppc/ppc64/arm compilation by merging Hugh's anobjrmap-6
	(I verified it compiles with a cross compiler but it's untested
	on real hardware).

	Avoid oopsing in fork too, if somebody forget VM_RESERVED (only warn).

	Renamd bitflag and fixed include guards per Christoph's suggestion.

Files 2.6.5-rc2-aa1/extraversion and 2.6.5-rc2-aa2/extraversion differ

	Rediffed.

Files 2.6.5-rc2-aa1/irq-safe-pagecache-lock.patch.gz and 2.6.5-rc2-aa2/irq-safe-pagecache-lock.patch.gz differ
Files 2.6.5-rc2-aa1/stop-using-dirty-pages.patch.gz and 2.6.5-rc2-aa2/stop-using-dirty-pages.patch.gz differ
Only in 2.6.5-rc2-aa1: stop-using-locked-pages-fix-2.patch.gz
Only in 2.6.5-rc2-aa1: stop-using-locked-pages-fix.patch.gz
Files 2.6.5-rc2-aa1/stop-using-locked-pages.patch.gz and 2.6.5-rc2-aa2/stop-using-locked-pages.patch.gz differ
Only in 2.6.5-rc2-aa1: tag-writeback-pages-fix.patch.gz
Only in 2.6.5-rc2-aa1: tag-writeback-pages-missing-filesystems.patch.gz
Files 2.6.5-rc2-aa1/tag-writeback-pages.patch.gz and 2.6.5-rc2-aa2/tag-writeback-pages.patch.gz differ
Files 2.6.5-rc2-aa1/unslabify-pgds-and-pmds.patch.gz and 2.6.5-rc2-aa2/unslabify-pgds-and-pmds.patch.gz differ

	Merged new versions from 2.6.5-rc2-mm1.
