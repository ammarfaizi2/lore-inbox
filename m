Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280149AbRKSX2L>; Mon, 19 Nov 2001 18:28:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280203AbRKSX2B>; Mon, 19 Nov 2001 18:28:01 -0500
Received: from h24-78-175-24.nv.shawcable.net ([24.78.175.24]:51587 "EHLO
	oof.localnet") by vger.kernel.org with ESMTP id <S280149AbRKSX1w>;
	Mon, 19 Nov 2001 18:27:52 -0500
Date: Mon, 19 Nov 2001 15:27:45 -0800
From: Simon Kirby <sim@netnation.com>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Andrea Arcangeli <andrea@suse.de>, linux-kernel@vger.kernel.org
Subject: Re: VM-related Oops: 2.4.15pre1
Message-ID: <20011119152745.A27716@netnation.com>
In-Reply-To: <20011119095631.A24617@netnation.com> <Pine.LNX.4.33.0111190958230.8205-100000@penguin.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.33.0111190958230.8205-100000@penguin.transmeta.com>
User-Agent: Mutt/1.3.23i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 19, 2001 at 10:03:34AM -0800, Linus Torvalds wrote:

> It looks like it's a bog-standard page, that was just free'd (probably
> because of page->count corruption) while it was still in the page cache.
> Now, how that page->count corruption actually happened, I have no idea,
> which is why I suspect you had other earlier oopses that left the machine
> in an inconsistent state.

Well, I found out what file has the bog-standard page.

open("/home/stevendi//.htaccess", O_RDONLY|O_LARGEFILE) = 4
fstat64(0x4, 0x80ea000)                 = 0
fcntl(4, F_SETFD, FD_CLOEXEC)           = 0
fstat64(0x4, 0xbfffd878)                = 0
old_mmap(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) = 0x401d3000
read(4,  <unfinished ...>
+++ killed by SIGSEGV +++

Every time that file is read, it Oopses.  It would probably be quite
difficult to find something that would exploit a kernel race on this
particular file (they are very rarely modified).

I suppose rebooting would be the only way to get rid of the broken page,
as it doesn't seem to have cleared up by itself.

Simon-

[  Stormix Technologies Inc.  ][  NetNation Communications Inc. ]
[       sim@stormix.com       ][       sim@netnation.com        ]
[ Opinions expressed are not necessarily those of my employers. ]
