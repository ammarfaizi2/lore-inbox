Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129190AbRBFT6R>; Tue, 6 Feb 2001 14:58:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130287AbRBFT6A>; Tue, 6 Feb 2001 14:58:00 -0500
Received: from chiara.elte.hu ([157.181.150.200]:39434 "HELO chiara.elte.hu")
	by vger.kernel.org with SMTP id <S130157AbRBFT5w>;
	Tue, 6 Feb 2001 14:57:52 -0500
Date: Tue, 6 Feb 2001 20:57:13 +0100 (CET)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: <mingo@elte.hu>
To: Ben LaHaise <bcrl@redhat.com>
Cc: Linus Torvalds <torvalds@transmeta.com>,
        "Stephen C. Tweedie" <sct@redhat.com>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Manfred Spraul <manfred@colorfullife.com>, Steve Lord <lord@sgi.com>,
        Linux Kernel List <linux-kernel@vger.kernel.org>,
        <kiobuf-io-devel@lists.sourceforge.net>,
        Ingo Molnar <mingo@redhat.com>
Subject: Re: [Kiobuf-io-devel] RFC: Kernel mechanism: Compound event wait
In-Reply-To: <Pine.LNX.4.30.0102061437250.15204-100000@today.toronto.redhat.com>
Message-ID: <Pine.LNX.4.30.0102062052110.8926-100000@elte.hu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 6 Feb 2001, Ben LaHaise wrote:

> This small correction is the crux of the problem: if it blocks, it
> takes away from the ability of the process to continue doing useful
> work.  If it returns -EAGAIN, then that's okay, the io will be
> resubmitted later when other disk io has completed.  But, it should be
> possible to continue servicing network requests or user io while disk
> io is underway.

typical blocking point is waiting for page completion, not
__wait_request(). But, this is really not an issue, NR_REQUESTS can be
increased anytime. If NR_REQUESTS is large enough then think of it as the
'absolute upper limit of doing IO', and think of the blocking as 'the
kernel pulling the brakes'.

[overhead of 512-byte bhs in the raw IO code is an artificial problem of
the raw IO code.]

	Ingo

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
