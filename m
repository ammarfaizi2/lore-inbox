Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262766AbUCJSvS (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Mar 2004 13:51:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262770AbUCJSvS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Mar 2004 13:51:18 -0500
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:5063 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id S262766AbUCJSvO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Mar 2004 13:51:14 -0500
Date: Wed, 10 Mar 2004 19:51:05 +0100
From: Adrian Bunk <bunk@fs.tum.de>
To: Corey Minyard <minyard@acm.org>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       "Davis, Todd C" <todd.c.davis@intel.com>, greg@kroah.com,
       sensors@stimpy.netroedge.com, "Simon G. Vogl" <simon@tk.uni-linz.ac.at>
Subject: Re: 2.6.4-rc2-mm1: IPMI_SMB doesnt compile
Message-ID: <20040310185105.GS14833@fs.tum.de>
References: <20040307223221.0f2db02e.akpm@osdl.org> <20040309013917.GH14833@fs.tum.de> <404F3BC3.2090906@acm.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <404F3BC3.2090906@acm.org>
User-Agent: Mutt/1.4.2i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 10, 2004 at 10:01:07AM -0600, Corey Minyard wrote:
>...
> I have included a patch from Todd Davis at Intel that adds this function 
> to the I2C driver.  I believe Todd has been working on getting this in 
> through the I2C driver writers, although the patch is fairly non-intrusive.
> 
> However, I have no real way to test this patch.
>...

I can only confirm that it fixes the compilation...


The patch to i2c-core.c is strange:


> --- linux-v31/drivers/i2c/i2c-core.c	2004-02-19 19:31:07.000000000 -0600
> +++ linux/drivers/i2c/i2c-core.c	2004-03-10 09:48:08.000000000 -0600
> @@ -1256,6 +1256,12 @@
>  	return (func & adap_func) == func;
>  }
>  
> +int i2c_spin_delay;
> +void i2c_set_spin_delay(int val)
> +{
> +	i2c_spin_delay = val;
> +}
> +
>  EXPORT_SYMBOL(i2c_add_adapter);
>  EXPORT_SYMBOL(i2c_del_adapter);
>  EXPORT_SYMBOL(i2c_add_driver);
> @@ -1292,6 +1298,8 @@
>  
>  EXPORT_SYMBOL(i2c_get_functionality);
>  EXPORT_SYMBOL(i2c_check_functionality);
> +EXPORT_SYMBOL(i2c_set_spin_delay);
> +EXPORT_SYMBOL(i2c_spin_delay);
>  
>  MODULE_AUTHOR("Simon G. Vogl <simon@tk.uni-linz.ac.at>");
>  MODULE_DESCRIPTION("I2C-Bus main module");
>...


You can either add get/set functions and export them (more an OO 
paradigm) or export the variable.

If you export the variable, it's quite useless to add such a set 
function since everyone can set the variable directly.


cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

