Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262024AbVCNXCX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262024AbVCNXCX (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Mar 2005 18:02:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262056AbVCNW7G
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Mar 2005 17:59:06 -0500
Received: from mail.kroah.org ([69.55.234.183]:9962 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S262026AbVCNW52 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Mar 2005 17:57:28 -0500
Date: Mon, 14 Mar 2005 14:57:16 -0800
From: Greg KH <greg@kroah.com>
To: Corey Minyard <minyard@acm.org>
Cc: Andrew Morton <akpm@osdl.org>, lkml <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Add sysfs support to the IPMI driver
Message-ID: <20050314225716.GA9779@kroah.com>
References: <4233C834.40903@acm.org> <20050313052011.GA18089@kroah.com> <4234C5C2.8000109@acm.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4234C5C2.8000109@acm.org>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 13, 2005 at 04:59:14PM -0600, Corey Minyard wrote:
> Greg KH wrote:
> >On Sat, Mar 12, 2005 at 10:57:24PM -0600, Corey Minyard wrote:
> >>The IPMI driver has long needed to tie into the device model (and I've 
> >>long been hoping someone else would do it).  I finally gave up and spent 
> >>the time to learn how to do it.  I think this is right, it seems to work 
> >>on on my system.
> >
> >Looks good.  One minor question:
> >
> >>+
> >>+	snprintf(name, sizeof(name), "ipmi%d", if_num);
> >>+	class_simple_device_add(ipmi_class, dev, NULL, name);
> >
> >What do ipmi class devices live on?  pci devices?  i2c devices?
> >platform devices?  Or are they purely virtual things?
> >
> Good question.  I struggled with this for a little while and decided the 
> class interface was important to have in first and I'd figure out the 
> rest later.  They live in different places depending on the particular 
> low-level interface.  Some live on the I2C bus (and will show up there 
> in sysfs with the I2C driver).  Some live on the ISA bus, some are 
> memory-mapped, some are on the PCI bus (though there is not a driver for 
> PCI support yet), and some sit on the end of a serial port (driver is in 
> the works).  I know, it's a mess, but there's not much I can do about 
> these crazy hardware manufacturers.
> 
> I wasn't sure where to handle all this.  The I2C and PCI bus side of 
> things should be handled.  However, the others probably need to sit 
> someplace on a bus, right?  That should probably be handled in the 
> low-level code that actually knows where the hardware sits.

Well, how about handling the devices that already have a struct device
today (like the i2c and pci devices)?  Pass the pointer to that device
into your class_simple_device_add() call.  Then, work on figuring out
where your other devices live on some new bus later.

thanks,

greg k-h
