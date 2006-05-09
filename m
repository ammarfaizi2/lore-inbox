Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751379AbWEIFDb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751379AbWEIFDb (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 May 2006 01:03:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751380AbWEIFDa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 May 2006 01:03:30 -0400
Received: from ns2.suse.de ([195.135.220.15]:37832 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1751379AbWEIFDa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 May 2006 01:03:30 -0400
Date: Mon, 8 May 2006 22:01:46 -0700
From: Greg KH <greg@kroah.com>
To: Michael Holzheu <holzheu@de.ibm.com>
Cc: akpm@osdl.org, ioe-lkml@rameria.de, joern@wohnheim.fh-wedel.de,
       linux-kernel@vger.kernel.org, mschwid2@de.ibm.com,
       penberg@cs.helsinki.fi
Subject: Re: [PATCH] s390: Hypervisor File System
Message-ID: <20060509050146.GB3546@kroah.com>
References: <20060508142416.4356e774.holzheu@de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060508142416.4356e774.holzheu@de.ibm.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 08, 2006 at 02:24:16PM +0200, Michael Holzheu wrote:
> Hi Greg,
> 
> Greg KH <greg@kroah.com> wrote on 05/05/2006 11:14:47 PM:
> > > I added a invisible config option CONFIG_SYS_HYPERVISOR. If this
> > > option is enabled, /sys/hypervisor is created. CONFIG_S390_HYPFS
> > > enables this option automatically using "select".
> > > 
> > > This the following patch acceptable for you?
> 
> Ok, I modified the patch according to your input. So
> hopefully that's the final one... ok?

It is so close...

> diff -urpN linux-2.6.16/drivers/base/base.h linux-2.6.16-hypervisor/drivers/base/base.h
> --- linux-2.6.16/drivers/base/base.h	2006-03-20 06:53:29.000000000 +0100
> +++ linux-2.6.16-hypervisor/drivers/base/base.h	2006-05-08 14:13:18.000000000 +0200
> @@ -5,6 +5,11 @@ extern int devices_init(void);
>  extern int buses_init(void);
>  extern int classes_init(void);
>  extern int firmware_init(void);
> +#ifdef CONFIG_SYS_HYPERVISOR
> +extern int hypervisor_init(void);
> +#else
> +#define hypervisor_init() do { } while(0)
> +#endif

Hm, that second case there doesn't return anything incase we actually
try to check the return value of hypervisor_init()...

Other than that, looks good.  Care to fix this and send it again with a
real changelog and Signed-off-by: line, and I'll be glad to add it to my
tree.

thanks,

greg k-h
