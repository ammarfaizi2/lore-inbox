Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261486AbVDNMlH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261486AbVDNMlH (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Apr 2005 08:41:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261490AbVDNMlH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Apr 2005 08:41:07 -0400
Received: from v6.netlin.pl ([62.121.136.6]:60176 "EHLO pointblue.com.pl")
	by vger.kernel.org with ESMTP id S261486AbVDNMk4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Apr 2005 08:40:56 -0400
Message-ID: <425E64C4.5020704@pointblue.com.pl>
Date: Thu, 14 Apr 2005 14:40:36 +0200
From: Grzegorz Piotr Jaskiewicz <gj@pointblue.com.pl>
User-Agent: Debian Thunderbird 1.0.2 (X11/20050331)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: JustMan <justman@e1.bmstu.ru>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [OOPS] on usb removal, and minicom closing 2.6.11.7
References: <425E5682.6060606@pointblue.com.pl> <200504141614.03459.justman@e1.bmstu.ru>
In-Reply-To: <200504141614.03459.justman@e1.bmstu.ru>
X-Enigmail-Version: 0.90.2.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Works great, I would like to ask everyone here on lkml to consider
adding this patch to mainline.
This ain't naughty solution, checking for object/pointer/whatever if
exists before doing anything with it, is good.

Anyone?

Buy the way, I am also looking for usblan for 2.6, can I use usbnet
instead ? Anyone ported usblan to 2.6 (it's on GPL).

JustMan wrote:
>>So,
>>
>>I plugged in e680 motorola phone, played a bit with minicom on
>>/dev/ttyACM0, and when I closed minicom, got this oops. USB is useless,
>>got to reboot computer to use it again!
>>it's vanilla 2.6.11.7
>>
>>oops attached.
>>
> 
> 
> Try attached patch... (nasty solution, but it work for my C350  motorola phone)
> 
> 
>>
> 
> 
> ------------------------------------------------------------------------
> 
> diff -uNrp linux/drivers/base/class.orig.c  linux/drivers/base/class.c
> --- linux/drivers/base/class.orig.c	2005-03-10 12:19:00.000000000 +0300
> +++ linux/drivers/base/class.c	2005-03-10 13:59:27.000000000 +0300
> @@ -307,12 +307,14 @@ static int class_hotplug(struct kset *ks
>  	if (class_dev->dev) {
>  		/* add physical device, backing this device  */
>  		struct device *dev = class_dev->dev;
> -		char *path = kobject_get_path(&dev->kobj, GFP_KERNEL);
>  
> -		add_hotplug_env_var(envp, num_envp, &i, buffer, buffer_size,
> -				    &length, "PHYSDEVPATH=%s", path);
> -		kfree(path);
> +		if(kobject_name(&dev->kobj)) {
> +			char *path = kobject_get_path(&dev->kobj, GFP_KERNEL);
>  
> +			add_hotplug_env_var(envp, num_envp, &i, buffer, buffer_size,
> +				    &length, "PHYSDEVPATH=%s", path);
> +			kfree(path);
> +		}
>  		/* add bus name of physical device */
>  		if (dev->bus)
>  			add_hotplug_env_var(envp, num_envp, &i,

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.0 (GNU/Linux)

iD8DBQFCXmTEi0HtPCVkDAURAvIMAJ4+8tKj6jt/ErTtCrsmNYtM2aDfNACgigLA
4GbLbHStQJBq+Ez1lFe+lPo=
=UWvD
-----END PGP SIGNATURE-----
