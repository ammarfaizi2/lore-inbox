Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262069AbVELQE4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262069AbVELQE4 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 May 2005 12:04:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262070AbVELQE4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 May 2005 12:04:56 -0400
Received: from mail.kroah.org ([69.55.234.183]:5614 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S262069AbVELQEx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 May 2005 12:04:53 -0400
Date: Thu, 12 May 2005 09:04:56 -0700
From: Greg KH <greg@kroah.com>
To: Andrew Morton <akpm@osdl.org>
Cc: adobriyan@gmail.com, linux-kernel@vger.kernel.org, airlied@linux.ie,
       davej@codemonkey.org.uk, linux-fbdev-devel@lists.sourceforge.net
Subject: Re: kobject_register failed for intelfb (-EACCES) (Re: 2.6.12-rc4-mm1)
Message-ID: <20050512160456.GA22177@kroah.com>
References: <20050512033100.017958f6.akpm@osdl.org> <200505121658.02019.adobriyan@gmail.com> <20050512154335.GD21765@kroah.com> <20050512085933.03dc0d10.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050512085933.03dc0d10.akpm@osdl.org>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 12, 2005 at 08:59:33AM -0700, Andrew Morton wrote:
> Greg KH <greg@kroah.com> wrote:
> >
> > 
> >  On Thu, May 12, 2005 at 04:58:01PM +0400, Alexey Dobriyan wrote:
> >  > kobject Intel(R) 830M/845G/852GM/855GM/865G/915G Framebuffer Driver:
> >  > registering. parent: <NULL>, set: drivers
> >  > kobject_register failed for Intel(R) 830M/845G/852GM/855GM/865G/915G
> > 
> >  Someone tried to put a "/" in a kobject name, which is not allowed.
> >  Actually the name seems to be set to:
> >  	"Intel(R) 830M/845G/852GM/855GM/865G/915G Framebuffer Driver"
> >  which is a bit verbous if you want to create a directory name :)
> 
> I don't think that part of the driver has changed in some time.  Is there
> something new in your trees which would trigger this?

No, not that I know of.

> Seems like a fix such as this will be needed:
> 
> --- 25/drivers/video/intelfb/intelfbdrv.c~intelfbdrv-naming-fix	2005-05-12 08:54:46.000000000 -0700
> +++ 25-akpm/drivers/video/intelfb/intelfbdrv.c	2005-05-12 08:55:03.000000000 -0700
> @@ -214,7 +214,7 @@ static struct fb_ops intel_fb_ops = {
>  
>  /* PCI driver module table */
>  static struct pci_driver intelfb_driver = {
> -	.name =		"Intel(R) " SUPPORTED_CHIPSETS " Framebuffer Driver",
> +	.name =		"intelfb",

Did the SUPPORTED_CHIPSETS macro change somehow?

Anyway, the patch looks correct to me.

thanks,

greg k-h
