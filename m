Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265282AbUF1XKz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265282AbUF1XKz (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Jun 2004 19:10:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265283AbUF1XKz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Jun 2004 19:10:55 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:21005 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S265282AbUF1XKw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Jun 2004 19:10:52 -0400
Date: Tue, 29 Jun 2004 00:10:44 +0100
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Andrew Morton <akpm@osdl.org>
Cc: Pat Gefre <pfg@sgi.com>, erikj@subway.americas.sgi.com, cw@f00f.org,
       hch@infradead.org, jbarnes@engr.sgi.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2.6] Altix serial driver
Message-ID: <20040629001043.G9214@flint.arm.linux.org.uk>
Mail-Followup-To: Andrew Morton <akpm@osdl.org>, Pat Gefre <pfg@sgi.com>,
	erikj@subway.americas.sgi.com, cw@f00f.org, hch@infradead.org,
	jbarnes@engr.sgi.com, linux-kernel@vger.kernel.org
References: <20040628121312.75ac9ed7.akpm@osdl.org> <Pine.SGI.3.96.1040628170609.36430N-100000@fsgi900.americas.sgi.com> <20040628152000.4b7665c6.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20040628152000.4b7665c6.akpm@osdl.org>; from akpm@osdl.org on Mon, Jun 28, 2004 at 03:20:00PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 28, 2004 at 03:20:00PM -0700, Andrew Morton wrote:
> Pat Gefre <pfg@sgi.com> wrote:
> >
> > On Mon, 28 Jun 2004, Andrew Morton wrote:
> > 
> > + Pat Gefre <pfg@sgi.com> wrote:
> > + >
> > + > We think we should stick with the major/minor set we have proposed.  We
> > + >  don't like hacking the 8250 code, dynamic allocation doesn't work (once
> > + >  that works we will update our driver to use it), registering for our
> > + >  own major/minor may not work (if we DO get one we will update the
> > + >  driver to reflect it) but in the meantime we need to get something in
> > + >  the community that works.
> > + 
> > + "we don't like" isn't a very strong argument ;)
> > + 
> > + It does sound to me like some work is needed in the generic serial layer to
> > + teach it to get its sticky paws off the ttyS0 major/minor if there is no
> > + corresponding hardware.  AFAICT nobody has scoped out exactly what has to
> > + be done for a clean solution there - it may not be very complex.  So could
> > + we please explore that a little further?
> > + 
> > + If that proves to be impractical for some reason then I'd be inclined to
> > + allocate a new misc minor, stick it in devices.txt and be done with it.
> > 
> > I'm not sure I understand what you mean by this. Use a different major
> > (one that is likely to not be used by anyone else on our system) and a
> > minor that no one is assigned ?
> > 
> 
> Or use dynamic allocation.  I'm trying to understand why early-boot code
> needs to know the major/minor when it will be accessing the driver via
> /dev/console anyway.

It's all a mess of struct console, struct tty_driver, registration
thereof, and device indexes.

To summarise, to open a tty device, even /dev/console, we need to find
a struct tty_driver and a tty device index, which we get from the
struct console.  The /dev/console aliases on to the real tty device
on the device driver.  tty_driver structures are registered with the
tty layer, and claim some char device space, whether or not there's
hardware behind them.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 PCMCIA      - http://pcmcia.arm.linux.org.uk/
                 2.6 Serial core
