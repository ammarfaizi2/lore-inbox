Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266233AbUBKWws (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Feb 2004 17:52:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266255AbUBKWwr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Feb 2004 17:52:47 -0500
Received: from mail.kroah.org ([65.200.24.183]:487 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S266233AbUBKWwp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Feb 2004 17:52:45 -0500
Date: Wed, 11 Feb 2004 14:52:46 -0800
From: Greg KH <greg@kroah.com>
To: James Simmons <jsimmons@infradead.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Linux Fbdev development list 
	<linux-fbdev-devel@lists.sourceforge.net>
Subject: Re: fbdev driver and sysfs question.
Message-ID: <20040211225246.GA14776@kroah.com>
References: <Pine.LNX.4.44.0402112225360.25659-100000@phoenix.infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0402112225360.25659-100000@phoenix.infradead.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 11, 2004 at 10:26:45PM +0000, James Simmons wrote:
> 
> I attempted to port over the vesafb driver to show up in the sysfs tree.
> Unfortunely it just hanges my box. From the code can someone tell me what 
> I'm doing wrong?
> 
> 
> +static struct device_driver vesafb_driver = {
> +	.name	= "VESA framebuffer",
> +	.probe	= vesafb_probe,
> +};
> +
> +static struct platform_device vesafb_device = {
> +	.name	= "VESA framebuffer",
> +	.id	= 0,
> +};

No release function for this device?  Brave...

> +int __init vesafb_init(void)
> +{
> +	int ret;
> +
> +	ret = driver_register(&vesafb_driver);

Woah, you are registering a driver that is associated with no bus?  

Where would this driver show up in the driver model?

What are you trying to achieve here?  



> +	if (!ret) {
> +		ret = platform_device_register(&vesafb_device);

What are you doing with this device?  It will work this way, but would
be nicer if you hook it up to something.  Can you have more than one
vesafb_device per system?

You also need to consider changing those .name fields to something that
looks sane in the sysfs tree.

thanks,

greg k-h
