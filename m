Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263836AbUAHOjS (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Jan 2004 09:39:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263868AbUAHOjS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Jan 2004 09:39:18 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:24035 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S263836AbUAHOjQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Jan 2004 09:39:16 -0500
Date: Thu, 8 Jan 2004 15:39:08 +0100
From: Jens Axboe <axboe@suse.de>
To: Valdis.Kletnieks@vt.edu
Cc: bert hubert <ahu@ds9a.nl>, linux-kernel@vger.kernel.org
Subject: Re: blockfile access patterns logging
Message-ID: <20040108143908.GA8688@suse.de>
References: <20040108120008.GA7415@outpost.ds9a.nl> <200401081430.i08EUVfx005021@turing-police.cc.vt.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200401081430.i08EUVfx005021@turing-police.cc.vt.edu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 08 2004, Valdis.Kletnieks@vt.edu wrote:
> On Thu, 08 Jan 2004 13:00:08 +0100, bert hubert said:
> 
> > For some time I've wanted to log exactly what linux is reading and writing
> > from my harddisk - for a variety of reasons. The current reason is that my
> > very idle laptop writes to disk every once in a while (or reads, I don't
> > know).
> > 
> > Now, conceptually this should not be very hard, but I'd like to ask your
> > thoughts on where I might insert some crude logging? There are lots of
> > places that might be better or worse for some reason.
> > 
> > I'd love to be as close to the physical block device as possible, short of
> > rewriting actual IDE drivers.
> 
> You probably want to do logging at a higher level.  It's totally
> useless to find out that LBA 2234324567 got re-written.  Mapping it to
> a partition on the disk so you know it was something on /dev/hda7 is a
> bit better.  And being able to tell that somebody updated the atime on
> /var/log/messages is most informative of all.

For laptops, it's often most interesting to find out _what_ process
dirtied what data (which in turn caused bdflush to sync it), or what
process keeps doing small reads. And block_dump does exactly that (it
was invented for exactly that purpose :)


> The other problem is that unless your laptop is *VERY* idle, you will
> have a scrolling problem and buffering issues - so you end up writing
> to disk to log the buffers and... ;)

I don't think you understand what Bert is looking for. He explicitly
mentions that the machine is very idle, so he's probably looking for
culprits that spin up the drive occasionally.

It doesn't provide tcpdump like logs of course, that's far more
invasive.

-- 
Jens Axboe

