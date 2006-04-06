Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751244AbWDFQIm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751244AbWDFQIm (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Apr 2006 12:08:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751254AbWDFQIm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Apr 2006 12:08:42 -0400
Received: from mail.kroah.org ([69.55.234.183]:54250 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S1751244AbWDFQIl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Apr 2006 12:08:41 -0400
Date: Thu, 6 Apr 2006 09:05:27 -0700
From: Greg KH <greg@kroah.com>
To: Anton Blanchard <anton@samba.org>
Cc: akpm@osdl.org, gregkh@suse.de, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Fix pciehp driver on non ACPI systems
Message-ID: <20060406160527.GA2965@kroah.com>
References: <20060406101731.GA9989@krispykreme>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060406101731.GA9989@krispykreme>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 06, 2006 at 08:17:31PM +1000, Anton Blanchard wrote:
> 
> Wrap some ACPI specific headers. ACPI hasnt taken over the whole world yet.
> 
> Signed-off-by: Anton Blanchard <anton@samba.org>
> ---
> 
> Index: kernel/drivers/pci/hotplug/pciehp_hpc.c
> ===================================================================
> --- kernel.orig/drivers/pci/hotplug/pciehp_hpc.c	2006-04-06 05:01:32.000000000 -0500
> +++ kernel/drivers/pci/hotplug/pciehp_hpc.c	2006-04-06 05:09:48.501122395 -0500
> @@ -38,10 +38,14 @@
>  
>  #include "../pci.h"
>  #include "pciehp.h"
> +
> +#ifdef CONFIG_ACPI
>  #include <acpi/acpi.h>
>  #include <acpi/acpi_bus.h>
>  #include <acpi/actypes.h>
>  #include <linux/pci-acpi.h>
> +#endif

Shouldn't the ACPI headers handle it if CONFIG_ACPI is not enabled?  All
other header files work that way, and we shouldn't have to add this to
the .c files.

thanks,

greg k-h
