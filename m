Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262632AbREOE7x>; Tue, 15 May 2001 00:59:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262634AbREOE7n>; Tue, 15 May 2001 00:59:43 -0400
Received: from leibniz.math.psu.edu ([146.186.130.2]:3055 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S262632AbREOE7X>;
	Tue, 15 May 2001 00:59:23 -0400
Date: Tue, 15 May 2001 00:59:20 -0400 (EDT)
From: Alexander Viro <viro@math.psu.edu>
To: Larry McVoy <lm@bitmover.com>
cc: Linus Torvalds <torvalds@transmeta.com>,
        Richard Gooch <rgooch@ras.ucalgary.ca>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Getting FS access events
In-Reply-To: <20010514213516.A15744@work.bitmover.com>
Message-ID: <Pine.GSO.4.21.0105150039560.19333-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 14 May 2001, Larry McVoy wrote:

> Hell, that's the OS that gave us mmap, remember that?  

"I got it from Agnes..."

Don't get me wrong, SunOS 4 was probably the nicest thing Sun had ever
released and I love it, but mmap(2) was _not_ the best of ideas. Files
as streams of bytes and files as persistent segments really do not mix
well. If you still have their source check the effects of write() from
mmaped area. Especially when you play with unaligned stuff.

Said that, in all sane cases we want indexing by (vnode,offset), not by
(device,block number). We _certainly_ don't want uncontrolled readahead
on block level. E.g. because we might have just allocated a new block
and are busy filling it with data we want to write. The last thing we
want is some fsckwit overwriting it with crap we have on disk. And that's
what such readahead is.

Besides, just how often do you reboot the box? If that's the hotspot for
you - when the hell does the boor beast find time to do something useful?

