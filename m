Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129426AbRBFV0v>; Tue, 6 Feb 2001 16:26:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129661AbRBFV0n>; Tue, 6 Feb 2001 16:26:43 -0500
Received: from colorfullife.com ([216.156.138.34]:62216 "EHLO colorfullife.com")
	by vger.kernel.org with ESMTP id <S129426AbRBFV0X>;
	Tue, 6 Feb 2001 16:26:23 -0500
Message-ID: <3A806BFA.A178BC7A@colorfullife.com>
Date: Tue, 06 Feb 2001 22:26:18 +0100
From: Manfred Spraul <manfred@colorfullife.com>
X-Mailer: Mozilla 4.75 [en] (X11; U; Linux 2.2.16-22 i586)
X-Accept-Language: en
MIME-Version: 1.0
To: Jens Axboe <axboe@suse.de>
CC: Ben LaHaise <bcrl@redhat.com>, Ingo Molnar <mingo@elte.hu>,
        Linus Torvalds <torvalds@transmeta.com>,
        "Stephen C. Tweedie" <sct@redhat.com>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>, Steve Lord <lord@sgi.com>,
        Linux Kernel List <linux-kernel@vger.kernel.org>,
        kiobuf-io-devel@lists.sourceforge.net, Ingo Molnar <mingo@redhat.com>
Subject: Re: [Kiobuf-io-devel] RFC: Kernel mechanism: Compound event wait
In-Reply-To: <Pine.LNX.4.30.0102061521270.15204-100000@today.toronto.redhat.com> <3A806177.59304E88@colorfullife.com> <20010206215053.G2975@suse.de>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jens Axboe wrote:
> 
> > Several kernel functions need a "dontblock" parameter (or a callback, or
> > a waitqueue address, or a tq_struct pointer).
> 
> We don't even need that, non-blocking is implicitly applied with READA.
>
READA just returns - I doubt that the aio functions should poll until
there are free entries in the request queue.

The pending aio requests should be "included" into the wait_for_requests
waitqueue (ok, they don't have a process context, thus a wait queue
entry doesn't help, but these requests belong into that wait queue)

--
	Manfred
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
