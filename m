Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030374AbWILTZT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030374AbWILTZT (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Sep 2006 15:25:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030373AbWILTZS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Sep 2006 15:25:18 -0400
Received: from 1wt.eu ([62.212.114.60]:35346 "EHLO 1wt.eu")
	by vger.kernel.org with ESMTP id S1030324AbWILTZR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Sep 2006 15:25:17 -0400
Date: Tue, 12 Sep 2006 21:17:36 +0200
From: Willy Tarreau <w@1wt.eu>
To: "Jurzitza, Dieter" <DJurzitza@harmanbecker.com>, davem@davemloft.net
Cc: linux-kernel@vger.kernel.org, Jeff Mahoney <jeffm@suse.com>,
       sparclinux@vger.kernel.org
Subject: Re: fix 2.4.33.3 / sun partition size
Message-ID: <20060912191736.GG541@1wt.eu>
References: <DA6197CAE190A847B662079EF7631C06015692C2@OEKAW2EXVS03.hbi.ad.harman.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DA6197CAE190A847B662079EF7631C06015692C2@OEKAW2EXVS03.hbi.ad.harman.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 12, 2006 at 01:23:56PM +0200, Jurzitza, Dieter wrote:
> Kernel: 2.4.33
> 
> Issue: really fix size display for sun partitions larger than 1TByte
> 
> Signed off by: Dieter Jurzitza DJurzitza@HarmanBecker.com
> 
> Problem: the last fix introduced by Jeff Mahoney for kernel 2.6 was not complete for kernel 2.4 (as applied)
> I found out that add_gd_partition is called by any type of partition (2.4). add_gd_partition is defined as add_gd_partition (int, int), what makes no sense to me as negative numbers should never occur here. As long as add_gd_partition is not changed to add_gd_partition (unsigned, unsigned), /proc/partitions will keep showing negative numbers.

It seems fair. David, what's your opinion ?

> If ever someone could look into this, within the different partition type files in linux/fs/partitions the parameters to add_gd_partitions seem to be chosen arbitrarily between int, unsigned and unsigned long, whatever seemed to be appropriate, I think it would make sense to get consistent parameters to add_gd_partition from all partition types here.
> Especially if one takes into account that sizeof (long) and sizeof (int) may differ significantly i. e. on sparc.

It would really depend on the on-disk format. If the partition table really
stores 32 bit ints for sector counts, there's no point switching from ints
to longs. But if it already stores 64 bits, then we're limiting it to 2 TB
with 32 bit ints. I haven't checked the code right now, so I don't know. I
hope Davem will enlighten us on this matter.

> Take care
> 
> 
> Dieter Jurzitza

Thanks,
Willy

