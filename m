Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262746AbVCJQzi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262746AbVCJQzi (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Mar 2005 11:55:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262711AbVCJQwP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Mar 2005 11:52:15 -0500
Received: from mail.kroah.org ([69.55.234.183]:62623 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S262748AbVCJQuB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Mar 2005 11:50:01 -0500
Date: Thu, 10 Mar 2005 07:28:08 -0800
From: Greg KH <greg@kroah.com>
To: JustMan <justman@e1.bmstu.ru>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2.6.11] fix: drivers/base/class.c
Message-ID: <20050310152808.GA15401@kroah.com>
References: <200503101508.56696.justman@e1.bmstu.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200503101508.56696.justman@e1.bmstu.ru>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 10, 2005 at 03:08:56PM +0300, JustMan wrote:
> fix: drivers/base/class.c

"fix" how?  What are you fixing?

> diff -uNrp linux/drivers/base/class.orig.c  linux/drivers/base/class.c
> --- linux/drivers/base/class.orig.c 2005-03-10 12:19:00.000000000 +0300
> +++ linux/drivers/base/class.c 2005-03-10 13:59:27.000000000 +0300
> @@ -307,12 +307,14 @@ static int class_hotplug(struct kset *ks
>   if (class_dev->dev) {
>    /* add physical device, backing this device  */
>    struct device *dev = class_dev->dev;

Your email client ate all of the tabs, this patch can't be applied :(

> -  char *path = kobject_get_path(&dev->kobj, GFP_KERNEL);
>  
> -  add_hotplug_env_var(envp, num_envp, &i, buffer, buffer_size,
> -        &length, "PHYSDEVPATH=%s", path);
> -  kfree(path);
> +  if(kobject_name(&dev->kobj)) {
> +   char *path = kobject_get_path(&dev->kobj, GFP_KERNEL);
>  
> +   add_hotplug_env_var(envp, num_envp, &i, buffer, buffer_size,
> +        &length, "PHYSDEVPATH=%s", path);
> +   kfree(path);
> +  }

Let me guess, you are using an out-of-tree driver that incorrectly sets
up the kobject and the hotplug userspace code doesn't like the <NULL> in
the strings?

Fix the driver, the kobject should have a name.

thanks,

greg k-h
