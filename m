Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267879AbRHASHM>; Wed, 1 Aug 2001 14:07:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267878AbRHASHD>; Wed, 1 Aug 2001 14:07:03 -0400
Received: from h24-64-71-161.cg.shawcable.net ([24.64.71.161]:47864 "EHLO
	webber.adilger.int") by vger.kernel.org with ESMTP
	id <S267857AbRHASGu>; Wed, 1 Aug 2001 14:06:50 -0400
From: Andreas Dilger <adilger@turbolinux.com>
Message-Id: <200108011806.f71I6Ht1006946@webber.adilger.int>
Subject: Re: Disk quotas not staying in sync?
In-Reply-To: <Pine.LNX.4.31.0108011322470.4569-100000@rc.priv.hereintown.net>
 "from Chris Meadors at Aug 1, 2001 01:43:23 pm"
To: Chris Meadors <clubneon@hereintown.net>
Date: Wed, 1 Aug 2001 12:06:17 -0600 (MDT)
CC: linux-kernel <linux-kernel@vger.kernel.org>
X-Mailer: ELM [version 2.4ME+ PL87 (25)]
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Chris writes:
> The problem is sometimes after all the messages have been deleted they
> still can't get any new mail.  Looking at their quota usage the machine
> still thinks that they have their quota full, but `du` says otherwise.
> 
> I've tried to reproduce this with a test account.  Just creating a bunch
> of files to run up to the quota and then deleting them.  But no matter
> what I tried the system followed the test account's disk usage exactly.

Maybe the problem is caused by root/admin deleting another users files?

> This doesn't just happen when someone runs up to their quota.  I have also
> seen their quota usage not correctly reflect what is on disk, but as the
> usage goes up and down, both the actual disk usage and the what quota says
> change by the same amount.

Do you run quotacheck at boot time?  It is possible with ext2 that the
on-disk quotas are not in sync with the actual files if there is a crash.
If you use ext3 then the quota updates and other filesystem updates are
kept atomic.

> Any ideas?  This machine is pretty much standard.  ext2 file systems on
> all partitions.  /home is the only one with user disk quotas.  Running
> 2.4.7 kernel (but I've seen it in all 2.4 kernels, I was running
> 2.4.0-prerelease on the machine when I first put it up, so I don't know
> how 2.2 works).

You should also try the -ac kernels.  I'm pretty sure that they have
some fixes to the quota code.  However, I _think_ the changes are not
compatible with the non-ac kernel quota on-disk data, so you will have
to re-build the quota files (a small price to pay if it actually works).

Cheers, Andreas
-- 
Andreas Dilger  \ "If a man ate a pound of pasta and a pound of antipasto,
                 \  would they cancel out, leaving him still hungry?"
http://www-mddsp.enel.ucalgary.ca/People/adilger/               -- Dogbert

