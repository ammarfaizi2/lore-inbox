Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263895AbUD0I60@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263895AbUD0I60 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Apr 2004 04:58:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263904AbUD0I60
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Apr 2004 04:58:26 -0400
Received: from mail1.kontent.de ([81.88.34.36]:37802 "EHLO Mail1.KONTENT.De")
	by vger.kernel.org with ESMTP id S263895AbUD0I6Z (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Apr 2004 04:58:25 -0400
From: Oliver Neukum <oliver@neukum.org>
To: Greg KH <greg@kroah.com>, Duncan Sands <baldrick@free.fr>
Subject: Re: [linux-usb-devel] Re: [PATCH 1/9] USB usbfs: take a reference to the usb device
Date: Tue, 27 Apr 2004 10:58:21 +0200
User-Agent: KMail/1.5.1
Cc: linux-usb-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org,
       Frederic Detienne <fd@cisco.com>
References: <200404141229.26677.baldrick@free.fr> <200404261605.17486.baldrick@free.fr> <20040426221407.GB22719@kroah.com>
In-Reply-To: <20040426221407.GB22719@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200404271058.21778.oliver@neukum.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Am Dienstag, 27. April 2004 00:14 schrieb Greg KH:
> On Mon, Apr 26, 2004 at 04:05:17PM +0200, Duncan Sands wrote:
> > diff -Nru a/drivers/usb/core/devio.c b/drivers/usb/core/devio.c
> > --- a/drivers/usb/core/devio.c	Mon Apr 26 13:48:28 2004
> > +++ b/drivers/usb/core/devio.c	Mon Apr 26 13:48:28 2004
> > @@ -350,8 +350,8 @@
> >  	 * all pending I/O requests; 2.6 does that.
> >  	 */
> >
> > -	if (ifnum < 8*sizeof(ps->ifclaimed))
> > -		clear_bit(ifnum, &ps->ifclaimed);
> > +	BUG_ON(ifnum >= 8*sizeof(ps->ifclaimed));
>
> I've changed that to a WARN_ON().  Yeah, writing over memory is bad, but
> oopsing is worse.  Let's be a bit nicer than that.

You aren't nice that way. An oops has localised consequences. Scribbling
over memory can cause anything.

	Regards
		Oliver

