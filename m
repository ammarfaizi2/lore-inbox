Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263269AbTJVBCi (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Oct 2003 21:02:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263277AbTJVBCe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Oct 2003 21:02:34 -0400
Received: from ppp-217-133-42-200.cust-adsl.tiscali.it ([217.133.42.200]:54174
	"EHLO velociraptor.random") by vger.kernel.org with ESMTP
	id S263269AbTJVBCd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Oct 2003 21:02:33 -0400
Date: Wed, 22 Oct 2003 03:03:10 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Neil Brown <neilb@cse.unsw.edu.au>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: Strange dcache memory pressure when highmem enabled
Message-ID: <20031022010310.GD12013@velociraptor.random>
References: <16268.52761.907998.436272@notabene.cse.unsw.edu.au> <20031014224352.0171e971.akpm@osdl.org> <20031016133304.GC1348@velociraptor.random> <16277.47600.3243.275778@notabene.cse.unsw.edu.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <16277.47600.3243.275778@notabene.cse.unsw.edu.au>
User-Agent: Mutt/1.4.1i
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
X-PGP-Key: 1024R/CB4660B9 CC A0 71 81 F4 A0 63 AC  C0 4B 81 1D 8C 15 C8 E5
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 22, 2003 at 08:57:52AM +1000, Neil Brown wrote:
> I didn't end up trying Andrew's patch, but tried 2.4.23-pre7 instead.
> It appears to be doing the right thing.
> Free Highmem (grep HighFree /proc/meminfo) steadily dropped from 3Gig
> to about 2-3 Meg and stayed there.
> The dentry cache (grep dentry_cache /proc/slabinfo) climbed up to
> about 500,000 and stayed there for 24 hours - much better than before
> where it would often be only a few thousand and we had complaints every
> night when the backups ran.

sounds good. And unless I misread something Andrew's patch shrinking
lowmem only for highmem allocation definitely looks wrong and it would
be DoSable as well.

As for 2.4 mainline there's some bit of refill_inactive still not fully
classzone aware, it's the half merge bit mentioned earlier on the list
that also introduced a typo kind of bug. My tree is fully aware instead
to avoid falling apart on the 32G boxes in production. Those secondary
bits in refill_inactive should be merged in mainline too over time.

Anyways for a 1G machine (or maybe with 2G too), those bits could hardly
make any difference, I assume your highmem/lowmem ratio isn't too high.

thanks,

Andrea - If you prefer relying on open source software, check these links:
	    rsync.kernel.org::pub/scm/linux/kernel/bkcvs/linux-2.[45]/
	    http://www.cobite.com/cvsps/
