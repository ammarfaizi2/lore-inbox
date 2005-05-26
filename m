Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261793AbVEZVOB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261793AbVEZVOB (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 May 2005 17:14:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261791AbVEZVMf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 May 2005 17:12:35 -0400
Received: from mail.kroah.org ([69.55.234.183]:62399 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261803AbVEZVLi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 May 2005 17:11:38 -0400
Date: Thu, 26 May 2005 13:37:57 -0700
From: Greg KH <greg@kroah.com>
To: Abhay_Salunke@Dell.com
Cc: linux-kernel@vger.kernel.org, ranty@debian.org
Subject: Re: [patch 2.6.12-rc3] dell_rbu: Resubmitting patch for new Dell BIOS update driver
Message-ID: <20050526203757.GA18723@kroah.com>
References: <367215741E167A4CA813C8F12CE0143B3ED399@ausx2kmpc115.aus.amer.dell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <367215741E167A4CA813C8F12CE0143B3ED399@ausx2kmpc115.aus.amer.dell.com>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 26, 2005 at 11:37:44AM -0500, Abhay_Salunke@Dell.com wrote:
> > -----Original Message-----
> > From: Greg KH [mailto:greg@kroah.com]
> > Sent: Monday, May 23, 2005 10:48 AM
> > To: Salunke, Abhay
> > Cc: linux-kernel@vger.kernel.org; akpm@osdl.org; Domsch, Matt
> > Subject: Re: [patch 2.6.12-rc3] dell_rbu: Resubmitting patch for new
> Dell
> > BIOS update driver
> > 
> > On Mon, May 23, 2005 at 09:52:05AM -0500, Abhay_Salunke@Dell.com
> wrote:
> > > Greg,
> > > >
> > > > Also, what's wrong with using the existing firmware interface in
> the
> > > > kernel?
> > > request_firmware requires the $FIRMWARE env to be populated with the
> > > firmware image name or the firmware image name needs to be hardcoded
> > > within  the call to request_firmware. Since the user is free to
> change
> > > the BIOS update image at will, it may not be possible if we use
> > > $FIRMWARE also I am not sure if this env variable might be
> conflicting
> > > to some other driver.
> > 
> > As others have already stated, this doesn't really matter.  Make it
> > "dell_bios_update", if any device names their firmware that, well,
> > that's their problem...
> 
> OK, I have been trying to use request_firmware but it always fails with
> return code -2. This is the code snippet below, any thoughts?
> 
> static struct device rbu_device_type;
> 
> static struct device rbu_device;

Struct devices must be created with kmalloc.

> static int __init dcdrbu_init(void)
> {
>         int rc = 0;
>         const struct firmware *fw;
> 
>         device_initialize(&rbu_device_type);
>         device_initialize(&rbu_device);
> 
>         strncpy(rbu_device.bus_id,"dell_rbu.bin", BUS_ID_SIZE);
>         strncpy(rbu_device_type.bus_id,"dell_rbu1.bin", BUS_ID_SIZE);
> 
>         rc = request_firmware(&fw, "dell_rbu_type", &rbu_device_type);

Try registering the device with sysfs first.

Good luck,

greg k-h
