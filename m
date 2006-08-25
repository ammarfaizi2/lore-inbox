Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422897AbWHYUjo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422897AbWHYUjo (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Aug 2006 16:39:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422899AbWHYUjo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Aug 2006 16:39:44 -0400
Received: from thunk.org ([69.25.196.29]:23461 "EHLO thunker.thunk.org")
	by vger.kernel.org with ESMTP id S1422897AbWHYUjn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Aug 2006 16:39:43 -0400
Date: Fri, 25 Aug 2006 16:39:29 -0400
From: Theodore Tso <tytso@mit.edu>
To: Stuart MacDonald <stuartm@connecttech.com>,
       "'Alan Cox'" <alan@lxorguk.ukuu.org.uk>,
       "'Krzysztof Halasa'" <khc@pm.waw.pl>, linux-serial@vger.kernel.org,
       "'LKML'" <linux-kernel@vger.kernel.org>, libc-alpha@sources.redhat.com
Subject: Re: Serial custom speed deprecated?
Message-ID: <20060825203929.GB25595@thunk.org>
Mail-Followup-To: Theodore Tso <tytso@mit.edu>,
	Stuart MacDonald <stuartm@connecttech.com>,
	'Alan Cox' <alan@lxorguk.ukuu.org.uk>,
	'Krzysztof Halasa' <khc@pm.waw.pl>, linux-serial@vger.kernel.org,
	'LKML' <linux-kernel@vger.kernel.org>,
	libc-alpha@sources.redhat.com
References: <1156459387.3007.218.camel@localhost.localdomain> <043501c6c85a$1eb09a60$294b82ce@stuartm> <20060825193203.GB725@flint.arm.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060825193203.GB725@flint.arm.linux.org.uk>
User-Agent: Mutt/1.5.11
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: tytso@thunk.org
X-SA-Exim-Scanned: No (on thunker.thunk.org); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 25, 2006 at 08:32:03PM +0100, Russell King wrote:
> On Fri, Aug 25, 2006 at 11:21:21AM -0400, Stuart MacDonald wrote:
> > From: On Behalf Of Alan Cox
> > > We could implement an entirely new TCSETS/TCGETS/TCSETSA/SAW 
> > > which used
> > > different B* values so B9600 was 9600 etc and the data was stored in
> > 
> > I think if a numeric baud rate is going to be supported, getting away
> > from the B* cruft is important. Just use a number.
> 
> The "B* cruft" is part of POSIX so needs to be retained.  These are
> used in conjunction with with cfgetispeed(), cfgetospeed(), cfsetispeed()
> and cfsetospeed() to alter the baud rate settings in the termios
> structure in an implementation defined manner.

The B* cruft has to be maintained.

But it would be POSIX complaint for B9600 to be #defined to B9600, and
B19200 to be #defined to B19200.

What would scare me though about doing something like would be
potential for the ABI changes.  Not only do you have to worry about a
consistent set of ioctl's, structure definitions, and B* defines, but
you also have to worry about userspace libraries that use B* as part
of their interface, and expect user programs to pass B* constants to
the userspace library.  (Say, some kind of conveience dialout library,
for example.)

In that case, the application could have been compiled with the
new-style termios.h, but the userspace library could have been
compiled with the old-style termios.h, and hence the old-style ioctl
definitions, and the opportunities for mischief are endless.

					- Ted
