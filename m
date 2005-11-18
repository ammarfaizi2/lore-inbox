Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964795AbVKRQqZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964795AbVKRQqZ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Nov 2005 11:46:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964816AbVKRQqZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Nov 2005 11:46:25 -0500
Received: from mail.kroah.org ([69.55.234.183]:13523 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S964795AbVKRQqZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Nov 2005 11:46:25 -0500
Date: Thu, 17 Nov 2005 17:39:04 -0800
From: Greg KH <greg@kroah.com>
To: Ingo Oeser <ioe-lkml@rameria.de>
Cc: linux-kernel@vger.kernel.org, Greg KH <gregkh@suse.de>,
       Alan Stern <stern@rowland.harvard.edu>,
       linux-usb-devel@lists.sourceforge.net
Subject: Re: [linux-usb-devel] [PATCH 02/02] USB: add dynamic id functionality to USB core
Message-ID: <20051118013904.GA11916@kroah.com>
References: <20051117003241.GC14896@kroah.com> <Pine.LNX.4.44L0.0511171049070.5089-100000@iolanthe.rowland.org> <20051117162533.GB26824@suse.de> <200511172058.48797.ioe-lkml@rameria.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200511172058.48797.ioe-lkml@rameria.de>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 17, 2005 at 08:58:42PM +0100, Ingo Oeser wrote:
> Hi,
> 
> On Thursday 17 November 2005 17:25, Greg KH wrote:
> > On Thu, Nov 17, 2005 at 10:55:33AM -0500, Alan Stern wrote:
> > > On Wed, 16 Nov 2005, Greg KH wrote:
> > > > +static int usb_create_newid_file(struct usb_driver *usb_drv)
> > > > +{
> > > > +	int error = 0;
> > > > +
> > > > +	if (usb_drv->probe != NULL)
> > > > +		error = sysfs_create_file(&usb_drv->driver.kobj,
> > > > +					  &driver_attr_new_id.attr);
> > > > +	return error;
> > > > +}
> > > 
> > > This deserves to be an inline function.
> 
> Come on, this is just a gloryfied if :-)
> 
> static inline int usb_create_newid_file(struct usb_driver *usb_drv)
> {
> 	if (usb_drv->probe != NULL) {
> 		return sysfs_create_file(&usb_drv->driver.kobj,
> 					  &driver_attr_new_id.attr);
> 	} else {
> 		return 0;
> 	}
> }

Yes it is.  But it's an #ifdef if, which makes it want to be a separate
function.

thanks,

greg k-h
