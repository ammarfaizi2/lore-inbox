Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262256AbTEUTxS (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 May 2003 15:53:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262257AbTEUTxS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 May 2003 15:53:18 -0400
Received: from e5.ny.us.ibm.com ([32.97.182.105]:15810 "EHLO e5.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S262256AbTEUTxQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 May 2003 15:53:16 -0400
Date: Wed, 21 May 2003 13:07:36 -0700
From: Greg KH <greg@kroah.com>
To: Manuel Estrada Sainz <ranty@debian.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
       Simon Kelley <simon@thekelleys.org.uk>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>, jt@hpl.hp.com,
       Pavel Roskin <proski@gnu.org>, Oliver Neukum <oliver@neukum.org>,
       David Gibson <david@gibson.dropbear.id.au>
Subject: Re: [PATCH] Re: request_firmware() hotplug interface, third round and a halve
Message-ID: <20030521200736.GA2606@kroah.com>
References: <20030517221921.GA28077@ranty.ddts.net> <20030521072318.GA12973@kroah.com> <20030521185212.GC12677@ranty.ddts.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030521185212.GC12677@ranty.ddts.net>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 21, 2003 at 08:52:12PM +0200, Manuel Estrada Sainz wrote:
> On Wed, May 21, 2003 at 12:23:18AM -0700, Greg KH wrote:
> > Oops, forgot to respond to this, sorry...
> > 
> > On Sun, May 18, 2003 at 12:19:22AM +0200, Manuel Estrada Sainz wrote:
> [snip]
> > >  - There is a timeout, changeable from userspace. Feedback on a
> > >    reasonable default value appreciated.
> > 
> > Is this really needed?  Especially as you now have:
> 
>  There is currently no way to know if hotplug couldn't be called at all
>  or if it failed because it didn't have firmware load support.
> 
>  If that happens, we would be waiting for ever. And I'd rather make that
>  a countable number of seconds :)
> 
>  I'll make '0' mean no timeout at all.

Ok, that's fine with me.  A bit of documentation for all of this might
be nice.  Just add some kerneldoc comments to your public functions, and
you should be fine.

>  I am not sure on how to implement "if a driver that uses it is
>  selected" and not sure on where to add the Kconfig entries to make it
>  available to out-of-kernel modules.

You could do something like what has been done for the mii module.  Look
at lib/Makefile and drivers/usb/net/Makefile.mii for an example.

I'm not saying that this is the best way, but it could be one solution.
Ideally, the user would never have to select the firmware core option,
it would just get automatically built if a driver that needs it is also
selected.

>  Patches:

The patches look great.  Add a bit of documentation, and some build
integration, and I'd think you are finished.  Unless anyone else has any
objections?

Very nice job, thanks again for doing this.

greg k-h
