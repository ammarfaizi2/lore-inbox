Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130818AbRBGBHc>; Tue, 6 Feb 2001 20:07:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130836AbRBGBHW>; Tue, 6 Feb 2001 20:07:22 -0500
Received: from chiara.elte.hu ([157.181.150.200]:8459 "HELO chiara.elte.hu")
	by vger.kernel.org with SMTP id <S130818AbRBGBHF>;
	Tue, 6 Feb 2001 20:07:05 -0500
Date: Wed, 7 Feb 2001 02:06:27 +0100 (CET)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: <mingo@elte.hu>
To: "Jeff V. Merkey" <jmerkey@vger.timpanogas.org>
Cc: Jens Axboe <axboe@suse.de>, Linus Torvalds <torvalds@transmeta.com>,
        "Stephen C. Tweedie" <sct@redhat.com>, Ben LaHaise <bcrl@redhat.com>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Manfred Spraul <manfred@colorfullife.com>, Steve Lord <lord@sgi.com>,
        Linux Kernel List <linux-kernel@vger.kernel.org>,
        <kiobuf-io-devel@lists.sourceforge.net>
Subject: Re: [Kiobuf-io-devel] RFC: Kernel mechanism: Compound event wait
In-Reply-To: <20010206190050.B23960@vger.timpanogas.org>
Message-ID: <Pine.LNX.4.30.0102070205430.14696-100000@elte.hu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 6 Feb 2001, Jeff V. Merkey wrote:

> > I don't see anything that would break doing this, in fact you can
> > do this as long as the buffers are all at least a multiple of the
> > block size. All the drivers I've inspected handle this fine, noone
> > assumes that rq->bh->b_size is the same in all the buffers attached
> > to the request. This includes SCSI (scsi_lib.c builds sg tables),
> > IDE, and the Compaq array + Mylex driver. This mostly leaves the
> > "old-style" drivers using CURRENT etc, the kernel helpers for these
> > handle it as well.
> >
> > So I would appreciate pointers to these devices that break so we
> > can inspect them.
> >
> > --
> > Jens Axboe
>
> Adaptec drivers had an oops.  Also, AIC7XXX also had some oops with it.

most likely some coding error on your side. buffer-size mismatches should
show up as filesystem corruption or random DMA scribble, not in-driver
oopses.

	Ingo

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
