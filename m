Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130785AbRBGBGc>; Tue, 6 Feb 2001 20:06:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130818AbRBGBGW>; Tue, 6 Feb 2001 20:06:22 -0500
Received: from vger.timpanogas.org ([207.109.151.240]:2834 "EHLO
	vger.timpanogas.org") by vger.kernel.org with ESMTP
	id <S130785AbRBGBGI>; Tue, 6 Feb 2001 20:06:08 -0500
Date: Tue, 6 Feb 2001 19:00:50 -0700
From: "Jeff V. Merkey" <jmerkey@vger.timpanogas.org>
To: Jens Axboe <axboe@suse.de>
Cc: Linus Torvalds <torvalds@transmeta.com>,
        "Stephen C. Tweedie" <sct@redhat.com>, Ingo Molnar <mingo@elte.hu>,
        Ben LaHaise <bcrl@redhat.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Manfred Spraul <manfred@colorfullife.com>, Steve Lord <lord@sgi.com>,
        Linux Kernel List <linux-kernel@vger.kernel.org>,
        kiobuf-io-devel@lists.sourceforge.net
Subject: Re: [Kiobuf-io-devel] RFC: Kernel mechanism: Compound event wait
Message-ID: <20010206190050.B23960@vger.timpanogas.org>
In-Reply-To: <20010207003629.M1167@redhat.com> <Pine.LNX.4.10.10102061642330.2045-100000@penguin.transmeta.com> <20010206185115.A23754@vger.timpanogas.org> <20010207020221.B13647@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
In-Reply-To: <20010207020221.B13647@suse.de>; from axboe@suse.de on Wed, Feb 07, 2001 at 02:02:21AM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 07, 2001 at 02:02:21AM +0100, Jens Axboe wrote:
> On Tue, Feb 06 2001, Jeff V. Merkey wrote:
> > I remember Linus asking to try this variable buffer head chaining 
> > thing 512-1024-512 kind of stuff several months back, and mixing them to 
> > see what would happen -- result.  About half the drivers break with it.  
> > The interface allows you to do it, I've tried it, (works on Andre's 
> > drivers, but a lot of SCSI drivers break) but a lot of drivers seem to 
> > have assumptions about these things all being the same size in a 
> > buffer head chain. 
> 
> I don't see anything that would break doing this, in fact you can
> do this as long as the buffers are all at least a multiple of the
> block size. All the drivers I've inspected handle this fine, noone
> assumes that rq->bh->b_size is the same in all the buffers attached
> to the request. This includes SCSI (scsi_lib.c builds sg tables),
> IDE, and the Compaq array + Mylex driver. This mostly leaves the
> "old-style" drivers using CURRENT etc, the kernel helpers for these
> handle it as well.
> 
> So I would appreciate pointers to these devices that break so we
> can inspect them.
> 
> -- 
> Jens Axboe

Adaptec drivers had an oops.  Also, AIC7XXX also had some oops with it.

Jeff

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
