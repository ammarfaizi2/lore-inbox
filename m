Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262400AbTELTks (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 May 2003 15:40:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262438AbTELTks
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 May 2003 15:40:48 -0400
Received: from havoc.daloft.com ([64.213.145.173]:57790 "EHLO havoc.gtf.org")
	by vger.kernel.org with ESMTP id S262400AbTELTkr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 May 2003 15:40:47 -0400
Date: Mon, 12 May 2003 15:53:31 -0400
From: Jeff Garzik <jgarzik@pobox.com>
To: Jens Axboe <axboe@suse.de>
Cc: "Mudama, Eric" <eric_mudama@maxtor.com>, Oleg Drokin <green@namesys.com>,
       Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>, Oliver Neukum <oliver@neukum.org>,
       lkhelp@rekl.yi.org, linux-kernel@vger.kernel.org
Subject: Re: 2.5.69, IDE TCQ can't be enabled
Message-ID: <20030512195331.GD10089@gtf.org>
References: <785F348679A4D5119A0C009027DE33C102E0D31D@mcoexc04.mlm.maxtor.com> <20030512193509.GB10089@gtf.org> <20030512194245.GG17033@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030512194245.GG17033@suse.de>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 12, 2003 at 09:42:45PM +0200, Jens Axboe wrote:
> On Mon, May 12 2003, Jeff Garzik wrote:
> > Most Linux people with TCQ drives seem to have Hitachi (nee IBM)
> > ones AFAICS.  These do not have a service interrupt (or at least,
> > do not report such)
> 
> Nonsense, it supports the service interrupt just fine. It will just
> complain if you try to turn it off, iirc.

Weird.  Mine doesn't seem to assert it, nor does the identify page
indicate it's supported.  Maybe I have a broken drive firmware.


> > They do have the release interrupt.
> 
> Which we don't use. To be interesting, you need to speculatively turn on
> the dma engine for each command you want to start. If you don't do that,
> then it's faster just to poll for release/no-release at command start
> time.

That's an annoying thing about ATA TCQ:  the command _may_ execute
immediately, or may be queued (even when queue is empty).  At least
that's how I read the code and specs...


> I don't think the multiple pending _and_ active is that big a deal, and
> besides _everybody_ uses write back caching on IDE which makes TCQ for
> writes very uninteresting.
[...]
> I have to agree with Eric that the largest win is potentially not
> getting hit by the rotational latency all the time. I don't think you'll
> get much extra from actually having more than one active from the dma
> POV.

Yes and no.  I am coming from a driver-complexity perspective:
single-active is more annoying on the driver side.

In terms of drive performance, multiple active probably doesn't make
a huge difference.  In terms of reduction in host CPU usage, there
is a performance gain there with multiple active.

	Jeff



