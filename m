Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261349AbTDCQzR 
	(for <rfc822;willy@w.ods.org>); Thu, 3 Apr 2003 11:55:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id S261351AbTDCQzR 
	(for <rfc822;linux-kernel-outgoing>); Thu, 3 Apr 2003 11:55:17 -0500
Received: from granite.he.net ([216.218.226.66]:53001 "EHLO granite.he.net")
	by vger.kernel.org with ESMTP id S261349AbTDCQzQ 
	(for <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Apr 2003 11:55:16 -0500
Date: Thu, 3 Apr 2003 09:07:26 -0800
From: Greg KH <greg@kroah.com>
To: DervishD <raul@pleyades.net>
Cc: Linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: USB Mouse issue
Message-ID: <20030403170726.GA4849@kroah.com>
References: <20030402193731.GA1273@DervishD> <20030403005344.GA5361@kroah.com> <20030403101033.GC47@DervishD>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030403101033.GC47@DervishD>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 03, 2003 at 12:10:33PM +0200, DervishD wrote:
>     Hi Greg :)
> 
>  Greg KH dixit:
> > >     But when I do 'gpm -m mouse -p -t imps2' I have a 'ENODEV'. Same
> > > if I try to open 'mouse' with cat or the like, always ENODEV:
> > >     crw-r--r--  1 root root 180,16 mouse
> > No, this interface (Major 180, minor 16) is long out of date.  You have
> > to use the input core now.
> 
>     And that means activate INPUT_MOUSEDEV and load the module, ok,
> but then, usbmouse does anything? Is it necessary for the USB mouse?

The ONLY reason you would want to use the usbmouse driver is if you are
building an embedded system.  Please read the configuration help files
about this.

What you want is the hid driver.  Use that, and select INPUT_MOUSEDEV.

>     Excuse me, none of the above was needed, just created the node
> (char 13,64) and run gpm saying that the mouse is of 'evdev' type. No
> INPUT_MOUSEDEV needed :) Just one curiosity: the usbmouse module
> shows as 'unused', in fact is 'evdev' the one used by 'gpm', but if I
> unload the usbmouse module (which I can do even with gpm running)
> then gpm stops working! I mean, the usbmouse module can be rmmod'ed
> but it is in use! Is this a bug? I'm afraid I must mark this module
> as not autocleanable :((( and it will remain loaded even if I stop
> using the mouse. Any advice?

No, it's not a bug, it's the way the author wants it.  The module does
not show up as being used as it would be a bit hard to unplug your
mouse or keyboard and then try to unload the module :)

thanks,

greg k-h
