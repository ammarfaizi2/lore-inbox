Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130476AbRBFWGY>; Tue, 6 Feb 2001 17:06:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130473AbRBFWGP>; Tue, 6 Feb 2001 17:06:15 -0500
Received: from perninha.conectiva.com.br ([200.250.58.156]:45582 "EHLO
	perninha.conectiva.com.br") by vger.kernel.org with ESMTP
	id <S130472AbRBFWGI>; Tue, 6 Feb 2001 17:06:08 -0500
Date: Tue, 6 Feb 2001 18:16:33 -0200 (BRST)
From: Marcelo Tosatti <marcelo@conectiva.com.br>
To: Linus Torvalds <torvalds@transmeta.com>
cc: Manfred Spraul <manfred@colorfullife.com>, Jens Axboe <axboe@suse.de>,
        Ben LaHaise <bcrl@redhat.com>, Ingo Molnar <mingo@elte.hu>,
        "Stephen C. Tweedie" <sct@redhat.com>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>, Steve Lord <lord@sgi.com>,
        Linux Kernel List <linux-kernel@vger.kernel.org>,
        kiobuf-io-devel@lists.sourceforge.net, Ingo Molnar <mingo@redhat.com>
Subject: Re: [Kiobuf-io-devel] RFC: Kernel mechanism: Compound event wait
In-Reply-To: <Pine.LNX.4.10.10102061336520.1753-100000@penguin.transmeta.com>
Message-ID: <Pine.LNX.4.21.0102061814400.23574-100000@freak.distro.conectiva>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 6 Feb 2001, Linus Torvalds wrote:

> 
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
> normal operations, waiting for requests. The things that makes them
> asycnhronous is not waiting for the requests to _complete_. Which you can
> already do, trivially enough.

Reading write(2): 

       EAGAIN Non-blocking  I/O has been selected using O_NONBLOCK and there was
              no room in the pipe or socket connected to fd to  write  the data
              immediately.

I see no reason why "aio function have to block waiting for requests". 

_Why_ they do ? 

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
