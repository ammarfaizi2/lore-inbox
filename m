Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262690AbVAKBkz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262690AbVAKBkz (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Jan 2005 20:40:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262568AbVAKBkw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Jan 2005 20:40:52 -0500
Received: from mail.kroah.org ([69.55.234.183]:53900 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S262690AbVAKBig (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Jan 2005 20:38:36 -0500
Date: Mon, 10 Jan 2005 17:36:01 -0800
From: Greg KH <greg@kroah.com>
To: Chad Kitching <CKitching@powerlandcomputers.com>
Cc: Pete Zaitcev <zaitcev@redhat.com>,
       linux-usb-devel@lists.sourcefoge.net.kroah.org,
       linux-kernel@vger.kernel.org, laforge@gnumonks.org
Subject: Re: My vision of usbmon
Message-ID: <20050111013601.GG18697@kroah.com>
References: <18DFD6B776308241A200853F3F83D5072851@pl6w2kex.lan.powerlandcomputers.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <18DFD6B776308241A200853F3F83D5072851@pl6w2kex.lan.powerlandcomputers.com>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 23, 2004 at 03:02:49PM -0600, Chad Kitching wrote:
> > -----Original Message-----
> > From: Greg KH [mailto:greg@kroah.com]
> > Sent: December 21, 2004 11:11 PM
> > Subject: Re: My vision of usbmon
> > 
> > -/* exported only within usbcore */
> > -struct usb_bus *usb_bus_get (struct usb_bus *bus)
> > +struct usb_bus *usb_bus_get(struct usb_bus *bus)
> >  {
> > -	struct class_device *tmp;
> > -
> > -	if (!bus)
> > -		return NULL;
> > -
> > -	tmp = class_device_get(&bus->class_dev);
> > -	if (tmp)        
> > -		return to_usb_bus(tmp);
> > -	else
> > -		return NULL;
> > +	if (bus)
> > +		class_device_get(&bus->class_dev);
> > +	return bus; 
> >  }
> > +EXPORT_SYMBOL_GPL(usb_bus_get);
>   
> I'm not familiar with this code, but if the replacement code is 
> equivalent, is there any point to the return usb_bus pointer?  With 
> the replacement, you should always get the same pointer you put 
> into it.  If that is the case, why not remove the return value, and 
> change drivers/usb/core/usb.c to match?

Because that goes against the "style" of the _get functions in the
driver core.  This way, it's easy to just do:
	some_function(usb_bus_get(my_bus), foo);

thanks,

greg k-h
