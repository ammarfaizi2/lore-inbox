Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265805AbUJARnY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265805AbUJARnY (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Oct 2004 13:43:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265773AbUJARnX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Oct 2004 13:43:23 -0400
Received: from mail.kroah.org ([69.55.234.183]:50353 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S265395AbUJARnD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Oct 2004 13:43:03 -0400
Date: Fri, 1 Oct 2004 10:42:43 -0700
From: Greg KH <greg@kroah.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Al Borchers <alborchers@steinerpoint.com>,
       linux-usb-devel <linux-usb-devel@lists.sourceforge.net>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: new locking in change_termios breaks USB serial drivers
Message-ID: <20041001174243.GA14015@kroah.com>
References: <415D3408.8070201@steinerpoint.com> <1096630567.21871.4.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1096630567.21871.4.camel@localhost.localdomain>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 01, 2004 at 12:36:09PM +0100, Alan Cox wrote:
> On Gwe, 2004-10-01 at 11:40, Al Borchers wrote:
> > Unfortunately, many USB serial drivers' set_termios functions
> > send an urb to change the termios settings and sleep waiting for
> > it to complete.
> > 
> > I just looked quickly, but it seems belkin_sa.c, digi_acceleport.c,
> > ftdi_sio.c, io_ti.c, kl5usb105.c, mct_u232.c, pl2303.c, and whiteheat.c
> > all sleep in their set_termios functions.
> > 
> > If this locking in change_termios() stays, we are going to have to
> > fix set_termios in all of these drivers.  I am updating io_ti.c right
> > now.
> 
> How much of a problem is this, would it make more sense to make the
> termios locking also include a semaphore to serialize driver side events
> and not the spin lock ?

It would make the usb-serial drivers much simpler if this was turned
into a semaphore.

> We need some kind of locking there otherwise multiple parallel termios
> setters resulting in truely strange occurences because driver authors
> don't think about 64 parallel executions of ->change_termios()
> 
> I can switch the lock around if you want.

I'm all for it, if the tty core isn't messing with any line settings
from interrupts.

thanks,

greg k-h
