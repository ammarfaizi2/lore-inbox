Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129655AbQK3WZb>; Thu, 30 Nov 2000 17:25:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129961AbQK3WZV>; Thu, 30 Nov 2000 17:25:21 -0500
Received: from h24-65-192-120.cg.shawcable.net ([24.65.192.120]:57330 "EHLO
	webber.adilger.net") by vger.kernel.org with ESMTP
	id <S129655AbQK3WZK>; Thu, 30 Nov 2000 17:25:10 -0500
From: Andreas Dilger <adilger@turbolinux.com>
Message-Id: <200011302154.eAULsJZ02315@webber.adilger.net>
Subject: Re: [PATCH] Re: [bug] infinite loop in generic_make_request()
In-Reply-To: <20001130214121.D18804@athlon.random> "from Andrea Arcangeli at
 Nov 30, 2000 09:41:21 pm"
To: Andrea Arcangeli <andrea@suse.de>
Date: Thu, 30 Nov 2000 14:54:19 -0700 (MST)
CC: Andreas Dilger <adilger@turbolinux.com>,
        Neil Brown <neilb@cse.unsw.edu.au>,
        Linus Torvalds <torvalds@transmeta.com>, V Ganesh <ganesh@veritas.com>,
        linux-kernel@vger.kernel.org, linux-LVM@sistina.com, mingo@redhat.com
X-Mailer: ELM [version 2.4ME+ PL73 (25)]
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrea writes:
> On Thu, Nov 30, 2000 at 01:05:53PM -0700, Andreas Dilger wrote:
> > the RAID and LVM make_request functions should be changed to do that
> > instead (i.e. 0 on success, -ve on error, and maybe "1" if they do their
> > own recursion to break the loop)?
> 
> We preferred to let the lowlevel drivers to handle error themselfs to
> simplify the interface. The lowlevel driver needs to call buffer_IO_error
> before returning in case of error.

Even if the lowlevel driver handles the error case, it would still
make more sense to stick with the normal kernel practise of -ERROR,
and 0 for success.  Then, if in the future we can do something with the
error codes, at least we don't have to change the interface yet again.
Also, it is a bit confusing, because the lvm (and md, I suppose) driver
returned "0" for success in 2.2, so now you need to special-case the
return value depending on kernel version, if you want to keep the same
code for 2.2 and 2.4.

Cheers, Andreas
-- 
Andreas Dilger  \ "If a man ate a pound of pasta and a pound of antipasto,
                 \  would they cancel out, leaving him still hungry?"
http://www-mddsp.enel.ucalgary.ca/People/adilger/               -- Dogbert
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
