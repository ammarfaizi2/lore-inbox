Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317876AbSIOGsr>; Sun, 15 Sep 2002 02:48:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317887AbSIOGsr>; Sun, 15 Sep 2002 02:48:47 -0400
Received: from 12-231-243-94.client.attbi.com ([12.231.243.94]:22798 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S317876AbSIOGsq>;
	Sun, 15 Sep 2002 02:48:46 -0400
Date: Sat, 14 Sep 2002 23:49:44 -0700
From: Greg KH <greg@kroah.com>
To: Brad Hards <bhards@bigpond.net.au>
Cc: oliver@neukum.name, Brian Craft <bcboy@thecraftstudio.com>,
       linux-kernel@vger.kernel.org
Subject: Re: delay before open() works
Message-ID: <20020915064944.GA727@kroah.com>
References: <20020914094225.A1267@porky.localdomain> <200209151525.01920.bhards@bigpond.net.au> <20020915061026.GA484@kroah.com> <200209151638.32883.bhards@bigpond.net.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200209151638.32883.bhards@bigpond.net.au>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 15, 2002 at 04:38:32PM +1000, Brad Hards wrote:
> On Sun, 15 Sep 2002 16:10, Greg KH wrote:
> > This "second" hotplug event will happen when the driver registers with
> > the "class".  So for the example of the USB scanner driver, it registers
> > itself with the USB "class" to set up the file_ops structure (this is
> > done in usb_register_dev().  At that point in time, /sbin/hotplug will
> > be called again.
> This is too soon, at least for the scanner driver. Look at how much code runs 
> in scanner_probe() between the fops registration and the devfs registration.
> 
> Hmmm, that is probably a race anyway. Oliver?

You're right, that is a race.  And is due to the historical fact that
usb_register() used to also register the fops structure at the same
time.  Now that the functions are split apart, the call to
usb_register_dev() should be done at the same place as the call to
devfs_register().  Patches gladly accepted :)

thanks,

greg k-h
