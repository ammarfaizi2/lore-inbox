Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261708AbULBTAh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261708AbULBTAh (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Dec 2004 14:00:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261717AbULBTAh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Dec 2004 14:00:37 -0500
Received: from e31.co.us.ibm.com ([32.97.110.129]:49092 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP id S261708AbULBTAF
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Dec 2004 14:00:05 -0500
Date: Thu, 2 Dec 2004 10:59:18 -0800
From: Greg KH <greg@kroah.com>
To: Mikael Pettersson <mikpe@csd.uu.se>
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH][2.6.10-rc2-mm4] perfctr sysfs update 1/4: core
Message-ID: <20041202185918.GA8264@kroah.com>
References: <200412021010.iB2AAORk004531@alkaid.it.uu.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200412021010.iB2AAORk004531@alkaid.it.uu.se>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 02, 2004 at 11:10:24AM +0100, Mikael Pettersson wrote:
> +static int __init perfctr_class_init(void)
> +{
> +	int ret;
> +
> +	ret = class_register(&perfctr_class);
> +	if (ret)
> +		return ret;
> +	ret |= class_create_file(&perfctr_class, &class_attr_driver_version);
> +	ret |= class_create_file(&perfctr_class, &class_attr_cpu_type);
> +	ret |= class_create_file(&perfctr_class, &class_attr_cpu_features);
> +	ret |= class_create_file(&perfctr_class, &class_attr_cpu_khz);
> +	ret |= class_create_file(&perfctr_class, &class_attr_tsc_to_cpu_mult);
> +	ret |= class_create_file(&perfctr_class, &class_attr_cpus_online);
> +	ret |= class_create_file(&perfctr_class, &class_attr_cpus_forbidden);
> +	if (ret)
> +		class_unregister(&perfctr_class);
> +	return ret;

It's easier to use sysfs_create_group() instead of registering all of
the individual files.

thanks,

greg k-h
