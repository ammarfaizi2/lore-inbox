Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287895AbSABSpa>; Wed, 2 Jan 2002 13:45:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287896AbSABSpV>; Wed, 2 Jan 2002 13:45:21 -0500
Received: from mta6.snfc21.pbi.net ([206.13.28.240]:55535 "EHLO
	mta6.snfc21.pbi.net") by vger.kernel.org with ESMTP
	id <S287895AbSABSpB>; Wed, 2 Jan 2002 13:45:01 -0500
Date: Wed, 02 Jan 2002 10:43:33 -0800
From: David Brownell <david-b@pacbell.net>
Subject: Re: [linux-usb-devel] Re: highmem and usb [was:"sr: unalignedtransfer"
 in 2.5.2-pre1]
To: Oliver.Neukum@lrz.uni-muenchen.de
Cc: Matthew Dharm <mdharm-kernel@one-eyed-alien.net>,
        Jens Axboe <axboe@suse.de>, linux-kernel@vger.kernel.org,
        linux-usb-devel@lists.sourceforge.net, Greg KH <greg@kroah.com>
Message-id: <07db01c193bd$62191ec0$6800000a@brownell.org>
MIME-version: 1.0
X-MIMEOLE: Produced By Microsoft MimeOLE V5.50.4133.2400
X-Mailer: Microsoft Outlook Express 5.50.4133.2400
Content-type: text/plain; charset=iso-8859-1
Content-transfer-encoding: 7BIT
X-Priority: 3
X-MSMail-priority: Normal
In-Reply-To: <Pine.SOL.4.33.0201021018550.4555-100000@sun2.lrz-muenchen.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > > I'd rather eliminate as much overhead as possible -- I already get
> > > complaints from performance fanatics about the inability of usb-storage to
> > > get past 92% bus saturation (sustained), and the problem will only get
> > > worse on USB 2.0
> >
> > Well then you'll  be glad to see a patch from me, soonish, that teaches
> > the usb-storage "transport" code to use bulk queueing.  That'll get the
> > bandwidth utilization up as high as it can get.  It won't address any of
> > these highmem issues though.
> 
> And there's the overhead of sleeping and waking a kernel thread. Larger io
> requests might help, but I am not sure.

Yes, it's that sleep/wake between scatterlist segments that's creating
that 92% (at 12 Mbit/sec) or about 20% (at 480 Mbit/sec :) bottleneck ...
Convert those calls to use bulk queuing, and those delays vanish.

- Dave


