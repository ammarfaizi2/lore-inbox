Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274738AbRIUBux>; Thu, 20 Sep 2001 21:50:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274737AbRIUBuo>; Thu, 20 Sep 2001 21:50:44 -0400
Received: from leibniz.math.psu.edu ([146.186.130.2]:3007 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S274736AbRIUBub>;
	Thu, 20 Sep 2001 21:50:31 -0400
Date: Thu, 20 Sep 2001 21:50:52 -0400 (EDT)
From: Alexander Viro <viro@math.psu.edu>
To: Andrea Arcangeli <andrea@suse.de>
cc: Linus Torvalds <torvalds@transmeta.com>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.4.10-pre11
In-Reply-To: <Pine.GSO.4.21.0109201905520.5631-100000@weyl.math.psu.edu>
Message-ID: <Pine.GSO.4.21.0109202146280.5631-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

	Andrea, what's the point of making blkdev_get() bump ->bd_count
in case of success and blkdev_put() - drop it?  We _do_ grab a reference
before calling blkdev_get() - any place where we don't is an immediately
oopsable hole both in the old an in the new tree.  Notice that you
do down(&bdev->bd_sem) before that increment of refcount, so if caller
doesn't hold a reference we are toast.  What's going on there?

