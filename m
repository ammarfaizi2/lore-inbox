Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265174AbUD3MsS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265174AbUD3MsS (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Apr 2004 08:48:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265176AbUD3MsS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Apr 2004 08:48:18 -0400
Received: from smtp801.mail.sc5.yahoo.com ([66.163.168.180]:63313 "HELO
	smtp801.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S265174AbUD3MsQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Apr 2004 08:48:16 -0400
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: linux-kernel@vger.kernel.org, maneesh@in.ibm.com
Subject: Re: [RFC 1/2] kobject_set_name - error handling
Date: Fri, 30 Apr 2004 07:48:13 -0500
User-Agent: KMail/1.6.1
Cc: viro@parcelfarce.linux.theplanet.co.uk, Greg KH <greg@kroah.com>,
       Jeff Garzik <jgarzik@pobox.com>
References: <20040417082206.GM24997@parcelfarce.linux.theplanet.co.uk> <20040430101333.GB25296@in.ibm.com> <20040430101401.GC25296@in.ibm.com>
In-Reply-To: <20040430101401.GC25296@in.ibm.com>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200404300748.14151.dtor_core@ameritech.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 30 April 2004 05:14 am, Maneesh Soni wrote:

> diff -puN drivers/base/bus.c~kobject_set_name-cleanup-01 drivers/base/bus.c
> --- linux-2.6.6-rc2-mm2/drivers/base/bus.c~kobject_set_name-cleanup-01	2004-04-30 15:14:03.000000000 +0530
> +++ linux-2.6.6-rc2-mm2-maneesh/drivers/base/bus.c	2004-04-30 15:14:03.000000000 +0530
> @@ -451,7 +451,9 @@ int bus_add_driver(struct device_driver 
>  
>  	if (bus) {
>  		pr_debug("bus %s: add driver %s\n",bus->name,drv->name);
> -		kobject_set_name(&drv->kobj,drv->name);
> +		error = kobject_set_name(&drv->kobj,drv->name);
> +		if (error)
> +			return error;

Hi, I think you are leaking a reference here, put_bus() is needed.

>  		drv->kobj.kset = &bus->drivers;
>  		if ((error = kobject_register(&drv->kobj))) {
>  			put_bus(bus);

-- 
Dmitry
