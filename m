Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261389AbUDCByd (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Apr 2004 20:54:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261425AbUDCByd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Apr 2004 20:54:33 -0500
Received: from ppp-217-133-42-200.cust-adsl.tiscali.it ([217.133.42.200]:6530
	"EHLO dualathlon.random") by vger.kernel.org with ESMTP
	id S261389AbUDCByb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Apr 2004 20:54:31 -0500
Date: Sat, 3 Apr 2004 03:54:27 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: linux-kernel@vger.kernel.org
Subject: 2.6.5-rc3-aa3
Message-ID: <20040403015427.GA2307@dualathlon.random>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
X-PGP-Key: 1024R/CB4660B9 CC A0 71 81 F4 A0 63 AC  C0 4B 81 1D 8C 15 C8 E5
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

this avoids (harmless) warnings while freeing non-compound pages, adds
some more robustness check to the freelist by making sure no page has
PG_compound set, and most important it adds merging for filebacked
mappings and anonymous mappings in mprotect. I'm running it on my main
desktop and there are no problems so far.

I believe the VM side is feature complete, in order:

-----------
[..]
# -aa VM (remove rmap)
objrmap-core
anon-vma
prio-tree
gfp-no-compound
mprotect-vma-merging
-----------

Two pending thing to clarify are swapsuspend/swapresume (works partially
for me because aic7xxx isn't swap-resume capable), and Christoph's xfs
oops on ppc that looks a miscompilation of some sort.

URL:

	http://www.us.kernel.org/pub/linux/kernel/people/andrea/kernels/v2.6/2.6.5-rc3-aa3.gz
	http://www.us.kernel.org/pub/linux/kernel/people/andrea/kernels/v2.6/2.6.5-rc3-aa3/

Changelog diff between 2.6.5-rc3-aa2 and 2.6.5-rc3-aa3:

Files 2.6.5-rc3-aa2/extraversion and 2.6.5-rc3-aa3/extraversion differ

	Rediffed.

Files 2.6.5-rc3-aa2/gfp-no-compound and 2.6.5-rc3-aa3/gfp-no-compound differ

	Avoid flood of warnings while freeing a non-compound multipage.
	Added bugchecks to be sure all pages in the freelist have PG_compound
	unset (for robusteness, the check for PG_compound is zerocost anyways
	since we check it in a bitmask).

	Christoph's troubles with ppc seems to be a gcc miscompilation if it's
	really the second bad_page in destroy_compound_page triggering.

	The swap suspend/swap resume works for me w/o apparent VM issues,
	aic7xxx simply hangs at resume, but Pavel said it's expected. I'll
	later try to load it on my laptop and see if I've more luck with it.

Only in 2.6.5-rc3-aa3: mprotect-vma-merging

	Resurrected mprotect anon-vma and file-backed merging. The file-backed
	merging is IMHO the most interesting one, and it's for the first time
	available in linux.

Files 2.6.5-rc3-aa2/prio-tree.gz and 2.6.5-rc3-aa3/prio-tree.gz differ

	Added s390 compilation fix.
