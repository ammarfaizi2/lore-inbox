Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261482AbVF2BZj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261482AbVF2BZj (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Jun 2005 21:25:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262335AbVF2AkB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Jun 2005 20:40:01 -0400
Received: from mail.kroah.org ([69.55.234.183]:8356 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S262222AbVF2A2l (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Jun 2005 20:28:41 -0400
Date: Tue, 28 Jun 2005 17:27:09 -0700
From: Greg KH <greg@kroah.com>
To: Roland Dreier <rolandd@cisco.com>
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org, openib-general@openib.org
Subject: Re: [PATCH 05/16] IB uverbs: core implementation
Message-ID: <20050629002709.GB17805@kroah.com>
References: <2005628163.lUk0bfpO8VsSXUh5@cisco.com> <2005628163.jfSiMqRcI78iLMJP@cisco.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2005628163.jfSiMqRcI78iLMJP@cisco.com>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 28, 2005 at 04:03:43PM -0700, Roland Dreier wrote:
> +++ linux/drivers/infiniband/core/uverbs_main.c	2005-06-28 15:20:04.363963991 -0700
> @@ -0,0 +1,708 @@
> +/*
> + * Copyright (c) 2005 Topspin Communications.  All rights reserved.
> + * Copyright (c) 2005 Cisco Systems.  All rights reserved.
> + *
> + * This software is available to you under a choice of one of two
> + * licenses.  You may choose to be licensed under the terms of the GNU
> + * General Public License (GPL) Version 2, available from the file
> + * COPYING in the main directory of this source tree, or the
> + * OpenIB.org BSD license below:

Ok, I've complained about this before, but due to the fact that you are
calling EXPORT_SYMBOL_GPL() only functions in this code, the ability for
it for someone to use the BSD license on it in the future, is pretty
much impossible, right?

Wasn't the openib group going to drop this horrible license, or are they
still insisting on porting this to other operating systems?

> +static ssize_t show_dev(struct class_device *class_dev, char *buf)
> +{
> +	struct ib_uverbs_device *dev =
> +		container_of(class_dev, struct ib_uverbs_device, class_dev);
> +
> +	return print_dev_t(buf, dev->dev.dev);
> +}
> +static CLASS_DEVICE_ATTR(dev, S_IRUGO, show_dev, NULL);

This is no longer needed with the class device interface in the kernel
today.  Please use the new api (basically just set dev_t in the
class_device, and you get this for free.)

thanks,

greg k-h
