Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129697AbRBFV5e>; Tue, 6 Feb 2001 16:57:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129786AbRBFV50>; Tue, 6 Feb 2001 16:57:26 -0500
Received: from colorfullife.com ([216.156.138.34]:2057 "EHLO colorfullife.com")
	by vger.kernel.org with ESMTP id <S129697AbRBFV5L>;
	Tue, 6 Feb 2001 16:57:11 -0500
Message-ID: <3A80733E.A570B6C7@colorfullife.com>
Date: Tue, 06 Feb 2001 22:57:18 +0100
From: Manfred Spraul <manfred@colorfullife.com>
X-Mailer: Mozilla 4.75 [en] (X11; U; Linux 2.2.16-22 i586)
X-Accept-Language: en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@transmeta.com>
CC: Jens Axboe <axboe@suse.de>, Ben LaHaise <bcrl@redhat.com>,
        Ingo Molnar <mingo@elte.hu>, "Stephen C. Tweedie" <sct@redhat.com>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>, Steve Lord <lord@sgi.com>,
        Linux Kernel List <linux-kernel@vger.kernel.org>,
        kiobuf-io-devel@lists.sourceforge.net, Ingo Molnar <mingo@redhat.com>
Subject: Re: [Kiobuf-io-devel] RFC: Kernel mechanism: Compound event wait
In-Reply-To: <Pine.LNX.4.10.10102061336520.1753-100000@penguin.transmeta.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds wrote:
> 
> On Tue, 6 Feb 2001, Manfred Spraul wrote:
> > Jens Axboe wrote:
> > >
> > > > Several kernel functions need a "dontblock" parameter (or a callback, or
> > > > a waitqueue address, or a tq_struct pointer).
> > >
> > > We don't even need that, non-blocking is implicitly applied with READA.
> > >
> > READA just returns - I doubt that the aio functions should poll until
> > there are free entries in the request queue.
> 
> The aio functions should NOT use READA/WRITEA. They should just use the
> normal operations, waiting for requests.

But then you end with lots of threads blocking in get_request()

Quoting Ben's mail:
<<<<<<<<<
> 
> =)  This is what I'm seeing: lots of processes waiting with wchan ==
> __get_request_wait.  With async io and a database flushing lots of io
> asynchronously spread out across the disk, the NR_REQUESTS limit is hit
> very quickly.
> 
>>>>>>>>>

On an io bound server the request queue is always full - waiting for the
next request might take longer than the actual io.

--
	Manfred
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
