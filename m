Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262402AbULCRcX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262402AbULCRcX (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Dec 2004 12:32:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262449AbULCRcW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Dec 2004 12:32:22 -0500
Received: from e1.ny.us.ibm.com ([32.97.182.141]:41113 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S262402AbULCRbV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Dec 2004 12:31:21 -0500
Date: Fri, 3 Dec 2004 09:03:51 -0800
From: Greg KH <greg@kroah.com>
To: Mikael Pettersson <mikpe@csd.uu.se>
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH][2.6.10-rc2-mm4] perfctr sysfs update 1/4: core
Message-ID: <20041203170351.GG28118@kroah.com>
References: <200412021010.iB2AAORk004531@alkaid.it.uu.se> <20041202185918.GA8264@kroah.com> <16816.14159.597170.829515@alkaid.it.uu.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <16816.14159.597170.829515@alkaid.it.uu.se>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 03, 2004 at 10:52:15AM +0100, Mikael Pettersson wrote:
> Greg KH writes:
>  > On Thu, Dec 02, 2004 at 11:10:24AM +0100, Mikael Pettersson wrote:
>  > > +static int __init perfctr_class_init(void)
>  > > +{
>  > > +	int ret;
>  > > +
>  > > +	ret = class_register(&perfctr_class);
>  > > +	if (ret)
>  > > +		return ret;
>  > > +	ret |= class_create_file(&perfctr_class, &class_attr_driver_version);
>  > > +	ret |= class_create_file(&perfctr_class, &class_attr_cpu_type);
>  > > +	ret |= class_create_file(&perfctr_class, &class_attr_cpu_features);
>  > > +	ret |= class_create_file(&perfctr_class, &class_attr_cpu_khz);
>  > > +	ret |= class_create_file(&perfctr_class, &class_attr_tsc_to_cpu_mult);
>  > > +	ret |= class_create_file(&perfctr_class, &class_attr_cpus_online);
>  > > +	ret |= class_create_file(&perfctr_class, &class_attr_cpus_forbidden);
>  > > +	if (ret)
>  > > +		class_unregister(&perfctr_class);
>  > > +	return ret;
>  > 
>  > It's easier to use sysfs_create_group() instead of registering all of
>  > the individual files.
> 
> Thanks for the hint. While looking around I noticed I can simplify
> it even further by having perfctr_class.class_attrs point to an array
> of attributes at class_register() time.

Nice, I forgot about that :)

greg k-h
