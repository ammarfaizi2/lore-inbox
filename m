Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262560AbVDYJsH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262560AbVDYJsH (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Apr 2005 05:48:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262563AbVDYJsH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Apr 2005 05:48:07 -0400
Received: from vsmtp4.tin.it ([212.216.176.224]:58045 "EHLO vsmtp4.tin.it")
	by vger.kernel.org with ESMTP id S262560AbVDYJsB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Apr 2005 05:48:01 -0400
To: Daniel Drake <dsd@gentoo.org>
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org,
       viro@parcelfarce.linux.theplanet.co.uk, helge.hafting@hist.no,
       opengeometry@yahoo.ca
Subject: Re: rootdelay
References: <87wtrphuvj.fsf@dedasys.com> <424D929A.2030801@gentoo.org>
From: davidw@dedasys.com (David N. Welton)
Date: 25 Apr 2005 11:45:59 +0200
In-Reply-To: <424D929A.2030801@gentoo.org>
Message-ID: <87pswjur3c.fsf@dedasys.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Daniel Drake <dsd@gentoo.org> writes:

[ Please CC replies to me - thanks! ]

> Hi David,

> David N. Welton wrote:

> > [ Please CC replies to me, thanks! ]

> > Hi, I was looking at your patch:

> > http://lkml.org/lkml/2005/1/21/132 Very small, which is nice.  I

> > was wondering if there were any interest in my own efforts in that
> > direction:

> > http://dedasys.com/freesoftware/patches/blkdev_wakeup.patch which

> > is far more intrusive, and perhaps isn't good kernel programming
> > style, but, on the other hand, is the optimal solution in terms of
> > boot time because it wakes up the boot process right when the
> > device comes on line.  Since I saw your patch included, it looks
> > like there is interest in this, and I'd toot my own horn once more
> > before just leaving my patch to the bit rot of the ages...
> > Thanks!

> As simple as it may be, it's a bit of a shame that we actually need
> rootdelay as its something that the kernel should do
> automatically. At the time when we last discussed it, we didn't come
> up with a better (and safe) way to handle it, but I don't think we
> considered anything like your implementation.

> I've CC'd a few people who were involved the last time around to see
> if they have any input for you.

Thanks!  I don't wish to be a pest, but not having heard a "no", I'll
send another ping out.  Perhaps a simple description is better than
the patch for busy people:

    In init/do_mounts.c, mount_root does an interruptible_sleep_on a
    wait queue, and goes on about its business after register_blkdev
    in drivers/block/genhd.c does a wake_up_interruptible on it, so
    that mounting the root device happens exactly when it needs to, no
    sooner, no later, and doesn't depend on any fiddly timing issues.

Thankyou,
-- 
David N. Welton
 - http://www.dedasys.com/davidw/

Apache, Linux, Tcl Consulting
 - http://www.dedasys.com/
