Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314325AbSEIUeF>; Thu, 9 May 2002 16:34:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314327AbSEIUeE>; Thu, 9 May 2002 16:34:04 -0400
Received: from nat-pool-rdu.redhat.com ([66.187.233.200]:40514 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id <S314325AbSEIUeE>; Thu, 9 May 2002 16:34:04 -0400
Date: Thu, 9 May 2002 16:33:59 -0400
From: Pete Zaitcev <zaitcev@redhat.com>
Message-Id: <200205092033.g49KXxG06486@devserv.devel.redhat.com>
To: "Tom 'spot' Callaway" <tcallawa@redhat.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Fix scsi.c kmod noise
In-Reply-To: <mailman.1020966481.25371.linux-kernel2news@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> [...] This error crops up whenever scsi.c
> is compiled in (which is fairly common in 2.4, Red Hat Linux does this
> as well).

> "kmod: failed to exec /sbin/modprobe -s -k scsi_hostadapter, errno = 2"

> --- linux/drivers/scsi/scsi.c.OLD	Wed May  1 16:33:14 2002
> +++ linux/drivers/scsi/scsi.c	Wed May  1 16:34:46 2002
> @@ -2389,10 +2389,18 @@

> +/* This doesn't make much sense to do unless CONFIG_SCSI is a module itself.
> + *
> + * ~spot <tcallawa@redhat.com> 05012002
> + */
> +
> +#ifdef MODULE
>  #ifdef CONFIG_KMOD
>  		if (scsi_hosts == NULL)
>  			request_module("scsi_hostadapter");
>  #endif
> +#endif
>  		return scsi_register_device_module((struct Scsi_Device_Template *) ptr);

I do not see how you suppose this should work. What if scsi.c
is compiled in, and sunesp.c is not? Besides, why are you running
a kernel with CONFIG_KMOD if exec returns -ENOENT? I suspect
something is broken in the Aurora land.

-- Pete
