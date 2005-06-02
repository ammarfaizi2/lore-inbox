Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261527AbVFBFLK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261527AbVFBFLK (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Jun 2005 01:11:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261556AbVFBFLK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Jun 2005 01:11:10 -0400
Received: from mail.kroah.org ([69.55.234.183]:48256 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261527AbVFBFLB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Jun 2005 01:11:01 -0400
Date: Wed, 1 Jun 2005 22:21:08 -0700
From: Greg KH <greg@kroah.com>
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
Cc: Alexey Dobriyan <adobriyan@gmail.com>, akpm@osdl.org,
       julien.tinnes@francetelecom.com, linux-kernel@vger.kernel.org
Subject: Re: potential-null-pointer-dereference-in-amiga-serial-driver.patch added to -mm tree
Message-ID: <20050602052108.GA8042@kroah.com>
References: <200505310909.j4V98xBR008727@shell0.pdx.osdl.net> <200505311949.15449.adobriyan@gmail.com> <20050531122215.GA5108@logos.cnet>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050531122215.GA5108@logos.cnet>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 31, 2005 at 09:22:15AM -0300, Marcelo Tosatti wrote:
> 
> Hi Alexey,
> 
> On Tue, May 31, 2005 at 07:49:15PM +0400, Alexey Dobriyan wrote:
> > On Tuesday 31 May 2005 13:08, akpm@osdl.org wrote:
> > > A pointer is dereferenced before it is null-checked.
> > 
> > > --- 25/drivers/char/amiserial.c~potential-null-pointer-dereference-in-amiga-serial-driver
> > > +++ 25-akpm/drivers/char/amiserial.c
> > 
> > >  static void rs_put_char(struct tty_struct *tty, unsigned char ch)
> > >  {
> > > -	struct async_struct *info = (struct async_struct *)tty->driver_data;
> > > +	struct async_struct *info;
> > >  	unsigned long flags;
> > >  
> > > +	if (!tty)
> > > +		return;
> > 
> > Can ->put_char be ever called with tty being NULL? From my reading of
> > drivers/char/n_tty.c it can't.
> 
> Nope it can't, but the change makes the code more readable IMO, while handling
> a NULL "tty" argument properly (which the old version pretends to, but doesnt).

But unneeded checks like this are not encouraged in the kernel.  As the
tty pointer can never be null, don't worry about it.

thanks,

greg k-h
