Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262780AbTDIE5t (for <rfc822;willy@w.ods.org>); Wed, 9 Apr 2003 00:57:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262784AbTDIE5t (for <rfc822;linux-kernel-outgoing>); Wed, 9 Apr 2003 00:57:49 -0400
Received: from granite.he.net ([216.218.226.66]:6157 "EHLO granite.he.net")
	by vger.kernel.org with ESMTP id S262780AbTDIE5r (for <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Apr 2003 00:57:47 -0400
Date: Tue, 8 Apr 2003 22:09:33 -0700
From: Greg KH <greg@kroah.com>
To: DervishD <raul@pleyades.net>
Cc: Linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: USB Mouse issue
Message-ID: <20030409050933.GC9073@kroah.com>
References: <20030402193731.GA1273@DervishD> <20030403005344.GA5361@kroah.com> <20030403101033.GC47@DervishD> <20030403170726.GA4849@kroah.com> <20030403205057.GA399@DervishD>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20030403205057.GA399@DervishD>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 03, 2003 at 10:50:57PM +0200, DervishD wrote:
>  Greg KH dixit:
> > > > No, this interface (Major 180, minor 16) is long out of date.  You have
> > > > to use the input core now.
> > >     And that means activate INPUT_MOUSEDEV and load the module, ok,
> > > but then, usbmouse does anything? Is it necessary for the USB mouse?
> > The ONLY reason you would want to use the usbmouse driver is if you are
> > building an embedded system.  Please read the configuration help files
> > about this.
> 
>     Which one, Configure.help? I've read the entry for usbmouse and I
> didn't found any info :?

The help entry for CONFIG_USB_MOUSE says:

  Say Y here only if you are absolutely sure that you don't want
  to use the generic HID driver for your USB keyboard and prefer
  to use the keyboard in its limited Boot Protocol mode instead.

  This is almost certainly not what you want.

  This code is also available as a module ( = code which can be
  inserted in and removed from the running kernel whenever you want).
  The module will be called usbmouse.o. If you want to compile it as
  a module, say M here and read <file:Documentation/modules.txt>.

  If even remotely unsure, say N.


Based on that, I would hope it would have enough info to scare you from
trying to use it :)

> > What you want is the hid driver.  Use that, and select INPUT_MOUSEDEV.
> 
>     Which advantages has this method. I mean, the mouse works with
> gpm and usbmouse, and that is all I need. Maybe X problems?

Please use the HID driver, it will work out much better in the long run.

> > > but it is in use! Is this a bug? I'm afraid I must mark this module
> > > as not autocleanable :((( and it will remain loaded even if I stop
> > > using the mouse. Any advice?
> > No, it's not a bug, it's the way the author wants it.  The module does
> > not show up as being used as it would be a bit hard to unplug your
> > mouse or keyboard and then try to unload the module :)
> 
>     Didn't think about that, obviously ;))) The fact that I never
> hotunplug a USB device doesn't mean it cannot be done ;)) Anyway,
> this renders the autoclean feature unusable for that module ¿true?.
> So, you must unload it by hand or, better, built into core.

Yes, "autoclean" does not like usb drivers (among others.)  I don't
think any distro uses that anymore.

Glad it's working for you.

greg k-h
