Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263250AbTFJPoa (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Jun 2003 11:44:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263234AbTFJPoZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Jun 2003 11:44:25 -0400
Received: from griffon.mipsys.com ([217.167.51.129]:32766 "EHLO gaston")
	by vger.kernel.org with ESMTP id S263369AbTFJPm3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Jun 2003 11:42:29 -0400
Subject: Re: [PATCH] IDE Power Management, try 3
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
Cc: Jens Axboe <axboe@suse.de>,
       linux-kernel mailing list <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.SOL.4.30.0306101621020.27439-100000@mion.elka.pw.edu.pl>
References: <Pine.SOL.4.30.0306101621020.27439-100000@mion.elka.pw.edu.pl>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1055260565.567.5.camel@gaston>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.4 
Date: 10 Jun 2003 17:56:05 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2003-06-10 at 16:23, Bartlomiej Zolnierkiewicz wrote:
> On 10 Jun 2003, Benjamin Herrenschmidt wrote:
> 
> > On Fri, 2003-06-06 at 23:25, Bartlomiej Zolnierkiewicz wrote:
> > > I have corrected it a bit and I am going to submit it, any comments?
> > >
> > > Ben, can you verify my changes and check that it still works after 'fixing'?
> > > :-)
> >
> > Heh, thanks for the "corrections" ;)
> >
> > Regarding ide_wait_not_busy(), I'd rather have it return -ENODEV
> > when it reads 0xff, what do you think ?
> 
> Nope, if you change it to return -ENODEV callers will fail.

Yup, that's the point, -ENODEV clearly mean don't bother probing here,
I'm reading 0xff, so there really mustn't be anything connected out
there. No ? At least that is why I added this 0xff test at first,
because some controllers with a non-wired bus don't even pull low
the BSY line as spec say they should do.

The -EBUSY case is tricky, it means the BSY bit stayed up for more than
the max timeout allowed by spec. Currently, I just continue probing with
a warning printed, ideally, we should probably try to reset or send an
EDD to the drive and then wait again, but then, I'm not sure this case
ever happens so...

> > I'll test the patch later today (just back from a long week-end),
> > Ben.
> 
> Good!

And it still works it seems ;) I haven't stressed it much yet though,
I have other problems with 2.5 right now, but I think it can go to
Linus, we can improve the actual state machines for individual
subdrivers later on.

Ben.
