Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263427AbTJUW6H (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Oct 2003 18:58:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263432AbTJUW6H
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Oct 2003 18:58:07 -0400
Received: from note.orchestra.cse.unsw.EDU.AU ([129.94.242.24]:38086 "HELO
	note.orchestra.cse.unsw.EDU.AU") by vger.kernel.org with SMTP
	id S263427AbTJUW6F (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Oct 2003 18:58:05 -0400
From: Neil Brown <neilb@cse.unsw.edu.au>
To: Andrea Arcangeli <andrea@suse.de>
Date: Wed, 22 Oct 2003 08:57:52 +1000
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16277.47600.3243.275778@notabene.cse.unsw.edu.au>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: Strange dcache memory pressure when highmem enabled
In-Reply-To: message from Andrea Arcangeli on Thursday October 16
References: <16268.52761.907998.436272@notabene.cse.unsw.edu.au>
	<20031014224352.0171e971.akpm@osdl.org>
	<20031016133304.GC1348@velociraptor.random>
X-Mailer: VM 7.17 under Emacs 21.3.1
X-face: [Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday October 16, andrea@suse.de wrote:
> 
> I wonder if what he's suffering from is a reduced normal zone due the
> mem_map_t being larger. The reduced normal zone will trigger the dcache
> shrinking more frequently. But he may want to try again with 2.4.23pre7
> with a classzone aware refill_inactive that will ensure the inactive
> list has enough lowmem pages before shrink_caches claims failure.
> 

I didn't end up trying Andrew's patch, but tried 2.4.23-pre7 instead.
It appears to be doing the right thing.
Free Highmem (grep HighFree /proc/meminfo) steadily dropped from 3Gig
to about 2-3 Meg and stayed there.
The dentry cache (grep dentry_cache /proc/slabinfo) climbed up to
about 500,000 and stayed there for 24 hours - much better than before
where it would often be only a few thousand and we had complaints every
night when the backups ran.

Thanks.

NeilBrown
