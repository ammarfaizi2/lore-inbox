Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161148AbWFVO24@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161148AbWFVO24 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Jun 2006 10:28:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161150AbWFVO24
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Jun 2006 10:28:56 -0400
Received: from mail.gmx.net ([213.165.64.21]:5062 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1161148AbWFVO2y (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Jun 2006 10:28:54 -0400
X-Authenticated: #704063
Date: Thu, 22 Jun 2006 16:28:15 +0200
From: Eric Sesterhenn / Snakebyte <snakebyte@gmx.de>
To: Mikael Pettersson <mikpe@it.uu.se>
Cc: linux-kernel@vger.kernel.org, snakebyte@gmx.de, gregkh@suse.de
Subject: Re: [Patch] Off by one in drivers/usb/serial/usb-serial.c
Message-ID: <20060622142815.GB7503@whiterabbit>
References: <200606221331.k5MDVua9010794@harpo.it.uu.se>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200606221331.k5MDVua9010794@harpo.it.uu.se>
X-Editor: Vim http://www.vim.org/
X-Info: http://www.snake-basket.de
X-Operating-System: Linux/2.6.15-1-686 (i686)
X-Uptime: 16:27:07 up 4 days, 22:17,  1 user,  load average: 0.02, 0.02, 0.01
User-Agent: Mutt/1.5.11+cvs20060403
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Mikael Pettersson (mikpe@it.uu.se) wrote:
> On Wed, 21 Jun 2006 23:28:17 +0200, Eric Sesterhenn wrote:
> > this fixes coverity id #554. since serial table
> > is defines as serial_table[SERIAL_TTY_MINORS] we
> > should make sure we dont acess with an index
> > of SERIAL_TTY_MINORS.
> > 
> > Signed-off-by: Eric Sesterhenn <snakebyte@gmx.de>
> > 
> > --- linux-2.6.17-git2/drivers/usb/serial/usb-serial.c.orig	2006-06-21 23:24:07.000000000 +0200
> > +++ linux-2.6.17-git2/drivers/usb/serial/usb-serial.c	2006-06-21 23:25:12.000000000 +0200
> > @@ -83,7 +83,7 @@ static struct usb_serial *get_free_seria
> >  
> >  		good_spot = 1;
> >  		for (j = 1; j <= num_ports-1; ++j)
> > -			if ((i+j >= SERIAL_TTY_MINORS) || (serial_table[i+j])) {
> > +			if ((i+j >= SERIAL_TTY_MINORS-1)||(serial_table[i+j])) {
> >  				good_spot = 0;
> >  				i += j;
> >  				break;
> 
> Where is the access coverity complained about? If it's the serial_table[i+j]
> quoted above, then the original code is OK since i+j < SERIAL_TTY_MINORS is
> an invariant in that subexpression.
> 
> And the other accesses to serial_table[] in get_free_serial() are also only
> done when the index is < SERIAL_TTY_MINORS.

I'll check that again on sunday, when i am back home.

Greetings, Eric
