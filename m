Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261679AbULIX51@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261679AbULIX51 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Dec 2004 18:57:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261680AbULIX51
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Dec 2004 18:57:27 -0500
Received: from e34.co.us.ibm.com ([32.97.110.132]:62428 "EHLO
	e34.co.us.ibm.com") by vger.kernel.org with ESMTP id S261679AbULIX5X
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Dec 2004 18:57:23 -0500
Date: Thu, 9 Dec 2004 15:57:09 -0800
From: Greg KH <greg@kroah.com>
To: Linus Torvalds <torvalds@osdl.org>
Cc: akpm@osdl.org, linux-usb-devel@lists.sourceforge.net,
       linux-kernel@vger.kernel.org
Subject: Re: [BK PATCH] USB fixes for 2.6.10-rc3
Message-ID: <20041209235709.GA8147@kroah.com>
References: <20041209230900.GA6091@kroah.com> <Pine.LNX.4.58.0412091538510.31040@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0412091538510.31040@ppc970.osdl.org>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 09, 2004 at 03:41:47PM -0800, Linus Torvalds wrote:
> 
> 
> On Thu, 9 Dec 2004, Greg KH wrote:
> > 
> > Greg Kroah-Hartman:
> >   o USB: fix another sparse warning in the USB core
> 
> This one looks incorrect.
> 
> The code doesn't _fix_ any warnings. It just shuts them up, without fixing 
> anything at all.

No, the "fun" problem with this specific field (the wTotalLength one) is
that we initially read them in from the hardware (which for USB is in le
order) and then, in a later function, convert all of the le fields to
native cpu order so that all device drivers don't have to worry about
which fields in the usb structures are in which order.

I tried a while ago to create 2 different versions of the structures,
one in the "on the wire" format, and the other after we had converted
them to native format, but it just got too messy for no real good
reason.  I then just put the proper __force markings in the needed
places within the USB core.  Here's just a place where I had missed it
before for some reason.

Yeah, it's not the cleanest, and yes, it is just shutting the warning
up, but that's ok in this case.  I guess I could look into doing the
"two different structures" type thing again, if people don't like things
like this in different places.

thanks,

greg k-h
