Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261881AbVCLIFT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261881AbVCLIFT (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 12 Mar 2005 03:05:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261890AbVCLIFS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 12 Mar 2005 03:05:18 -0500
Received: from mail.kroah.org ([69.55.234.183]:6619 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261881AbVCLIFB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 12 Mar 2005 03:05:01 -0500
Date: Fri, 11 Mar 2005 23:25:23 -0800
From: Greg KH <greg@kroah.com>
To: long <tlnguyen@snoqualmie.dp.intel.com>
Cc: linux-kernel@vger.kernel.org, linux-pci@atrey.karlin.mff.cuni.cz,
       tom.l.nguyen@intel.com
Subject: Re: [PATCH 2/6] PCI Express Advanced Error Reporting Driver
Message-ID: <20050312072523.GC11236@kroah.com>
References: <200503120013.j2C0DXcK020305@snoqualmie.dp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200503120013.j2C0DXcK020305@snoqualmie.dp.intel.com>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 11, 2005 at 04:13:33PM -0800, long wrote:
> +static ssize_t aer_sysfs_consume_show(struct device_driver *dev, char *buf)
> +{
> +	return aer_fsprint_record(buf);
> +}
> +                  	
> +static ssize_t aer_sysfs_status_show(struct device_driver *dev, char *buf)
> +{
> +	return aer_fsprint_devices(buf);
> +}
> +                  	

Why call wrapper functions that only do one thing?  Why have this extra
layer of indirection that is not needed from what I can tell?

> +static ssize_t aer_sysfs_verbose_show(struct device_driver *dev, char *buf)
> +{
> +	return sprintf(buf, "Verbose display set to %d\n", 
> +		aer_get_verbose());				
> +}

Just echo the value, don't print out pretty strings :)

> +static ssize_t aer_sysfs_verbose_store(struct device_driver *drv, 	
> +					const char *buf, size_t count)  
> +{                            
> +	aer_set_verbose(buf[0] - 0x30);			
> +	return count;							
> +}

Oh, that's a problem waiting to happen... Please validate the user
provided value before acting on it.

> +static ssize_t aer_sysfs_auto_show(struct device_driver *dev, char *buf)
> +{
> +	return sprintf(buf, "Automatic reporting is %s\n", 		
> +		(aer_get_auto_mode()) ? "on" : "off");  			
> +}

Again, just print on/off.

> +static ssize_t aer_sysfs_auto_store(struct device_driver *drv, 	
> +					const char *buf, size_t count)          
> +{                            
> +	aer_set_auto_mode(buf[0] - 0x30);			
> +	return count;							
> +}

Also validate this.

thanks,

greg k-h
