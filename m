Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262585AbUEAXIr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262585AbUEAXIr (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 1 May 2004 19:08:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262602AbUEAXIr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 1 May 2004 19:08:47 -0400
Received: from mail.kroah.org ([65.200.24.183]:59340 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S262585AbUEAXIp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 1 May 2004 19:08:45 -0400
Date: Sat, 1 May 2004 16:01:51 -0700
From: Greg KH <greg@kroah.com>
To: Duncan Sands <baldrick@free.fr>
Cc: Oliver Neukum <oliver@neukum.org>, linux-usb-devel@lists.sourceforge.net,
       linux-kernel@vger.kernel.org, Frederic Detienne <fd@cisco.com>
Subject: Re: [linux-usb-devel] Re: [PATCH 1/9] USB usbfs: take a reference to the usb device
Message-ID: <20040501230150.GA13676@kroah.com>
References: <200404141229.26677.baldrick@free.fr> <20040426221407.GB22719@kroah.com> <200404271058.21778.oliver@neukum.org> <200404301104.24555.baldrick@free.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200404301104.24555.baldrick@free.fr>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 30, 2004 at 11:04:24AM +0200, Duncan Sands wrote:
> On Tuesday 27 April 2004 10:58, Oliver Neukum wrote:
> > Am Dienstag, 27. April 2004 00:14 schrieb Greg KH:
> > > On Mon, Apr 26, 2004 at 04:05:17PM +0200, Duncan Sands wrote:
> > > > diff -Nru a/drivers/usb/core/devio.c b/drivers/usb/core/devio.c
> > > > --- a/drivers/usb/core/devio.c	Mon Apr 26 13:48:28 2004
> > > > +++ b/drivers/usb/core/devio.c	Mon Apr 26 13:48:28 2004
> > > > @@ -350,8 +350,8 @@
> > > >  	 * all pending I/O requests; 2.6 does that.
> > > >  	 */
> > > >
> > > > -	if (ifnum < 8*sizeof(ps->ifclaimed))
> > > > -		clear_bit(ifnum, &ps->ifclaimed);
> > > > +	BUG_ON(ifnum >= 8*sizeof(ps->ifclaimed));
> > >
> > > I've changed that to a WARN_ON().  Yeah, writing over memory is bad, but
> > > oopsing is worse.  Let's be a bit nicer than that.
> >
> > You aren't nice that way. An oops has localised consequences. Scribbling
> > over memory can cause anything.
> 
> Hi Greg, if won't accept a BUG_ON, how about the following?

Fine with me, applied, thanks.

greg k-h
