Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131010AbRBGBNW>; Tue, 6 Feb 2001 20:13:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131029AbRBGBNO>; Tue, 6 Feb 2001 20:13:14 -0500
Received: from vger.timpanogas.org ([207.109.151.240]:8210 "EHLO
	vger.timpanogas.org") by vger.kernel.org with ESMTP
	id <S131010AbRBGBNE>; Tue, 6 Feb 2001 20:13:04 -0500
Date: Tue, 6 Feb 2001 19:07:54 -0700
From: "Jeff V. Merkey" <jmerkey@vger.timpanogas.org>
To: Ingo Molnar <mingo@elte.hu>
Cc: Jens Axboe <axboe@suse.de>, Linus Torvalds <torvalds@transmeta.com>,
        "Stephen C. Tweedie" <sct@redhat.com>, Ben LaHaise <bcrl@redhat.com>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Manfred Spraul <manfred@colorfullife.com>, Steve Lord <lord@sgi.com>,
        Linux Kernel List <linux-kernel@vger.kernel.org>,
        kiobuf-io-devel@lists.sourceforge.net
Subject: Re: [Kiobuf-io-devel] RFC: Kernel mechanism: Compound event wait
Message-ID: <20010206190754.D23960@vger.timpanogas.org>
In-Reply-To: <20010206190050.B23960@vger.timpanogas.org> <Pine.LNX.4.30.0102070205430.14696-100000@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
In-Reply-To: <Pine.LNX.4.30.0102070205430.14696-100000@elte.hu>; from mingo@elte.hu on Wed, Feb 07, 2001 at 02:06:27AM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 07, 2001 at 02:06:27AM +0100, Ingo Molnar wrote:
> 
> On Tue, 6 Feb 2001, Jeff V. Merkey wrote:
> 
> > > I don't see anything that would break doing this, in fact you can
> > > do this as long as the buffers are all at least a multiple of the
> > > block size. All the drivers I've inspected handle this fine, noone
> > > assumes that rq->bh->b_size is the same in all the buffers attached
> > > to the request. This includes SCSI (scsi_lib.c builds sg tables),
> > > IDE, and the Compaq array + Mylex driver. This mostly leaves the
> > > "old-style" drivers using CURRENT etc, the kernel helpers for these
> > > handle it as well.
> > >
> > > So I would appreciate pointers to these devices that break so we
> > > can inspect them.
> > >
> > > --
> > > Jens Axboe
> >
> > Adaptec drivers had an oops.  Also, AIC7XXX also had some oops with it.
> 
> most likely some coding error on your side. buffer-size mismatches should
> show up as filesystem corruption or random DMA scribble, not in-driver
> oopses.
> 
> 	Ingo

Oops was in my code, but was caused by these drivers.  The Adaptec 
driver did have an oops that was it's own code address, AIC7XXX 
crashed in my code.

Jeff

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
