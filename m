Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274669AbRIUDrq>; Thu, 20 Sep 2001 23:47:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274750AbRIUDrh>; Thu, 20 Sep 2001 23:47:37 -0400
Received: from [195.223.140.107] ([195.223.140.107]:39927 "EHLO athlon.random")
	by vger.kernel.org with ESMTP id <S274748AbRIUDrZ>;
	Thu, 20 Sep 2001 23:47:25 -0400
Date: Fri, 21 Sep 2001 05:47:49 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Alexander Viro <viro@math.psu.edu>
Cc: Linus Torvalds <torvalds@transmeta.com>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.4.10-pre11
Message-ID: <20010921054749.Z729@athlon.random>
In-Reply-To: <20010921003136.H729@athlon.random> <Pine.GSO.4.21.0109201835320.5631-100000@weyl.math.psu.edu> <20010921010340.L729@athlon.random>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20010921010340.L729@athlon.random>; from andrea@suse.de on Fri, Sep 21, 2001 at 01:03:40AM +0200
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 21, 2001 at 01:03:40AM +0200, Andrea Arcangeli wrote:
> What do you prefer for the next 2.4.10 mainline? I'd like to have this

Famous last words, after a few hours of debugging mixed with vm patches
and emails, I finally got around finding the real bug. The fact is that
the secure-ramdisk logic was totally broken, not just for initrd, oh 
well, so please don't apply such patch (code in mainline has the
security issue if you allow an luser to read from /dev/ram0, but it
isn't buggy). and the issue is quite unfixable with just a PageSecure
set inside rd.c.  The fact is that I cannot just clear-around the
written "bh", around there could be the source for the next block to
write and I cannot zero it out. It is getting harder to fix this one
just inside the ->make_request callback... Hints?

Andrea
