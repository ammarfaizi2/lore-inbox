Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129919AbRBHLgv>; Thu, 8 Feb 2001 06:36:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130348AbRBHLgl>; Thu, 8 Feb 2001 06:36:41 -0500
Received: from [194.213.32.137] ([194.213.32.137]:6916 "EHLO bug.ucw.cz")
	by vger.kernel.org with ESMTP id <S129919AbRBHLg3>;
	Thu, 8 Feb 2001 06:36:29 -0500
Message-ID: <20010208001735.C189@bug.ucw.cz>
Date: Thu, 8 Feb 2001 00:17:35 +0100
From: Pavel Machek <pavel@suse.cz>
To: Linus Torvalds <torvalds@transmeta.com>,
        Marcelo Tosatti <marcelo@conectiva.com.br>
Cc: Jens Axboe <axboe@suse.de>, Manfred Spraul <manfred@colorfullife.com>,
        Ben LaHaise <bcrl@redhat.com>, Ingo Molnar <mingo@elte.hu>,
        "Stephen C. Tweedie" <sct@redhat.com>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>, Steve Lord <lord@sgi.com>,
        Linux Kernel List <linux-kernel@vger.kernel.org>,
        kiobuf-io-devel@lists.sourceforge.net, Ingo Molnar <mingo@redhat.com>
Subject: select() returning busy for regular files [was Re: [Kiobuf-io-devel] RFC: Kernel mechanism: Compound event wait]
In-Reply-To: <Pine.LNX.4.21.0102061900060.23574-100000@freak.distro.conectiva> <Pine.LNX.4.10.10102061516570.1972-100000@penguin.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.93i
In-Reply-To: <Pine.LNX.4.10.10102061516570.1972-100000@penguin.transmeta.com>; from Linus Torvalds on Tue, Feb 06, 2001 at 03:26:44PM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > Its arguing against making a smart application block on the disk while its
> > able to use the CPU for other work.
> 
> There are currently no other alternatives in user space. You'd have to
> create whole new interfaces for aio_read/write, and ways for the kernel to
> inform user space that "now you can re-try submitting your IO".

Why is current select() interface not good enough?

Defining that select may say regular file is not ready should be
enough. Okay, maybe you'd want new fcntl() flag saying "I _really_
want this regular file to be non-blocking". No need for new
interfaces.
								Pavel
-- 
I'm pavel@ucw.cz. "In my country we have almost anarchy and I don't care."
Panos Katsaloulis describing me w.r.t. patents at discuss@linmodems.org
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
