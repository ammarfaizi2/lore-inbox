Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261365AbVFCVRh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261365AbVFCVRh (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Jun 2005 17:17:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261397AbVFCVRh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Jun 2005 17:17:37 -0400
Received: from mail.kroah.org ([69.55.234.183]:5867 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261365AbVFCVRd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Jun 2005 17:17:33 -0400
Date: Fri, 3 Jun 2005 13:33:26 -0700
From: Greg KH <greg@kroah.com>
To: Abhay_Salunke@Dell.com
Cc: marcel@holtmann.org, linux-kernel@vger.kernel.org, akpm@osdl.org,
       Matt_Domsch@Dell.com
Subject: Re: [patch 2.6.12-rc3] dell_rbu: Resubmitting patch for new DellBIOS update driver
Message-ID: <20050603203326.GA8092@kroah.com>
References: <367215741E167A4CA813C8F12CE0143B3ED3AA@ausx2kmpc115.aus.amer.dell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <367215741E167A4CA813C8F12CE0143B3ED3AA@ausx2kmpc115.aus.amer.dell.com>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 03, 2005 at 02:57:23PM -0500, Abhay_Salunke@Dell.com wrote:
> > > At what point I should be calling request_firmware?
> > 
> > Never, you should call request_firmware_nowait() instead.  And do it
> > from your module init function.
> > 
> > > As my driver does
> > > not have any entry points. In this driver it is called when the user
> is
> > > ready to download the firmware image (when it echoes the firmware
> image
> > > name). Also the driver needs to be resident for handling multiple
> such
> > > requests; that's why cannot do this at driver init time.
> > 
> > That's what request_firmware_nowait() is for.
> > 
> But isn't request_firmware_nowait a one time deal.

Yes.

> It creates a kernel thread which will call the cont function once and
> end it.

Yes.

And in that cont function, you can do whatever you want, like handle the
firmware given to you, copy it off to whereever you need to, and if you
want, call request_firmware_nowait again for another firmware to be sent
to you...

> In that case I will have to unload and reload the driver every time
> before doing an update.

No, see above.

> Also driver's unload has to free the allocated memory; this will not
> serve the purpose of this driver.

See above.

> > > When ever the user echoes the file name, it gets passed on to
> > > request_firmware and the $FIRMWARE env gets populated with the file
> > > name. thus making the hotplug code to automatically load the image
> which
> > > is passed back as fw->data and fw->size.
> > 
> > It's easier for the user to just copy the firmware to the sysfs file
> > whenever they want to.  No messing with hotplug events or filenames.
> > 
> I must be missing some things here. Can copying the data to the sysfs
> file with normal attributes work?

The firmware class creates a sysfs file.  That is what I am referring to
here.

thanks,

greg k-h
