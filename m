Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964951AbWEYEDv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964951AbWEYEDv (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 25 May 2006 00:03:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964952AbWEYEDv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 25 May 2006 00:03:51 -0400
Received: from mail.suse.de ([195.135.220.2]:43756 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S964951AbWEYEDu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 25 May 2006 00:03:50 -0400
Date: Wed, 24 May 2006 21:01:34 -0700
From: Greg KH <greg@kroah.com>
To: Shaohua Li <shaohua.li@intel.com>
Cc: lkml <linux-kernel@vger.kernel.org>,
       Patrick Mochel <mochel@digitalimplant.org>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH 1/2] request_firmware without a device
Message-ID: <20060525040134.GA29974@kroah.com>
References: <1148529045.32046.102.camel@sli10-desk.sh.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1148529045.32046.102.camel@sli10-desk.sh.intel.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 25, 2006 at 11:50:45AM +0800, Shaohua Li wrote:
> The patch allows calling request_firmware without a 'struct device'.
> It appears we just need a name here from 'struct device'. I changed it
> to use a kobject as Patrick suggested.
> Next patch will use the new API to request firmware (microcode) for a CPU.

But a cpu does have a struct device.  Why not just use that?

> +fw_setup_class_device_id(struct class_device *class_dev, struct kobject *kobj)
>  {
>  	/* XXX warning we should watch out for name collisions */
> -	strlcpy(class_dev->class_id, dev->bus_id, BUS_ID_SIZE);
> +	strlcpy(class_dev->class_id, kobj->k_name, BUS_ID_SIZE);

There's a function for this, kobject_name(), please never touch k_name
directly.

> +EXPORT_SYMBOL(request_firmware_kobj);

Ick, if you really want to do this, just fix up all callers of
request_firmware(), there aren't that many of them.

But I don't recommend it anyway.

thanks,

greg k-h
