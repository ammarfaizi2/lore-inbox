Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289073AbSAUFtu>; Mon, 21 Jan 2002 00:49:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289055AbSAUFro>; Mon, 21 Jan 2002 00:47:44 -0500
Received: from astound-64-85-224-253.ca.astound.net ([64.85.224.253]:43535
	"EHLO master.linux-ide.org") by vger.kernel.org with ESMTP
	id <S289057AbSAUFq4>; Mon, 21 Jan 2002 00:46:56 -0500
Date: Sat, 19 Jan 2002 16:31:20 -0800 (PST)
From: Andre Hedrick <andre@linuxdiskcert.org>
To: Davide Libenzi <davidel@xmailserver.org>
cc: Jens Axboe <axboe@suse.de>, Anton Altaparmakov <aia21@cam.ac.uk>,
        Linus Torvalds <torvalds@transmeta.com>,
        lkml <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.5.3-pre1-aia1
In-Reply-To: <Pine.LNX.4.40.0201191343000.1538-100000@blue1.dev.mcafeelabs.com>
Message-ID: <Pine.LNX.4.10.10201191628290.9354-100000@master.linux-ide.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Yes,

I have a patch against 2.5.3-pre1 clean, and is up on kernel.org's upload
site, but k.o is down.  It can also be gotten off
	http://www.linuxdiskcert.org/
It is a tiny 37k patch and bzip2'd to 8k.


On Sat, 19 Jan 2002, Davide Libenzi wrote:

> On Sat, 19 Jan 2002, Andre Hedrick wrote:
> 
> > On Sat, 19 Jan 2002, Jens Axboe wrote:
> >
> > > On Sat, Jan 19 2002, Andre Hedrick wrote:
> > > > On Sat, 19 Jan 2002, Jens Axboe wrote:
> > > >
> > > > > On Fri, Jan 18 2002, Davide Libenzi wrote:
> > > > > > Guys, instead of requiring an -m8 to every user that is observing this
> > > > > > problem, isn't it better that you limit it inside the driver until things
> > > > > > gets fixed ?
> > > > >
> > > > > There is no -m8 limit, 2.5.3-pre1 + ata253p1-2 patch handles any set
> > > > > multi mode value.
> > > > >
> > > > > --
> > > > > Jens Axboe
> > > > >
> > > >
> > > > And that will generate the [lost interrupt], and I have it fixed at all
> > > > levels too now.
> > >
> > > How so? I don't see the problem.
> >
> > Unlike ATAPI which will generally send you more data than requested on
> > itw own, ATA devices do not like enjoy or play the game.  Additionally the
> > current code asks for 16 sectors, but we do not do the request copy
> > anymore, and this mean for every 4k of paging we are soliciting for 8k.
> > We only read out 4k thus the device has the the next 4k we may be wanting
> > ready.  Look at it as a dirty prefetch, but eventally the drive is going
> > to want to go south, thus [lost interrupt]
> >
> > Basically as the Block maintainer, you pointed out I am restricted to 4k
> > chunking in PIO.  You decided, in the interest of the block glue layer
> > into the driver, to force early end request per Linus's requirements to
> > return back every 4k completed to block regardless of the size of the
> > total data requested.
> >
> > For the above two condition to be properly satisfied, I have to adjust
> > and apply one driver policy make the driver behave and give the desired
> > results.  We should note this will conform with future IDEMA proposals
> > being submitted to the T committees.
> 
> That was it. By limiting the sector count request i was able to fix it.
> Do you've any permanent/not-hackish fix for this ?
> 
> 
> 
> 
> - Davide
> 
> 

Andre Hedrick
Linux Disk Certification Project                Linux ATA Development

