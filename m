Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129098AbRBHNbJ>; Thu, 8 Feb 2001 08:31:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129486AbRBHNa7>; Thu, 8 Feb 2001 08:30:59 -0500
Received: from zeus.kernel.org ([209.10.41.242]:26338 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id <S129098AbRBHNan>;
	Thu, 8 Feb 2001 08:30:43 -0500
Date: Thu, 8 Feb 2001 13:22:18 +0000
From: "Stephen C. Tweedie" <sct@redhat.com>
To: Pavel Machek <pavel@suse.cz>
Cc: Linus Torvalds <torvalds@transmeta.com>, Jens Axboe <axboe@suse.de>,
        Marcelo Tosatti <marcelo@conectiva.com.br>,
        Manfred Spraul <manfred@colorfullife.com>,
        Ben LaHaise <bcrl@redhat.com>, Ingo Molnar <mingo@elte.hu>,
        "Stephen C. Tweedie" <sct@redhat.com>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>, Steve Lord <lord@sgi.com>,
        Linux Kernel List <linux-kernel@vger.kernel.org>,
        kiobuf-io-devel@lists.sourceforge.net, Ingo Molnar <mingo@redhat.com>
Subject: Re: [Kiobuf-io-devel] RFC: Kernel mechanism: Compound event wait
Message-ID: <20010208132218.E9130@redhat.com>
In-Reply-To: <20010206230929.K2975@suse.de> <Pine.LNX.4.10.10102061421490.1825-100000@penguin.transmeta.com> <20010208001513.B189@bug.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2i
In-Reply-To: <20010208001513.B189@bug.ucw.cz>; from pavel@suse.cz on Thu, Feb 08, 2001 at 12:15:13AM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, Feb 08, 2001 at 12:15:13AM +0100, Pavel Machek wrote:
> 
> > EAGAIN is _not_ a valid return value for block devices or for regular
> > files. And in fact it _cannot_ be, because select() is defined to always
> > return 1 on them - so if a write() were to return EAGAIN, user space would
> > have nothing to wait on. Busy waiting is evil.
> 
> So you consider inability to select() on regular files _feature_?

Select might make some sort of sense for sequential access to files,
and for random access via lseek/read but it makes no sense at all for
pread and pwrite where select() has no idea _which_ part of the file
the user is going to want to access next.

> How do you write high-performance ftp server without threads if select
> on regular file always returns "ready"?

Select can work if the access is sequential, but async IO is a more
general solution.

Cheers,
 Stephen
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
