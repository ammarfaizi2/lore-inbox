Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274748AbRIUEAg>; Fri, 21 Sep 2001 00:00:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274749AbRIUEA1>; Fri, 21 Sep 2001 00:00:27 -0400
Received: from leibniz.math.psu.edu ([146.186.130.2]:5116 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S274748AbRIUEAL>;
	Fri, 21 Sep 2001 00:00:11 -0400
Date: Fri, 21 Sep 2001 00:00:35 -0400 (EDT)
From: Alexander Viro <viro@math.psu.edu>
To: Andrea Arcangeli <andrea@suse.de>
cc: Linus Torvalds <torvalds@transmeta.com>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.4.10-pre11
In-Reply-To: <20010921054749.Z729@athlon.random>
Message-ID: <Pine.GSO.4.21.0109202350190.5631-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 21 Sep 2001, Andrea Arcangeli wrote:

> Famous last words, after a few hours of debugging mixed with vm patches
> and emails, I finally got around finding the real bug. The fact is that
> the secure-ramdisk logic was totally broken, not just for initrd, oh 
> well, so please don't apply such patch (code in mainline has the
> security issue if you allow an luser to read from /dev/ram0, but it
> isn't buggy). and the issue is quite unfixable with just a PageSecure
> set inside rd.c.  The fact is that I cannot just clear-around the
> written "bh", around there could be the source for the next block to
> write and I cannot zero it out. It is getting harder to fix this one
> just inside the ->make_request callback... Hints?

Well, taking a file on ramfs and doing losetup on it should be equivalent
to ramdisk.  Turning relevant pieces into a driver shouldn't be too hard.
It won't be pretty, though - you'll probably want different
address_space_operations, so that read()/write() wouldn't bother with
requests at all.

