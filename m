Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030277AbWILWRQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030277AbWILWRQ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Sep 2006 18:17:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030367AbWILWRP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Sep 2006 18:17:15 -0400
Received: from mx1.redhat.com ([66.187.233.31]:61867 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1030361AbWILWRO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Sep 2006 18:17:14 -0400
Subject: Re: fix 2.4.33.3 / sun partition size
From: "Tom 'spot' Callaway" <tcallawa@redhat.com>
To: Willy Tarreau <w@1wt.eu>
Cc: "Jurzitza, Dieter" <DJurzitza@harmanbecker.com>, davem@davemloft.net,
       linux-kernel@vger.kernel.org, Jeff Mahoney <jeffm@suse.com>,
       sparclinux@vger.kernel.org
In-Reply-To: <20060912191736.GG541@1wt.eu>
References: <DA6197CAE190A847B662079EF7631C06015692C2@OEKAW2EXVS03.hbi.ad.harman.com>
	 <20060912191736.GG541@1wt.eu>
Content-Type: text/plain
Organization: Red Hat
Date: Tue, 12 Sep 2006 17:17:08 -0500
Message-Id: <1158099428.13234.232.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.0 (2.8.0-1.fc6) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2006-09-12 at 21:17 +0200, Willy Tarreau wrote:
> On Tue, Sep 12, 2006 at 01:23:56PM +0200, Jurzitza, Dieter wrote:
> > Kernel: 2.4.33
> > 
> > Issue: really fix size display for sun partitions larger than 1TByte
> > 
> > Signed off by: Dieter Jurzitza DJurzitza@HarmanBecker.com
> > 
> > Problem: the last fix introduced by Jeff Mahoney for kernel 2.6 was not complete for kernel 2.4 (as applied)
> > I found out that add_gd_partition is called by any type of partition (2.4). add_gd_partition is defined as add_gd_partition (int, int), what makes no sense to me as negative numbers should never occur here. As long as add_gd_partition is not changed to add_gd_partition (unsigned, unsigned), /proc/partitions will keep showing negative numbers.
> 
> It seems fair. David, what's your opinion ?
> 
> > If ever someone could look into this, within the different partition type files in linux/fs/partitions the parameters to add_gd_partitions seem to be chosen arbitrarily between int, unsigned and unsigned long, whatever seemed to be appropriate, I think it would make sense to get consistent parameters to add_gd_partition from all partition types here.
> > Especially if one takes into account that sizeof (long) and sizeof (int) may differ significantly i. e. on sparc.
> 
> It would really depend on the on-disk format. If the partition table really
> stores 32 bit ints for sector counts, there's no point switching from ints
> to longs. But if it already stores 64 bits, then we're limiting it to 2 TB
> with 32 bit ints. I haven't checked the code right now, so I don't know. I
> hope Davem will enlighten us on this matter.

I think Davem may be on vacation...

~spot
-- 
Tom "spot" Callaway || Red Hat || Fedora || Aurora || GPG ID: 93054260

"We must not confuse dissent with disloyalty. We must remember always
that accusation is not proof and that conviction depends upon evidence
and due process of law. We will not walk in fear, one of another. We
will not be driven by fear into an age of unreason, if we dig deep in
our history and our doctrine, and remember that we are not descended
from fearful men -- not from men who feared to write, to speak, to
associate and to defend causes that were, for the moment, unpopular."
-- Edward R. Murrow, March 9, 1954

