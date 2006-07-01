Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751195AbWGAW3R@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751195AbWGAW3R (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 1 Jul 2006 18:29:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751202AbWGAW3R
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 1 Jul 2006 18:29:17 -0400
Received: from mx2.suse.de ([195.135.220.15]:53677 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1751195AbWGAW3Q (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 1 Jul 2006 18:29:16 -0400
From: Neil Brown <neilb@suse.de>
To: Andrew Morton <akpm@osdl.org>
Date: Sun, 2 Jul 2006 08:29:04 +1000
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17574.63280.655747.111167@cse.unsw.edu.au>
Cc: Grant Wilson <grant.wilson@zen.co.uk>, linux-kernel@vger.kernel.org,
       linux-scsi@vger.kernel.org
Subject: More RAID / SATA / barrier problems [ Re: 2.6.17-mm5 ]
In-Reply-To: message from Andrew Morton on Saturday July 1
References: <20060701033524.3c478698.akpm@osdl.org>
	<20060701142419.GB28750@tlg.swandive.local>
	<20060701143047.b3975472.akpm@osdl.org>
X-Mailer: VM 7.19 under Emacs 21.4.1
X-face: v[Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday July 1, akpm@osdl.org wrote:
> 
> mddev->pers is NULL in md_error(), so the test of
> !mddev->pers->error_handler oopsed.  Perhaps this is a real MD bug which is
> now being exposed by the new barrier-handling problem.
> 

Yes, this is a real MD bug which would hit whenever writing a
superblock fails during array-shutdown.  I guess that has never
happened before!  The work around you propose is probably as good as
any, but I'll think through it some more and see.

It seems that super block writes are always failing in some
configurations at the moment!

I wonder what we *should* do when writing to the superblock on the
last device of a raid1 faills... maybe switch the array to read-only?
I'll have a think about that too.

But we need to find out why barrier-writes are returning EIO.
Hopefully Reuben's testing will shed some light.

NeilBrown
