Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263205AbTEMG23 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 May 2003 02:28:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263206AbTEMG23
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 May 2003 02:28:29 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:3281 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S263205AbTEMG21 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 May 2003 02:28:27 -0400
Date: Tue, 13 May 2003 08:40:59 +0200
From: Jens Axboe <axboe@suse.de>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: "Mudama, Eric" <eric_mudama@maxtor.com>, Oleg Drokin <green@namesys.com>,
       Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>, Oliver Neukum <oliver@neukum.org>,
       lkhelp@rekl.yi.org, linux-kernel@vger.kernel.org
Subject: Re: 2.5.69, IDE TCQ can't be enabled
Message-ID: <20030513064059.GL17033@suse.de>
References: <785F348679A4D5119A0C009027DE33C102E0D31D@mcoexc04.mlm.maxtor.com> <20030512193509.GB10089@gtf.org> <20030512194245.GG17033@suse.de> <20030512195331.GD10089@gtf.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030512195331.GD10089@gtf.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 12 2003, Jeff Garzik wrote:
> On Mon, May 12, 2003 at 09:42:45PM +0200, Jens Axboe wrote:
> > On Mon, May 12 2003, Jeff Garzik wrote:
> > > Most Linux people with TCQ drives seem to have Hitachi (nee IBM)
> > > ones AFAICS.  These do not have a service interrupt (or at least,
> > > do not report such)
> > 
> > Nonsense, it supports the service interrupt just fine. It will just
> > complain if you try to turn it off, iirc.
> 
> Weird.  Mine doesn't seem to assert it, nor does the identify page
> indicate it's supported.  Maybe I have a broken drive firmware.

Then the linux code won't work on it, have you tried? I've tried a lot
of different IBM models, they all do service interrupts just fine.

> > > They do have the release interrupt.
> > 
> > Which we don't use. To be interesting, you need to speculatively turn on
> > the dma engine for each command you want to start. If you don't do that,
> > then it's faster just to poll for release/no-release at command start
> > time.
> 
> That's an annoying thing about ATA TCQ:  the command _may_ execute
> immediately, or may be queued (even when queue is empty).  At least
> that's how I read the code and specs...

That's correct, you can use the release interrupt to get around that...

> > I don't think the multiple pending _and_ active is that big a deal, and
> > besides _everybody_ uses write back caching on IDE which makes TCQ for
> > writes very uninteresting.
> [...]
> > I have to agree with Eric that the largest win is potentially not
> > getting hit by the rotational latency all the time. I don't think you'll
> > get much extra from actually having more than one active from the dma
> > POV.
> 
> Yes and no.  I am coming from a driver-complexity perspective:
> single-active is more annoying on the driver side.
> 
> In terms of drive performance, multiple active probably doesn't make
> a huge difference.  In terms of reduction in host CPU usage, there
> is a performance gain there with multiple active.

It should make a non-neglible difference in smart positioning in the
drive, some things just cannot be done in software for this stuff.

-- 
Jens Axboe

