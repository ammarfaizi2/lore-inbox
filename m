Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964984AbVLQVwu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964984AbVLQVwu (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 17 Dec 2005 16:52:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964983AbVLQVwu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 17 Dec 2005 16:52:50 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:49677 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S964982AbVLQVwt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 17 Dec 2005 16:52:49 -0500
Date: Sat, 17 Dec 2005 22:52:51 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Roland Dreier <rolandd@cisco.com>
Cc: linux-kernel@vger.kernel.org, openib-general@openib.org
Subject: Re: [PATCH 13/13]  [RFC] ipath Kconfig and Makefile
Message-ID: <20051217215251.GV23349@stusta.de>
References: <200512161548.MdcxE8ZQTy1yj4v1@cisco.com> <200512161548.lokgvLraSGi0enUH@cisco.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200512161548.lokgvLraSGi0enUH@cisco.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 16, 2005 at 03:48:55PM -0800, Roland Dreier wrote:

>...
> --- /dev/null
> +++ b/drivers/infiniband/hw/ipath/Kconfig
> @@ -0,0 +1,18 @@
> +config IPATH_CORE
> +	tristate "PathScale InfiniPath Driver"
> +	depends on PCI_MSI && X86_64
>...

The driver shouldn't use assembler code and therefore no longer depend 
on X86_64.

> --- /dev/null
> +++ b/drivers/infiniband/hw/ipath/Makefile
> @@ -0,0 +1,15 @@
> +EXTRA_CFLAGS += -Idrivers/infiniband/include
> +
> +EXTRA_CFLAGS += -Wall -O3 -g3

-Wall is always set when compiling the kernel.

-O3 doesn't make much sense since the fight for producing the fastest 
code is between -O2 and -Os.

You don't want to always compile your driver with -g3.

> +_ipath_idstr:="$$""Id: kernel.org InfiniPath Release 1.1 $$"" $$""Date: $(shell date +%F-%R)"" $$"
> +EXTRA_CFLAGS += -D_IPATH_IDSTR='$(_ipath_idstr)' -DIPATH_KERN_TYPE=0
>...

Please move the _IPATH_IDSTR revision tag to a header file and remove 
IPATH_KERN_TYPE.

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

