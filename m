Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265843AbUAQARj (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Jan 2004 19:17:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265845AbUAQARj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Jan 2004 19:17:39 -0500
Received: from mail.kroah.org ([65.200.24.183]:28375 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S265843AbUAQARi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Jan 2004 19:17:38 -0500
Date: Fri, 16 Jan 2004 16:17:39 -0800
From: Greg KH <greg@kroah.com>
To: Hollis Blanchard <hollisb@us.ibm.com>
Cc: Greg KH <gregkh@us.ibm.com>, linux-kernel@vger.kernel.org
Subject: Re: kobj_to_dev ?
Message-ID: <20040117001739.GB3840@kroah.com>
References: <3FC7B008-487C-11D8-AED9-000A95A0560C@us.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3FC7B008-487C-11D8-AED9-000A95A0560C@us.ibm.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 16, 2004 at 05:32:29PM -0600, Hollis Blanchard wrote:
> Hi Greg, could this be added to device.h:
> 
> --- 1.112/include/linux/device.h        Wed Jan  7 23:58:16 2004
> +++ edited/include/linux/device.h       Fri Jan 16 17:35:04 2004
> @@ -279,6 +279,8 @@
>         void    (*release)(struct device * dev);
>  };
> 
> +#define kobj_to_dev(k) container_of((k), struct device, kobj)
> +
>  static inline struct device *
>  list_to_dev(struct list_head *node)
>  {
> 
> I'm using it as the following (inspired by find_bus), and it seems like 
> it would make sense to put in device.h.

How about just adding a find_device() function to the driver core, where
you pass in a name and a type, so that others can use it?

> As a side node, since those #defines don't to type-checking, would it 
> make sense to name them with both types? E.g. "kobj_to_dev" instead of 
> just "to_dev"?

The compiler does the typechecking for you :)

thanks,

greg k-h
