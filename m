Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261887AbUCLBGH (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Mar 2004 20:06:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261888AbUCLBGH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Mar 2004 20:06:07 -0500
Received: from mail.kroah.org ([65.200.24.183]:57817 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261887AbUCLBFu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Mar 2004 20:05:50 -0500
Date: Thu, 11 Mar 2004 16:34:06 -0800
From: Greg KH <greg@kroah.com>
To: Leann Ogasawara <ogasawara@osdl.org>
Cc: linux-kernel@vger.kernel.org, Hanna Linder <hannal@us.ibm.com>,
       faith@valinux.com
Subject: Re: [Dri-devel][PATCH] sysfs simple class support for DRI char device
Message-ID: <20040312003406.GB26958@kroah.com>
References: <1078517655.29095.32.camel@ibm-d.pdx.osdl.net> <20040311185221.GA20223@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040311185221.GA20223@kroah.com>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 11, 2004 at 10:52:21AM -0800, Greg KH wrote:
> >  	DRM_DEBUG("\n");
> > -	if (register_chrdev(DRM_MAJOR, "drm", &DRM(stub_fops)))
> > +	ret1 = register_chrdev(DRM_MAJOR, "drm", &DRM(stub_fops));
> > +	if (!ret1) {
> > +		drm_class = class_simple_create(THIS_MODULE, "drm");
> > +		if (IS_ERR(drm_class)) {
> > +			printk (KERN_ERR "Error creating drm class.\n");
> > +			unregister_chrdev(DRM_MAJOR, "drm");
> > +			return PTR_ERR(drm_class);
> > +		}
> > +	}
> > +	else if (ret1 == -EBUSY)
> >  		i = (struct drm_stub_info *)inter_module_get("drm");
> > +	else
> > +		return -1;
> 
> If ret1 == -EBUSY then we never create the "drm" class_simple structure,
> right?  That's not good.
> 
> Care to fix this up and send a new patch?

In talking about this on irc, I agree I was wrong.  I'll go apply this
patch now.

thanks,

greg k-h
