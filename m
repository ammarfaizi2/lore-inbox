Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263270AbTEMT7O (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 May 2003 15:59:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263245AbTEMT7N
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 May 2003 15:59:13 -0400
Received: from astound-64-85-224-253.ca.astound.net ([64.85.224.253]:44293
	"EHLO master.linux-ide.org") by vger.kernel.org with ESMTP
	id S263270AbTEMT7I (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 May 2003 15:59:08 -0400
Date: Tue, 13 May 2003 13:03:35 -0700 (PDT)
From: Andre Hedrick <andre@linux-ide.org>
To: Jens Axboe <axboe@suse.de>
cc: Jeff Garzik <jgarzik@pobox.com>, Dave Jones <davej@codemonkey.org.uk>,
       "Mudama, Eric" <eric_mudama@maxtor.com>,
       Oleg Drokin <green@namesys.com>,
       Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>, Oliver Neukum <oliver@neukum.org>,
       lkhelp@rekl.yi.org, linux-kernel@vger.kernel.org
Subject: Re: 2.5.69, IDE TCQ can't be enabled
In-Reply-To: <20030513181337.GM17033@suse.de>
Message-ID: <Pine.LNX.4.10.10305131256240.2718-100000@master.linux-ide.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Why are we still dorking around with device TCQ.
There are three holes in the state machine.
IBM's design (goat-screw) is lamer than a duck.
Maxtor thought about redoing TCQ, to not leave the host in a daze but
dropped the ball.

Nobody cares about a broken pile of crap in the NCITS standard, otherwise
the rest of the drive vendors would have adopted.

Stop with drive side crappola and make it host side for SATA.

If you want TCQ go use another OS, and kiss your data good bye.

Not a single OS (linux included) can deal with a error in flush cache, 
much less an error from a previous tagged request.

Don't do it, and if you do, don't bitch.

Cheers,

Andre Hedrick
LAD Storage Consulting Group

PS Jens this is not directed to you, just this was the fatest cc list to
bang a drum on.

On Tue, 13 May 2003, Jens Axboe wrote:

> On Tue, May 13 2003, Jens Axboe wrote:
> > On Tue, May 13 2003, Jeff Garzik wrote:
> > > On Tue, May 13, 2003 at 08:03:34PM +0200, Jens Axboe wrote:
> > > > On Tue, May 13 2003, Dave Jones wrote:
> > > > > On Tue, May 13, 2003 at 08:40:59AM +0200, Jens Axboe wrote:
> > > > >  > > Weird.  Mine doesn't seem to assert it, nor does the identify page
> > > > >  > > indicate it's supported.  Maybe I have a broken drive firmware.
> > > > >  > 
> > > > >  > Then the linux code won't work on it, have you tried? I've tried a lot
> > > > >  > of different IBM models, they all do service interrupts just fine.
> > > > > 
> > > > > bug in the firmware version on Jeffs drives perhaps ?
> > > > 
> > > > It's possible, it would help a lot of Jeff would answer the question
> > > > above and maybe even share what drive he is using with us.
> > > 
> > > hehe, just did (answer: no).  I'll post hdparm -I for it tomorrow.
> > 
> > :) thanks! fwiw, I've tried DTLA, DPTA, and the IC vancouvers here.
> 
> btw, you may want to see the IDE_TCQ_FIDDLE_SI define in ide-tcq, here's
> the comment I put there:
> 
> /*
>  * we are leaving the SERVICE interrupt alone, IBM drives have it
>  * on per default and it can't be turned off. Doesn't matter, this
>  * is the sane config.
>  */
> #undef IDE_TCQ_FIDDLE_SI
> 
> Are you sure this isn't what you are seeing?
> 
> -- 
> Jens Axboe
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 

