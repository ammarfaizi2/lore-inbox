Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269366AbUIRPns@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269366AbUIRPns (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 18 Sep 2004 11:43:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269553AbUIRPns
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 18 Sep 2004 11:43:48 -0400
Received: from smtp801.mail.sc5.yahoo.com ([66.163.168.180]:113 "HELO
	smtp801.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S269366AbUIRPnp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 18 Sep 2004 11:43:45 -0400
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: linux-kernel@vger.kernel.org
Subject: Re: bus_type->dev_attrs not properly thought out
Date: Sat, 18 Sep 2004 10:43:41 -0500
User-Agent: KMail/1.6.2
Cc: Russell King <rmk+lkml@arm.linux.org.uk>, Greg KH <greg@kroah.com>
References: <20040918155659.B17085@flint.arm.linux.org.uk>
In-Reply-To: <20040918155659.B17085@flint.arm.linux.org.uk>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200409181043.42268.dtor_core@ameritech.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 18 September 2004 09:56 am, Russell King wrote:

> 
> static struct device_attributes mmc_dev_attrs[] = {
> 	{
> 		{
> 			.name = "cid",
> 			.owner = THIS_MODULE,
> 			.mode = S_IRUGO,
> 		},
> 		.show = mmc_dev_show_cid,
> 	}, {
> 		{
> 			.name = "csd",
> 			.owner = THIS_MODULE,
> 			.mode = S_IRUGO,
> 		},
> 		.show = mmc_dev_show_csd,
> 	}, {
> 		{
> 			.name = "date",
> 			.owner = THIS_MODULE,
> 			.mode = S_IRUGO,
> 		},
> 		.show = mmc_dev_show_date,
> 	}, ... etc ...
> };
> 
> Hardly elegant, hardly clean, and hardly foolproof from silly C'n'P
> errors.
> 

What's wrong with the following (drivers/input/serio/serio.c):

static struct device_attribute serio_device_attrs[] = {
        __ATTR(description, S_IRUGO, serio_show_description, NULL),
        __ATTR(driver, S_IWUSR | S_IRUGO, serio_show_driver, serio_rebind_driver),
        __ATTR(bind_mode, S_IWUSR | S_IRUGO, serio_show_bind_mode, serio_set_bind_mode),
        __ATTR_NULL
};

Pretty compact and expressive IMHO.

-- 
Dmitry
