Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264226AbUDNN3O (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Apr 2004 09:29:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264231AbUDNN3O
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Apr 2004 09:29:14 -0400
Received: from mail1.kontent.de ([81.88.34.36]:48339 "EHLO Mail1.KONTENT.De")
	by vger.kernel.org with ESMTP id S264226AbUDNN3K (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Apr 2004 09:29:10 -0400
From: Oliver Neukum <oliver@neukum.org>
To: Duncan Sands <baldrick@free.fr>, Greg KH <greg@kroah.com>
Subject: Re: [linux-usb-devel] [PATCH 8/9] USB usbfs: missing lock in proc_getdriver
Date: Wed, 14 Apr 2004 15:29:06 +0200
User-Agent: KMail/1.5.1
Cc: linux-usb-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org,
       Frederic Detienne <fd@cisco.com>
References: <200404141247.24227.baldrick@free.fr> <200404141304.48641.oliver@neukum.org> <200404141337.28631.baldrick@free.fr>
In-Reply-To: <200404141337.28631.baldrick@free.fr>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200404141529.06710.oliver@neukum.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Am Mittwoch, 14. April 2004 13:37 schrieb Duncan Sands:
> On Wednesday 14 April 2004 13:04, Oliver Neukum wrote:
> > > +	down_read(&usb_bus_type.subsys.rwsem);
> > > +	if (interface && interface->dev.driver) {
> > > +		strncpy(gd.driver, interface->dev.driver->name, sizeof(gd.driver));
> > > +		ret = copy_to_user(arg, &gd, sizeof(gd)) ? -EFAULT : 0;
> > > +	}
> > > +	up_read(&usb_bus_type.subsys.rwsem);
> > > +	return ret;
> >
> > IMHO you should drop the lock before you copy to userspace.
>
> Hi Oliver, I wasn't particularly worried about it since it's a rwsem taken
> for reading and writing is a rare event.  Do you think it really matters? 
> If so, how about this instead (compiles but otherwise untested):

Hi,

I expect it to rarely matter, but it might matter now and then. It's
just a question of hygiene. If you are using a temporary buffer I'd
like to see it used to full advantage. So either drop the lock or do
a direct copy. I'd prefer the first option your patch implemented.

	Regards
		Oliver

