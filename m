Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130473AbRBFWKp>; Tue, 6 Feb 2001 17:10:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130472AbRBFWK0>; Tue, 6 Feb 2001 17:10:26 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:36882 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S130272AbRBFWKX>;
	Tue, 6 Feb 2001 17:10:23 -0500
Date: Tue, 6 Feb 2001 23:09:29 +0100
From: Jens Axboe <axboe@suse.de>
To: Marcelo Tosatti <marcelo@conectiva.com.br>
Cc: Linus Torvalds <torvalds@transmeta.com>,
        Manfred Spraul <manfred@colorfullife.com>,
        Ben LaHaise <bcrl@redhat.com>, Ingo Molnar <mingo@elte.hu>,
        "Stephen C. Tweedie" <sct@redhat.com>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>, Steve Lord <lord@sgi.com>,
        Linux Kernel List <linux-kernel@vger.kernel.org>,
        kiobuf-io-devel@lists.sourceforge.net, Ingo Molnar <mingo@redhat.com>
Subject: Re: [Kiobuf-io-devel] RFC: Kernel mechanism: Compound event wait
Message-ID: <20010206230929.K2975@suse.de>
In-Reply-To: <Pine.LNX.4.10.10102061336520.1753-100000@penguin.transmeta.com> <Pine.LNX.4.21.0102061814400.23574-100000@freak.distro.conectiva>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.21.0102061814400.23574-100000@freak.distro.conectiva>; from marcelo@conectiva.com.br on Tue, Feb 06, 2001 at 06:16:33PM -0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 06 2001, Marcelo Tosatti wrote:
> > > > We don't even need that, non-blocking is implicitly applied with READA.
> > > >
> > > READA just returns - I doubt that the aio functions should poll until
> > > there are free entries in the request queue.
> > 
> > The aio functions should NOT use READA/WRITEA. They should just use the
> > normal operations, waiting for requests. The things that makes them
> > asycnhronous is not waiting for the requests to _complete_. Which you can
> > already do, trivially enough.
> 
> Reading write(2): 
> 
>        EAGAIN Non-blocking  I/O has been selected using O_NONBLOCK and there was
>               no room in the pipe or socket connected to fd to  write  the data
>               immediately.
> 
> I see no reason why "aio function have to block waiting for requests". 

That was my reasoning too with READA etc, but Linus seems to want that we
can block while submitting the I/O (as throttling, Linus?) just not
until completion.

-- 
Jens Axboe

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
