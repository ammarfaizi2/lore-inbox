Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274674AbRIUEGQ>; Fri, 21 Sep 2001 00:06:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274750AbRIUEGG>; Fri, 21 Sep 2001 00:06:06 -0400
Received: from [195.223.140.107] ([195.223.140.107]:44791 "EHLO athlon.random")
	by vger.kernel.org with ESMTP id <S274674AbRIUEGC>;
	Fri, 21 Sep 2001 00:06:02 -0400
Date: Fri, 21 Sep 2001 06:06:25 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Alexander Viro <viro@math.psu.edu>
Cc: Linus Torvalds <torvalds@transmeta.com>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.4.10-pre11
Message-ID: <20010921060625.A729@athlon.random>
In-Reply-To: <20010921003136.H729@athlon.random> <Pine.GSO.4.21.0109201835320.5631-100000@weyl.math.psu.edu> <20010921010340.L729@athlon.random> <20010921054749.Z729@athlon.random>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20010921054749.Z729@athlon.random>; from andrea@suse.de on Fri, Sep 21, 2001 at 05:47:49AM +0200
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 21, 2001 at 05:47:49AM +0200, Andrea Arcangeli wrote:
> write and I cannot zero it out. It is getting harder to fix this one
> just inside the ->make_request callback... Hints?

I think the best fix is to have the ramdisk using the same aops of ramfs
and replace "Secure" with "Uptodate". We need to trap the security issue
at the higher layer and also this will avoid us having to map useless
bh, so it should be an improvement, only the filesystem will end
triggering the ->make_request callback of the ramdisk. Then if the fs
does I/O on stuff out of the physical address space we'll just clear it
out.

Andrea
