Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261558AbVE3IVn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261558AbVE3IVn (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 May 2005 04:21:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261560AbVE3IVn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 May 2005 04:21:43 -0400
Received: from pop.gmx.de ([213.165.64.20]:5064 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S261558AbVE3IVe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 May 2005 04:21:34 -0400
X-Authenticated: #428038
Date: Mon, 30 May 2005 10:21:31 +0200
From: Matthias Andree <matthias.andree@gmx.de>
To: Greg Stark <gsstark@mit.edu>
Cc: Matthias Andree <matthias.andree@gmx.de>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Arjan van de Ven <arjan@infradead.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux does not care for data integrity (was: Disk write cache)
Message-ID: <20050530082130.GC11366@merlin.emma.line.org>
Mail-Followup-To: Greg Stark <gsstark@mit.edu>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>,
	Arjan van de Ven <arjan@infradead.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <42877C1B.2030008@pobox.com> <20050516110203.GA13387@merlin.emma.line.org> <1116241957.6274.36.camel@laptopd505.fenrus.org> <20050516112956.GC13387@merlin.emma.line.org> <1116252157.6274.41.camel@laptopd505.fenrus.org> <20050516144831.GA949@merlin.emma.line.org> <1116256005.21388.55.camel@localhost.localdomain> <87zmudycd1.fsf@stark.xeocode.com> <20050529211610.GA2105@merlin.emma.line.org> <87is11xn9d.fsf@stark.xeocode.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87is11xn9d.fsf@stark.xeocode.com>
X-PGP-Key: http://home.pages.de/~mandree/keys/GPGKEY.asc
User-Agent: Mutt/1.5.9i
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 30 May 2005, Greg Stark wrote:

> Matthias Andree <matthias.andree@gmx.de> writes:
> 
> > On Sun, 29 May 2005, Greg Stark wrote:
> > 
> > > They meet this requirement just fine on SCSI drives (where write caching
> > > generally ships disabled) and on any OS where fsync issues a cache flush. If
> > 
> > I don't know what facts "generally ships disabled" is based on, all of
> > the more recent SCSI drives (non SCA type though) I acquired came with
> > write cache enabled and some also with queue algorithm modifier set to 1.
> 
> People routinely post "Why does this cheap IDE drive outperform my shiny new
> high end SCSI drive?" questions to the postgres mailing list. To which people
> point out the IDE numbers they've presented are physically impossible for a
> 7200 RPM drive and the SCSI numbers agree appropriately with an average
> rotational latency calculated from whatever speed their SCSI drives are.

This may be a different reason than the vendor default or the saved
setting being WCE = 0, Queue Algorithm Modifier = 0...

I would really appreciate if the kernel printed a warning for every
partition mounted that cannot both enforce write order and guarantee
synchronous completion for f(data)sync, based on the drive's write
cache, file system type, current write barrier support and all that.

> > It's a matter of enforcing write order. In how far such ordering
> > constraints are propagated by file systems, VFS layer, down to the
> > hardware, is the grand question.
> 
> Well guaranteeing write order will at least mean the database isn't complete
> garbage after a power event.
> 
> It still means lost transactions, something that isn't going to be acceptable
> for any real-life business where those transactions are actual dollars.

Right, synchronous completion is the other issue. I want the kernel to
tell me if it's capable of doing that on a particular partition (given
hardware settings WRT cache, drivers, file system, and all that). Either
in the docs or if it's too confusing via dmesg.

-- 
Matthias Andree
