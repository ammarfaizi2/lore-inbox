Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267713AbUHEXCd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267713AbUHEXCd (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Aug 2004 19:02:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267727AbUHEXCc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Aug 2004 19:02:32 -0400
Received: from mail.kroah.org ([69.55.234.183]:2451 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S267713AbUHEXCb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Aug 2004 19:02:31 -0400
Date: Thu, 5 Aug 2004 15:46:57 -0700
From: Greg KH <greg@kroah.com>
To: Thomas Koeller <thomas.koeller@baslerweb.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Device class reference counting
Message-ID: <20040805224656.GA22545@kroah.com>
References: <200407301803.00269.thomas.koeller@baslerweb.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200407301803.00269.thomas.koeller@baslerweb.com>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 30, 2004 at 06:03:00PM +0200, Thomas Koeller wrote:
> Hi,
> 
> I found a little issue with reference counting for
> device classes in 2.6.8-rc2. Patch attached.

> --- linux-mips/drivers/base/class.c	2004-07-14 16:21:33.000000000 +0200
> +++ linux-mips-work/drivers/base/class.c	2004-07-30 17:51:09.477331128 +0200
> @@ -353,8 +353,8 @@
>  	struct class_interface * class_intf;
>  	int error;
>  
> -	class_dev = class_device_get(class_dev);
> -	if (!class_dev || !strlen(class_dev->class_id))
> +	if (!strlen(class_dev->class_id)
> +		|| !(class_dev = class_device_get(class_dev)))
>  		return -EINVAL;

I don't understand what you are trying to fix here.  In fact, if
class_dev is NULL, you will now oops.

Hm, I guess if class_dev->class_id is null, we will exit with an extra
reference grabbed on the class_dev.  Is that what you are trying to fix
here?

If so, please rework the patch.

thanks,

greg k-h
