Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932436AbWALSxt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932436AbWALSxt (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Jan 2006 13:53:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932665AbWALSxt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Jan 2006 13:53:49 -0500
Received: from e35.co.us.ibm.com ([32.97.110.153]:1774 "EHLO e35.co.us.ibm.com")
	by vger.kernel.org with ESMTP id S932436AbWALSxs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Jan 2006 13:53:48 -0500
Message-ID: <43C6A5B4.80801@us.ibm.com>
Date: Thu, 12 Jan 2006 12:53:40 -0600
From: Anthony Liguori <aliguori@us.ibm.com>
User-Agent: Mozilla Thunderbird 1.0.7 (X11/20051013)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Greg KH <greg@kroah.com>
CC: Gerd Hoffmann <kraxel@suse.de>, Arjan van de Ven <arjan@infradead.org>,
       "Mike D. Day" <ncmike@us.ibm.com>, lkml <linux-kernel@vger.kernel.org>,
       xen-devel@lists.xensource.com
Subject: Re: [RFC] [PATCH] sysfs support for Xen attributes
References: <43C53DA0.60704@us.ibm.com> <20060111230704.GA32558@kroah.com> <43C5A199.1080708@us.ibm.com> <20060112005710.GA2936@kroah.com> <43C5B59C.8050908@us.ibm.com> <43C65196.8040402@suse.de> <1137072089.2936.29.camel@laptopd505.fenrus.org> <43C66ACC.60408@suse.de> <20060112173926.GD10513@kroah.com>
In-Reply-To: <20060112173926.GD10513@kroah.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greg KH wrote:

>What exactly do the different ioctls do?  Do they have to be ioctls?
>Can you use configfs or sysfs for most of the stuff there?
>  
>
The canonical example is /proc/xen/privcmd which is our userspace 
hypercall interface.  A hypercall is software interrupt with a number of 
parameters passed via registers.  This has to come from ring 1 for 
security reasons (the kernel is running in ring 1).

We wish to make management hypercalls as the root user in userspace 
which means we have to go through the kernel.  Currently, we do this by 
having /proc/xen/privcmd accept an ioctl() that takes a structure that 
describe the register arguments.  The kernel interface allows us to 
control who in userspace can execute hypercalls.

It would perhaps be possible to use a read/write interface for 
hypercalls but ioctl() seems a little less awkward.  Suggestions are 
certainly appreciated though.

Right now, I think a misc char device with an ioctl() interface seems 
like the most promising way to do this.  This doesn't seem like the sort 
of think one would want to expose in sysfs...

Regards,

Anthony Liguori

>thanks,
>
>greg k-h
>-
>To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
>the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html
>Please read the FAQ at  http://www.tux.org/lkml/
>
>
>  
>

