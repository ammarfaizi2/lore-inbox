Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129144AbRBHRN6>; Thu, 8 Feb 2001 12:13:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129741AbRBHRNs>; Thu, 8 Feb 2001 12:13:48 -0500
Received: from green.csi.cam.ac.uk ([131.111.8.57]:19647 "EHLO
	green.csi.cam.ac.uk") by vger.kernel.org with ESMTP
	id <S129144AbRBHRN2>; Thu, 8 Feb 2001 12:13:28 -0500
Date: Thu, 8 Feb 2001 17:13:10 +0000 (GMT)
From: James Sutherland <jas88@cam.ac.uk>
To: Rik van Riel <riel@conectiva.com.br>
cc: Mikulas Patocka <mikulas@artax.karlin.mff.cuni.cz>,
        Marcelo Tosatti <marcelo@conectiva.com.br>,
        "Stephen C. Tweedie" <sct@redhat.com>, Pavel Machek <pavel@suse.cz>,
        Linus Torvalds <torvalds@transmeta.com>, Jens Axboe <axboe@suse.de>,
        Manfred Spraul <manfred@colorfullife.com>,
        Ben LaHaise <bcrl@redhat.com>, Ingo Molnar <mingo@elte.hu>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>, Steve Lord <lord@sgi.com>,
        Linux Kernel List <linux-kernel@vger.kernel.org>,
        kiobuf-io-devel@lists.sourceforge.net, Ingo Molnar <mingo@redhat.com>
Subject: Re: [Kiobuf-io-devel] RFC: Kernel mechanism: Compound event wait
In-Reply-To: <Pine.LNX.4.21.0102081456030.2378-100000@duckman.distro.conectiva>
Message-ID: <Pine.SOL.4.21.0102081711200.11832-100000@green.csi.cam.ac.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 8 Feb 2001, Rik van Riel wrote:

> On Thu, 8 Feb 2001, Mikulas Patocka wrote:
> 
> > > > You need aio_open.
> > > Could you explain this? 
> > 
> > If the server is sending many small files, disk spends huge
> > amount time walking directory tree and seeking to inodes. Maybe
> > opening the file is even slower than reading it
> 
> Not if you have a big enough inode_cache and dentry_cache.

Eh? However big the caches are, you can still get misses which will
require multiple (blocking) disk accesses to handle...

> OTOH ... if you have enough memory the whole async IO argument
> is moot anyway because all your files will be in memory too.

Only for cache hits. If you're doing a Mindcraft benchmark or something
with everything in RAM, you're fine - for real world servers, that's not
really an option ;-)

Really, you want/need cache MISSES to be handled without blocking. However
big the caches, short of running EVERYTHING from a ramdisk, these will
still happen!


James.

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
