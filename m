Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261914AbVEaROn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261914AbVEaROn (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 May 2005 13:14:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261930AbVEaRMw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 May 2005 13:12:52 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:63670 "EHLO
	parcelfarce.linux.theplanet.co.uk") by vger.kernel.org with ESMTP
	id S261914AbVEaRLG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 May 2005 13:11:06 -0400
Date: Tue, 31 May 2005 09:22:15 -0300
From: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
To: Alexey Dobriyan <adobriyan@gmail.com>
Cc: akpm@osdl.org, julien.tinnes@francetelecom.com,
       linux-kernel@vger.kernel.org
Subject: Re: potential-null-pointer-dereference-in-amiga-serial-driver.patch added to -mm tree
Message-ID: <20050531122215.GA5108@logos.cnet>
References: <200505310909.j4V98xBR008727@shell0.pdx.osdl.net> <200505311949.15449.adobriyan@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200505311949.15449.adobriyan@gmail.com>
User-Agent: Mutt/1.5.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Alexey,

On Tue, May 31, 2005 at 07:49:15PM +0400, Alexey Dobriyan wrote:
> On Tuesday 31 May 2005 13:08, akpm@osdl.org wrote:
> > A pointer is dereferenced before it is null-checked.
> 
> > --- 25/drivers/char/amiserial.c~potential-null-pointer-dereference-in-amiga-serial-driver
> > +++ 25-akpm/drivers/char/amiserial.c
> 
> >  static void rs_put_char(struct tty_struct *tty, unsigned char ch)
> >  {
> > -	struct async_struct *info = (struct async_struct *)tty->driver_data;
> > +	struct async_struct *info;
> >  	unsigned long flags;
> >  
> > +	if (!tty)
> > +		return;
> 
> Can ->put_char be ever called with tty being NULL? From my reading of
> drivers/char/n_tty.c it can't.

Nope it can't, but the change makes the code more readable IMO, while handling
a NULL "tty" argument properly (which the old version pretends to, but doesnt).

> Every single time ->put_char is used a-la
> 
> 	tty->driver->put_char(tty, '\r');
> 
> So, tty will be dereferenced before function call. Same for static inline
> put_char() there.  
